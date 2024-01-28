module HumanizeValue
  extend ActiveSupport::Concern

  # Fetch humanize for a key of an enum
  # Return a string
  # Example: female => Nữ
  def value(enum_name, enum_key)
    model_name = self.class.to_s.underscore
    I18n.t("activerecord.enums.#{model_name}.#{enum_name}.#{enum_key}")
  end
end