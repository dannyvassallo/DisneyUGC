class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :title
      t.string :description      
      t.string :call_to_action

      t.timestamps null: false
    end
  end
end
