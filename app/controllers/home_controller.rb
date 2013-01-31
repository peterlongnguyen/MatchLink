class HomeController < ApplicationController
  def index
  end

  def index
    @users = User.all
  end
end
