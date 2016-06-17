# require 'json_web_token'
#
# class JwtController < ApplicationController
#     # Allow the browser to make CORS requests since we do not provide a UI.
#     # This is expected and totally cool, so long as subsequent requests are propertly signed.
#     before_filter :cors_preflight_check
#
#     # We *only* support JSON endpoints!
#     before_filter :ensure_json_request, except: :cors_preflight_check
#
#     after_filter :set_cors_response_headers
#
#     def ensure_json_request
#         return if params[:format] == 'json' || request.headers['Accept'] =~ /json/
#         render json: { message: "This service only responds to JSON requests. Please set your 'Accept' header to 'application/json'." }, status: 406
#     end
#
#     WillPaginate.per_page = 10 # Seems like a reasonable default for INDEX requests. May be overrided via query paramater.
#
#     # Our JWT authentication
#     before_filter :authenticate_request
#     attr_accessor :current_user
#     # helper_method :current_user
#
#     # Prevent CSRF attacks by raising an exception.
#     # For APIs, you may want to use :null_session instead.
#     # protect_from_forgery with: :exception
#     protect_from_forgery with: :null_session
#
#     # We don't do HTML, so layouts aren't really needed.
#     layout false
#
#     # This intercepts *all* preflight OPTIONS request,
#     # return only necessary headers and response body.
#     def cors_preflight_check
#         if request.method == 'OPTIONS'
#             set_cors_response_headers
#             render text: '', content_type: 'text/plain'
#         end
#     end
#
#     private
#
#     def set_cors_response_headers
#         headers['Access-Control-Allow-Origin'] = '*'
#         headers['Access-Control-Allow-Methods'] = 'INDEX, GET, POST, PUT, PATCH, DELETE, OPTIONS'
#         headers['Access-Control-Max-Age'] = '1728000'
#         #   headers['Access-Control-Request-Method'] = '*'
#         headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization, X-Requested-With, X-Prototype-Version'
#     end
#
#     def after_sign_in_path_for(_resource)
#         dashboard_path
#     end
#
#     def authenticate_request
#         t = decode_auth_token
#         if t && t['exp'] && t['sub']
#             self.current_user ||= User.find(t['sub'])
#         else
#             render json: { message: 'Invalid or expired JWT. Please (re)authenticate and sign your request properly!', login_url: sessions_url }, status: :unauthorized
#         end
#     end
#
#     def decode_auth_token
#         @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
#   end
#
#     def http_auth_header
#         authz = request.headers['Authorization']
#         return authz.split(' ').last if authz.present?
#         nil
#     end
# end
