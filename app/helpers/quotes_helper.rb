module QuotesHelper
  def quotes_per_page_link(num)
    url_for :per_page => num.to_s
  end

  def speaker_image(speaker)
    image_html = image_tag speaker.photo_url, :width => '100', :height => '100', :class => 'quote-speaker-photo', :alt => speaker.name
    link_to image_html, speaker_quotes_path(:speaker_id => speaker.id)
  end
end
