
require 'nokogiri'
require 'open-uri'

class ProcessPlatformJob < ApplicationJob
  queue_as :default

  def perform(platform_product_id)
    platform_product = PlatformProduct.find(platform_product_id)
    platform = platform_product.platform
    product_name = platform_product.product.name

    return unless platform
   
    search_url = platform.platform_url(product_name)

    platform_product.transition_to!(:in_progress)

    doc = Nokogiri::HTML(URI.open(search_url))
    # puts "#{doc}"
    products = doc.css(' .product')

    products.each do |product|
      name = platform.get_name(product)
      image_url = platform.get_image_url(product)
      product_url = platform.get_product_url(product)

      candidate = Candidate.new(name: name, url: product_url, image_url: image_url, platform_product_id: platform_product_id)
      if candidate.save
        puts "Candidate successfully saved: #{candidate.inspect}"
      else
        puts "Error saving candidate: #{candidate.errors.full_messages.join(', ')}"
      end
    end

    platform_product.transition_to!(:located)
  end
end
