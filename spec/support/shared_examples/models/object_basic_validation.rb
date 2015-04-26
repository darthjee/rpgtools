require 'spec_helper'

shared_examples 'object has invalid numeric attribute' do |attributes|
  attributes.each do |attribute|
    before { object.public_send("#{attribute}=", value) }
    context "due to invalid value for #{attribute}" do
      let(:value) { -1 }
      it { expect(object).to be_invalid }
    end
  end
end

shared_examples 'object has invalid numeric obligatory attribute' do |attributes|
  attributes = attributes.enum_for(:tap) unless attributes.is_a? Array
  it_behaves_like 'object has invalid numeric attribute', attributes
  attributes.each do |attribute|
    before { object.public_send("#{attribute}=", value) }
    context "due to lack of #{attribute}" do
      let(:value) { nil }
      it { expect(object).to be_invalid }
    end
  end
end

shared_examples 'object that has mandatory string attributes' do |*attributes|
  attributes.each do |attribute|
    describe "#{attribute}" do
      context 'when blank' do
        before { object.public_send("#{attribute}=", '') }
        it { expect(object).not_to be_valid }
        it { expect(object).to have(1).error_on(attribute) }
      end

      it_behaves_like 'object that has mandatory attributes', attribute
    end
  end
end

shared_examples 'object that has mandatory attributes' do |*attributes|
  attributes.each do |attribute|
    describe "#{attribute}" do
      context 'when nil' do
        before { object.public_send("#{attribute}=", nil) }
        it { expect(object).not_to be_valid }
        it { expect(object).to have(1).error_on(attribute) }
      end

      context 'when not blank' do
        it { expect(object).to be_valid }
      end
    end
  end
end
