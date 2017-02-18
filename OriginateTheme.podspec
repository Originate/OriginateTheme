Pod::Spec.new do |s|
  s.name                = 'OriginateTheme'
  s.version             = '2.0.0-alpha'
  s.summary             = 'OriginateTheme is a lightweight user interface theming framework.'
  s.homepage            = 'https://github.com/Originate/OriginateTheme'
  s.license             = 'MIT'
  s.authors             = { 'Philip Kluz' => 'philip.kluz@originate.com',
                            'Robert Weindl' => 'robert.weindl@originate.com',
                            'Allen Wu' => 'allen.wu@originate.com',
                            'Danny Chhay' => 'danny.chhay@originate.com' }
  s.source              = { git: 'https://github.com/Originate/OriginateTheme.git', branch: 'swift-3-support' }
  s.platform            = :ios, '9.0'
  s.requires_arc        = true
  s.source_files        = 'OriginateTheme/Sources/**/*.{h,m,swift}'
  s.public_header_files = 'OriginateTheme/Sources/**/*.h'
  s.preserve_path       = 'OriginateTheme/Scripts/*.py'
end
