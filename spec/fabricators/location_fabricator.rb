Fabricator :location do
  urn { "g5-cl-2398223-#{Faker::Name.name.parameterize}" }
  name { Faker::Name.name }
  default_number { Faker::PhoneNumber.phone_number }
end
