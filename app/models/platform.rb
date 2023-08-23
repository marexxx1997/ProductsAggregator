class Platform < ApplicationRecord
    validates :name, :url, :logo_url, presence: true
    validates :name, :url, :logo_url, uniqueness: true
    validates :logo_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'}
    def platform_url(product_name)
        platform_url_merged = self.url.gsub(/\s+/, '')
        case self.name
        when 'Univerzalno', 'Mobishop', 'IQ Mobile'
            "#{platform_url_merged}?s=#{CGI.escape(product_name)}&post_type=product"
        when 'fonTELe'
            "#{platform_url_merged}/catalogsearch/result/?q=#{CGI.escape(product_name)}"
        when 'AAR Mekline'
            "#{platform_url_merged}?post_type=product&s=#{CGI.escape(product_name)}"
        end
    end

    def get_name(product)
        case self.name
        when 'Univerzalno'
            name = product.css('.woocommerce-loop-product__title').text.strip
        when 'Mobishop'
            name = product.css('.woocommerce-loop-product__title').text.strip
        when 'fonTELe'
            name = product.css('.product-item-link').text.strip
        when 'IQ Mobile'    
            name = product.css('.product-title').text.strip
        when 'AAR Mekline'
            name = product.css('.product-title').text.strip
        end
    end
    def get_image_url(product)
        case self.name
        when 'Univerzalno'
            image_url = product.css('img.attachment-woocommerce_thumbnail').attr('data-src').to_s
        when 'Mobishop'
            image_url = product.css('img.attachment-woocommerce_thumbnail').attr('src').to_s
        when 'fonTELe'
            image_url = product.css('.product-image-photo').attr('data-mst-lazy-src').to_s.strip
        when 'IQ Mobile'    
            image_url = product.css('.attachment-shop_catalog').attr('src').to_s
        when 'AAR Mekline'
            image_url = product.css('.attachment-woocommerce_thumbnail').attr('src').to_s
        end
    end

    def get_product_url(product)
        case self.name
        when 'Univerzalno'
            # product_url = product.css('.product-title a').attribute('href').
            product_url = product.css('a.woocommerce-LoopProduct-link.woocommerce-loop-product__link').attribute('href').value
        when 'Mobishop'
            product_url = product.css('.product-title a').attribute('href').value
        when 'fonTELe'
            product_url = product.css('.product-thumb a').attribute('href').value
        when 'IQ Mobile'
            product_url = product.css('.product-image a').attribute('href').value
        when 'AAR Mekline'
            product_url = product.css('.product-title a').attribute('href').value
        end
    end
end
