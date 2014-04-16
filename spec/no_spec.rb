require 'spec_helper'

# http://www.ruby-doc.org/core-2.1.1/NilClass.html
describe NO::NullObject do
  %w(to_a to_c to_f to_i to_r to_s rationalize).each do |method|
    describe "##{method}" do
      subject { described_class.new.send(method) }
      it { should eq(nil.send(method)) }
    end
  end

  describe '#to_h' do
    context 'Ruby version is 2.0.0 or later' do
      if RUBY_VERSION >= '2.0.0'
        subject { described_class.new.to_h }
        it { should eq(nil.to_h) }
      end
    end

    context 'Ruby version is earlier than 2.0.0' do
      if RUBY_VERSION < '2.0.0'
        subject { described_class.new.to_h }
        it { should eq(nil) }
      end
    end
  end

  describe '#&' do
    context 'NO::NullObject & object' do
      subject { NO::NullObject.new & Object.new }
      it { should be_false }
    end
  end

  describe '#^' do
    context 'NO::NullObject ^ nil' do
      subject { NO::NullObject.new ^ nil }
      it { should eq(nil ^ nil) }
    end

    context 'NO::NullObject ^ false' do
      subject { NO::NullObject.new ^ false }
      it { should eq(nil ^ false) }
    end

    context 'NO::NullObject ^ NO::NullObject' do
      subject { NO::NullObject.new ^ NO::NullObject.new }
      it { should eq(nil ^ nil) }
    end

    context 'NO::NullObject ^ object(that is not nil, false or NO::NullObject)' do
      subject { NO::NullObject.new ^ Object.new }
      it { should eq(nil ^ Object.new) }
    end
  end

  describe '#|' do
    context 'NO::NullObject | nil' do
      subject { NO::NullObject.new | nil }
      it { should eq(nil ^ nil) }
    end

    context 'NO::NullObject | false' do
      subject { NO::NullObject.new | false }
      it { should eq(nil ^ false) }
    end

    context 'NO::NullObject | NO::NullObject' do
      subject { NO::NullObject.new | NO::NullObject.new }
      it { should eq(nil ^ nil) }
    end

    context 'NO::NullObject | object(that is not nil, false or NO::NullObject)' do
      subject { NO::NullObject.new | Object.new }
      it { should eq(nil ^ Object.new) }
    end
  end

  describe '#==' do
    context 'NO::NullObject == nil' do
      subject { described_class.new == nil }
      it { should be_true }
    end

    context 'NO::NullObject == NO::NullObject (Same instance)' do
      subject { a = described_class.new; a == a }
      it { should be_true }
    end

    context 'NO::NullObject == NO::NullObject (Different instance)' do
      # `a == nil is true` and `b == nil` is true, but `a == b` is false
      # !!!This is strange but useful!!!
      # Example:
      #   class Annonymous < NO::NullObject
      #   end
      #
      #   class FakeLogger < NO::NullObject
      #   end
      #
      #   FakeLogger.new == Annonymous.new # => false
      #

      subject { described_class.new == described_class.new }
      it {
        should be_false

        # Check example's validity {{{
        class Annonymous < NO::NullObject; end
        class FakeLogger < NO::NullObject; end
        expect(FakeLogger.new == Annonymous.new).to be_false
        # }}}
      }
    end
  end

  describe '#!' do
    subject { !described_class.new }
    it { should be_true }
  end

  describe '#nil?' do
    subject { described_class.new.nil? }
    it { should be_true }
  end

  describe 'methods that nil don\'t have' do
    it 'should return nil' do
      n = described_class.new

      expect(n.foo).to eq(nil)
    end
  end

  class Annonymous < NO::NullObject
    def name
      'annonymous'
    end

    def age
      'unknown'
    end
  end

  it 'can expand by inheritance' do
    expect(Annonymous.new.name).to eq('annonymous')
    expect(Annonymous.new.age).to eq('unknown')
  end
end
