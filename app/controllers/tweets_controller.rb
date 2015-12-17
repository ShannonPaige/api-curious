class TweetsController < ApplicationController
  def create
    raise :test
    redirect_to root_path
  end
end
