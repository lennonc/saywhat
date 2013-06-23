class SpeakersController < ApplicationController
  def photo
    speaker = Speaker.find_by_id(params[:speaker_id])

    send_data '' if speaker.nil?

    photo = speaker.photo ? speaker.photo : open(Rails.root.join("app", "assets", "images", "unknown.jpg")).read

    send_data photo, :type => 'image/jpeg', :disposition => 'inline'
  end
end
