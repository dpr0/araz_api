# frozen_string_literal: true

class Api::InnController < ApplicationController
  protect_from_forgery with: :null_session

  api :GET, '/inn/:id', 'id is a inn'
  def show
    json = JSON.parse RestClient.get("https://gosnalogi.ru/ajax/taxes_inn?inn=#{params[:id]}")
    render status: :ok, json: json
  end
end
