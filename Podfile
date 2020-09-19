# Uncomment the next line to define a global platform for your project
platform :ios, '14'

post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
  end
 end
end

target 'FooTeam' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for FooTeam

pod 'Firebase/Analytics'
pod 'Firebase/Auth'
pod 'Firebase/Firestore'
pod 'Firebase/Storage'
pod 'GoogleSignIn'
pod 'MessageKit'
pod 'SDWebImage', '~> 5.0'
pod 'SDWebImageSwiftUI'

end
