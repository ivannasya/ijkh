collection @vendors

attributes :id, :title, :merchant_id, :is_active, :inn

child :cities do
	extends 'city/index'
end

child :tariff_templates do
	extends 'tariff_template/index'
end