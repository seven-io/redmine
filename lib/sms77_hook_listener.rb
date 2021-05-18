class Sms77HookListener < Redmine::Hook::ViewListener
  def view_account_left_bottom(context = {})
    mobile = Sms77Controller.user_mobile(context[:user])

    if mobile.present?
      link_to(l('sms77.menu.sms'), use_route: 'sms77_sms', to: mobile) +
        tag('br', nil, true) +
        link_to(l('sms77.menu.voice'), use_route: 'sms77_voice', to: mobile)
    end
  end
end
