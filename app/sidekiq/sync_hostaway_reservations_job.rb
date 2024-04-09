class SyncHostawayReservationsJob
  include Sidekiq::Job

  def perform(*args)
    PropertyManagementSystems::Sync::Hostaway
      .new
      .sync_reservations(departureEndDate: 2.weeks.ago.to_date.to_s)
  end
end
