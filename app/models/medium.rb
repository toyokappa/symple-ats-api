class Medium < ApplicationRecord
  enum category: { agent: 10, ad: 20, scout: 30, sns: 40, referral: 50, other: 60 }, _prefix: true
  enum automation: { disable: 10, enable: 20, impossible: 30 }, _prefix: true
end
