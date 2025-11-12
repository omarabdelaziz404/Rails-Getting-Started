#Model
class Product < ApplicationRecord
  include Notifications

  has_one_attached :featured_image
  has_rich_text :description

  validates :name, presence: true
  validates :inventory_count, numericality: { greater_than_or_equal_to: 0 } #inventory count is never a negative number

  after_update_commit :notify_subscribers, if: :back_in_stock?

  def back_in_stock?
    inventory_count_previously_was.zero? && inventory_count.positive?
  end
end