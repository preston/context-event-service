class SnomedctConceptsController < ApplicationController

	def index
		@concepts = SnomedctConcept.paginate(page: params[:page], per_page: params[:per_page])
		@concepts = @concepts.includes(:descriptions)
	    sort = %w{snomedct_id module_id}.include?(params[:sort]) ? params[:sort] : :snomedct_id
	    order = 'desc' == params[:order] ? :desc : :asc
	    @concepts = @concepts.order(sort => order)
	    if params[:snomedct_id] && params[:module_id] # both options could be present
	        @concepts = @concepts.where('snomedct_id = ? AND locale = ?', params[:snomedct_id], params[:module_id])
	    elsif params[:external_id] # External IDs are not gauranteed to be unique, so we may have multiple results.
	        @concepts = @concepts.where('snomedct_id = ?', params[:snomedct_id])
	    elsif params[:module_id] # empty string is a valid value, so we just need the special case for any explicit locale value.
	        @concepts = @concepts.where('locale = ?', params[:module_id])
	    end
	    # @concepts = @concepts.search_by_name(params[:filter]) if params[:filter]

	end
end
