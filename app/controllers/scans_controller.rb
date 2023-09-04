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

      PlatformProduct.all.each do |platform_product|
        current_state = platform_product.current_state
        if current_state == 'approved'
          platform_product_id = platform_product.id
          ScanJob.perform_later(platform_product_id, scan_id)
        end
      end  
    end
end
