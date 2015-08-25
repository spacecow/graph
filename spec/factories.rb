FactoryGirl.define do
  factory :article do
    name 'factory name'
    type 'Character'
  end

  factory :book do
  end

  factory :note do
    text 'factory text'
  end

  factory :reference do
  end

  factory :tag do
    title 'factory title'
  end

  factory :universe do
    title 'factory title'
  end
end
