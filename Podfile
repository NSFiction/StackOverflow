def common_pods
 pod 'Alamofire'
 pod 'PKHUD'
 pod 'XCGLogger', '~> 3.2'
end

platform :ios, '8.0'
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
  puts "#{target.name}"
 end
end
