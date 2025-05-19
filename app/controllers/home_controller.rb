class HomeController < ApplicationController
  def index
    @quotes = Quote.includes(:categories).take(5)
  end

  def uquotes
    @qoutes = Quote.includes(:categories).where(user_id: session[:user_id])
   end
end
