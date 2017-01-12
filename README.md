# Tumblr to Hugo

I didn't want to move a bunch of blog posts manually from Tumblr to Hugo, so I built this.

Just run `ruby t2h.rb SOME+API+KEY+HERE my-blog-on.tumblr.com`.

It will create a file per post, with the proper title and a path that makes sense (/blog/the-title-of-the-post) and also create a CSV file with the original URL and the new path on Hugo, to help you setup the redirections.
