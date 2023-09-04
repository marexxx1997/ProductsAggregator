class PlatformFactory

    def create_instance(platform_name)
        case platform_name
        when :univerzalno
            UniverzalnoPlatform.new
        when :mobishop
            MobishopPlatform.new    
        when :fontele
            FontelePlatform.new
        when :iq_mobile
            IQMobilePlatform.new
        when :aar_mekline
            AARMeklinePlatform.new
        else
            puts "Don't match for platform_name: #{platform_name}"
            nil
        end
    end
    
end