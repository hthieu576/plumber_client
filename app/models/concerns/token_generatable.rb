# frozen_string_literal: true

module TokenGeneratable
  extend ActiveSupport::Concern

  def generate_unique_token(options = {})
    generator_method = options.delete(:generator) || SecureRandom.method(:hex)
    token_size       = options.delete(:size) || 32
    generator_method.call(token_size)
  end

  def generate_referral_code
    # SecureRandom.urlsafe_base64(8).tr('_-', 'xx')
    "#{('A'..'Z').to_a.sample}#{('0'..'9').to_a.sample(5).join}"
  end
end

