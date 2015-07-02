#
#  Be sure to run `pod spec lint TestRedLining.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "TestRedLining"
  s.version      = "0.0.1"
  s.summary      = "Simple red lining class"

  s.description  = <<-DESC
                   This application will provide you the information required to build a red lining, drawing lines, circles, polygons above the
                   overlay of a map view. 
                   DESC

  s.homepage     = "https://github.com/neerajneeruz/TestRedLining"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Neeraj P K" => "neerajpk02@gmail.com" }
  s.social_media_url   = "https://www.facebook.com/neerajneeruz"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/neerajneeruz/TestRedLining.git", :tag => “1.0.0” }
  s.source_files  = "RedLiningMapProj"
  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
