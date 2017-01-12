require 'active_support/inflector/transliterate'

class Hugo
  include ActiveSupport::Inflector

  OUTPUT_DIRECTORY = './blog/'

  def initialize
    Dir.mkdir(OUTPUT_DIRECTORY) unless File.exists?(OUTPUT_DIRECTORY)
  end

  def write_post(post)
    old_url = post['post_url']
    safe_title = parameterize(post['title'])
    post_date = post['date'].split(' ')[0]
    file_name = "#{post_date}-#{safe_title}.html"
    new_path = "/blog/#{safe_title}"

    puts "Writing #{file_name}"

    file_content  = <<-EOF
+++
date = "#{post_date}"
title = "#{post['title']}"
slug = "#{safe_title}"
layout = "blog"
+++
#{post['body'].gsub('Dependency','Dependency')}
EOF

    File.open("#{OUTPUT_DIRECTORY}#{file_name}", "w") {|f| f.write(file_content) }

    return {old_url: old_url, new_path: new_path}
  end
end
