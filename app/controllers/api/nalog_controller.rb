# frozen_string_literal: true

class Api::NalogController < ApplicationController
  protect_from_forgery with: :null_session

  api :GET, '/nalog/:inn', 'Проверка ФЛ на дисквалификацию, ограничение и ИП (https://pb.nalog.ru/search-proc.json)'
  def show
    resp = begin
             load
           rescue Errno::ECONNRESET => e
             load
           end
    json = JSON.parse(resp)
    data = prepare(json['ip']['data'])

    render status: :ok, json: data
  end

  private

  def load
    RestClient.post('https://pb.nalog.ru/search-proc.json', "mode=search-ip&queryIp=#{params[:id]}")
  end

  def prepare(data)
    { success: 0, ip: data.map { |d| mapping(d) }, error: '' }
  end

  def mapping(data)
    {
      ogrn:       data['ogrn'],
      okved:      data['okved2'],
      okved_name: data['okved2name'],
      name:       data['namec']
    }
  end
end
