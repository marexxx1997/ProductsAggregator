class ScansController < ApplicationController
    def index
      @scans = Scan.all
      count_per_scan_id = ProductAudit.group(:scan_id).count
      @count_per_scan_id = count_per_scan_id
    end

    def show
      @scan = Scan.find(params[:id])
    end

    def start_scan 
      scan = Scan.new
      scan.save
      scan_id = scan.id
      puts ">>>>>>>>>>>>>>>ScanId:#{scan_id}<<<<<<<<<<<<"

      PlatformProduct.all.each do |platform_product|
            current_state = platform_product.current_state
            if current_state == 'approved'
              # puts ">>>>>>>>>>>>>>>Id:#{platform_product.id}<<<<<<<<<<<<"
              platform_product_id = platform_product.id
              # product_id = platform_product.product_id
              # puts ">>>>>>>>>>>>>>>IdProduct:#{product_id}<<<<<<<<<<<<"
              # product_name = Product.find_by(id: product_id).name
              # product_name = product.name
              # puts ">>>>>>>>>>NameProduct:#{product_name}<<<<<<<"
              # image_url = Candidate.find_by(platform_product_id: platform_product.id, selected: true).image_url
              # puts ">>>>>>>>>>ImageUrl:#{image_url}<<<<<<<"
              ScanJob.perform_later(platform_product_id, scan_id)
            end
        end  
        # approved_platform_products.each do |approved_platform_product|
        #     puts ">>>>>>>>>>>>>>#{approved_platform_product.id}<<<<<<<<<<"
        # end
    end
end
