require_relative '../all'

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

	namespace :agent do

		desc "Sends 'message of the day' events to common initialization actions."
		task motd: :environment do
			Context::Agent::MessageOfTheDay.new.run
		end

		desc "Monitors all UI events and responds with nonsense."
		task smith: :environment do
			Context::Agent::Smith.new.run
		end

		desc "Prunes old clock events older than #{Context::Clock::TICK_TIME_TO_LIVE} seconds."
		task pruner: :environment do
			Context::Agent::Pruner.new.run
		end
	end
end
