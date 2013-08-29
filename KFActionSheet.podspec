Pod::Spec.new do |s|
  s.name         = "KFActionSheet"
  s.version      = "0.0.1"
  s.summary      = "A customizable action sheet for iPhone (iOS 6+)."
  #s.description  = <<-DESC
                    #An optional longer description of KFActionSheet

                    #* Markdown format.
                    #* Don't worry about the indent, we strip it!
                   #DESC
  s.homepage     = "pods.kf-interactive.com"
  s.screenshots  = "https://github.com/trispo/KFActionSheet/Screenshots/screenshot.png"
  s.license      = 'MIT'
  s.author       = { "Gunnar Herzog" => "gunnar.herzog@kf-interactive.com", "Rico Becker" => "rico.becker@kf-interactive.com" }
  s.source       = { :git => "https://github.com/trispo/KFActionSheet.git", :tag => s.version.to_s }

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'Classes/ios'
  s.resources = 'Assets'

  s.ios.exclude_files = 'Classes/osx'
  s.osx.exclude_files = 'Classes/ios'
end
