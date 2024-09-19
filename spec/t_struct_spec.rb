# typed: false
require 'sorbet-coerce'
require 'sorbet-runtime'

describe TypeCoerce do
  context "Uses key specified in `name` arg when building structs" do
    class Song < T::Struct
      const :id, Integer, name: "songId"
      const :name, String, name: "songName"
      const :artist, String, default: "Unknown", name: "songArtist"
    end

    class Customer < T::Struct
      const :id, Integer, name: "customerId"
      const :name, String, name: "customerName"
      const :favourite_movies, T::Array[String], default: [], name: "customerFavouriteMovies"
      const :favourite_songs, T::Array[Song], default: [], name: "customerFavouriteSongs"
    end

    it "Works" do
      converted = TypeCoerce[Customer].new.from({
        "customerId" => "1",
        "customerName" => "Craig",
        "favourite_songs" => [{
          "songId" => "1",
          "songName" => "One More Time",
          "artist" => "Daft Punk"
        }]
      })

      expect(converted.id).to eql(1)
      expect(converted.name).to eql("Craig")
      expect(converted.favourite_movies).to eql([])
      expect(converted.favourite_songs.map(&:id)).to eql([1])
      expect(converted.favourite_songs.map(&:name)).to eql(["One More Time"])
      expect(converted.favourite_songs.map(&:artist)).to eql(["Daft Punk"])
    end
  end
end
