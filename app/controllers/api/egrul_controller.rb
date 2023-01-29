# frozen_string_literal: true

class Api::EgrulController < ApplicationController
  protect_from_forgery with: :null_session

  api :GET, '/egrul/:inn', 'Проверка ЕГРЮЛ (https://egrul.nalog.ru/index.html)'
  def show
    @errors = []
    token = begin
              token_request
            rescue Errno::ECONNRESET => e
              token_request
            end

    data = JSON.parse(token)
    resp = begin
             inn_request(data['t'])
           rescue Errno::ECONNRESET => e
             inn_request(data['t'])
           end


    render status: :ok, json: JSON.parse(resp)['rows'].map { |row| transform(row) }
  end

  private

  def token_request
    RestClient.post('https://egrul.nalog.ru/', "vyp3CaptchaToken=&page=&query=#{params[:id]}&region=&PreventChromeAutocomplete=")
  end

  def inn_request(token)
    RestClient.get("https://egrul.nalog.ru/search-result/#{token}")
  end

  def transform(row)
    {
      start_at: row['r'],
      end_at: row['e'],
      pg: row['pg'],
      tot: row['tot'],
      cnt: row['cnt'],
      form: row['k'],
      name: row['n'],
      ogrn: row['o']
    }
  end
end
