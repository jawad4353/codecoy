 .ios/Flutter/podhelper.rb

# Uncomment this line to define a global platform for your project
 platform :ios, '9.0'

def flutter_additional_ios_build_settings(target)
  # Add custom build settings here. For example:

  # Enable Swift support (if you're using Swift in your project)
  # target.build_configurations.each do |config|
  #   config.build_settings['ENABLE_BITCODE'] = 'NO'
  #   config.build_settings['SWIFT_VERSION'] = '5.0'
  # end

  # Configure Firebase pods
  # if target.platform_name == :ios
  #   target 'Runner' do
  #     pod 'Firebase/Auth'
  #     pod 'Firebase/Core'
  #   end
  # end

  # Specify custom pod configurations
  # if target.platform_name == :ios
  #   target 'Runner' do
  #     # Add pods for Flutter plugins.
  #     # Examples:
  #     # pod 'SomeLibrary', :path => '../'
  #     # pod 'AnotherLibrary', :path => '../../'

  #     # Add more pods here as needed
  #   end
  # end
end
