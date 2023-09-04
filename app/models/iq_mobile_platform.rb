class IQMobilePlatform < Platform
    def platform_url(product_name)
        "https://www.iqmobile.ba/catalogsearch/result/?q=#{CGI.escape(product_name)}"
    end
    def get_name(product)
        name = product.css('.product-title').text.strip
    end
    def get_image_url(product)
        image_url = product.css('.attachment-shop_catalog').attr('src').to_s
    end
    def get_product_url(product)
        product_url = product.css('.product-image a').attribute('href').value
    end
end