class CreateAccountTerms < ActiveRecord::Migration[7.0]
  def change
    create_table :account_terms do |t|
      t.references :account, null: false, foreign_key: true
      t.references :term_and_conditions, null: false, foreign_key: true

      t.timestamps
    end
  end
end
