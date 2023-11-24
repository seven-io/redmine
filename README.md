![](https://www.seven.io/wp-content/uploads/Logo.svg "seven Logo")

# Official plugin for [Redmine](https://www.redmine.org/)

## Prerequisites

- An [API key](https://help.seven.io/en/api-key-access) from seven - [get one for free](https://app.seven.io/signup)

### Installation

This plugin adds a custom field named `Mobile Phone`.

1. Extract the archive to `/path/to/redmine/plugins`
2. Run `bundle install && rails redmine:plugins NAME=seven`
3. Restart Redmine
4. Go to `Administration->Plugins->seven` and click `Configure`
5. Fill out the API key and press `Apply`

#### Features

- Send (bulk) SMS via `Administration->seven SMS`
- Issue (bulk) voice calls via `Administration->seven Voice`
- Limit bulk messaging to group and/or admin only
- Message individual users via their profile
- SMS dispatch after issue creation to assigned user or custom phone number

##### Support

Need help? Feel free to [contact us](https://www.seven.io/en/company/contact/).

[![MIT](https://img.shields.io/badge/License-MIT-teal.svg)](LICENSE)