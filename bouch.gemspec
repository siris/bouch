$LOAD_PATH.unshift File.expand_path('lib', __dir__)
require 'bouch/version'

Gem::Specification.new do |s|
  s.name        = 'bouch'.freeze
  s.date        = '2018-03-17'
  s.version     = Bouch::VERSION
  s.summary     =
    'A simple tool to calculate and project your ' +
    'annual personal budget based on fiscal quarters ' +
    'expenditures, income, assets, and debts.'
  s.description = 'The Budget Pouch. Fast annual budget projections.'
  s.authors     = ['Shane Sofos'.freeze]
  s.email       = ['ssofos@gmail.com'.freeze]
  s.homepage    = 'https://github.com/siris/bouch'.freeze
  s.license     = 'GPL-3.0'.freeze

  s.files         = %x(git ls-files).split($INPUT_RECORD_SEPARATOR)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib'.freeze]

  s.required_ruby_version = '>= 2.4.0'.freeze
end
