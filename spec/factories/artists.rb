FactoryGirl.define do
  factory :artist do
    name          { Faker::BossaNova.artist }
    image_url     "https://www.putumayo.com/wp-content/uploads/2011/01/Bossa-Nova-Cover-Art-PRINT-WEB.jpg"
  end
end
