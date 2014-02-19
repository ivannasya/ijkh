class UtilityMetric < ActiveRecord::Base
  attr_accessible :energy_phase_one, :energy_phase_two, :gas, :user_id, :vendor_id, :water_cold, :water_hot

  belongs_to :user
  belongs_to :vendor
end