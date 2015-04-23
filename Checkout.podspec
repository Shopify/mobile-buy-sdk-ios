Pod::Spec.new do |s|
  s.name         = "ShopifyCheckoutAnywhere"
  s.version      = "0.9.9"
  s.summary      = "An iOS library to create apps to purchase items off of Shopify Stores."

  s.description  = <<-DESC
                   An iOS library to create apps to purchase items off of Shopify Stores using ApplePay or Credit Cards. This library takes advantage of Shopify's Storefront API and its Checkout Anywhere API.
                   DESC

  s.homepage     = "https://github.com/Shopify/checkout-anywhere-ios/"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = "Shopify Inc."
  s.platform     = :ios, "8.0"
  s.source = {
    s.http = "https://www.dropbox.com/s/4rx7k007crlad3r/Checkout.framework.zip?dl=1"
  },
  s.requires_arc = true
  s.vendored_frameworks = "Checkout.framework",
  s.public_header_files = "Checkout.framework/**/*.h",
  s.frameworks = [
    "PassKit",
  ]
end
