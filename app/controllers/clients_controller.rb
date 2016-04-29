class ClientsController < OpenIdConnectController

	def index
		@clients = Client.all
	end
end
