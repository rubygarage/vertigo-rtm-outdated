class CreateVertigoRtmPreferences < ActiveRecord::Migration[5.0]
  def change
    create_table :vertigo_rtm_preferences do |t|
      t.boolean :notify_on_mention, default: true, null: false
      t.boolean :notify_on_message, default: true, null: false
      t.boolean :muted, default: false, null: false
      t.text :highlight_words, default: ''
      t.references :preferenceable, polymorphic: true, index: false
      t.index [:preferenceable_id, :preferenceable_type], name: :index_vertigo_rtm_preferences_on_preferenceable

      t.timestamps null: false
    end
  end
end
