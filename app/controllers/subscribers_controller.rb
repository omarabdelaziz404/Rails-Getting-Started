class SubscribersController < ApplicationController
  allow_unauthenticated_access
  before_action :set_product #Before running any action, Rails will first run set_product

  def create #runs when someone submits a form to subscribe
    @product.subscribers.where(subscriber_params).first_or_create
    redirect_to @product, notice: "You are now subscribed."
  end

  private
    def set_product
      @product = Product.find(params[:product_id])
    end

    def subscriber_params
      params.expect(subscriber: [ :email ])
    end
end
