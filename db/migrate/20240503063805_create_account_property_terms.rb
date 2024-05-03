class CreateAccountPropertyTerms < ActiveRecord::Migration[7.0]
  def change
    create_table :account_property_terms do |t|
      t.references :account, null: false, foreign_key: true
      t.references :property_term_and_conditions, null: false, foreign_key: true

      t.timestamps
    end
  end
end
