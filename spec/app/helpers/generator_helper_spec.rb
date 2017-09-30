require 'spec_helper'

RSpec.describe 'Vimspec::App::GeneratorHelper' do
  pending "add some examples to (or delete) #{__FILE__}" do
    let(:helpers) { Class.new }
    before { helpers.extend Vimspec::App::GeneratorHelper }
    subject { helpers }

    it 'should return nil' do
      expect(subject.foo).to be_nil
    end
  end
end
