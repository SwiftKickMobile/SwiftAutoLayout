Pod::Spec.new do |spec|
    spec.name             = 'SwiftLayout'
    spec.version          = '1.0.0'
    spec.license          = { :type => 'MIT' }
    spec.homepage         = 'https://github.com/SwiftKickMobile/SwiftLayout'
    spec.authors          = { 'Timothy Moose' => 'tim@swiftkick.it' }
    spec.summary          = 'Super awesome Auto Layout constraint simplifier for Swift.'
    spec.source           = {:git => 'https://github.com/SwiftKickMobile/SwiftLayout.git', :tag => spec.version}
    spec.platform         = :ios, '10.0'
    spec.swift_version    = '4.2'
    spec.ios.deployment_target = '10.0'
    spec.framework        = 'UIKit'
    spec.requires_arc     = true
end
