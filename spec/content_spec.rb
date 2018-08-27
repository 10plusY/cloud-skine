require "content_checker"

describe CloudSkine::ContentChecker do
  describe ".has_tags?" do
    context "for a default checker" do
      checker = CloudSkine::ContentChecker.new
      context "given an empty string" do
        it "returns false" do
          expect(checker.has_tags?("")).to be false
        end
      end

      context "given a string with tags" do
        it "returns true" do
          expect(checker.has_tags?("#foo")).to be true
        end
      end
    end

    context "for a custom checker" do
      checker2 = CloudSkine::ContentChecker.new "&"
      context "given a string with tags" do
        it "returns true" do
          expect(checker2.has_tags?("&foo &bar")).to be true
        end
      end

      context "given a string without tags" do
        it "returns true" do
          expect(checker2.has_tags?("foo")).to be false
        end
      end
    end
  end

  context ".parse_tags" do
    checker = CloudSkine::ContentChecker.new
    context "given a string with tags" do
      it "returns the tagged words" do
        expected_tags = ["foo", "bar"]
        expect(checker.parse_tags("#foo #bar")).to eql(expected_tags)
      end
    end
  end
end
