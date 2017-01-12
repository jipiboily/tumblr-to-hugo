require 'httparty'
require 'pry'

require './tumblr'
require './hugo'


tumblr = Tumblr.new

next_post = tumblr.next_post
all_posts = [next_post]

while next_post != nil
  next_post = tumblr.next_post

  all_posts << next_post if next_post
end

hugo = Hugo.new
CSV.open("redirects.csv", "wb") do |csv|
  csv << ["Old URL", "New Path"]
  all_posts.each do |post|
    urls = hugo.write_post(post)
    csv << [urls[:old_url], urls[:new_path]]
  end
end
