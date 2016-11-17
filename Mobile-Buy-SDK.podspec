Pod::Spec.new do |s|
  s.name                = 'Mobile-Buy-SDK'
  s.version             = '2.0.1'
  s.summary             = 'Sell with Shopify in iOS apps'
  s.description         = 'Shopify’s Mobile Buy SDK makes it simple to sell physical products inside your mobile app. With a few lines of code, you can connect your app with the Shopify platform and let your users buy your products using Apple Pay or their credit card.'
  s.homepage            = 'https://developers.shopify.com/mobile-buy-sdk'
  s.license             = { :type => 'MIT', :file => 'LICENSE' }
  s.author              = 'Shopify Inc.'
  s.platform            = :ios, '8.0'
  s.resource_bundles    = { 'Buy' => 'Mobile Buy SDK/Mobile Buy SDK/Models/Mobile Buy SDK.xcdatamodeld' }
  s.source              = { :git => 'https://github.com/Shopify/mobile-buy-sdk-ios.git', :tag => s.version }
  s.source_files        = 'Mobile Buy SDK/Mobile Buy SDK/**/*.{h,m,mm}'
  s.public_header_files = 'Mobile Buy SDK/Mobile Buy SDK/Buy.h', 'Mobile Buy SDK/Mobile Buy SDK/**/*.h'
  s.header_dir          = 'Buy'
  s.module_name         = 'Buy'
  s.weak_framework      = 'PassKit'
  s.libraries           = 'c++'
  s.requires_arc        = true
end
