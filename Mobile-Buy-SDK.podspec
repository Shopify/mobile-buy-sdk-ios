Pod::Spec.new do |s|

  s.name                = 'Mobile-Buy-SDK'
  s.version             = '6.1.0'
  s.summary             = 'Create custom Shopify storefront on iOS.'
  s.description         = 'Shopify’s Mobile Buy SDK makes it simple to create custom storefronts in your mobile app. Utitlizing the power and flexibility of GraphQL you can build native storefront experiences using the Shopify platform.'
  s.homepage            = 'https://github.com/Shopify/mobile-buy-sdk-ios'
  s.author              = 'Shopify Inc.'
  s.module_name         = 'MobileBuySDK'
  s.requires_arc        = true
  s.platforms           = {
    :ios     => '12.0',
    :watchos => '3.1',
    :tvos    => '12.0'
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

  s.swift_version        = '5.0'
  s.source_files         = 'Buy/**/*.{swift}'
  s.exclude_files        = 'Pay/Utilities/Log.swift'
  s.ios.source_files     = 'Pay/**/*.{swift}'
  s.watchos.source_files = 'Pay/**/*.{swift}'

end
