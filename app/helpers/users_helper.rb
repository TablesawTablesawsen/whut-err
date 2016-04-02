module UsersHelper

  def text_with_user_mentions (tweet)
    text_with_mentions = tweet.full_text.dup
    if tweet.user_mentions?
      tweet.user_mentions.reverse_each do |mention|
        user = @client.user(mention.screen_name)
        # This method relies on the accuracy of the initial indices value from
        # the API call, but this doesn't appear to always be accurate (though
        # it seems more reliable than the ending index)
        mention_range = mention.indices[0]..mention.indices[0] + user.screen_name.length
        text_with_mentions[mention_range] = link_to(
          text_with_mentions[mention_range],
          user_path(mention.screen_name),
          title: mention.name,
          data: {
            toggle: "popover",
            content: "#{user.tweets_count} tweets | #{user.followers_count} "\
                     "followers",
            trigger: "focus hover"
            }
          )
      end
    end
    # relies on twitter's API providing HTML safe text, I can't find great
    # information on that
    text_with_mentions.html_safe
  end
end
