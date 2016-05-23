#
# Be sure to run `pod lib lint RealmDefaults.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "RealmDefaults"
  s.version          = "0.4.1"
  s.summary          = "RealmDefaults is a Simple value store."

  s.description      = <<-DESC
                       RealmDefaults is a Simple value store. Replacement for NSUserDefaults
                       DESC

  s.homepage         = "https://github.com/muukii/RealmDefaults"
  s.license          = 'MIT'
  s.author           = { "muukii" => "m@muukii.me" }
  s.source           = { :git => "https://github.com/muukii/RealmDefaults.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/muukii0803'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'

  s.dependency 'RealmSwift', '~> 0.100.0'
end
