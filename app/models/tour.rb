class Tour < ApplicationRecord
  belongs_to :property

  enum status: { scheduled: 'scheduled', completed: 'completed', awaiting: 'awaiting' }
end
