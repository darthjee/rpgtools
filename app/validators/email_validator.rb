class EmailValidator < ActiveModel::EachValidator
  REGEXP = /^[\w]+([_.+][\w\d]+)*@[\w]+([._]?[\w\d]+)*(\.[\w\d]{2,3}){1,2}$/

  def validate_each(record, attribute, value)
    return if value =~ REGEXP
    record.errors[attribute] << (options[:message] || :invalid_email_format)
  end
end
