class Position < ApplicationRecord
  enum status: { open: 10, close: 20 }, _prefix: true
end
