# This migration comes from vertigo_rtm (originally 20160722132554)
class CreateVertigoRtmMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :vertigo_rtm_messages do |t|
      t.text :text, null: false
      t.references :creator, null: false
      t.references :conversation, null: false

      t.timestamps null: false
    end
  end
end
