#
#  Be sure to run `pod spec lint Echo.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "Echo"
  s.version      = "0.0.1-beta0"

  s.summary      = "Echo: Record & Replay JSON webservices responses easily!"
  s.description  = <<-EOS
  create and use JSON file to mock your app easily!"

  2 modes available:
  - record
  - mock-responses

  override json files on asset folder by following file nomenclature!
  EOS

  s.homepage     = "https://github.com/Axance-Technology-Open-Source/echo-ios" 
  s.license      = { :type => "MIT", :file => "License.md" }
  s.author       = { "Charles Legrand" => "charles.legrand@devoteam.com" }
  s.source       = { :git => "https://github.com/Axance-Technology-Open-Source/echo-ios.git", :tag => "#{s.version}" }

  s.swift_version = "5"
  s.platform      = :ios  
  s.ios.deployment_target = '8.0'

  s.source_files  = "Echo/*.{swift}"

  s.default_subspec = "Moya13"

  s.subspec "Moya14-beta" do |ss|
    ss.dependency 'Moya/Core', '~> 14.0.0-beta.0'
    ss.source_files  = "Echo/*.{swift}"
    ss.ios.deployment_target = '10.0'
  end

  s.subspec "Moya13" do |ss|
    ss.dependency 'Moya/Core', '~> 13.0'
    ss.source_files  = "Echo/*.{swift}"
  end

  s.subspec "Moya12" do |ss|
    ss.dependency 'Moya/Core', '~> 12.0'
    ss.source_files  = "Echo/*.{swift}"
  end
end
