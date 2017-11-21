# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'demo' do
    use_frameworks!
    pod 'RxSwift',    '~> 4.0'
    pod 'RxCocoa',    '~> 4.0'
    pod 'RxDataSources'
    pod 'SnapKit', '~> 4.0'

    pod 'SwiftyJSON'
    pod 'RxGesture'

    pod 'DeallocationChecker', '~> 1.0.2'
    
    post_install do |installer|
        installer.pods_project.targets.each do |target|
            if target.name == ‘RxSwift’
                target.build_configurations.each do |config|
                    if config.name == ‘Debug’
                        config.build_settings[‘OTHER_SWIFT_FLAGS’] ||= [‘-D’, ‘TRACE_RESOURCES’]
                    end
                end
            end
        end
    end
    
end
