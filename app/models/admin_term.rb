class AdminTerm < ApplicationRecord
  belongs_to :admin_user
  belongs_to :term_and_condition
end
