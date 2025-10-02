<img src="https://www.seven.io/wp-content/uploads/Logo.svg" width="250" />

# Seven.io Redmine Plugin

Official [seven.io](https://www.seven.io) plugin for [Redmine](https://www.redmine.org/) that enables SMS and voice messaging capabilities.

## Overview

This plugin integrates seven.io's SMS and voice services with Redmine, allowing administrators to send bulk messages to users and automatically notify assignees when issues are created. It supports filtering by user groups and roles, and integrates with the RedmineUP CRM plugin for contact management.

## Prerequisites

- Redmine installation (compatible with Rails 5.2+)
- An [API key](https://help.seven.io/en/api-key-access) from seven.io - [get one for free](https://app.seven.io/signup)
- Admin privileges in Redmine

## Installation

1. **Download and Extract**
   ```bash
   cd /path/to/redmine/plugins
   # Extract the plugin archive here
   ```

2. **Install Dependencies**
   ```bash
   bundle install
   ```

3. **Run Migration**
   ```bash
   bundle exec rake redmine:plugins:migrate RAILS_ENV=production NAME=seven
   ```

4. **Restart Redmine**
   ```bash
   # Restart your Redmine server
   ```

5. **Configure Plugin**
   - Navigate to `Administration → Plugins → seven`
   - Click `Configure`
   - Enter your seven.io API key
   - Configure additional settings as needed
   - Click `Apply`

## Features

### Core Functionality
- **Bulk SMS Messaging**: Send SMS to multiple users via `Administration → seven SMS`
- **Bulk Voice Calls**: Make voice calls to multiple users via `Administration → seven Voice`
- **User Filtering**: Limit messaging to specific groups and/or admin users only
- **Individual Messaging**: Send messages to individual users via their profile pages

### Issue Integration
- **Automatic Notifications**: SMS dispatch after issue creation to assigned user or custom phone number
- **Priority Filtering**: Configure which issue priorities trigger notifications
- **Placeholder Support**: Use dynamic content in messages
  - `{{id}}` → Resolves to the issue ID

### CRM Integration
- **RedmineUP CRM Support**: Send bulk SMS to contacts when [RedmineUP CRM Plugin](https://www.redmineup.com/pages/plugins/crm) is installed

### User Experience
- **Mobile Phone Field**: Automatically adds a "Mobile Phone" custom field for users
- **Multi-language Support**: Available in English and German
- **Profile Integration**: SMS/Voice links appear on user profile pages

## Configuration

### Plugin Settings
Access via `Administration → Plugins → seven → Configure`:

- **API Key**: Your seven.io API key (required)
- **SMS From**: Sender number (up to 11 alphanumeric or 16 numeric characters)
- **Voice From**: Caller ID (use verified sender IDs or shared virtual numbers)
- **Issue Priority**: Which priorities trigger automatic SMS notifications
- **Issue Recipient**: Send to assignee or custom phone number
- **Issue Text**: Message template with placeholder support

### User Setup
Users need to add their mobile phone number in their profile:
1. Go to `My Account`
2. Fill in the "Mobile Phone" field
3. Save changes

## Usage

### Sending Bulk Messages
1. Navigate to `Administration → seven SMS` or `Administration → seven Voice`
2. Choose recipient filters (groups, admin status, table)
3. Enter your message
4. Configure additional options (sender, delay, etc.)
5. Send

### Individual Messages
1. Visit a user's profile page
2. Click "seven SMS" or "seven Voice" links
3. Compose and send your message

## Troubleshooting

### Common Issues
- **No recipients found**: Ensure users have mobile phone numbers in their profiles
- **API errors**: Verify your API key is correct and has sufficient credits
- **Migration issues**: Check Rails environment and plugin name are correct

### Logs
Check Redmine logs for detailed error information when troubleshooting API calls or hook executions.

## Development

### Uninstalling
To remove the plugin:
```bash
bundle exec rake redmine:plugins:migrate VERSION=0 RAILS_ENV=production NAME=seven
```

## Support

Need help? Feel free to [contact us](https://www.seven.io/en/company/contact/).

## License

[![MIT](https://img.shields.io/badge/License-MIT-teal.svg)](LICENSE)

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
