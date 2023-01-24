# frozen_string_literal: true

class Api::ArbitrController < ApplicationController
  protect_from_forgery with: :null_session

  api :GET, '/arbitr/:inn', 'Поиск решений арбитражного суда - json: { link: , num: , judge: , title: , name: , dt: } (https://kad.arbitr.ru/Kad/SearchInstances)'
  def show
    wasm = params[:wasm] || 'a025bec59465aa18d109e7b218021f4e'
    pr_fp = params[:pr_fp] || '93507f585f80bf8f7b97ed641610e3e1373fc3a0a9c6b51abdea108294991545'
    render status: :ok, json: ArbitrService.new(params[:id], wasm, pr_fp).call
  end
end
