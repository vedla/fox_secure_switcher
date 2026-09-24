#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint fox_secure_switcher.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'fox_secure_switcher'
  s.version          = '0.0.1'
  s.summary          = 'A safe screen masking Flutter plugin.'
  s.description      = <<-DESC
Apply a safe masking effect to the app screen on the app switcher or task list.
                       DESC
  s.homepage         = 'https://gitlab.com/vedla/fox_secure_switcher'
  s.license          = { :file => '../LICENSE' }
  s.source           = { :path => '.' }
  s.source_files = 'fox_secure_switcher/Sources/fox_secure_switcher/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end