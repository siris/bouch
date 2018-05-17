# frozen_string_literal: true

require 'bouch/cli'

describe 'Bouch::CLI' do
  before :all do
    @cli = Bouch::CLI.new('pouch.example.yml')
  end

  it 'is a Bouch::CLI object' do
    expect(@cli).to be_kind_of(Bouch::CLI)
  end

  describe '#yaml_file' do
    it 'returns a name of a file that is a String' do
      expect(@cli.yaml_file).to be_kind_of(String)
    end
  end

  describe '.start' do
    context 'when no file is supplied as the first CLI argument' do
      it 'outputs warning and usage help messages' do
        @cli.yaml_file = nil
        expect { @cli.start }.to output.to_stdout
      end
    end

    context 'when an existent file is supplied as the first CLI argument' do
      it 'calculates a budget from a budget pouch file and outputs it' do
        @cli.yaml_file = 'pouch.example.yml'
        expect { @cli.start }.to output.to_stdout
      end
    end

    context 'when a non-existent file is supplied as the first CLI argument' do
      it 'ouputs a warning and usage help messsages' do
        @cli.yaml_file = 'foobar.yml'
        expect { @cli.start }.to output.to_stdout
      end
    end
  end

  describe '.usage' do
    it 'outputs a bouch usage help message' do
      expect { @cli.usage }.to output.to_stdout
    end
  end
end
