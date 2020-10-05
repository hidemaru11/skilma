class RequestsController < ApplicationController
  before_action :set_request, only: [:show]

  def index
    @requests = Request.all.sorted_desc
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
end

private

  def request_params
    params.require(:request).permit(:title, :content, :area)
  end

  def set_request
    @request = Request.find(params[:id])
  end