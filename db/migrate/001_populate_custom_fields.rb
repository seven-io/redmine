class PopulateCustomFields < ActiveRecord::Migration[5.2]
  MOBILE_FIELD_NAME = 'Mobile Phone'.freeze

# called on plugin removal
  def self.down
    CustomField.find_by_name(MOBILE_FIELD_NAME)&.delete
  end
  
# called on plugin installation
  def self.up
    if CustomField.find_by_name(MOBILE_FIELD_NAME).nil?
      CustomField.create(
        name: MOBILE_FIELD_NAME,
        field_format: 'string',
        type: 'UserCustomField',
        description: 'A users mobile phone number'
      )
    end
  end
end
