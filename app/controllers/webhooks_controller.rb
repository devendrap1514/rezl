require 'openssl'

class WebhooksController < ApplicationController
  before_action :authorize_request, only: %i[]
  def calendly
    webhook_signing_key = ENV['WEBHOOK_SIGNING_KEY']

    calendly_signature = request.headers['Calendly-Webhook-Signature']
    signature_hash = Hash[*calendly_signature.split(/[\,,\=]/)]

    t = signature_hash['t']
    signature = signature_hash['v1']

    raise 'Invalid Signature' if t.nil? || signature.nil?

    signed_payload = t + '.' + request.body.read

    digest = OpenSSL::Digest::SHA256.new
    hmac = OpenSSL::HMAC.new(webhook_signing_key, digest)

    expected_signature = (hmac << signed_payload).to_s

    if expected_signature != signature
      raise 'Invalid Signature'
    else
      body = JSON.parse(request.body.read)
      if body['event'] == 'invitee.created' || body['event'] == 'invitee.canceled'
        property = Property.find_by(creator: body['created_by'])
        payload = body['payload']
        event = payload['scheduled_event']
        body = {
          'uri': payload['uri'],
          'event_name': event['name'],
          'status': event['status'],
          'start_time': event['start_time'],
          'invitee_first_name': payload['first_name'],
          'invitee_last_name': payload['last_name'],
          'reschedule_url': payload['reschedule_url'],
          'phone_number': payload['questions_and_answers'][0]['answer']
        }
        EventHandleWorker.new.perform(property.id, body)
      end
    end
  end
end
