Gem::Specification.new do |s|
  s.name        = 'bouch'
  s.version     = '1.0.1'
  s.date        = '2017-12-22'
  s.summary     =
    'A simple tool to calculate and project your ' +
    'annual personal budget based on fiscal quarters ' +
    'expenditures, income, assets, and debts.'
  s.description = 'The Budget Pouch. Fast annual budget projections.'
  s.authors     = ['Shane Sofos']
  s.email       = 'ssofos@gmail.com'
  s.homepage    =
    'https://github.com/siris/bouch'
  s.license     = 'GPL-3.0'

  s.files         = %x(git ls-files).split($INPUT_RECORD_SEPARATOR)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 2.2.0'
end
