class QuotesController < ApplicationController

  before_filter :authorize
  def index
    @quotes = Quote.all
  end

  def create
      q = Quote.create(params[:quote])
      puts q
  end

  def new
    @quote = Quote.new
  end

  def destroy
    
  end


end