class SevenHookListener < Redmine::Hook::ViewListener
  def view_account_left_bottom(context = {})
    mobile = SevenController.user_mobile(context[:user])

    if mobile.present?
      link_to(l('seven.menu.sms'), use_route: 'seven_sms', to: mobile) +
        tag('br', nil, true) +
        link_to(l('seven.menu.voice'), use_route: 'seven_voice', to: mobile)
    end
  end
end
