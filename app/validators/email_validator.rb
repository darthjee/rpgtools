class EmailValidator < ActiveModel::EachValidator
  REGEXP = /^[a-z]+(([_.][a-z])?[a-z0-9]+)*(\+\w+)*@[\w]+([._]?[a-z0-9]+)*(\.[a-z0-9]{2,3}){1,2}$/i

  def validate_each(record, attribute, value)
    return if value =~ REGEXP
    record.errors[attribute] << (options[:message] || :invalid_email_format)
  end
end
