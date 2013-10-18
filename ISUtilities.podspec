Pod::Spec.new do |s|

  s.name         = "ISUtilities"
  s.version      = "0.0.2"
  s.summary      = "Objective-C utility classes"
  s.homepage     = "https://github.com/jbmorley/glue"
  s.license      = { :type => 'MIT', :file => 'LICENSE.md' }

  s.author       = { "Jason Barrie Morley" => "jason.morley@inseven.co.uk" }

  s.source       = { :git => "https://github.com/jbmorley/glue.git", :branch => "master" }

  s.source_files = 'utilities', '*.{h,m}'

  s.requires_arc = true

  s.platform = :ios, "6.0", :osx, "10.8"

end
