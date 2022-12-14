# frozen_string_literal: true

class Api::VideoController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  def create
    name = 'all.mp4'
    json = RestClient.get("https://player02.getcourse.ru/player/#{params[:url]}")
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
    send_data(name)
  end
end
