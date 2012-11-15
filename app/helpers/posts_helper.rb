module PostsHelper

  def display_url_link(post)
    if post.url.starts_with?("http://") || post.url.starts_with?("https://")
      return post.url
    else
      return "http://" + post.url
    end
  end

  def nested_comments(comments)
    comments.map do |comment, sub_comments|
      render(comment) + content_tag(:div, nested_comments(sub_comments), class: "nested_messages")
    end.join.html_safe
  end
end
