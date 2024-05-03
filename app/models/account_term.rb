class AccountTerm < ApplicationRecord
  belongs_to :account
  belongs_to :term_and_conditions
end
