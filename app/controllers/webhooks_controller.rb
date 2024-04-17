require 'openssl'

class WebhooksController < ApplicationController
  before_action :authorize_request, only: %i[]
  def calendly
    puts
    puts
    puts("-----------------------------------------------------")
    webhook_signing_key = ENV['WEBHOOK_SIGNING_KEY']

    calendly_signature = request.headers['Calendly-Webhook-Signature']
    byebug
    signature_hash = Hash[*calendly_signature.split(/[\,,\=]/)]

    t = signature_hash['t'] # UNIX timestamp
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
      if body['event'] == 'invitee.canceled'
      end
    end
    puts('-----------------------------------------------------')
    puts
    puts
  end
end
