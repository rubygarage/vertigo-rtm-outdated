class CreateVertigoRtmPreferences < ActiveRecord::Migration[5.0]
  def change
    create_table :vertigo_rtm_preferences do |t|
      t.text :highlight_words, default: ""
      t.boolean :push_everything, default: true
      t.boolean :muted, default: false
      t.references :preferenceable, polymorphic: true, index: false
      t.index [:preferenceable_id, :preferenceable_type], name: :index_vertigo_rtm_preferences_on_preferenceable

      t.timestamps null: false
    end
  end
end
