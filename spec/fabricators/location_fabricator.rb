Fabricator :location do
  urn { "g5-cl-2398223-#{Faker::Name.name.parameterize}" }
  name { Faker::Name.name }
  client_uid { Faker::Lorem.word }
  uid { Faker::Lorem.word }
end
