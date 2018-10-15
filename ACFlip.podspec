Pod::Spec.new do |s|
  s.name         = 'ACFlip'
  s.version      = '1.0.2'
  s.summary      = '简单实用的翻转控件'
  s.homepage     = 'https://github.com/kuah/ACFlip'
  s.author       = "Kuah => 284766710@qq.com"
  s.source       = {:git => 'https://github.com/kuah/ACFlip.git', :tag => "#{s.version}"}
  s.source_files = "source/*.{h,m}"
  s.requires_arc = true
  s.ios.deployment_target = '8.0'
  s.license = 'MIT'
end
