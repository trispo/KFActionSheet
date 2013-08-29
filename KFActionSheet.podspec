#
# Be sure to run `pod spec lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about the attributes see http://docs.cocoapods.org/specification.html
#
Pod::Spec.new do |s|
  s.name         = "KFActionSheet"
  s.version      = "0.0.1"
  s.summary      = "A customizable action sheet for iPhone (iOS 6+)."
  #s.description  = <<-DESC
                    #An optional longer description of KFActionSheet

                    #* Markdown format.
                    #* Don't worry about the indent, we strip it!
                   #DESC
  s.homepage     = "https://github.com/trispo/KFActionSheet"
  s.screenshots  = "https://github.com/trispo/KFActionSheet/Screenshots/screenshot.png"
  s.license      = 'MIT'
  s.author       = { "Gunnar Herzog" => "gunnar.herzog@kf-interactive.com" }
  s.source       = { :git => "https://github.com/trispo/KFActionSheet.git", :tag => s.version.to_s }

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'Classes/ios'
  s.resources = 'Assets'

  s.ios.exclude_files = 'Classes/osx'
  s.osx.exclude_files = 'Classes/ios'
end
