require 'context'

namespace :context do

	namespace :tick do

		include Context::Clock

		desc "Emit a tick every second to #{TICK_URI_SECOND}"
		task second: :environment do
			emit_every_to(1, TICK_URI_SECOND)
		end

		desc "Emit a tick every minute to #{TICK_URI_MINUTE}"
		task minute: :environment do
			emit_every_to(60, TICK_URI_MINUTE)
		end

		desc "Emit a tick every hour to #{TICK_URI_HOUR}"
		task hour: :environment do
			emit_every_to(60 * 60, TICK_URI_HOUR)
		end

		desc "Emit a tick every day to #{TICK_URI_DAY}"
		task day: :environment do
			emit_every_to(60 * 60 * 24, TICK_URI_DAY)
		end

	end

	# namespace :snomedct do

	# 	DATA_DIR = File.join(Rails.root, 'snomedct', 'SnomedCT_RF2Release_US1000124_20160301')

	# 	desc 'Load SNOMEDCT data from local disk.'
	# 	task load: :environment do
	# 		if !File.exist?(DATA_DIR)
	# 			puts "#{ENV_VAR_NAME} doesn't exist!"
	# 			exit 1
	# 		else
	# 			dir = DATA_DIR
	# 			puts "Loading SNOMEDCT from #{dir} ..."
	# 			include Data::SNOMEDCT
	# 			load_snomed(dir)
	# 		end

	# 	end

	# end
end
