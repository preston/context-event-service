google = Provider.create_with(
    name: 'Google',
    client_id: '418783041492-ji2qu86h9ap35rr08cfnlpcs4ivptt78.apps.googleusercontent.com',
    client_secret: 'fTu8Jq_HwkOIoPZRdXWhzKin'
).find_or_create_by(issuer: 'https://accounts.google.com')
google.reconfigure
google.save!

live = Provider.create_with(
	name: 'Microsoft Live',
	client_id: '0000000040193B01',
	client_secret: '5J4ZxPQb22bXxvj1i-eqaHQILqKKRb2-',
    alternate_client_id: '00000000-0000-0000-0000-000040193B01'
).find_or_create_by(issuer: 'https://login.live.com')
live.reconfigure
live.save!

smart = Provider.create_with(
    name: 'SMART HIT',
    client_id: 'bda1236a-7288-4ca7-991d-fb7f419fea30',
    client_secret: 'QR-EVIOifG_hoCZsjMKnreXPs486c0-_m-3Yjv5BgsGl_x0zO9wDIoku7gv0stkTk9UaFwqE2mX_TEVokXy0Ww',
    alternate_client_id: 'eyJhbGciOiJSUzI1NiJ9.eyJhdWQiOlsiYmRhMTIzNmEtNzI4OC00Y2E3LTk5MWQtZmI3ZjQxOWZlYTMwIl0sImlzcyI6Imh0dHBzOlwvXC9hdXRob3JpemUtZHN0dTIuc21hcnRoZWFsdGhpdC5vcmdcLyIsImp0aSI6ImYzZTY0NzI2LTZmMGUtNDQ4Yi1hZjhlLWJmMzg2MGVkNjdiZCIsImlhdCI6MTQ2MTc5NzQ5Nn0.OpaESmBnrK1pmYuWTP9hBSkTTGxaK4OtdynqXkeg_9xV9zMebJH6tx8YbucxGA4Fp3d1UUFJD8o8O0rO-jhXrlBxEVyyhsNiff5OgkqmzPwJW9ynj3EHJ7NRwb_VCLXG4lF_9dlcJvFCpWwVdW1rYXIMeN7R4BXhmBzozy0Lq28'
# ).find_or_create_by(issuer: 'https://authorize-dstu2.smarthealthit.org')
).find_or_create_by(issuer: 'https://authorize.smarthealthit.org')
smart.reconfigure
smart.save!

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
