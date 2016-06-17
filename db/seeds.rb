google = Provider.create_with(
    name: 'Google',
    client_id: '418783041492-19ttts5dg6if4rtba1h0tkmb26b5f352.apps.googleusercontent.com',
    client_secret: 'w2Fl4xLW-HWIIreUsY-TD9Yk',
    scopes: 'openid email profile'
).find_or_create_by(issuer: 'https://accounts.google.com')
google.reconfigure
google.save!

live = Provider.create_with(
    name: 'Microsoft Live',
    client_id: '0000000040193B01',
    client_secret: '5J4ZxPQb22bXxvj1i-eqaHQILqKKRb2-',
    alternate_client_id: '00000000-0000-0000-0000-000040193B01',
    scopes: 'openid email profile'
).find_or_create_by(issuer: 'https://login.live.com')
live.reconfigure
live.save!

Client.create!(
    name: "Preston's Client Template",
    launch_url: 'https://healthcreek-alpha.s3-us-west-2.amazonaws.com/index.html',
    icon_url: 'http://healthcreek-alpha.s3.amazonaws.com/app/images/textures/tileable_wood_texture.png',
    available: true
)

Client.create!(
    name: 'Context-Driven UI POC',
    launch_url: 'http://piper-ui.s3-website-us-east-1.amazonaws.com/v1/app',
    available: true
)

physician = Role.create!(
    name: 'Physician',
    code: 'physician'
)

patient = Role.create!(
    name: 'Patient',
    code: 'patient'
)

peter = User.create!(name: 'Peter Patient',
                     first_name: 'Peter',
                     middle_name: 'Paul',
                     last_name: 'Patient')

ernest = User.create!(name: 'Ernest E.',
                      first_name: 'Ernesto',
                      middle_name: 'Eugene',
                      last_name: 'Endocrinologist')

Capability.create!(entity: peter, role: patient)
Capability.create!(entity: ernest, role: physician)

(0..100).each do |_n|
    u = User.create!(
        salutation: Faker::Name.prefix,
        name: Faker::Name.name,
        first_name: Faker::Name.first_name,
        middle_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name
    )
    Capability.create!(entity: u, role: physician)
end

(0..1000).each do |_n|
    u = User.create!(
        salutation: Faker::Name.prefix,
        name: Faker::Name.name,
        first_name: Faker::Name.first_name,
        middle_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name
    )
    Capability.create!(entity: u, role: patient)
end
