class CommentsController < ApplicationController
  before_action :require_login
  
  def create
    @memo = Memo.find(params[:memo_id])
    if @memo
      comment = Comment.new(comment_params)
      comment.memo_id = params[:memo_id]
      comment.user_id = current_user.id
      if comment.save
        redirect_to @memo
        return
      end
    end
    redirect_to root_path, alert: "Failed to add comment"
  end
  
  private
    def comment_params
      params.require(:comment).permit(:comment)
    end
  
end