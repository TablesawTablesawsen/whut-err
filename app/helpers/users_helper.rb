module UsersHelper

  def text_with_user_mentions (tweet)
    text_with_mentions = tweet.full_text.dup
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
    # relies on twitter's API providing HTML safe text.
    text_with_mentions.html_safe
  end

  # def text_with_user_mentions (tweet)
  #   text_with_mentions = "".html_safe
  #   if tweet.user_mentions?
  #     start = 0
  #     tweet.user_mentions.each do |mention|
  #       text_with_mentions << tweet.full_text[start...mention.indices[0]]

  #       user = @client.user(mention.screen_name)
  #       mention_range = mention.indices[0]...mention.indices[1]
  #       text_with_mentions << link_to(
  #         tweet.full_text[mention_range],
  #         user_path(mention.screen_name),
  #         title: mention.name,
  #         data: {
  #           toggle: "popover",
  #           content: "#{user.tweets_count} tweets | #{user.followers_count} "\
  #                    "followers",
  #           trigger: "focus hover"
  #           }
  #         )
  #       start = mention.indices[1]
  #     end
  #     text_with_mentions << tweet.full_text[start...-1]
  #     text_with_mentions
  #   else
  #     tweet.full_text
  #   end
  # end
end
