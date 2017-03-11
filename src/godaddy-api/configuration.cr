module Godaddy
  class Configuration
    property api_key : String
    property api_secret : String

    def initialize
      @api_key = ""
      @api_secret = ""
    end

    def version
      "v1"
    end
  end
end
