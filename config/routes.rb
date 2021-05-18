get 'sms77', to: 'settings#plugin', id: 'sms77'
post 'sms77', to: 'settings#plugin', id: 'sms77'

get 'sms77/sms', to: 'sms77#sms', as: 'sms77_sms'
post 'sms77/sms', to: 'sms77#sms'

get 'sms77/voice', to: 'sms77#voice', as: 'sms77_voice'
post 'sms77/voice', to: 'sms77#voice'