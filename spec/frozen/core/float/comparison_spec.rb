require File.expand_path('../../../spec_helper', __FILE__)

describe "Float#<=>" do
  before(:all) do
    @inf = 1/0.0
    @nan = 0/0.0
  end

  it "returns -1, 0, 1 when self is less than, equal, or greater than other" do
    (1.5 <=> 5).should == -1
    (2.45 <=> 2.45).should == 0
    ((bignum_value*1.1) <=> bignum_value).should == 1
  end

  it "returns nil when either argument is NaN" do
    (@nan <=> 71.2).should be_nil
    (1771.176 <=> @nan).should be_nil
  end

  # TODO: Remove duplicate ruby_bug guards when ruby_bug is fixed.
  ruby_bug "[ruby-dev:38672] [Bug #1645]", "1.8.7" do
    # The 4 tests below are taken from matz's revision 23730 for Ruby trunk
    #
    it "returns 1 when self is Infinity and other is a Bignum" do
      (@inf <=> Float::MAX.to_i*2).should == 1
    end

    it "returns -1 when self is negative and other is Infinty" do
      (-Float::MAX.to_i*2 <=> @inf).should == -1
    end

    it "returns -1 when self is -Infinity and other is negative" do
      (-@inf <=> -Float::MAX.to_i*2).should == -1
    end

    it "returns 1 when self is negative and other is -Infinity" do
      (-Float::MAX.to_i*2 <=> -@inf).should == 1
    end
  end

  ruby_bug "[ruby-dev:38672] [Bug #1645]", "1.8.7.302" do
    # The 4 tests below are taken from matz's revision 23730 for Ruby trunk
    #
    it "returns 1 when self is Infinity and other is a Bignum" do
      (@inf <=> Float::MAX.to_i*2).should == 1
    end

    it "returns -1 when self is negative and other is Infinty" do
      (-Float::MAX.to_i*2 <=> @inf).should == -1
    end

    it "returns -1 when self is -Infinity and other is negative" do
      (-@inf <=> -Float::MAX.to_i*2).should == -1
    end

    it "returns 1 when self is negative and other is -Infinity" do
      (-Float::MAX.to_i*2 <=> -@inf).should == 1
    end
  end
end
