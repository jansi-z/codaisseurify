FactoryGirl.define do
  factory :song do
    name  { Faker::BossaNova.song }
  end
end
