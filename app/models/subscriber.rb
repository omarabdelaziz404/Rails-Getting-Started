class Subscriber < ApplicationRecord
  belongs_to :product
  generates_token_for :unsubscribe #Creates a unique token for unsubscribe links
end
