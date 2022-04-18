class Address < ApplicationRecord
  belongs_to :user
  validates :house_number, 
            :street,
            :town,
            :city,
            :country,
            :zip_code,
            :mobile_number,
            :user_id,
            :state,
            presence: true
end
