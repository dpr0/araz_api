# frozen_string_literal: true

class Api::EgrulController < ApplicationController
  protect_from_forgery with: :null_session
  URL = 'https://egrul.nalog.ru/'.freeze

  api :GET, '/egrul/:inn', "Проверка ЕГРЮЛ (#{URL}index.html)"
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
    RestClient.post(URL, "vyp3CaptchaToken=&page=&query=#{params[:id]}&region=&PreventChromeAutocomplete=")
  end

  def inn_request(token)
    RestClient.get("#{URL}search-result/#{token}")
  end

  def transform(row)
    puts row
    {
      start_at: row['r'],
      end_at: row['e'],
      pdf: "#{URL}vyp-download/#{row['t']}",
      pg: row['pg'],
      tot: row['tot'],
      cnt: row['cnt'],
      address: row['a'],
      short_name: row['c'],
      full_name: row['n'],
      gendir: row['g'],
      form: row['k'],
      kpp: row['p'],
      ogrn: row['o']
    }
  end
end
