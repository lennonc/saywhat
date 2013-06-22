class QuotesController < ApplicationController

  before_filter :authorize
  def index
    @quotes = Quote.all
  end

  def create
    quote_params = params[:quote]

    speaker_name = params[:quote][:speaker]
    speaker = Speaker.find_by_name(speaker_name)
    speaker = Speaker.create(:name => speaker_name) unless speaker

    quote_params.delete :speaker
    quote_params[:user_id] = current_user.id
    quote_params[:speaker_id] = speaker.id

    quote = Quote.create quote_params
    quote.save!

    redirect_to '/'
  end

  def new
    @quote = Quote.new
  end

  def destroy
    
  end


end