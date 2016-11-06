class UsersController < ApplicationController
  def index
    current_user
  end

  def new
    @user = User.new
  end

  # def create
  # end
  #
  # def edit
  # end
  #
  # def update
  # end
  #
  # def destroy
  # end
end
