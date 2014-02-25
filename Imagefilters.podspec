Pod::Spec.new do |s|

  s.name         = "Imagefilters"
  s.version      = "0.0.1"
  s.summary      = "This is a short description of Imagefilters."
  s.homepage     = "https://github.com/sandeshpujarmindtree/mysources"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author             = { "sandeshpujarmindtree" => "sandesh_pujar@mindtree.com" }

  s.source       = { :git => "https://github.com/sandeshpujarmindtree/mysources.git", :tag => "0.0.1" }

  s.platform     = :ios, '5.0'
  s.source_files  = '*.{h,m}'
  s.requires_arc = true

end
