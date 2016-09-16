Pod::Spec.new do |s|
  s.name                = 'OriginateTheme'
  s.version             = '1.0.0'
  s.summary             = 'OriginateTheme is a lightweight user interface theming framework.'
  s.homepage            = 'https://github.com/Originate/OriginateTheme'
  s.license             = 'MIT'
  s.authors             = { 'Philip Kluz' => 'philip.kluz@originate.com', 'Robert Weindl' => 'robert.weindl@originate.com' }
  s.source              = { :git => 'https://github.com/Originate/OriginateTheme.git', :tag => s.version.to_s }
  s.platform            = :ios, '8.0'
  s.requires_arc        = true
  s.source_files        = 'OriginateTheme/{Sources, Scripts}/**/*{.h, .m, .rb, .py, .sh}'
  s.public_header_files = 'OriginateTheme/Sources/**/*.h'
  # s.prepare_command     = "ruby OriginateTheme/Scripts/install_run_script.rb '#{path}'"
end
