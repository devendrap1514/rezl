class Property < ApplicationRecord
  has_many :tours

  has_many :property_term_and_conditions

  # validate :validate_calendly_token
  # validates :calendly_token, uniqueness: true
  # validates :organization, uniqueness: true, if: -> { calendly_token.present? }
  validates :name, presence: true
  # before_destroy :unsubscribe_webhook


  def validate_calendly_token
    if calendly_token.present?
      begin
        client = Calendly::Client.new calendly_token
        me = client.me
        is_subscribe, message = WebhookSubscribeService.new.subscribe(self)
        unless is_subscribe
          errors.add(:base, message)
        end
      rescue StandardError => e
        if e.message.present?
          errors.add(:base, "#{e.message}")
          return
        end
        errors.add(:base, 'Too many requests')
      end
    end
  end

  def unsubscribe_webhook
    is_subscribe, message = WebhookSubscribeService.new.unsubscribe(self)
    unless is_subscribe
      byebug
      errors.add(:base, message)
      throw :abort
    end
  end
end
