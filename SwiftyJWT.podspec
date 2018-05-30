Pod::Spec.new do |s|
  s.name         = "SwiftyJWT"
  s.version      = "0.0.2"
  s.summary      = "A library to generate JWT with Swift"
  s.homepage     = "https://github.com/privakey/SwiftyJWT"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "jfischetti" => "jfischetti@privakey.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/privakey/SwiftyJWT.git" }
  s.source_files = 'Sources/**/*.swift'
  s.dependency 'SwiftyCrypto', '~> 0.0.1'
  s.swift_version = '4.0'
end