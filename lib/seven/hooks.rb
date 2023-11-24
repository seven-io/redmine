module Seven
  module Hooks
    class ControllerHooks < Redmine::Hook::Listener
      def controller_issues_new_after_save(context = {})
        settings = SevenController.get_settings

        text = settings.value['issue_text']
        if text.empty?
          return
        end

        api_key = settings.value['apiKey']
        if api_key.empty?
          return
        end

        issue_priority = settings.value['issue_priority']

        unless issue_priority.include? context[:issue].priority_id.to_s
          return
        end

        issue_to = settings.value['issue_to']

        to = issue_to
        if issue_to == 'assignee'
          assignee_id = context[:issue].assigned_to_id
          if assignee_id == nil
            return
          end

          user = User.find_by_id(assignee_id)
          to = SevenController.user_mobile(user)
        end

        if to == nil || to.empty?
          return
        end

        resource = Sms77::Resources::Sms.new(api_key, 'redmine')
        params = {
          'from' => settings.value['sms_from'],
          'text' => text,
          'to' => to,
        }
        resource.retrieve(params)
      end
    end

    class Hooks < Redmine::Hook::ViewListener
      def view_account_left_bottom(context = {})
        mobile = SevenController.user_mobile(context[:user])

        if mobile.present?
          link_to(l('seven.menu.sms'), use_route: 'seven_sms', to: mobile) +
            tag('br', nil, true) +
            link_to(l('seven.menu.voice'), use_route: 'seven_voice', to: mobile)
        end
      end
    end
  end
end