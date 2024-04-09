module PropertyManagementSystems
  module Sync
    class Hostaway
      def sync_reservations(params = {})
        PropertyManagementSystems::Connectors::Hostaway
          .new
          .fetch_reservations => reservations

        if reservations.nil?
          return false
        end

        reservations.each do |reservation|
          record = Reservation.find_or_initialize_by(provider: "hostaway", listing_id: reservation["hostawayReservationId"])

          record.status = reservation["status"]
          record.check_in = DateTime.parse("#{reservation["checkInTime"]}  #{reservation["arrivalDate"]}") 
          record.check_out = DateTime.parse("#{reservation["checkOutTime"]}  #{reservation["departureDate"]}") 
          record.price = reservation["totalPrice"]
          record.guest_name = "#{reservation["guestFirstName"]} #{reservation["guestLastName"]}" 

          record.save
        end

        true
      end
    end
  end
end
