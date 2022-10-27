# == Schema Information
#
# Table name: api_tokens
#
#  id            :bigint           not null, primary key
#  admin_user_id :bigint           not null
#  access_key    :string(255)      not null
#  secret_key    :string(255)      not null
#  refresh_token :string(255)
#  expire_at     :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class ApiToken < ApplicationRecord
  include TokenGeneratable
	belongs_to :admin_user

	before_validation :generate_keys, on: :create
  before_validation :generate_refresh_token, on: :create
 
	validates_presence_of :access_key, :secret_key

	def access_token
    payload = {
      access_key: access_key
    }
    ::JWT.encode(payload, secret_key, 'HS256')
  end

  def expired?
    expire_at && expire_at < Time.zone.now
  end

	private

  def generate_refresh_token
    self.refresh_token = generate_unique_token
  end

  def generate_keys
    begin
      self.access_key = ::Auth::Utils.generate_access_key
    end while ApiToken.where(access_key: access_key).any?

    begin
      self.secret_key = ::Auth::Utils.generate_secret_key
    end while ApiToken.where(secret_key: secret_key).any?
  end
end
