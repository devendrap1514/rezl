class EventHandleWorker
  include Sidekiq::Job

  def perform(property_id, hsh)
    check_and_save_in_db(property_id, hsh)
  end

  def check_and_save_in_db(property_id, body)
    event = JSON.parse(body.to_json)
    tour = Tour.find_by(uri: event['uri'], property_id: property_id)
    if tour
      if tour.status == 'awaiting' && event['status'] == 'canceled'
        tour.destroy
      elsif tour.status == 'scheduled' && event['status'] == 'canceled'
        tour.destroy
      end
    else
      return if event['status'] == 'canceled'
      tour = Tour.new(
        uri: event['uri'],
        event_name: event['event_name'],
        event_status: event['status'],
        start_time: event['start_time'],
        invitee_first_name: event['invitee_first_name'],
        invitee_last_name: event['invitee_last_name'],
        reschedule_url: event['reschedule_url'],
        phone_number: event['phone_number'],
        property_id: property_id,
        status: 'awaiting'
      )
      tour.save
      File.write('output.txt', "#{tour.errors.full_messages}\n", mode: 'a+') if Rails.env.development?
    end
  end
end
