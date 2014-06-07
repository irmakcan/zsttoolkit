
Pod::Spec.new do |s|
  s.name         = "ZSTToolkit"
  s.version      = "0.0.2"
  s.summary      = "A set of classes/categories to make your iOS life easier."

  s.description  = %{
    ZSTToolkit includes a set of utility and helper classes.
  }

  s.homepage     = "https://github.com/irmakcan/ZSTToolkit"

  s.license      = { :type => "MIT", :file => "LICENSE" }
  
  s.authors            = { "Irmak Can Ozsut" => "irmakcan@irmakcan.com" }
  s.social_media_url   = "http://twitter.com/irmakcanozsut"

  s.platform     = :ios, "6.0"
  s.requires_arc = true
  s.source       = { :git => "https://github.com/irmakcan/ZSTToolkit.git", :tag => "v#{s.version}" }
  s.source_files  = "ZSTToolkit/**/*.{h,m}"

  s.ios.frameworks = 'Foundation', 'UIKit', 'CoreGraphics'
end
