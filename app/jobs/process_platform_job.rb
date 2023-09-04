require 'nokogiri'
require 'open-uri'
$platform_factory = PlatformFactory.new

class ProcessPlatformJob < ApplicationJob
  queue_as :default

  def perform(platform_product_id)

    platform_product = PlatformProduct.find(platform_product_id)
    platform = platform_product.platform
    concrete_platform = $platform_factory.create_instance(platform.name.to_sym)

    product_name = platform_product.product.name

    search_url = concrete_platform.platform_url(product_name)

    platform_product.transition_to!(:in_progress)

    doc = Nokogiri::HTML(URI.open(search_url))
    products = doc.css(' .product').uniq
    products.each do |product|
      name = concrete_platform.get_name(product) 
      image_url = concrete_platform.get_image_url(product)
      product_url = concrete_platform.get_product_url(product)

      candidate = Candidate.new(name: name, url: product_url, image_url: image_url, platform_product_id: platform_product_id)
      if candidate.save
        puts "Candidate successfully saved: #{candidate.inspect}"
      else
        puts "Error saving candidate: #{candidate.errors.full_messages.join(', ')}"
        platform_product.transition_to!(:error)
      end
    end

    platform_product.transition_to!(:located)
  end
end
