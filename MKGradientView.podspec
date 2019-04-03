Pod::Spec.new do |s|
  s.name = 'MKGradientView'
  s.version = '2.0.1'
  s.summary = 'Highly customizable Core Graphics based gradient view'
  s.homepage = 'https://github.com/maxkonovalov/MKGradientView'
  s.license = 'MIT'
  s.author = 'Max Konovalov'
  s.source = { git: 'https://github.com/maxkonovalov/MKGradientView.git', tag: s.version.to_s }

  s.source_files = 'MKGradientView/**/*.swift'

  s.ios.deployment_target = '8.0'

  s.swift_version = '5.0'
  s.swift_versions = ['4.0', '4.2', '5.0']

  s.frameworks = 'UIKit'
end
