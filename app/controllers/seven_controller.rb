require 'sms77'
require 'sms77/client'
require 'sms77/resource'
# require 'phonelib'
require_relative '../../db/migrate/001_populate_custom_fields'

class SevenController < ApplicationController
  TABLE_CONTACTS = 'contacts'
  TABLE_USERS = 'users'

  def self.custom_field_mobile
    CustomField.find_by_name(PopulateCustomFields::MOBILE_FIELD_NAME)
  end

  def self.user_mobile(user, mobile_field = custom_field_mobile)
    val = mobile_field.custom_values.find_by({ custom_field_id: mobile_field.id, customized_id: user.id })
    val.nil? ? nil : val.value
  end

  def self.get_settings
    Setting.find_by_name('plugin_seven')
  end

  def initialize
    super

    @responses = []
    @settings = SevenController.get_settings
  end

  def index
    @tables = [TABLE_USERS]

    if Module.const_defined?(:RedmineContacts)
      @tables.push(TABLE_CONTACTS)
    end

    @groups = Group.all.to_a
    @user_count_by_group_id = user_count_by_group_id
    @users = User.all

    @groups_counts = { _total: 0 }
    @groups.each do |group|
      @groups_counts[group.id] = @user_count_by_group_id[group.id] || 0
      @groups_counts[:_total] += @groups_counts[group.id]
    end
  end

  def sms
    send_sms if is_post

    index
  end

  def voice
    send_voice if is_post

    index
  end

  private

  def build_recipients
    if params[:to].blank?
      to = []

      if params[:filter_table] == TABLE_USERS
        admin = ActiveModel::Type::Boolean.new.cast(params.key?(:filter_admin) ? params[:filter_admin] : false)
        users = User.admin(admin)

        if params[:filter_groups].blank?
          users = users.all
        else
          users = users.in_group(params[:filter_groups])
        end

        mobile_field = SevenController.custom_field_mobile
        users.each do |user|
          mobile = SevenController.user_mobile(user, mobile_field)
          to.append(mobile) unless mobile.nil?
        end
      else
        Rails.logger.info "table contacts!"
        Rails.logger.info "filter_groups: #{params[:filter_groups]}"

        contacts = Contact.order_by_name
        contacts.each do |contact|
          to.push(*contact.phones)
=begin
          contact.phones.each do |phone|
            parsed = Phonelib.parse('123456789')
            if parsed.types.include? :mobile
              to.push(phone)
              break
            end
          end
=end
        end
      end

      if to.blank?
        @responses.append l('seven.no_recipients_found')

        return false
      end

      params[:to] = to
    else
      params[:to] = params[:to].split(',')
    end

    true
  end

  def is_post
    request.request_method == 'POST'
  end

  def send_message(cls, method, params)
    Rails.logger.info "apiKey1: #{@settings.value['apiKey']}"
    @responses.append(cls.new(@settings.value['apiKey'], 'redmine').method(method).call(params.merge({ json: true })))
  end

  def send_sms
    if build_recipients
      sms_params = params.to_unsafe_h.slice(
        :delay, :foreign_id, :flash, :from, :label, :no_reload, :text, :to, :ttl, :performance_tracking
      )

      sms_params[:to] = sms_params[:to].join(',')

      send_message(Sms77::Resources::Sms, 'retrieve', sms_params)
    end
  end

  def send_voice
    if build_recipients
      recipients = params[:to]
      voice_params = params.to_unsafe_h.slice(:from, :text, :ttl, :xml)

      recipients.each do |to|
        send_message(Sms77::Resources::Voice, 'send', voice_params.merge({ to: to }))
      end
    end
  end

  def user_count_by_group_id
    h = User.joins(:groups).group('group_id').count

    h.each_key do |key|
      h[key.to_i] = h.delete(key)
    end
    h
  end
end
