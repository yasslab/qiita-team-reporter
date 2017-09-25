Gem::Specification.new do |s|
  s.name        = 'qiita-team-reporter'
  s.version     = '0.1.0'
  s.licenses    = ['MIT']
  s.summary     = 'Qiita:Team reporter'
  s.authors     = ['Seiei Miyagi', 'Yohei Yasukawa']
  s.email       = ['yohei@yasslab.jp']
  s.files       = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  s.bindir      = "exe"
  s.executables = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.homepage = 'https://github.com/yasslab/qiita-team-reporter/'

  s.add_runtime_dependency "qiita"
end
