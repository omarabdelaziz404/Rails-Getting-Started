module Product::Notifications #defines a nested module under Product
  extend ActiveSupport::Concern #This module is a concern — it can safely include both code and callbacks inside other classes

  included do
    has_many :subscribers, dependent: :destroy
    after_update_commit :notify_subscribers, if: :back_in_stock?
  end

  def back_in_stock?
    inventory_count_previously_was.zero? && inventory_count.positive?
  end

  def notify_subscribers
    subscribers.each do |subscriber|
      ProductMailer.with(product: self, subscriber: subscriber).in_stock.deliver_later
    end
  end
end
