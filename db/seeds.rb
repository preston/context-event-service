google = System::IdentityProvider.create_with(
    name: 'Google',
    client_id: '418783041492-si96ptie7gdbn46184e86thjmee3nj88.apps.googleusercontent.com',
    client_secret: 'MoyTrvZ0t4FFC6_LVGnN2TYo',
    scopes: 'openid email profile'
).find_or_create_by(issuer: 'https://accounts.google.com')
google.reconfigure
google.save!

# live = System::IdentityProvider.create_with(
#     name: 'Microsoft Live',
#     client_id: '0000000040193B01',
#     client_secret: '5J4ZxPQb22bXxvj1i-eqaHQILqKKRb2-',
#     alternate_client_id: '00000000-0000-0000-0000-000040193B01',
#     scopes: 'openid email profile'
# ).find_or_create_by(issuer: 'https://login.live.com')
# live.reconfigure
# live.save!

System::Client.create!(
    name: "Preston's Client Template",
    launch_url: 'https://context-event-service.s3-us-west-2.amazonaws.com/index.html',
    # icon_url: 'http://context-event-service.s3.amazonaws.com/app/images/textures/tileable_wood_texture.png',
    available: true
)

System::Client.create!(
    name: 'Context-Driven UI POC',
    launch_url: 'http://piper-ui.s3-website-us-east-1.amazonaws.com/v1/app',
    available: true
)

physician = System::Role.create!(
    name: 'Physician',
    code: 'physician'
)

patient = System::Role.create!(
    name: 'Patient',
    code: 'patient'
)

peter = System::Person.create!(name: 'Peter Patient',
                               first_name: 'Peter',
                               middle_name: 'Paul',
                               last_name: 'Patient')

ernest = System::Person.create!(name: 'Ernest E.',
                                first_name: 'Ernesto',
                                middle_name: 'Eugene',
                                last_name: 'Endocrinologist')

System::Capability.create!(entity: peter, role: patient)
System::Capability.create!(entity: ernest, role: physician)

physicians = []
(0..100).each do |_n|
    physicians << u = System::Person.create!(
        salutation: Faker::Name.prefix,
        name: Faker::Name.name,
        first_name: Faker::Name.first_name,
        middle_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name
    )
    System::Capability.create!(entity: u, role: physician)
end

patients = []
(0..1000).each do |_n|
    patients << u = System::Person.create!(
        salutation: Faker::Name.prefix,
        name: Faker::Name.name,
        first_name: Faker::Name.first_name,
        middle_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name
    )
    System::Capability.create!(entity: u, role: patient)
end

places = []
places << Context::Place.create!(
    name: 'Ambulatory',
    description: Faker::Company.catch_phrase,
    address: "#{Faker::Address.street_address}\n#{Faker::Address.city}, #{Faker::Address.state}\n#{Faker::Address.zip_code}"
)
# (0..10).each do |_n|
#     places << u = Context::Place.create!(
#         name: Faker::Company.name + ' ' + Faker::Company.suffix,
#         description: Faker::Company.catch_phrase,
#         address: "#{Faker::Address.street_address}\n#{Faker::Address.city}, #{Faker::Address.state}\n#{Faker::Address.zip_code}"
#     )
# end

assets = []
(0..10).each do |_n|
    assets << u = Context::Asset.create!(
        uri: Faker::Internet.url
    )
end

activities = []
(0..10).each do |_n|
    activities << a = Context::Activity.create!(
        name: Faker::Company.buzzword,
        description: Faker::Company.catch_phrase,
        system: (rand(2) == 1),
        place: places.sample,
        scope: (rand(2) == 1 ? activities.sample : nil),
        next: (rand(2) == 1 ? activities.sample : nil),
        parent: (rand(2) == 1 ? activities.sample : nil)
    )
    Context::UsageRole.create!(activity: a, asset: assets.sample, semantic_uri: 'uri://asset1')
    Context::UsageRole.create!(activity: a, asset: assets.sample, semantic_uri: 'uri://asset2')
    Context::ActorRole.create!(activity: a, person: patients.sample, semantic_uri: 'uri://patient1')
    Context::ActorRole.create!(activity: a, person: physicians.sample, semantic_uri: 'uri://physician1')
    Context::ActorRole.create!(activity: a, person: physicians.sample, semantic_uri: 'uri://physician2')
    Context::ActorRole.create!(activity: a, person: physicians.sample, semantic_uri: 'uri://physician3')
    Context::Objective.create!(formalized: (rand(2) == 1), language: 'fake', semantic_uri: 'uri://dl', specification: 'true', activity: a, comment: Faker::Lorem.paragraph)
end
