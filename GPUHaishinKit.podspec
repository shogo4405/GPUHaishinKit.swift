Pod::Spec.new do |s|

  s.name         = "GPUHaishinKit"
  s.version      = "1.1.4"
  s.summary      = "Camera and Microphone streaming library via RTMP, HLS for iOS. Powered by GPUImage + HaishinKit"

  s.description  = <<-DESC
  GPUHaishinKit. Camera and Microphone streaming library via RTMP, HLS for iOS. Powered by GPUImage + HaishinKit
  DESC

  s.homepage     = "https://github.com/shogo4405/GPUHaishinKit.swift"
  s.license      = "New BSD"
  s.author       = { "shogo4405" => "shogo4405@gmail.com" }
  s.authors      = { "shogo4405" => "shogo4405@gmail.com" }
  s.source       = { :git => "https://github.com/shogo4405/GPUHaishinKit.swift.git", :tag => "#{s.version}" }
  s.social_media_url = "http://twitter.com/shogo4405"

  s.ios.deployment_target = "8.0"
  s.ios.source_files = "Platforms/iOS/*.{h,swift}"

  s.source_files = "Sources/**/*.swift"
  s.dependency 'GPUImage', '~> 0.1.7'
  s.dependency 'HaishinKit', '~> 0.7.4'

end
