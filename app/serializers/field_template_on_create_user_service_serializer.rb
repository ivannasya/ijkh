class FieldTemplateOnCreateUserServiceSerializer < ActiveModel::Serializer
  attributes :id, :title, :tariff_template_id, :field_type, :value, :is_for_calc

  has_many :field_template_list_values
  has_one :reading_field_template

 
end
