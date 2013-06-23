require 'open-uri'

class Speaker < ActiveRecord::Base
  API_TOKEN  = 'CAACEdEose0cBACq5APiHpkqsiMvJ3ZBUpHqy1RbGDn7s3619VBiFDlKn56IHmX35y7ETAA78GEh1MD3ynMeC8na8ZA4B0XQ00QZBTxOD0Wt5MrBTjVTwk8nAg6L9MEfUk9htesPm3Hh3BTg1HHPjaVqZBtTA0SwZD'
  BASE_NAME  = 'Lennon Chimbumu'
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
    graph = Koala::Facebook::API.new(API_TOKEN)

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
