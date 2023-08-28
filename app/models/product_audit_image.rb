class ProductAuditImage < ApplicationRecord
    belongs_to :product
    belongs_to :scan
end