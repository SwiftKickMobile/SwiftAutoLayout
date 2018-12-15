Pod::Spec.new do |spec|
    spec.name             = 'SwiftAutoLayout'
    spec.version          = '1.0.1'
    spec.license          = { :type => 'MIT' }
    spec.homepage         = 'https://github.com/SwiftKickMobile/SwiftAutoLayout'
    spec.authors          = { 'Timothy Moose' => 'tim@swiftkick.it' }
    spec.summary          = 'Write constraints in a concise, expressive, Swifty way.'
    spec.source           = {:git => 'https://github.com/SwiftKickMobile/SwiftAutoLayout.git', :tag => spec.version}
    spec.platform         = :ios, '10.0'
    spec.swift_version    = '4.2'    
    spec.ios.deployment_target = '10.0'
    spec.source_files     = 'SwiftAutoLayout/**/*.swift'
    spec.framework        = 'UIKit'
    spec.requires_arc     = true
end
