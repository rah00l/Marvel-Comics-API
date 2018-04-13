module MarvelComicsApi
  module API
    class Router
      def characters_path
        'public/characters'
      end

      def character_path(id)
        "public/characters/#{id}"
      end
    end
  end
end
