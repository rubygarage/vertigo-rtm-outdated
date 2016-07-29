class CreateVertigoRtmConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :vertigo_rtm_conversations do |t|
      t.string :name, null: false
      t.string :type, null: false
      t.integer :state, default: 0
      t.references :creator, null: false
      t.integer :posts_count, default: 0
      t.integer :messages_count, default: 0
      t.integer :members_count, default: 0

      t.timestamps null: false
    end
  end
end
