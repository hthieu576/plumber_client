
FactoryBot.define do
  factory :api_token do
    admin_user { create :admin_user }
  end
end
