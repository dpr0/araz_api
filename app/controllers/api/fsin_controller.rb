# frozen_string_literal: true

class Api::FsinController < ApplicationController
  protect_from_forgery with: :null_session

  api :GET, '/fsin/:id', 'id is a inn'
  def show
    render status: :ok, json: FsinService.new(params[:id]).call
  end
end
