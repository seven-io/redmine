<p align="center">
  <img src="https://www.seven.io/wp-content/uploads/Logo.svg" width="250" alt="seven logo" />
</p>

<h1 align="center">seven SMS &amp; Voice for Redmine</h1>

<p align="center">
  Bulk and event-based SMS / voice messaging for <a href="https://www.redmine.org/">Redmine</a> via the seven gateway. Includes RedmineUP CRM support.
</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-teal.svg" alt="MIT License" /></a>
  <img src="https://img.shields.io/badge/Redmine-Rails%205.2%2B-d1393a" alt="Redmine on Rails 5.2+" />
  <img src="https://img.shields.io/badge/Ruby-2.7%2B-red" alt="Ruby 2.7+" />
</p>

---

## Features

- **Bulk SMS / Voice** - Reach all users (or a filtered subset) via **Administration > seven SMS** / **seven Voice**
- **Issue-Based Notifications** - Auto-fire SMS to the assignee on issue creation, gated by priority
- **Per-User Mobile Field** - Plugin auto-installs a custom field "Mobile Phone" on users
- **CRM Integration** - Bulk SMS to RedmineUP CRM contacts (when the [RedmineUP CRM plugin](https://www.redmineup.com/pages/plugins/crm) is installed)
- **Profile Shortcuts** - SMS / Voice links right on each user's profile page
- **Bilingual** - English and German translations bundled

## Prerequisites

- Redmine on Rails 5.2 or higher
- Admin privileges in Redmine
- A [seven account](https://www.seven.io/) with API key ([How to get your API key](https://help.seven.io/en/developer/where-do-i-find-my-api-key))

## Installation

```bash
cd /path/to/redmine/plugins
# extract the plugin archive into ./seven
bundle install
bundle exec rake redmine:plugins:migrate RAILS_ENV=production NAME=seven
```

Restart Redmine, then go to **Administration > Plugins > seven > Configure** and paste your seven API key.

## Configuration

| Setting | Description |
|---------|-------------|
| API Key | Your seven API key |
| SMS From | Default sender ID for SMS (max 11 alphanumeric / 16 numeric) |
| Voice From | Default caller ID (verified or shared number) |
| Issue Priority | Which issue priorities trigger automatic SMS |
| Issue Recipient | Send to assignee or to a custom phone number |
| Issue Text | Message template - supports `{{id}}` for the issue ID |

### Per-user setup

Each user fills the auto-installed *Mobile Phone* custom field via **My Account**.

## Usage

### Bulk Messages

1. Go to **Administration > seven SMS** or **seven Voice**.
2. Filter recipients (groups, admin, or RedmineUP table).
3. Compose the message and send.

### Individual Messages

Open any user profile and click **seven SMS** or **seven Voice**.

### Automatic Issue Notifications

Once configured, new issues matching the priority filter trigger an SMS to the assignee or the configured number.

## Troubleshooting

| Problem | Solution |
|---------|----------|
| No recipients found | Make sure target users have the *Mobile Phone* custom field filled |
| API errors | Verify the API key and account balance |
| Migration issues | Confirm `RAILS_ENV` and `NAME=seven` are set correctly |

## Uninstalling

```bash
bundle exec rake redmine:plugins:migrate VERSION=0 RAILS_ENV=production NAME=seven
```

## Support

Need help? Feel free to [contact us](https://www.seven.io/en/company/contact/) or [open an issue](https://github.com/seven-io/redmine/issues).

## License

[MIT](LICENSE)
