# frozen_string_literal: true

class Api::DebtorsController < ApplicationController
  protect_from_forgery with: :null_session

  api :GET, '/debtors/:inn', 'Поиск задолженностей - csv'
  def show
    send_data(DebtorsService.new(params[:id]).call, filename: 'response.csv', type: 'text/csv')
  end
end
