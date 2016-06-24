json.extract! person, :id, :external_id, :name, :first_name, :middle_name, :last_name
json.url person_url(person)
json.path person_path(person)
# json.memberships do
# 	json.array! person.memberships do |m|
# 		json.extract! m, :id
# 		json.url group_member_url(m.group, m)
# 		json.path group_member_path(m.group, m)
# 		json.group do
# 			json.extract! m.group, :id, :name
# 			json.url group_url(m.group)
# 			json.path group_path(m.group)
# 		end
# 	end
# end
