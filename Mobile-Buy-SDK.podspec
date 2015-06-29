Pod::Spec.new do |s|
  s.name         = 'Mobile-Buy-SDK'
  s.version      = '1.0.2'
  s.summary      = 'Sell with Shopify in iOS apps'
  s.description  = 'Shopify’s Mobile Buy SDK makes it simple to sell physical products inside your mobile app. With a few lines of code, you can connect your app with the Shopify platform and let your users buy your products using Apple Pay or their credit card.'
  s.homepage     = 'https://www.shopify.com'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = 'Shopify Inc.'
  s.platform     = :ios, '8.0'
  s.source       = { :http => 'http://cdn.shopify.com/shopify-marketing_assets/static/mobile-buy-sdk-ios-1.0.2.zip' }
  s.source_files = 'Buy.framework/Versions/Current/**/*.h'
  s.public_header_files = 'Buy.framework/**/*.h'
  s.frameworks   = 'PassKit'
  s.libraries    = 'c++'
  s.requires_arc = true
end
