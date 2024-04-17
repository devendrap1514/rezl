class CalendlyJob
  include Sidekiq::Job

  def perform(property_id)
    CalendlyService.new(property_id).get_tours
  end
end
