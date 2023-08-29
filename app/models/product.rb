class Product < ApplicationRecord
    validates :name, presence: true
    validates :name, uniqueness: true
    has_many :platform_products, dependent: :destroy
end
