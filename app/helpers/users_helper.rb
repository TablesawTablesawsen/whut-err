module UsersHelper

  def text_with_user_mentions (tweet)
    tweet = tweet.retweeted_status if tweet.retweet?

    text_with_mentions = sanitize(tweet.full_text.dup)
    if tweet.user_mentions?
      tweet.user_mentions.reverse_each do |mention|
        user = @client.user(mention.screen_name)
        mention_range = mention.indices[0]...mention.indices[1]
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
    text_with_mentions
  end
end
