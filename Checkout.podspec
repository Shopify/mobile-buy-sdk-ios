Pod::Spec.new do |s|

  s.name         = "Checkout"
  s.version      = "1.0"
  s.summary      = "An iOS library to create apps to purchase items off of Shopify Stores."
  s.description  = <<-DESC
                   An iOS library to create apps to purchase items off of Shopify Stores using ApplePay or Credit Cards. This library takes advantage of Shopify's Checkout API.
                   DESC
  s.homepage     = "https://www.shopify.com"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = "Shopify Inc."
  s.platform     = :ios
  s.platform     = :ios, "8.0"
  s.source       = { :http => "https://www.dropbox.com/s/4rx7k007crlad3r/Checkout.framework.zip?dl=1" }
  s.vendored_frameworks = "Checkout.framework"
  s.frameworks   = "PassKit"

end
