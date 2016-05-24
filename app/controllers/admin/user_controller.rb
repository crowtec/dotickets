class Admin::UserController < AdminController
  before_action :authenticate_user!, only: [:password_edit, :password_update]
  layout 'admin'

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save!
    redirect_to admin_user_index_path, :notice => 'User was successfully created.'
  rescue
    render :new
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_user_index_path, :notice => 'User was successfully updated.'
  rescue
    render :edit
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_user_index_path, :notice => 'User was successfully destroyed.'
  end
  
  def password_edit
  end

  def password_update
    current_user.update(password_params)
    redirect_to admin_index_path, :notice => 'Password was successfully updated.'
  end

  private
  def user_params
    params.require(:user).permit(User.permitted_params)
  end
  def password_params
    params.require(:user).permit(User.password_params)
  end

end
