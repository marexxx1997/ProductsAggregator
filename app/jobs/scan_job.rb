require 'nokogiri'
require 'open-uri'
$platform_factory = PlatformFactory.new

class ScanJob < ApplicationJob
    queue_as :default

    def perform(platform_product_id, scan_id)
        product_id = PlatformProduct.find_by(id: platform_product_id).product_id
        product_name = Product.find_by(id: product_id).name
        image_url = Candidate.find_by(platform_product_id: platform_product_id, selected: true).image_url

        product_audit = ProductAudit.new(image_url: image_url, product_id: product_id, scan_id: scan_id)
        if product_audit.save
            puts "Product audit successfully saved: #{product_audit.inspect}"
            product_audit.transition_to!(:processing)
        else
            puts "Error saving candidate: #{product_audit.errors.full_messages.join(', ')}"
        end

        product_audit_url = Candidate.find_by(platform_product_id: platform_product_id, selected: true).url
        doc = Nokogiri::HTML(URI.open(product_audit_url))
        platform_product = PlatformProduct.find(platform_product_id)
        platform = platform_product.platform
        concrete_platform = $platform_factory.create_instance(platform.name.to_sym)
        # product_audit_price = platform.get_price(doc)
        product_audit_price = concrete_platform.get_price(doc)
        if product_audit_price
            price_text = product_audit_price.text.strip
            price_float = price_text.delete('.').tr(',', '.').to_f 
            audit_price = ProductAuditPrice.new(price: price_float, product_audit_id: product_audit.id, platform_product_id: platform_product_id)
                if audit_price.save
                    puts "Product audit price successfully saved: #{audit_price.inspect}"
                    product_audit.transition_to!(:finished)
                else
                    puts "Error saving candidate: #{audit_price.errors.full_messages.join(', ')}"
                end
        else
            product_audit.transition_to!(:error)
        end
    end
end