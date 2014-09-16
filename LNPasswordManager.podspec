#
# Be sure to run `pod lib lint LNPasswordManager.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "LNPasswordManager"
  s.version          = "0.1.0"
  s.summary          = "A simple keychain password manager. Enables syncing with iCloud"
  s.description      = <<-DESC
                       LNPasswordManager can be used to simply manage passwords
                       and key/value pairs in the iOS keychain.
                       
                       It contains some helper methods for verifying passwords and can also
                       be synced to iCloud keychain by configurable options.
                       DESC
  s.homepage         = "https://github.com/NilSkilz/LNPasswordManager"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "NilSkilz" => "rob_stokes@me.com" }
  s.source           = { :git => "https://github.com/NilSkilz/LNPasswordManager.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/limeNinjas'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'LNPasswordManager/*'
  s.resource_bundles = {
    'LNPasswordManager' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
