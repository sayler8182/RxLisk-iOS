Pod::Spec.new do |s|
  s.name = 'RxLisk-iOS'
  s.version = '1.6.0.0'
  s.summary = 'Swift 5 library for Lisk Blockchain'
  s.homepage = 'https://github.com/sayler8182/RxLisk-iOS'
  s.documentation_url = 'https://github.com/sayler8182/RxLisk-iOS'
  s.license = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author = { 'Konrad Piękoś' => 'konradpiekos93@gmail.com' }
  s.source = { :git => 'https://github.com/sayler8182/RxLisk-iOS.git', :tag => s.version.to_s }

  s.pod_target_xcconfig = { 'SWIFT_WHOLE_MODULE_OPTIMIZATION' => 'YES',
                            'APPLICATION_EXTENSION_API_ONLY' => 'YES' }

  s.ios.deployment_target = '10.0' 
  s.swift_version = "5.0"
  s.source_files = 'RxLisk/**/*.{h,c,swift}'
  s.public_header_files = 'RxLisk/**/*.h'

  s.dependency 'Alamofire' 
  s.dependency 'RxAtomic'
  s.dependency 'RxOptional'
  s.dependency 'RxRelay'
  s.dependency 'RxSwift'
  s.dependency 'RxTest'
end