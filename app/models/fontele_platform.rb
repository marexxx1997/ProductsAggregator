class FontelePlatform < Platform
    def platform_url(product_name)
        "https://www.fontele.ba/catalogsearch/result/?q=#{CGI.escape(product_name)}"
    end
    def get_name(product)
        name = product.css('.product-item-link').text.strip
    end
    def get_image_url(product)
        image_url = product.css('.product-image-photo').attr('data-mst-lazy-src').to_s.strip
    end
    def get_product_url(product)
        product_url = product.css('.product-thumb a').attribute('href').value
    end
end