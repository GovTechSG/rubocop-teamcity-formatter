Gem::Specification.new do |s|
  s.name          = 'rubocop-teamcity-formatter'
  s.version       = '0.0.2'
  s.date          = '2016-11-23'
  s.summary       = 'Report RuboCop offences as TeamCity Service Messages'
  s.description   = 'Allows TeamCity builds to properly report RuboCop offences'
  s.authors       = ['Raphael Tan']
  s.email         = 'raphaeltanyw@gmail.com'
  s.files         = Dir['lib/**/*.rb']
  s.require_paths = ['lib']
  s.license       = 'MIT'

  # s.required_ruby_version = '>~2.3.0'

  s.add_development_dependency 'rake',  '~> 12.3.3'
  s.add_development_dependency 'rubocop', '~> 0.49'
  s.add_development_dependency 'rspec', '~> 3.4'
end
