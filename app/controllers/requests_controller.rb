class RequestsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :update, :edit]
  before_action :set_request, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit]

  def index
    @requests = Request.all.sorted_desc
  end

  def new
    @request = current_user.requests.build
  end
  
  def create
    @requests = Request.all.sorted_desc
    @request = current_user.requests.build(request_params)
    if @request.save
      flash[:notice] = "投稿しました"
      redirect_to requests_path
    else
      render :index, collection: @requests
    end
  end

  def show
  end

  def edit
  end

  def update
    if @request.update(request_params)
      flash[:notice] = "編集しました"
      redirect_to request_path
   else
     render :edit
   end
  end

  def destroy
    @request.destroy
    flash[:notice] = "削除しました"
    redirect_to requests_path
  end
end

private

  def request_params
    params.require(:request).permit(:title, :content, :area)
  end

  def set_request
    @request = Request.find(params[:id])
  end

  def correct_user
    set_request
    if current_user.id != @request.user.id
      flash[:notice] = "アクセス権限がありません"
      redirect_to root_path
    end
  end