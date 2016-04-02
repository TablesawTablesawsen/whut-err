module UsersHelper

  def text_with_user_mentions (tweet)
    text_with_mentions = tweet.full_text.dup
    if tweet.user_mentions?
      tweet.user_mentions.reverse_each do |mention|
        mention_range = mention.indices[0]...mention.indices[1]
        text_with_mentions[mention_range] = link_to(
          text_with_mentions[mention_range],
          user_path(mention.screen_name)
          )
      end
    end
    text_with_mentions
  end

end
