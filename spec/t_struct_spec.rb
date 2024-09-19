# typed: false
require 'sorbet-coerce'
require 'sorbet-runtime'

describe TypeCoerce do
  context "Uses key specified in `name` arg when building structs" do
    class Wish < T::Struct
      const :wish_number, Integer, name: "Num"
    end

    class Genie < T::Struct
      const :name, String, name: "NAME"
      const :wishes, T::Array[Wish], name: "Wishes"
    end

    it "Works" do
      converted = TypeCoerce[Genie].new.from({
        "NAME" => "Craig",
        "Wishes" => [
          "Num" => "500"
        ]
      })

      expect(converted.name).to eql("Craig")
      expect(converted.wishes.map(&:wish_number)).to eql([500])
    end
  end
end
