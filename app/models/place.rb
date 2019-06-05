class Place < ApplicationRecord
	#validation
	validates :name, presence: true
	validates :address, presence: true
	validates :description, presence: true
end
