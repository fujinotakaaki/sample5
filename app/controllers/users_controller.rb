class UsersController < ApplicationController
  def edit
  end

  def index
  end

  def new
    @user = User.new
    # debugger # 標準で実装されているbyebug gemがそうらしい(7.1.3参照)
  end

  def create
    # @user = User.new(params[:user])
    # このような[new/update_attributes]のようなマスアサインメント系のメゾットでは
    # 無条件に全てのフィールドを上書きしてしまう為、
    # 悪意のあるユーザが自身に管理者権限を付与するなどシステムを自由に操作できてしまう危険性があった
    @user = User.new(user_params)
    if @user.save then
       flash[:success] = "Welcome to the Sample App!"
      # redirect_to user_path(@user)
      # redirect_to @user
      # これはredirect_to @userというコードから (Railsエンジニアが)
      # user_url(@user)といったコードを実行したいということを、
      # Railsが推察してくれた結果になります。（困惑）

      # 以下と挙動が一緒っぽい
      # 1.
      redirect_to user_url(@user)
      # 2.
      # redirect_to "/users/#{@user.id}"# 条件付き(後述)
      # config/routes.rb で resources を使用している場合だけ…っぽい。
      # resources を使用せずに1つ1つ指定していて、user_urlがないならできない。
      # 3.
      # redirect_to user_url(id: @user.to_param)
      # ↑Modelオブジェクトのto_paramメソッドは基本idを返す(オーバーライドしてid以外を返すのもよくあるらしい)
      # 4.
      # redirect_to user_url(id: @user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    # debugger # 標準で実装されているbyebug gemがそうらしい(7.1.3参照)
    # アプリケーション内のエラーを追跡したりデバッグするときに非常に強力なツール
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
