class Api::WebhookController < ApplicationController

  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def create
    p params
    render :json => {status: 'ok'}, status: :ok
  end
end
