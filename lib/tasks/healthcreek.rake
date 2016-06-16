require 'healthcreek'

namespace :healthcreek do

	namespace :snomed do

		ENV_VAR_NAME = 'HEALTHCREEK_SNOMED_DATA'
		desc 'Load SNOMEDCT data from local disk.'
		task load: :environment do
			if ENV[ENV_VAR_NAME].nil?
				puts"#{ENV_VAR_NAME} must be set to an unzipped SNOMED CT data directory!"
				exit 1
			elsif !File.exist?(ENV[ENV_VAR_NAME])
				puts "#{ENV_VAR_NAME} doesn't exist!"
				exit 1
			else
				dir = ENV[ENV_VAR_NAME]
				puts "Loading SNOMEDCT from #{dir} ..."
				include HealthCreek::Data::SNOMEDCT
				load_snomed(dir)
			end

		end

	end
end
