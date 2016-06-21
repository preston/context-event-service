class MajorRefactoring < ActiveRecord::Migration
    def change
        # Remove the 'focus' concept entirely.
        drop_table	:foci do
		end

        # Use a generic URI instead of SNOMEDCT specifically.
        rename_column	:interests,	:snomedct_concept_id,	:concept_uri
        rename_column	:issues,	:snomedct_concept_id,	:concept_uri

        # Move 'activity' to the top of the food chain.
		remove_column		:activities,	:activity_id,	:uuid
		remove_column		:activities,	:context_id,	:uuid
        remove_column		:assets,	:context_id,	:uuid
        remove_column		:objectives,	:context_id,	:uuid
        remove_column		:participants,	:context_id,	:uuid

		add_column		:objectives,	:activity_id,	:uuid,	null: false, index: true
        add_column		:participants,	:activity_id,	:uuid,	null: false, index: true
		add_foreign_key	:objectives,	:activities
        add_foreign_key	:participants,	:activities

        # Add some additional fields.
        add_column	:activities,	:system,	:boolean,	null: false
        add_column	:activities,	:previous_id,	:uuid
        add_column	:activities,	:context_id,	:uuid
        add_foreign_key	:activities,	:activities,	column: :context_id
        add_foreign_key	:activities,	:activities,	column: :previous_id

		# Change 'interest'.
		remove_column	:interests,	:role_id,	:uuid
		add_column		:interests,	:group_id,	:uuid
		add_foreign_key	:interests,	:groups
    end
end
