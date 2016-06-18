class AddActivityPlace < ActiveRecord::Migration
  def change
	  add_column	:activities, :place_id,	:uuid,	index: true
	  add_foreign_key	:activities,	:places
  end
end
