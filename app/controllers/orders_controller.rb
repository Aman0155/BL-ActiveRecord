class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
 result = Orders::CreateOrderService.new(order_params).call

if result[:success]
render json: { message: "Order created!", order: result[:order] }, status: :created
  else
  render json: { error: result[:errors] }, status: :unprocessable_entity
end
  end

  private

  def order_params
  params.require(:order).permit(:user_id, :status)
  end
end
