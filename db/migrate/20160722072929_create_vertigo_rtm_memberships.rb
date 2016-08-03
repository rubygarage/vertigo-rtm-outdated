class CreateVertigoRtmMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :vertigo_rtm_memberships do |t|
      t.references :conversation, null: false, index: false
      t.references :user, null: false
      t.datetime :last_read_at, null: false
      t.index [:conversation_id], name: :index_vertigo_rtm_conversation_user_relations_on_conversation

      t.timestamps null: false
    end
  end
end
