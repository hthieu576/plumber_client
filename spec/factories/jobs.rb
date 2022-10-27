# == Schema Information
#
# Table name: jobs
#
#  id          :bigint           not null, primary key
#  description :string(255)
#  client_id   :bigint           not null
#  plumber_id  :bigint           not null
#  time_period :datetime
#  status      :integer          default("assigned")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :job do
    description { Faker::Lorem.word }
    time_period { Date.today + 3.days }
    plumber { create :plumber }
    client { create :client }
    status { [:assigned, :finished].sample }
  end
end
