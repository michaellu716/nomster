class Place < ApplicationRecord
	#validation
	validates :name, presence: true, length: { minimum: 3, name: "%{count}" }
	validates :address, presence: true
	validates :description, presence: true

	belongs_to :user
	has_many :comments
	has_many :photos
	geocoded_by :address
	after_validation :geocode
end
