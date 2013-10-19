Pod::Spec.new do |s|

  s.name         = "ISUtilities"
  s.version      = "0.0.1"
  s.summary      = "Objective-C utility classes"
  s.homepage     = "https://github.com/jbmorley/ISUtilities"
  s.license      = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author       = { "Jason Barrie Morley" => "jason.morley@inseven.co.uk" }
  s.source       = { :git => "https://github.com/jbmorley/ISUtilities.git", :commit => "9046b659c8e3e76b4a7d8888873168a64d5362c1" }

  s.source_files = 'Classes/*.{h,m}'

  s.requires_arc = true

  s.platform = :ios, "6.0", :osx, "10.8"

end
