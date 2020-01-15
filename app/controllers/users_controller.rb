class UsersController < ApplicationController
  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def index
    # inputの中身が空だったら処理を終了する
    return nil if params[:keyword] == ""
    # 入力された値を含むかつ、ログインしているユーザのidは除外する、これはjbuilderに渡す変数
    @users = User.where(['name LIKE ?', "%#{params[:keyword]}%"] ).where.not(id: current_user.id).limit(10)
    respond_to do |format|
      format.html
      format.json
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
