class CreatePropertyTermAndConditions < ActiveRecord::Migration[7.0]
  def change
    create_table :property_term_and_conditions do |t|
      t.string :title
      t.string :description
      t.references :property, null: false, foreign_key: true

      t.timestamps
    end
  end
end
