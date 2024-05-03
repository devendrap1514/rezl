class CreateTermAndConditions < ActiveRecord::Migration[7.0]
  def change
    create_table :term_and_conditions do |t|
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
