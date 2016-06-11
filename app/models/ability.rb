class Ability
	include CanCan::Ability

	def initialize(user)
		user ||= User.new # Unauthenticated

		if user.id.nil? # Unauthenticated guest.
			# Nada!
		else # Normal authenticated user.

			# Identity and Access Management (IAM)
			can :read,	Identity, user_id: user.id
			can :delete,	Identity, user_id: user.id
			can :read, User, id: user.id

			can :edit, User, id: user.id

			can :read, Client
			can :launch, Client

		end
	end
end
