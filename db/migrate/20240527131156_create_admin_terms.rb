class CreateAdminTerms < ActiveRecord::Migration[7.0]
  def change
    create_table :admin_terms do |t|
      t.references :admin_user, null: false, foreign_key: true
      t.references :term_and_condition, null: false, foreign_key: true

      t.timestamps
    end
  end
end
