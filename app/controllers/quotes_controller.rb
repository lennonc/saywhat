class QuotesController < ApplicationController

  before_filter :authorize
  def index
    @quotes = Quote.all
  end

  def create
      
  end

  def new
    @quote = Quote.new
  end

  def destroy
    
  end


end