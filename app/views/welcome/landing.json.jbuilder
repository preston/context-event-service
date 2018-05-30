json.message "This service is middleware, and isn't intended to be viewed directly. If you are a SMART-on-FHIR app developer, you can initialize a session by 'chaining' your authentication process. That is, after the user authenticates with your app, redirect them to one of the following pre-configured launch URLs to repeat the process for CES, such that it may also a acquire an access token for the same FHIR sandboxes. The CES URL you send the user to must be the same as the one your user launched against. If yours isn't yet listed, you can declare it -- including a new client_id and client_secret for CES use -- via the REST API."
json.identity_providers do
json.array!(IdentityProvider.all) do |idp|
	json.extract! idp, :id, :name
	json.path identity_provider_path(idp)
	json.url identity_provider_url(idp)
	json.launch_path launch_identity_provider_path(idp)
	json.launch_url launch_identity_provider_url(idp)
end
end