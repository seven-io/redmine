get 'seven', to: 'settings#plugin', id: 'seven'
post 'seven', to: 'settings#plugin', id: 'seven'

get 'seven/sms', to: 'seven#sms', as: 'seven_sms'
post 'seven/sms', to: 'seven#sms'

get 'seven/voice', to: 'seven#voice', as: 'seven_voice'
post 'seven/voice', to: 'seven#voice'