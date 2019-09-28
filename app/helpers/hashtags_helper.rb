# frozen_string_literal: true

module HashtagsHelper
  def find_and_replace_hashtag_link(text)
    hashtags = Hashtag.find_hashtags(text)

    hashtags.each do |hashtag|
      text.gsub!(/#{hashtag.name}/i, link_to(hashtag.name, hashtag_path(hashtag), class: 'hashtag'))
    end
    text.html_safe
  end
end
