class Platform < ApplicationRecord

    validates :name, :url, :logo_url, presence: true
    validates :name, :url, :logo_url, uniqueness: true
    validates :logo_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'}
  
    enum name: {
      univerzalno: 'Univerzalno',
      mobishop: 'Mobishop',
      iq_mobile: 'IQ Mobile',
      fontele: 'fonTELe',
      aar_mekline: 'AAR Mekline'
    }

    def platform_url(product_name)
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

    def get_name(product)
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

    def get_image_url(product)
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

    def get_product_url(product)
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

    def get_price(doc_url)
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end
end
