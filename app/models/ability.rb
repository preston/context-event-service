class Ability
	include CanCan::Ability

	def initialize(person)
		person ||= Person.new # Unauthenticated

		if person.id.nil? # Unauthenticated guest.
			# Nada!
		else # Normal authenticated person.

			# We're going to disable detailed authorization controls for now!
			can :manage, :all
			
			# can :manage, Person
			#
			# # Identity and Access Management (IAM)
			# can :read,	Identity, person_id: person.id
			# can :delete,	Identity, person_id: person.id
			# can :read, Person, id: person.id
			#
			# can :edit, Person, id: person.id
			#
			# can :read, Client
			# can :launch, Client

		end
	end
end
