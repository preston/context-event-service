module Context

	module Session
		SESSION_URI_PREFIX = 'artaka://sessions'

		def session_uri_for(id)
			"#{SESSION_URI_PREFIX}/#{id}"
		end
	end

end