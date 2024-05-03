class AccountPropertyTerm < ApplicationRecord
  belongs_to :account
  belongs_to :property_term_and_conditions
end
