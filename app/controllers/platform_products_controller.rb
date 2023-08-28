class PlatformProductsController < ApplicationController
    def update_platform_product_status
      puts "Printing data in controller..."
      candidate = Candidate.find(params[:candidate_id])
      puts "Candidate ID: #{candidate.id}"
      platform_product = PlatformProduct.find(candidate.platform_product_id)
      puts "Platform product ID: #{platform_product.id}"
      candidate.update(selected: true)
      candidate.save
      puts "Candidate updated: #{candidate.inspect}"
      platform_product.transition_to!(:approved)
      render json: platform_product.to_json
    end
  end
  