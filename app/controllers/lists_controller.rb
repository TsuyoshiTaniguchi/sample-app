class ListsController < ApplicationController
  def new
    # memo Viewへ渡すためのインスタンス変数も空のModelオブジェクトを生成する。
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      flash[:notice] = "投稿に成功しました"
      redirect_to list_path(@list.id)
    else
      flash.now[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    list = List.find(params[:id])
    list.update(list_params)
    redirect_to list_path(list.id)
  end

  def destroy
    list = List.find(params[:id]) # memoデータ (レコード) を1件取得
    list.destroy # memoデータ (レコード) を削除
    redirect_to '/lists' # memo投稿一覧画面へリダイレクト
  end


  private

  def list_params
    params.require(:list).permit(:title, :body, :image)
  end
end
