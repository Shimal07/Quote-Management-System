class SearchController < ApplicationController
  def index
    category_query = params[:category_query]
    
    if category_query.present?
      @quotematch = Quote.joins(:quote_categories, :categories)
                        .where("LOWER(categories.catname) LIKE ?", "%#{category_query.downcase}%")
                        .distinct
    end
  end
end





