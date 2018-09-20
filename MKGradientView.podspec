Pod::Spec.new do |s|
  s.name             = "MKGradientView"
  s.version          = "2.0"
  s.summary          = "Highly customizable Core Graphics based gradient view"
  s.homepage         = "https://github.com/maxkonovalov/MKGradientView"
  s.license          = 'MIT'
  s.author           = "Max Konovalov"
  s.source           = { :git => "https://github.com/maxkonovalov/MKGradientView.git", :tag => s.version.to_s }

  s.platform     = :ios, "8.0"
  s.requires_arc = true

  s.source_files = "MKGradientView/**/*.swift"

  s.frameworks = "UIKit"
end
