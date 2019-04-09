Pod::Spec.new do |s|

  s.name                = 'Mobile-Buy-SDK'
  s.version             = '3.4.0'
  s.summary             = 'Create custom Shopify storefront on iOS.'
  s.description         = 'Shopify’s Mobile Buy SDK makes it simple to create custom storefronts in your mobile app. Utitlizing the power and flexibility of GraphQL you can build native storefront experiences using the Shopify platform.'
  s.homepage            = 'https://github.com/Shopify/mobile-buy-sdk-ios'
  s.author              = 'Shopify Inc.'
  s.module_name         = 'MobileBuySDK'
  s.requires_arc        = true
  s.platforms           = {
    :ios     => '9.0',
    :watchos => '3.1',
    :tvos    => '9.0'
  }

  s.license = {
    :type => 'MIT',
    :file => 'LICENSE'
  }

  s.source = {
    :git        => 'https://github.com/Shopify/mobile-buy-sdk-ios.git',
    :tag        => s.version,
    :submodules => true
  }

  s.source_files         = 'Buy/**/*.{h,m,c,swift}', 'Dependencies/Swift Gen/support/Sources/GraphQL.swift'
  s.ios.source_files     = 'Pay/**/*.{swift}'
  s.watchos.source_files = 'Pay/**/*.{swift}'

  s.xcconfig = {
    "GCC_PREPROCESSOR_DEFINITIONS" => '$(inherited) COCOAPODS=1'
  }

end
