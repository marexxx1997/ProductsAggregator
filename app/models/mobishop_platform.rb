class MobishopPlatform < Platform
        def platform_url(product_name)
            "https://www.mobishop.ba/?s=#{CGI.escape(product_name)}&post_type=product"
        end 
        def get_name(product)
            name = product.css('.woocommerce-loop-product__title').text.strip
        end
        def get_image_url(product)
            image_url = product.css('img.attachment-woocommerce_thumbnail').attr('src').to_s
        end
        def get_product_url(product)
            product_url = product.css('.product-title a').attribute('href').value
        end
        def get_price(doc_url)
            product_audit_price = doc_url.at('del span.woocommerce-Price-amount.amount bdi span.woocommerce-Price-amount.amount bdi')
        end
end