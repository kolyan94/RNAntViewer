
Pod::Spec.new do |s|
  s.name         = "RNAntViewer"
  s.version      = "1.0.5"
  s.summary      = "RNAntViewer"
  s.description  = <<-DESC
                  RNAntViewer bla bla
                   DESC
  s.homepage     = "https://github.com/kolyan94/RNAntViewer"
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author       = { "author" => "author@domain.cn" }
  s.platform     = :ios, "11.3"
  s.source       = { :git => "https://github.com/kolyan94/RNAntViewer.git", :tag => s.version.to_s }
  s.source_files  = "ios/**/*.{h,m,swift}"
  s.requires_arc = true

  s.static_framework = true
  s.dependency "React"
  s.dependency "AntViewer_ios"

end
