class UsersController < ApplicationController
  def index
    @users = User.all
   
  end

  def new
  @user = User.new
  

  end

  def create
  @user = User.new(params.require(:user).permit(:title, :start_date, :end_date,:all_day , :schedule))
  if @user.save
    flash[:notice] = "ユーザーを新規登録しました"
    redirect_to :users
  else
    render "new"
  end
  end
  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash[:error] = "ユーザーが見つかりませんでした"
      redirect_to users_path
    end
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update(params.require(:user).permit(:title,:start_date,:end_date,:all_day,:schedule))
    flash[:notice] = "あなたは「#{@user.id}」」の情報を更新しました"
    redirect_to :users
    else
      render = "edit"
    end
  end
  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "ユーザーを削除しました"
      redirect_to users_path, status: :see_other
    else
      flash[:alert] = "ユーザーの削除に失敗しました"
      redirect_to users_path
    end
  end
end  
