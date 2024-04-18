class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.string :name
      t.string :calendly_token
      t.string :organization
      t.string :me_uri
      t.string :webhook_uuid
      t.string :creator

      t.timestamps
    end
  end
end
