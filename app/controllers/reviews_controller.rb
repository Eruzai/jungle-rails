class ReviewsController < ApplicationController
  before_action :require_login

  def create
    @product = Product.find params[:product_id]
    @review = @product.reviews.new(review_params)
    @review.user = current_user

    if @review.save
      redirect_to "/products/#{params[:product_id]}", notice: 'Review created!'
    else
      render "products/show", params: [@reviews = @product.reviews.includes(:user)]
    end
  end

  private

  def review_params
    params.require(:review).permit(
      :product_id,
      :user_id,
      :description,
      :rating
    )
  end

  def require_login
    unless current_user
      flash[:error] = "You must be logged in to leave a review"
      redirect_to '/login'
    end
  end
end
