class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    comment_params = params.require(:new_comment).permit(:text, :post_id)
    comment = Comment.new(comment_params)
    comment.author = current_user
    comment.post = Post.find(comment_params[:post_id])
    respond_to do |format|
      format.html do
        if comment.save
          flash.now[:notice] = 'Comment created successfully'
          redirect_to user_post_path(comment.post.author_id, comment.post.id)
        else
          flash.now[:alert] = 'Comment creation failed'
          redirect_to user_post_path(params[:user_id], params[:id])
        end
      end
    end
  end
  
  def destroy
    comment = Comment.find(params[:id])
    respond_to do |format|
      if comment.destroy
        # Successfully deleted the record
        flash[:success] = 'Comment deleted successfully'
      else
        # Failed to delete the record
        flash.now[:error] = 'Error: Comment could not be deleted'
      end
      format.html { redirect_to "/users/#{current_user.id}/posts/#{params[:post_id]}" }
    end
  end
end
