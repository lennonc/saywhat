class QuotesController < ApplicationController

  before_filter :authorize

  def index
    if params[:speaker_id]
      @quotes = Quote.where(:speaker_id => params[:speaker_id].to_i).all
    elsif params[:user_id]
      @quotes = Quote.where(:user_id => params[:user_id].to_i).all
    end

    @quotes = Quote.all unless @quotes
  end

  def create
    quote_params = params[:quote]

    speaker_params = params[:quote][:speaker]
    speaker = Speaker.where(speaker_params).first
    speaker = Speaker.new(speaker_params) unless speaker

    ap speaker

    quote_params.delete :speaker

    quote = Quote.new quote_params
    quote.user = current_user
    quote.speaker = speaker

    if quote.save
      redirect_to root_path
    else
      @quote = quote
      ap @quote.speaker
      render :new
    end
  end

  def new
    @quote = Quote.new
    @quote.speaker = Speaker.new
  end

  def destroy
    
  end


end