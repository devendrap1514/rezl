class AdminTerm < ApplicationRecord
  belongs_to :admin_user
  belongs_to :term_and_condition

  validates :admin_user, uniqueness: { scope: :term_and_condition }
end
