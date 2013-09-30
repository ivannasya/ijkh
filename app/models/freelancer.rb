class Freelancer < ActiveRecord::Base
  attr_accessible :freelance_category_id, :description, :phone, :picture_url, :title, :work_time, :name

  belongs_to :freelance_category
end
