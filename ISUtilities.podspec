Pod::Spec.new do |s|

  s.name         = "ISUtilities"
  s.version      = "0.0.1"
  s.summary      = "Objective-C utility classes"
  s.homepage     = "https://github.com/jbmorley/ISUtilities"
  s.license      = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author       = { "Jason Barrie Morley" => "jason.morley@inseven.co.uk" }
  s.source       = { :git => "https://github.com/jbmorley/ISUtilities.git", :commit => "eca34dbff3ae5992c9e192a6d8793e4fe2499c6c" }

  s.source_files = 'Classes/*.{h,m}'

  s.requires_arc = true

  s.platform = :ios, "6.0", :osx, "10.8"

end
