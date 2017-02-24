class MemosController < ApplicationController
  before_action :set_memo, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:new, :create, :destroy]
  before_action only: [:edit, :update, :destroy] do
    require_user(@memo.user_id)
  end

  # GET /memos
  # GET /memos.json
  def index
    @memos = Memo.all
  end

  # GET /memos/1
  # GET /memos/1.json
  def show
    @comment = Comment.new
    @comments = Comment.where(memo_id: params[:id]).order("created_at DESC")
  end

  # GET /memos/new
  def new
    @memo = Memo.new
  end

  # GET /memos/1/edit
  def edit
  end

  # POST /memos
  # POST /memos.json
  def create
    @memo = Memo.new(memo_params)
    respond_to do |format|
      if session[:user_id]
        @memo.user_id = session[:user_id]
        if @memo.save
          format.html { redirect_to @memo, notice: 'Memo was successfully created.' }
          format.json { render :show, status: :created, location: @memo }
        else
          format.html { render :new }
          format.json { render json: @memo.errors, status: :unprocessable_entity }
        end
      else
        format.html { render new_memo_path } #redirect_toにしないとalertが出てくれない
        format.json { render json: [], status: :unauthorized }
      end
    end
  end

  # PATCH/PUT /memos/1
  # PATCH/PUT /memos/1.json
  def update
    respond_to do |format|
      if @memo.update(memo_params)
        format.html { redirect_to @memo, notice: 'Memo was successfully updated.' }
        format.json { render :show, status: :ok, location: @memo }
      else
        format.html { render :edit }
        format.json { render json: @memo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memos/1
  # DELETE /memos/1.json
  def destroy
    @memo.destroy
    respond_to do |format|
      format.html { redirect_to memos_url, notice: 'Memo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_memo
      @memo = Memo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def memo_params
      params.require(:memo).permit(:title, :body)
    end
end
