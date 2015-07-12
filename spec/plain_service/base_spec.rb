require 'spec_helper'

describe PlainService::Base do
  subject { described_class.new(params) }
  let(:params) { {} }

  context '#perform' do
    context 'valid' do
      before do
        allow(subject).to receive(:valid?).and_return true
      end

      context 'process succeeds' do
        before do
          allow(subject).to receive(:process).and_return true
        end

        it 'should be truthy' do
          expect(subject.perform).to be_truthy
        end
      end

      context 'process fails' do
        before do
          allow(subject).to receive(:process).and_return false
        end

        it 'should be falsey' do
          expect(subject.perform).to be_falsey
        end
      end
    end

    context 'invalid' do
      before do
        allow(subject).to receive(:valid?).and_return false
      end

      it 'should be falsey' do
        expect(subject.perform).to be_falsey
      end
    end
  end

  context '.perform' do
    it 'should instantiate and perform' do
      expect(PlainService::Base).
        to receive(:new).with(params).and_call_original
      expect_any_instance_of(PlainService::Base).
        to receive(:perform).and_return true

      expect(described_class.perform(params)).to be_truthy
    end
  end
end
