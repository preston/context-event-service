require 'healthcreek'

namespace :healthcreek do

	namespace :snomed do

		DATA_DIR = File.join(Rails.root, 'snomedct', 'SnomedCT_RF2Release_US1000124_20160301')

		desc 'Load SNOMEDCT data from local disk.'
		task load: :environment do
			if !File.exist?(DATA_DIR)
				puts "#{ENV_VAR_NAME} doesn't exist!"
				exit 1
			else
				dir = DATA_DIR
				puts "Loading SNOMEDCT from #{dir} ..."
				include HealthCreek::Data::SNOMEDCT
				load_snomed(dir)
			end

		end

	end
end
