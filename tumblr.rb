class Tumblr
  TUMBLR_API_KEY = ARGV[0].freeze
  TUMBLR_DOMAIN = ARGV[1].freeze
  BASE_URL = "https://api.tumblr.com/v2/blog/#{TUMBLR_DOMAIN}/posts/text?api_key=#{TUMBLR_API_KEY}"

  def initialize
    @page = 1
    @per_page = 20
    raw = HTTParty.get("#{BASE_URL}&limit=#{@per_page}&offset=#{offset}")

    @page_results = raw['response']
    @total_posts = @page_results['total_posts']

    @posts_read = 0
  end

  def next_post
    if @posts_read >= @total_posts
      puts "We're done!"
      return nil
    end

    post = @page_results['posts'][@posts_read - offset]

    if post.nil?
      if @posts_read == @total_posts
        return nil
      end

      puts "~~~ Page #{@page} done ~~~"
      puts "Read so far: #{@posts_read}"
      puts "Out of #{@total_posts}"
      @page_results = next_page
      post = @page_results['posts'][@posts_read - offset]
    end

    @posts_read+=1
    puts "#{@posts_read} - #{post['title']}"

    return post
  end

  def next_page
    sleep 1
    @page += 1
    raw = HTTParty.get("#{BASE_URL}&limit=#{@per_page}&offset=#{offset}")
    if raw['meta']['status'] != 200
      puts "#{raw['meta']['status']} - #{raw['meta']['msg']}"
      # binding.pry
      raise "Tumblr API Error"
    end
    raw['response']
  end

  def offset
    (@page - 1 ) * 20
  end
end
