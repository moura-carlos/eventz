module LikesHelper
  def like_or_unlike_button(event, like)
    if like
      button_to "☆ Unlike", event_like_path(event, like), method: :delete
    else
      # we don't have to specify POST here because button_to always uses POST as the verb.
      button_to "★ Like", event_likes_path(event)
    end
  end
end
