FactoryGirl.define do
  factory :article do
    sequence :name do |n| "factory name #{n}" end
    type 'Character'
    gender 'n'
  end

  factory :article_note do
  end

  factory :book do
  end

  factory :event do
    title 'factory title'
  end

  factory :note do
    text 'factory text'
  end

  factory :participation do
  end

  factory :reference do
  end

  factory :relation do
    type 'Owner'
  end

  factory :step do
  end

  factory :tag do
    title 'factory title'
  end

  factory :tagging do
  end

  factory :universe do
    title 'factory title'
  end
end
