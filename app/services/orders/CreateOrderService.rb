module Orders
  class CreateOrderService
  def initialize(params)
      @params = params  
    end
    def call
      order = Order.new(@params)  
      if order.save
 ::ExpiresUnpaidOrdersJob.set(wait: 1.minutes).perform_later(order.id)
return { success: true, order: order }
 else
        return { success: false, errors: order.errors.full_messages }
      end
end
end
end
