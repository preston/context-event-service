class Ability
	include CanCan::Ability

	def initialize(person)
		person ||= Person.new # Unauthenticated

		if person.id.nil? # Unauthenticated guest.
			# Nada!
		else # Normal authenticated person.

			# We're going to disable detailed authorization controls for now!
			can :manage, :all
			
			# can :manage, System::Person
			#
			# # Identity and Access Management (IAM)
			# can :read,	System::Identity, person_id: person.id
			# can :delete,	System::Identity, person_id: person.id
			# can :read, System::Person, id: person.id
			#
			# can :edit, System::Person, id: person.id
			#
			# can :read, System::Client
			# can :launch, System::Client

		end
	end
end
