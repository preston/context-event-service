# hspc = IdentityProvider.create_with(
#     name: 'ARTAKA HSPC Sandbox',
#     client_id: '86830e09-8269-41b0-8d11-9b8466c44548',
#     client_secret: 'UIjkXmQm0YOuvupDnWutpdl1YsDUuuO4tXRuanwBlNKu3wJyz7yRilkgla3KBFY2hmxwhqM4BrxFXHFu-WVtzw',
#     scopes: 'openid email profile'
# ).find_or_create_by(issuer: 'https://account.hspconsortium.org')
# # hspc.reconfigure
# hspc.save!

hspc_localhost = IdentityProvider.create_with(
    name: 'ARTAKA HSPC Sandbox (localhost)',
    client_id: '1781cab7-4a64-43c6-b32f-64207189c29f',
    client_secret: 'V5shOCs8VsjQQ7h4_lQvcblGAEdch8HWfPDH5YUD9LyMBKW63hM-5vrD-vpZLM3sp7BPBNvnDQVz8vXx6yT4Hg',
    scopes: 'openid email profile'
).find_or_create_by(issuer: 'https://auth.hspconsortium.org/')
hspc_localhost.reconfigure
hspc_localhost.save!
# https://auth.hspconsortium.org/.well-known/openid-configuration

physician = Role.create_with(
    name: 'Physician'
).find_or_create_by(code: 'physician')

patient = Role.create_with(
    name: 'Patient'
).find_or_create_by(code: 'patient')

peter = Person.create!(name: 'Peter Patient',
                               first_name: 'Peter',
                               middle_name: 'Paul',
                               last_name: 'Patient')

ernest = Person.create!(name: 'Ernest E.',
                                first_name: 'Ernesto',
                                middle_name: 'Eugene',
                                last_name: 'Endocrinologist')

Capability.create!(entity: peter, role: patient)
Capability.create!(entity: ernest, role: physician)

physicians = []
(0..100).each do |_n|
    physicians << u = Person.create!(
        salutation: Faker::Name.prefix,
        name: Faker::Name.name,
        first_name: Faker::Name.first_name,
        middle_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name
    )
    Capability.create!(entity: u, role: physician)
end

patients = []
(0..1000).each do |_n|
    patients << u = Person.create!(
        salutation: Faker::Name.prefix,
        name: Faker::Name.name,
        first_name: Faker::Name.first_name,
        middle_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name
    )
    Capability.create!(entity: u, role: patient)
end

# places = []
# places << Place.create!(
#     name: 'Ambulatory',
#     description: Faker::Company.catch_phrase,
#     address: "#{Faker::Address.street_address}\n#{Faker::Address.city}, #{Faker::Address.state}\n#{Faker::Address.zip_code}"
# )

# events = []
# (0..10).each do |_n|
#     events << a = Event.create!(
#         # name: Faker::Company.buzzword,
#         # description: Faker::Company.catch_phrase,
#         topic_uri: 'artaka://example',
#         model_uri: 'artaka://example',
#         # place: places.sample,
#         next: (rand(2) == 1 ? events.sample : nil),
#         parent: (rand(2) == 1 ? events.sample : nil)
#     )
# end

# Objective.create_with.find_or_create_by(formalized: (rand(2) == 1), language: 'fake', topic_uri: 'artaka://languages/fake', specification: 'true', event: e.sample)
