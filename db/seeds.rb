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
    name: 'Prototype Web UI',
    launch_url: 'https://healthcreek-alpha.s3-us-west-2.amazonaws.com/index.html',
    icon_url: 'http://healthcreek-alpha.s3.amazonaws.com/app/images/textures/tileable_wood_texture.png',
    available: true
)
# admin = User.create!(external_id: 42,
#                               name: 'Default Administrator',
#                               email: 'admin@example.com',
#                               password: 'password',
#                               password_hash: User.compute_hash('password'))
#
# patient = User.create!(external_id: 42,
#                                 name: 'Peter Patient',
#                                 email: 'patient@example.com',
#                                 password: 'password',
#                                 password_hash: User.compute_hash('password'))
#
# endo = User.create!(external_id: 42,
#                               name: 'Ernest Endocrinologist',
#                               email: 'endo@example.com',
#                               password: 'password',
#                               password_hash: User.compute_hash('password'))
#
#
# d2 = Problem.create!(name: 'Diabetes Type II', external_id: '44054006')
# context = Context.create!(name: 'Diabetes Followup', scope: '44054006')
#
# i = Issue.create!(user: admin, problem: d2)
# e = Encounter.create!(user: admin, issue: i, context: context)
#
# Participant.create!(encounter: e, user: endo)
