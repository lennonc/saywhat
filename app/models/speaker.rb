require 'open-uri'

class Speaker < ActiveRecord::Base
  API_TOKEN  = 'CAACZBDEeMMMkBAMgST519elIFErClk9LZB3DlcIjD1EpnWZB9lwdGtTXe6GcdMNvyPEK1zZCzprATSmtQeQ1uiSvdBOti4yBC2qWZCXBDDHYPzCgvJSEQUqEvZCTHp2GF8dgKGIbrvP0ABOyVGq7QqDMLUSZAaP0hYZD'
  BASE_NAME  = 'Kyle Moore'
  PHOTO_SIZE = '200'

  attr_accessible :name, :photo
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :quotes

  before_save :update_photo

  def name=(str)
    write_attribute(:name, str.to_s.titleize)
  end

  def update_photo
    oauth = Koala::Facebook::OAuth.new('208959949254857', '43ca934f27f13c97b2ab905b6cc2a43d')
    token = oauth.exchange_access_token_info(API_TOKEN)['access_token']
    graph = Koala::Facebook::API.new(token)

    if name == BASE_NAME
      image_url = graph.get_picture('me', :width => PHOTO_SIZE, :height => PHOTO_SIZE)
    else
      graph.get_connections('me', 'friends').each do |friend|
        if friend['name'] == name
          image_url = graph.get_picture(friend['id'], :width => PHOTO_SIZE, :height => PHOTO_SIZE)
        end
      end
    end

    self.photo = open(image_url).read if image_url
  end

  def photo_url
    Rails.application.routes.url_helpers.speaker_photo_path :speaker_id => self.id
  end

end
