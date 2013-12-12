require 'rspec'
require 'argument_parser'

describe ArgumentParser do
  subject { ArgumentParser.new }
  { "{a, b, c}" => ["a", "b", "c"],
    "{a|,b, c}" => ["a,b", "c"],
    "{||, |,|, }" => ["|, ,, "],
    "{, , a, }" => ["", "", "a", ""],
    "{| , |,, }" => ["| ", ",", ""],
    "{}" => [""],
  }.each do |string, expected|
    it "returns #{expected} when supplied #{string}" do
      subject.parse(string).should eq(expected)
    end
  end

  [1, "}", "{", "{{}", "{}}", "{a,b}"].each do |invalid|
    it "raises an exception when supplied '#{invalid}'" do
      expect { subject.parse(invalid) }.to raise_error(ArgumentError, /Args list is invalid/)
    end
  end

  context "my own tests" do
    { "{a|}|,, |b, c}" => ["a},", "|b", "c"],
      "{a, }" => ["a",""],
      "{a}" => ["a"],
      "{a, b, }" => ["a","b", ""],
      "{ a, b, }" => [" a","b", ""],
    }.each do |string, expected|
      it "returns #{expected} when supplied #{string}" do
        subject.parse(string).should eq(expected)
      end
    end

    ["{a}|,, |b, c}"].each do |invalid|
      it "raises an exception when supplied '#{invalid}'" do
        expect { subject.parse(invalid) }.to raise_error(ArgumentError, /Args list is invalid/)
      end
    end

  end

end
