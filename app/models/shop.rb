class Shop < ApplicationRecord
	belongs_to :user
	belongs_to :category
	validates :title, :description, :price, :color, presence: true
	has_one_attached :image
end
