class SessionsController < ApplicationController

  def new #login page route
    @user = User.new
    render :new
  end


  def create
    if user = User.find_by(user_params[:name])
      sessions[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      redirect_to new_session_path
    end

  end

  def destroy
    session.clear
  end


  private

  def user_params
    params.require(:user).permit(:name)
  end


end
