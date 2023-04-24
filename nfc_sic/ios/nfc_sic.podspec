Pod::Spec.new do |s|
  s.name             = 'nfc_sic'
  s.version          = '1.2.0'
  s.summary          = 'This is flutter plugin using NFC feature for SIC chip.'
  s.description      = <<-DESC
This is flutter plugin using NFC feature for SIC chip.
                       DESC
  s.homepage         = 'http://www.sic.co.th'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Sukawit Charoendet' => 'sukawit.ch@sic.co.th' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  # s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end