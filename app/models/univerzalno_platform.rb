class UniverzalnoPlatform < Platform
    def platform_url(product_name)
        "https://www.univerzalno.com/?s=#{CGI.escape(product_name)}&post_type=product"
    end
    def get_name(product)
        name = product.css('.woocommerce-loop-product__title').text.strip
    end
    def get_image_url(product)
        image_url = product.css('img.attachment-woocommerce_thumbnail').attr('data-src').to_s
    end
    def get_product_url(product)
        product_url = product.css('a.woocommerce-LoopProduct-link.woocommerce-loop-product__link').attribute('href').value
    end

    def get_price(doc_url)
        product_audit_price = doc_url.at_css(".price del span.woocommerce-Price-amount.amount bdi")
    end
end 