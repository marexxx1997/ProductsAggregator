class AARMeklinePlatform < Platform
    def platform_url(product_name)
        "https://www.mekline.ba/?post_type=product&s=#{CGI.escape(product_name)}"
    end
    def get_name(product)
        name = product.css('.product-title').text.strip
    end
    def get_image_url(product)
        image_url = product.css('.attachment-woocommerce_thumbnail').attr('src').to_s
    end
    def get_product_url(product)
        product_url = product.css('.product-title a').attribute('href').value
    end
end