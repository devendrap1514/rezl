class CreateTours < ActiveRecord::Migration[7.0]
  def change
    create_table :tours do |t|
      t.string :uri
      t.string :event_name
      t.string :status
      t.datetime :start_time
      t.string :invitee_first_name
      t.string :invitee_last_name
      t.string :invitee_status
      t.string :reschedule_url
      t.string :phone_number
      t.references :property

      t.timestamps
    end
  end
end
