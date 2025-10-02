# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Redmine plugin for seven.io SMS and voice services. It allows Redmine administrators to send bulk SMS/voice messages to users and integrates with Redmine's issue system to automatically notify assignees when issues are created.

## Development Commands

### Installation & Setup
```bash
# Install dependencies
bundle install

# Run plugin migration
bundle exec rake redmine:plugins:migrate RAILS_ENV=production NAME=seven

# For development environment
bundle exec rake redmine:plugins:migrate RAILS_ENV=development NAME=seven
```

### Testing
```bash
# Run tests (uses Redmine's test framework)
# Tests are located in test/ directory and inherit from Redmine's test_helper
ruby -I test test/test_helper.rb
```

### Plugin Management
```bash
# Rollback plugin migration
bundle exec rake redmine:plugins:migrate VERSION=0 RAILS_ENV=production NAME=seven
```

## Architecture

### Core Components

**Plugin Registration** (`init.rb`):
- Registers admin menu items for SMS and Voice interfaces
- Defines plugin settings with defaults for API configuration
- Configures settings partial at `app/views/settings/_seven_settings.html.erb`

**Main Controller** (`app/controllers/seven_controller.rb`):
- `SevenController` handles SMS and voice message dispatch
- Supports bulk messaging to filtered user groups or individual recipients
- Integrates with RedmineUP CRM Plugin for contact management
- Uses sms77 gem for API communication

**Hooks System** (`lib/seven/hooks.rb`):
- `ControllerHooks`: Automatically sends SMS when new issues are created
- `Hooks`: Adds SMS/voice links to user profile pages
- Supports placeholder substitution ({{id}} for issue ID)

**Database Schema**:
- Migration creates "Mobile Phone" custom field for users
- Custom field is referenced in `PopulateCustomFields::MOBILE_FIELD_NAME`

### Key Dependencies
- `sms77` gem (v0.4.0) for seven.io API integration
- `phonelib` gem (v0.8.7) for phone number validation (partially commented out)

### Routes Configuration
- Admin routes: `/seven/sms` and `/seven/voice`
- Settings route: `/seven` for plugin configuration

### Internationalization
- Supports English and German locales
- Locale files in `config/locales/`
- All user-facing strings use I18n keys under `seven.*`

### Views Structure
- Main SMS/Voice interfaces: `app/views/seven/sms.html.erb`, `app/views/seven/voice.html.erb`
- Shared partials: `_text.html.erb`, `_to.html.erb` for form components
- Settings partial: `app/views/settings/_seven_settings.html.erb`

### JavaScript Assets
- `assets/javascripts/compose.js` handles frontend interactions

## Development Notes

### Custom Field Integration
The plugin creates a "Mobile Phone" custom field for users. Access mobile numbers via:
```ruby
mobile_field = SevenController.custom_field_mobile
mobile = SevenController.user_mobile(user, mobile_field)
```

### Settings Access
Plugin settings are stored in Redmine's settings system:
```ruby
settings = SevenController.get_settings
api_key = settings.value['apiKey']
```

### Message Sending
Both SMS and voice use the seven.io API through the sms77 gem:
- SMS: `Sms77::Resources::Sms`
- Voice: `Sms77::Resources::Voice`

### Filter System
The plugin supports filtering recipients by:
- User groups
- Admin status
- Table type (users vs contacts for CRM integration)

### Issue Integration
Automatic SMS dispatch on issue creation is configured via:
- Priority filtering (only send for specified priorities)
- Recipient setting (assignee or custom phone number)
- Text template with placeholder support