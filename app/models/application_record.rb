class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.human_enum_name(enum_name)
    I18n.t("activerecord.attributes.#{model_name.
           i18n_key}.#{enum_name.to_s.pluralize}")
  end
end
