Pod::Spec.new do |s|

  s.name         = "ISUtilities"
  s.version      = "1.1.0"
  s.summary      = "Objective-C utility classes"
  s.homepage     = "https://github.com/jbmorley/ISUtilities"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Jason Barrie Morley" => "jason.morley@inseven.co.uk" }
  s.source       = { :git => "https://github.com/jbmorley/ISUtilities.git", :tag => "1.1.0" }

  s.ios.deployment_target = '6.0'
  s.osx.deployment_target = '10.9'

  s.source_files = 'ISUtilities/*.{h,m}'

  s.requires_arc = true

  s.subspec 'UIKit+ISUtilities' do |ss|
    ss.platform = :ios
    ss.source_files = 'UIKit+ISUtilities/*.{h,m}'
  end

end
