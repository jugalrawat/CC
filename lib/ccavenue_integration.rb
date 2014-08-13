# Payment Name    : CCAvenue  Shopify
# Description          : Extends Payment with  CCAvenue
# Shopify version  : write
# CCAvenue Version  : 1.3.x
# Module Version    : bz-1.0
# Author              : BlueZeal SoftNet
# Web: www.bluezeal.in
# Copyright         : © 2013-2014

require File.dirname(__FILE__) + '/ccavenue_integration/helper.rb'
require File.dirname(__FILE__) + '/ccavenue_integration/notification.rb'


require File.dirname(__FILE__) + '/ccavenue_integration/crypto.rb'
require File.dirname(__FILE__) + '/ccavenue_integration/ccavRequestHandler.rb'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module CcavenueIntegration

        mattr_accessor :production_url
      self.production_url = 'http://www.ccavenue.com/shopzone/cc_details.jsp'
    
    
    def self.service_url
          mode = ActiveMerchant::Billing::Base.integration_mode
          case mode
          when :production
            self.production_url
          when :test
            self.production_url
          else
            raise StandardError, "Integration mode set to an invalid value: #{mode}"
          end
        end
    

        def self.notification(post)
          Notification.new(post)
        end
      end
    end
  end
end
