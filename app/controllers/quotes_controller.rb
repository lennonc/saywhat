class QuotesController < ApplicationController

  before_filter :authorize

  helper_method :quotes_per_page_list

  def quotes_per_page_list
    [10, 20, 50]
  end

  def index
    @per_page = params[:per_page] ? params[:per_page].to_i : quotes_per_page_list.first
    Quote.per_page = @per_page

    if params[:speaker_id]
      @speaker = Speaker.find_by_id(params[:speaker_id].to_i)
      @quotes = Quote.where(:speaker_id => @speaker.id).paginate(:page => params[:page])
    elsif params[:user_id]
      @user = User.find_by_id(params[:user_id].to_i)
      @quotes = Quote.where(:user_id => @user.id).paginate(:page => params[:page])
    end

    @quotes = Quote.paginate(:page => params[:page]) unless @quotes

  end

  def create
    quote_params = params[:quote]

    speaker_params = params[:quote][:speaker]
    speaker = Speaker.where(speaker_params).first
    speaker = Speaker.new(speaker_params) unless speaker

    quote_params.delete :speaker

    quote = Quote.new quote_params
    quote.user = current_user
    quote.speaker = speaker

    if quote.save
      redirect_to root_path
    else
      @quote = quote
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