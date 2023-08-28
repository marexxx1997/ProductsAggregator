class Candidate < ApplicationRecord
    belongs_to :platform_product

    validates :name, :url, :image_url, presence: true
#     validates :image_url, allow_blank: true, format: {
#     with: %r{\.(gif|jpg|png)\z}i,
#     message: 'must be a URL for GIF, JPG or PNG image.'
# }
end
