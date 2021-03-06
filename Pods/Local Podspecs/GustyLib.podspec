Pod::Spec.new do |s|
    s.name                  = 'GustyLib'
    s.version           = '1.0.0'
    s.summary           = 'A Cocoa Touch static library to help you develop high quality iOS apps faster.'
    s.homepage          = 'https://github.com/marcelo-schroeder/GustyLib'
    s.license           = 'Apache-2.0'
    s.author            = { 'Marcelo Schroeder' => 'marcelo.schroeder@infoaccent.com' }
    s.platform          = :ios, '8.0'
    s.requires_arc      = true
    s.source            = { :git => 'https://github.com/marcelo-schroeder/GustyLib.git', :tag => 'v1.0.0' }
    s.default_subspec   = 'CoreUI'
    s.subspec 'Foundation' do |ss|
        ss.source_files  = 'GustyLib/GustyLib/Foundation/classes/**/*.{h,m}'
    end
    s.subspec 'CoreUI' do |ss|
        ss.source_files  = 'GustyLib/GustyLib/CoreUI/classes/**/*.{h,m}'
        ss.resource      = 'GustyLib/GustyLib/CoreUI/resources/**/*.*'
        ss.dependency 'GustyLib/Foundation'
        ss.dependency 'ODRefreshControl', '1.1.0'
    end
    s.subspec 'GoogleMobileAdsSupport' do |ss|
        ss.source_files  = 'GustyLib/GustyLib/GoogleMobileAdsSupport/classes/**/*.{h,m}'
        ss.xcconfig      = { 'GCC_PREPROCESSOR_DEFINITIONS' => 'IFA_AVAILABLE_GoogleMobileAdsSupport=1' }
        ss.dependency 'GustyLib/CoreUI'
        ss.dependency 'Google-Mobile-Ads-SDK', '~> 6'
    end
    s.subspec 'FlurrySupport' do |ss|
        ss.source_files  = 'GustyLib/GustyLib/FlurrySupport/classes/**/*.{h,m}'
        ss.xcconfig      = { 'GCC_PREPROCESSOR_DEFINITIONS' => 'IFA_AVAILABLE_FlurrySupport=1' }
        ss.dependency 'GustyLib/CoreUI'
        ss.dependency 'FlurrySDK'
    end
    s.subspec 'Html' do |ss|
        ss.source_files  = 'GustyLib/GustyLib/Html/classes/**/*.{h,m}'
        ss.resource      = 'GustyLib/GustyLib/Html/resources/**/*.*'
        ss.xcconfig      = { 'GCC_PREPROCESSOR_DEFINITIONS' => 'IFA_AVAILABLE_Html=1' }
        ss.dependency 'GustyLib/CoreUI'
        ss.dependency 'DTFoundation', '1.7.2'
        ss.dependency 'MWFeedParser', '1.0.1'
    end
    s.subspec 'Help' do |ss|
        ss.source_files  = 'GustyLib/GustyLib/Help/classes/**/*.{h,m}'
        ss.resource      = 'GustyLib/GustyLib/Help/resources/**/*.*'
        ss.xcconfig      = { 'GCC_PREPROCESSOR_DEFINITIONS' => 'IFA_AVAILABLE_Help=1' }
        ss.dependency 'GustyLib/CoreUI'
        ss.dependency 'GustyLib/Html'
    end
end
