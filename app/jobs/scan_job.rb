class ScanJob < ApplicationJob
    queue_as :default

    def perform(platform_product_id, scan_id)
        product_id = PlatformProduct.find_by(id: platform_product_id).product_id
        puts ">>>>>>>>>>>>>>New scan for product with id:#{product_id}<<<<<<<<<<<<"
        product_name = Product.find_by(id: product_id).name
        puts ">>>>>>>>>>>>>>New scan for product with id:#{product_name}<<<<<<<<<<<<"
        image_url = Candidate.find_by(platform_product_id: platform_product_id, selected: true).image_url
        puts ">>>>>>>>>>ImageUrl:#{image_url}<<<<<<<"

        product_audit = ProductAudit.new(image_url: image_url, product_id: product_id, scan_id: scan_id)
        if product_audit.save
            puts "Product audit successfully saved: #{product_audit.inspect}"
        else
            puts "Error saving candidate: #{product_audit.errors.full_messages.join(', ')}"
        end
    end
end