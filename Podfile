def networking
 pod 'Alamofire', '~> 4.0'
 pod 'AlamofireImage', '~> 3.1'
end

def log
 pod 'XCGLogger', '~> 4.0.0'
end

def mapper
 pod 'ObjectMapper', '~> 2.2'
end

def rx
 pod 'RxSwift',    '~> 3.0'
 pod 'RxCocoa',    '~> 3.0'
end

def common_pods
 networking
 log
 mapper
 rx
end

platform :ios, '9.2'
use_frameworks!
inhibit_all_warnings!

xcodeproj 'StackOverflow.xcodeproj'

target :StackOverflow do
 common_pods
end

target :StackOverflowTests do
 common_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.2'
    end
  end
end
