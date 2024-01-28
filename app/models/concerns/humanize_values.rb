module HumanizeValues
  extend ActiveSupport::Concern

  # Fetch all humanize values for an enum
  # Return an array
  # Example: ['female', 'male', 'unknown'] => ['Nữ', 'Nam', 'Không xác định']
  def values(enum_name)
    model_name = self.to_s.underscore
    self.send(enum_name).keys.map { |key| [I18n.t("activerecord.enums.#{model_name}.#{enum_name}.#{key}"), key]  }
  end
end