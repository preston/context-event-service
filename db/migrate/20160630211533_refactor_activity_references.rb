class RefactorActivityReferences < ActiveRecord::Migration
  def change
	  rename_column	:activities,	:context_id,	:scope_id
	  rename_column	:activities,	:previous_id,	:next_id
  end
end
