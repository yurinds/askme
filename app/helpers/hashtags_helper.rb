# frozen_string_literal: true

module HashtagsHelper
  def find_and_replace_hashtag_link(text)
    hashtags = Hashtag.find_hashtags(text)

    hashtags.each do |hashtag|
      text.gsub!(/#{hashtag.name}/i) do |match|
        link_to(match, hashtag_path(hashtag), class: 'hashtag')
      end
    end
    text.html_safe
  end
end
