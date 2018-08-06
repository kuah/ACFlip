Pod::Spec.new do |s|
  s.name         = 'ACFlip'
  s.version      = '1.0.0'
  s.summary      = '简单实用的翻转控件'
  s.homepage     = 'https://github.com/kuah/ACFlip.git'
  s.author       = "ACFlip => 284766710@qq.com"
  s.source       = {:git => 'https://github.com/kuah/ACFlip'', :tag => "#{s.version}"}
  s.source_files = "source/*.{h,m}"
  s.requires_arc = true
  s.ios.deployment_target = '8.0'
  s.license = 'MIT'
end
