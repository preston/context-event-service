class OpenIdConnectController < ApplicationController

	include CanCan::ControllerAdditions

	# Assure that CanCanCan authorization checks run.
	# check_authorization

	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	before_filter :set_user_from_session

	def set_options_from(request)
		@options = {}
		request.body.split(/&/).each do |param|
		  key, val = param.split('=').map { |v| CGI.unescape(v) }
		  @options[key] = val
		end
	end

	# Return the CORS access control headers.
	def cors_set_access_control_headers
		headers['Access-Control-Allow-Origin'] = '*'
		headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
		headers['Access-Control-Allow-Headers'] = '*'
		headers['Access-Control-Max-Age'] = "1728000"
	end

	# If this is a preflight OPTIONS request, then short-circuit the
	# request, return only the necessary headers and return an empty
	# text/plain.
	def cors_preflight_check
		if request.method == :options
			headers['Access-Control-Allow-Origin'] = '*'
			headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
			headers['Access-Control-Allow-Headers'] = '*'
			headers['Access-Control-Max-Age'] = '1728000'
			render :text => '', :content_type => 'text/plain'
		end
	end

	# CanCanCan's authorization
	rescue_from CanCan::AccessDenied do |exception|
		# byebug
		Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
		flash[:error] = exception.message
		redirect_to root_url
	end

	def set_user_from_session
		identity_id = session['identity_id']
		puts "identity_id: #{identity_id}"
		if identity_id.nil?
			# Oh well!
		else
			begin
				@current_identity = Identity.find(identity_id)
				@current_user = @current_identity.user
			rescue
				# User may be have been deleted.
				session[:identity_id] = nil
			end
		end
		@current_user
	end

	def unauthenticate!
		session[:identity_id] = nil
		@current_user = nil
		@current_identity = nil
	end

	def current_user
		@current_user
	end

	def current_identity
		@current_identity
	end

	def new_nonce
		session[:nonce] = SecureRandom.hex(16)
	end

	def stored_nonce
		session.delete(:nonce)
	end


	def build_oauth_request(tool, uri, options)
		# The OAuth::Consumer is finicky about port specification.
		if uri.port == uri.default_port
			host = uri.host
		else
			host = "#{uri.host}:#{uri.port}"
		end
		consumer = OAuth::Consumer.new(
			tool.key,
			tool.secret,
			:site => "#{uri.scheme}://#{host}",
			:signature_method => options['oauth_signature_method'])

		path = uri.path
		path = '/' if path.empty?
		if uri.query_values # && uri.query != ''
			uri.query_values.each do |k, v|
				unless options[k]
					options[k] = v.first
					# options[k] = URI.escape(v.first)
					options["custom_#{k}"] = v.first
				end
			end
		end
		# uri.query = nil

		# Note the use of the "body" scheme instead of header!
		request = consumer.create_signed_request(
				:post,
				path,
				nil,
				{ :scheme => 'body', timestamp: options['oauth_timestamp'], :nonce => options['oauth_nonce'] },
				options)

		if uri.query_values
			# Remove them from the body.
			cleaned_query = Rack::Utils.parse_nested_query(request.body)
			uri.query_values.each do |k, v|
				# cleaned_query.delete k
				# cleaned_query.delete "custom_#{k}"
			end
			puts request.body = cleaned_query.to_query
		end
		request
	end

end
