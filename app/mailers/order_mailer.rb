class OrderMailer < ApplicationMailer
  def order_receipt_email
    @order = params[:order]
    mail(to: @order.email, subject: "Your Order no. #{@order.id} From Jungle")
  end
end
