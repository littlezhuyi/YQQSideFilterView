Pod::Spec.new do |s|

  s.name         = "XXImage"
  s.version      = "0.0.1"
  s.summary      = "XXImage."

  s.description  = <<-DESC
                    this is XXImage
                   DESC

  s.homepage     = "https://github.com/littlezhuyi"

  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author       = "xiaozhu"

  s.platform     = :ios, "8.0"

  s.source       = { :git => "git@github.com:littlezhuyi/XXImage.git", :tag => s.version.to_s }

  s.source_files  = "XXImage/XXImage/**/*.{h,m}"
  # s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"

  # s.resources  = "XXImage/XXImage/**/*.{storyboard,xib}", "XXImage/Assets.xcassets"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "AFNetworking"

end
