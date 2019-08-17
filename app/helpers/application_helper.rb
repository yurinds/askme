# frozen_string_literal: true

module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'swin.png'
    end
  end
end
