# frozen_string_literal: true

class Api::VideoController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  def index
    name = 'all.mp4'
    z = "https://player02.getcourse.ru/player/#{params[:url]}"
    # z = 'https://player02.getcourse.ru/player/0bdad15df289e721229ffe07fb26d480/2bb29d7da7f899f35a58ab1ff1e7a7f1/media/1080.m3u8?sid=&user-cdn=cloudflare&version=5%3A2%3A1%3A0%3Acloudflare&user-id=276438375&jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyLWlkIjoyNzY0MzgzNzV9.Z9ja59KiWO7P4vXqaVjmYggu7xord5NgPrtpKx3XydU'
    # z = 'https://player02.getcourse.ru/player/2b177ef17cb081161909415289934918/b6c2fc22765b62372aff4ba976d70219/media/1080.m3u8?sid=&user-cdn=integros&version=5%3A2%3A1%3A0%3Aintegros&user-id=276539105&jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyLWlkIjoyNzY1MzkxMDV9.3Z3t_6qlaRdvo_2Bv2ooSyzbWMlQGRy5yBG0RJS6KtM'
    json = RestClient.get(z)
    links = json.body.split("\n").reject { |x| x.size < 100 }
    links.each_with_index do |link, index|
      file = File.new("video_00_#{index}.ts", 'wb')
      data = RestClient.get(link, 'Content-Type': 'multipart/form-data;').body
      file.write data
      file.close
      print '.'
    end
    files = (0...links.size).map { |i| "video_00_#{i}.ts"}.join(' ')
    system "cat #{ files } > all.txt"
    system "ffmpeg -i all.txt -c copy -bsf:a aac_adtstoasc #{name}"
    system "rm #{ files }"
    system "rm all.txt"
    send_data(name)
  end
end
