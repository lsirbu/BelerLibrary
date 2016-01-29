
Pod::Spec.new do |s|
s.name             = "BelerLibrary"
s.version          = "0.1.0"
s.summary          = "Just testing out a cocoapod library"
s.description      = <<-DESC
This is a sample library, testing things out!
DESC
s.homepage         = "https://github.com/lsirbu/BelerLibrary"
# s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
s.license          = 'MIT'
s.author           = { "lsirbu" => "lsirbu@belersoft.ro" }
s.source           = { :git => "https://github.com/lsirbu/BelerLibrary.git", :tag => s.version.to_s }

s.platform     = :ios, '7.0'
s.requires_arc = true

s.source_files = 'Pod/Classes'
s.resource_bundles = {
'BelerLibrary' => ['Pod/Assets/*.png']
}
end
