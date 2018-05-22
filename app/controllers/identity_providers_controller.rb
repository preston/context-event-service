require 'uri'

class IdentityProvidersController < ApplicationController

    load_resource :identity_provider
    skip_before_action	:authenticate_identity! #,	except: :destroy
    skip_authorization_check
    
    def launch
        idp = @identity_provider
        session['provider_id'] = idp.id
        # uri = URI(idp.configuration['authorization_endpoint'])
        issuer = params['iss']
        launch_id = params['launch']
        scope = params['scope'] || 'patient/*.read openid email profile'
        query = {
            redirect_uri:	callback_url,
            # state: 			new_nonce,
            response_type: 	:code,
            access_type: 	:offline,
            # aud: idp.client_id,
            client_id: 		idp.client_id,
            # scope: idp.scopes
            scope: 			scope,
            aud: issuer,
            launch: launch_id
            # scope: 			'launch/encounter person/*.read launch openid patient/*.read profile'
            # scope: 			'phone email address launch/encounter person/*.read launch openid patient/*.read profile'
        }
        uri.query = URI.encode_www_form(query)
        redirect_to uri.to_s
    end

end
