class CandidatesController < ApplicationController
    def show
        platform_id = params[:platform_id]
        platform_product_id = params[:platform_product_id]
        puts "Platform product ID: #{platform_product_id}"
        candidates = Candidate.where(platform_product_id: platform_product_id)
        approved_candidates = candidates.find_by(selected: true)
        @approved_candidates_url = approved_candidates&.url
        puts ">>>>>>>>>>>Approved candidate: #{@approved_candidates_url}<<<<<<<<<<"

        respond_to do |format|
            format.json { render json: candidates }
        end
    end  
end