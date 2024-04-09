module PropertyManagementSystems
  module Connectors
    class Hostaway
      def initialize
        @conn = Faraday.new(
          url: "https://api.hostaway.com/v1/",
          headers: {
            "Content-Type" => "application/json",
            "Authorization" => "Bearer #{ENV["HOSTAWAY_ACCESS_TOKEN"]}",
          }
        )
      end

      def fetch_reservations(params = {})
        @conn.get("reservations") do |req|
          req.params = params
        end => response

        if response.success?
          JSON.parse(response.body)["result"]
        else
          nil
        end
      end
    end
  end
end
