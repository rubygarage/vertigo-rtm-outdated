class CreateVertigoRtmAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :vertigo_rtm_attachments do |t|
      t.string :attachment, null: false
      t.references :message, null: false

      t.timestamps null: false
    end
  end
end
