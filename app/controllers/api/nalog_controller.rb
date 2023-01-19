# frozen_string_literal: true

class Api::NalogController < ApplicationController
  protect_from_forgery with: :null_session

  api :GET, '/nalog/:id', 'id is a inn'
  def show
    json = begin
             load
           rescue Errno::ECONNRESET => e
             load
           end
    render status: :ok, json: JSON.parse(json)
  end

  private

  def load
    RestClient.post('https://pb.nalog.ru/search-proc.json', "mode=search-ip&queryIp=#{params[:id]}")
  end
end
