# frozen_string_literal: true

require 'bouch/version'

describe 'Bouch::Version' do
  it 'returns the RubyGem version of Bouch as a string' do
    expect(Bouch::VERSION).to be_a_kind_of(String)
  end
end
