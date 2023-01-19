# frozen_string_literal: true

class Api::InnController < ApplicationController
  protect_from_forgery with: :null_session

  api :GET, '/inn/:inn', 'Проверка ФЛ на долги - json: {"error": 0, "finesList": [], "count": null, "inGarage": 0}'
  def show
    json = JSON.parse RestClient.get("https://gosnalogi.ru/ajax/taxes_inn?inn=#{params[:id]}")
    render status: :ok, json: json
  end
end
