![Sms77.io Logo](https://www.sms77.io/wp-content/uploads/2019/07/sms77-Logo-400x79.png "Sms77.io Logo")

# Official plugin for [Redmine](https://www.redmine.org/)

## Prerequisites

- An API key from Sms77.io - [get one for free](https://app.sms77.io/anmelden)

### Installation

This plugin adds a custom field named `Mobile Phone`.

1. Extract the archive to `/path/to/redmine/plugins`
2. Run `RAILS_ENV=production bundle exec rake redmine:plugins:migrate`
3. Restart Redmine
4. Go to `Administration->Plugins->Sms77` and click `Configure`
5. Fill out the API key and press `Apply`

#### Features

- Send (bulk) SMS via `Administration->Sms77 SMS`
- Issue (bulk) voice calls via `Administration->Sms77 Voice`
- Limit bulk messaging to group and/or admin only
- Message individual users via their profile

##### Support

Need help? Feel free to [contact us](https://www.sms77.io/en/company/contact/).

[![MIT](https://img.shields.io/badge/License-MIT-teal.svg)](LICENSE)