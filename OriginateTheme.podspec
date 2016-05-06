Pod::Spec.new do |s|
  s.name                = "OriginateTheme"
  s.version             = "0.0.1"
  s.summary             = "A lightweight user interface theming framework."
  s.homepage            = "https://github.com/Originate/OriginateTheme"
  s.license             = 'MIT'
  s.author              = { "Philip Kluz" => "philip.kluz@originate.com" }
  s.source              = { :git => "https://github.com/Originate/OriginateTheme.git", :tag => s.version.to_s }
  s.platform            = :ios, '8.0'
  s.requires_arc        = true
  s.source_files        = 'Pod/Sources/**/*'
  s.public_header_files = 'Pod/Sources/**/*.h'
end
