require_relative 'lib/seven/hooks'

Redmine::Plugin.register :seven do
  menu :admin_menu, :seven_sms, { controller: 'seven', action: 'sms' }, caption: :'seven.menu.sms'
  menu :admin_menu, :seven_voice, { controller: 'seven', action: 'voice' }, caption: :'seven.menu.voice'

  settings default: {
    'apiKey' => '',
    'sms_from' => '',
    'voice_from' => '',
    'issue_priority' => '1',
    'issue_to' => '',
    'issue_text' => '',
  }, partial: 'settings/seven_settings'

  author 'seven communications GmbH & Co. KG'
  author_url 'https://www.seven.io'
  description 'Redmine plugin for sending SMS and making text-to-speech calls via seven.io'
  name 'seven plugin'
  url 'https://github.com/seven-io/redmine'
  version '0.5.0'
end
