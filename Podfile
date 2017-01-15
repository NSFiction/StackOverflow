def common_pods
 pod 'Alamofire', '~> 3.5.1'
 pod 'PKHUD'
 pod 'XCGLogger', '~> 3.2'
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
      config.build_settings['SWIFT_VERSION'] = '2.3'
    end
  end
end
