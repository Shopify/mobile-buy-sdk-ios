Pod::Spec.new do |s|

  s.name                = 'Mobile-Buy-SDK'
  s.version             = '3.0.6'
  s.summary             = 'Create custom Shopify storefront on iOS.'
  s.description         = 'Shopify’s Mobile Buy SDK makes it simple to create custom storefronts in your mobile app. Utitlizing the power and flexibility of GraphQL you can build native storefront experiences using the Shopify platform.'
  s.homepage            = 'https://github.com/Shopify/mobile-buy-sdk-ios'
  s.author              = 'Shopify Inc.'
  s.platform            = :ios, '10.0'
  s.module_name         = 'MobileBuySDK'
  s.requires_arc        = true
  
  s.license = { 
    :type => 'MIT', 
    :file => 'LICENSE' 
  }
  
  s.source = { 
    :git        => 'https://github.com/Shopify/mobile-buy-sdk-ios.git', 
    :tag        => s.version, 
    :submodules => true 
  }
  
  s.source_files = 'Buy/**/*.{h,m,c,swift}', 'Pay/**/*.{swift}', 'Dependencies/Swift Gen/support/Sources/GraphQL.swift'
  s.xcconfig = { 
    "GCC_PREPROCESSOR_DEFINITIONS" => '$(inherited) COCOAPODS=1'
  }
  
end
