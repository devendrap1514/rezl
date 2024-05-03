require 'uri'
require 'net/http'
require 'openssl'

class WebhookSubscribeService
  def subscribe(property)
    token = property.calendly_token
    url = URI('https://api.calendly.com/users/me')
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request['Content-Type'] = 'application/json'
    request['Authorization'] = "Bearer #{token}"

    response = http.request(request)
    me_body = JSON.parse(response.body)
    if response.code == '200'
      organization = me_body['resource']['current_organization']
      property.organization = organization
      user = me_body['resource']['uri']
      property.me_uri = user

      signing_key = ENV['WEBHOOK_SIGNING_KEY']

      end_point = "https://api.calendly.com/webhook_subscriptions/"
      url = URI(end_point)

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Post.new(url)
      request["Content-Type"] = 'application/json'
      request["Authorization"] = "Bearer #{token}"

      redirect_url = ENV['CALENDLY_REDIRECT_URL']
      request.body = "{\n  \"url\": \"#{redirect_url}\",\n  \"events\": [\n    \"invitee.created\",\n    \"invitee.canceled\"\n  ],\n  \"organization\": \"#{organization}\",\n  \"scope\": \"organization\",\n  \"signing_key\": \"#{signing_key}\"\n}"

      response = http.request(request)
      body = JSON.parse(response.body)
      if response.code == '201'
        webhook_body = JSON.parse(response.body)
        property.webhook_uuid = webhook_body['resource']['uri'].gsub(end_point, '')
        property.creator = webhook_body['resource']['creator']

        return true, "Successfully subscribe"
      else
        return false, body['message']
      end
    else
      return false, body['message']
    end
  rescue => e
    return false, "App Error: #{e.message}"
  end

  def unsubscribe(property)
    token = property.calendly_token
    webhook_uuid = property.webhook_uuid
    url = URI("https://api.calendly.com/webhook_subscriptions/#{webhook_uuid}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Delete.new(url)
    request["Content-Type"] = 'application/json'
    request["Authorization"] = "Bearer #{token}"
    response = http.request(request)
    body = JSON.parse(response.body) unless response.body.nil?
    if response.code == '204'
      return true, 'Successfully unsubscribe'
    else
      return false, body['message']
    end
  rescue => e
    return false, e.message
  end
end
