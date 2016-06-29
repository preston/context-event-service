class PeopleController < ApplicationController

	load_and_authorize_resource	class: 'System::Person'

	def index
        @people = System::Person.paginate(page: params[:page], per_page: params[:per_page])
		if params[:role]
			@people = @people.joins(capabilities: :role).where('roles.code = ?', params[:role])
		end
        # sort = %w(name external_id).include?(params[:sort]) ? params[:sort] : :name
        # order = 'desc' == params[:order] ? :desc : :asc
        # @people = @people.order(sort => order)
        # if params[:external_id] # External IDs are not gauranteed to be unique, so we may have multiple results.
        #     @people = @people.where('external_id = ?', params[:external_id])
        # end
        @people = @people.search_by_name(params[:name]) if params[:name]
    end

end
