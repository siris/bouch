# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('lib', __dir__)
require 'bouch/version'

Gem::Specification.new do |s|
  s.name        = 'bouch'
  s.date        = '2018-04-23'
  s.version     = Bouch::VERSION
  s.authors     = ['Shane R. Sofos']
  s.email       = ['ssofos@gmail.com']
  s.homepage    = 'https://github.com/siris/bouch'
  s.license     = 'GPL-3.0'
  s.description = 'The Budget Pouch. Fast annual budget projections.'
  s.summary     =
    'A simple tool to calculate and project your ' +
    'annual personal budget based on fiscal quarters ' +
    'expenditures, income, assets, and debts.'

  s.files         = %x(git ls-files).split($INPUT_RECORD_SEPARATOR)
  s.bindir        = 'bin'
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 2.4.0'
end
