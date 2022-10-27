# frozen_string_literal: true

module ResponseHelper
  def json_body
    JSON.parse(self.body)
  end

  def mash_body
    if json_body.is_a?(Array)
      json_body.map { |i| i.is_a?(String) ? i : Hashie::Mash.new(i) }
    elsif json_body.is_a?(String)
      json_body
    else
      Hashie::Mash.new(self.json_body)
    end
  rescue JSON::ParserError
    Rails.logger.info('JSON::ParserError')
    {}
  end
end

::ActionDispatch::TestResponse.include ResponseHelper
