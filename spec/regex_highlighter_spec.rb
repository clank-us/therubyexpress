require 'regex_highlighter'

describe RegexHighlighter do
  let(:pattern) { "th" }
  let(:flags) { "i" }
  let(:test_string) { "this is the test string though" }
  let(:match_params) do
    {
      "pattern"     => pattern,
      "flags"       => flags,
      "test_string" => test_string
    }
  end

  subject do
    described_class.new(match_params)
  end

  it "knows the pattern" do
    expect(described_class.new(match_params).pattern).to eq(pattern)
  end

  describe "#match_string" do
    it "wraps matches in <span>'s" do
      expect(subject.match_string).to eq("--{th}--is is --{th}--e test string --{th}--ough")
    end
  end


  describe "#match_data" do
    it "returns an array of matches" do
      expect(subject.match_data).to eq(["th", "th", "th"])
    end

    context "with captures" do
      let(:pattern) { "(th)" }
      it "returns an array of matches" do
        expect(subject.match_data).to eq(["th", "th", "th"])
      end
    end
  end

  describe "#captures" do
    context "with captures () used" do
      let(:pattern) { "(th)" }
      it "returns a collection of capture groups " do
        expect(subject.captures).to eq([["th"],["th"], ["th"]])
      end
    end
    context "without captures" do
      it "returns nil" do
        expect(subject.captures).to eq([])
      end
    end
  end

  describe "highlights" do
    context "with captures" do
      let(:pattern) { "(th)" }
      it "return the match_data and the captures" do
        expect(subject.highlights).to eq(
          {
            match_data: ["th", "th", "th" ],
            captures: [["th"],["th"], ["th"]],
            match_string: "--{th}--is is --{th}--e test string --{th}--ough"
          }
        )
      end
    end
    context "without captures" do
      it "return the match_data and the captures and highlighted string" do
        expect(subject.highlights).to eq(
          {
            match_data: ["th", "th", "th" ],
            captures: [],
            match_string: "--{th}--is is --{th}--e test string --{th}--ough"
          }
        )
      end
    end
  end

end
