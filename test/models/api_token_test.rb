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
require 'test_helper'

class ApiKeyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
