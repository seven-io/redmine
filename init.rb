require_dependency 'sms77_hook_listener'

Redmine::Plugin.register :sms77 do
  menu :admin_menu, :sms77_sms, { controller: 'sms77', action: 'sms' }, caption: :'sms77.menu.sms'
  menu :admin_menu, :sms77_voice, { controller: 'sms77', action: 'voice' }, caption: :'sms77.menu.voice'

  settings default: {
    'apiKey' => '',
    'sms_from' => '',
    'voice_from' => ''
  }, partial: 'settings/sms77_settings'

  author 'sms77 e.K.'
  author_url 'https://www.sms77.io'
  description 'Redmine plugin for sending SMS via sms77.io'
  name 'sms77 plugin'
  url 'https://github.com/sms77io/redmine'
  version '0.0.1'
end
