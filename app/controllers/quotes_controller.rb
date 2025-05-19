class QuotesController < ApplicationController
  before_action :set_quote, only: %i[ show edit update destroy ]
  before_action :require_login, except: [:index, :show]
  before_action :set_quote, only: [:show, :edit, :update, :destroy]


  # GET /quotes or /quotes.json
  def index
    if current_user
      @quotes = current_user.quotes
    else
      @quotes = Quote.all
    end
  end

  # GET /quotes/1 or /quotes/1.json
  def show
  end

  # GET /quotes/new
  def new
    @quote = Quote.new
  end

  # GET /quotes/1/edit
  def edit
    @quote = Quote.find(params[:id])
    if current_user == @quote.user
      # Allow the user to edit the quote
    else
      flash[:alert] = "You are not authorized to edit this quote."
      redirect_to quotes_path
    end
  end
  

  # POST /quotes or /quotes.json
  def create
    @quote = Quote.new(quote_params)
    source_params = params.require(:quote).permit(:fname, :lname, :byear, :dyear, :bio)
    source = Source.find_or_create_by(fname: source_params[:fname], lname: source_params[:lname])
    source.update(source_params) # Update additional source attributes
    @quote.source = source

    category_name = params[:quote][:category_name]
    category = Category.find_or_create_by(catname: category_name)
    @quote.categories << category

    respond_to do |format|
      if @quote.save
        format.html { redirect_to quote_url(@quote), notice: "Quote was successfully created." }
        format.json { render :show, status: :created, location: @quote }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotes/1 or /quotes/1.json
  def update
    @quote = Quote.find(params[:id])
    logger.debug "Updating quote with ID: #{params[:id]}"
    logger.debug "Params: #{quote_params}"
    respond_to do |format|
      if @quote.update(quote_params)
        format.html { redirect_to quote_url(@quote), notice: "Quote was successfully updated." }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1 or /quotes/1.json
  def destroy
    @quote.destroy

    respond_to do |format|
      format.html { redirect_to quotes_url, notice: "Quote was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quote_params
      params.require(:quote).permit(:id,:catname,:qtext, :qyear, :qcom, :ispublic, :user_id, :fname, :lname, :byear, :dyear, :bio)
    end
end
