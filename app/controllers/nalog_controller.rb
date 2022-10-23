# frozen_string_literal: true

class NalogController < ApplicationController
  protect_from_forgery with: :null_session

  def show
    json = JSON.parse RestClient.post('https://pb.nalog.ru/search-proc.json', "mode=search-ip&queryIp=#{params[:id]}")
    render status: :ok, json: json
  end
end
