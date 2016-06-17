class SessionsController < ApplicationController
    skip_before_filter	:authenticate_identity!,	except: :destroy
    skip_authorization_check

    before_filter :cleanse_session, except: :callback

    def cleanse_session
        session['provider_id'] = nil
    end

    def callback
        if params['code'].nil?
            flash[:warning] = "We couldn't verify your single sign-on identity, sorry. Please try again. If you continue to have issues, try logging out first."
            redirect_to :root
        else
            openid_connect_login
        end
    end

    def openid_connect_login
        provider = Provider.find(session['provider_id'])
        uri = URI(provider.configuration['token_endpoint'])
        data = {
            code: params['code'],
            grant_type: 	:authorization_code,
            client_id: 	provider.client_id,
            client_secret: 	provider.client_secret,
            redirect_uri:	callback_url
            # state: session[:session_id],
            # nonce: new_nonce
        }
        response = Net::HTTP.post_form(uri, data)
        authorization = JSON.parse(response.body)
        logger.debug "Authorization JSON response: #{authorization}"
        jwt = nil
        # byebug
        public_keys_for(provider).each_with_index do |pk, i|
            public_key = OpenSSL::PKey::RSA.new(pk)
            begin
                jwt = JWT.decode(authorization['id_token'], public_key)
                logger.debug("Key #{i} worked!")
                break
            rescue
                # Probably the wrong key.
                # logger.debug("Key #{i} didin't work.")
                next
            end
        end
        # byebug
        msg = "Hmm.. #{provider.name} didn't return what we expected, so we are playing it safe and not authenticating you. Sorry!"
        if jwt.nil?
            redirect_to	:login, message: "#{msg} (Couldn't decrypt token with known public keys.)"
        elsif jwt[0]['aud'] != provider.client_id && jwt[0]['aud'] != provider.alternate_client_id
            flash[:error] = "#{msg} (Provider mismatch.)"
            redirect_to :login
        # elsif authorization['state'] != session[:session_id]
        # 	flash[:error] = "#{msg} (Session ID mismatch.)"
        # 	render 	:sorry
        else
            # Looks good!
            logger.debug jwt
            session[:expires_at] = DateTime.strptime(jwt[0]['exp'].to_s, '%s')
            subject = jwt[0]['sub']
            identity = Identity.find_by_sub_and_provider_id(subject, provider.id)
            email = jwt[0]['email']
            if identity.nil?
                user = current_user
                if user.nil? # The user is not logged in.
                    user = User.create!(
                        name: jwt[0]['name'],
                        first_name: jwt[0]['given_name'],
                        last_name: jwt[0]['family_name']
                    )
                end

                identity = Identity.create!(
                    user: user,
                    provider: provider,
                    sub: subject,
                    iat: jwt[0]['iat'],
                    hd: jwt[0]['hd'],
                    locale: jwt[0]['locale'],
                    email: email,
                    jwt: jwt[0]
                )
            end
            session['identity_id'] = identity.id
            jwt = JsonWebToken.new(identity_id: identity.id, expires_at: 24.hours.from_now)
            jwt.save!
            redirect_to :dashboard
        end
    end

    # Some OpenID Connect IDP change their encryption keys frequently. For example, Google rotates daily:
    #
    # 	https://developers.google.com/identity/protocols/OpenIDConnect?hl=en
    #
    # To assure we always have current copies of the public keys, we'll force hourly reconfiguration.
    def public_keys_for(provider)
        if provider.updated_at < 1.hour.ago
            logger.debug 'Forcing IDP reconfiguration to update public keys.'
            provider.reconfigure
            provider.save
        else
            logger.debug 'Using existing public keys.'
        end
        provider.public_keys
    end

    def authenticate
        provider = Provider.find(params['provider_id'])
        session['provider_id'] = provider.id
        uri = URI(provider.configuration['authorization_endpoint'])
        query = {
            redirect_uri:	callback_url,
            # state: 			new_nonce,
            response_type: 	:code,
            access_type: 	:offline,
            # aud: provider.client_id,
            client_id: 		provider.client_id,
            scope: provider.scopes
            # scope: 			'openid email profile'
            # scope: 			'launch/encounter user/*.read launch openid patient/*.read profile'
            # scope: 			'phone email address launch/encounter user/*.read launch openid patient/*.read profile'
        }
        uri.query = URI.encode_www_form(query)
        redirect_to uri.to_s
    end

    def destroy
        unauthenticate!
        redirect_to root_url
    end
end
