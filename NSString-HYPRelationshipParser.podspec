Pod::Spec.new do |s|
s.name             = "NSString-HYPRelationshipParser"
s.version          = "0.3"
s.summary          = "Parse string representations of model relationships"
s.homepage         = "https://github.com/hyperoslo/NSString-HYPRelationshipParser"
s.license          = 'MIT'
s.author           = { "Hyper AS" => "teknologi@hyper.no" }
s.source           = { :git => "https://github.com/hyperoslo/NSString-HYPRelationshipParser.git", :tag => s.version.to_s }
s.social_media_url = 'https://twitter.com/hyperoslo'

s.platform     = :ios, '7.0'
s.requires_arc = true

s.source_files = 'Source/**/*'

s.frameworks = 'Foundation'
s.dependency 'NSString-ZENInflections'
end
