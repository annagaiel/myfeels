class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:edit, :update, :destroy]

  def edit
    set_comment
    allowed_user
  end

  def create
    @comment = current_user.comments.create(comment_params)

    if @comment.valid?
      redirect_to phrase_path(@comment.phrase), notice: "Saved comment"
    end
  end

  def update
    allowed_user

    @comment.update_attributes(comment_params)

    if @comment.valid?
      redirect_to phrase_path(@comment.phrase), notice: "Updated comment"
    else
      render :edit, :status => :unprocessable_entity
    end
  end

  def destroy
    set_comment
    allowed_user

    @comment.destroy
    redirect_to phrase_path(@comment.phrase), notice: "Deleted comment"
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :phrase_id)
  end

  def allowed_user
    if @comment.user != current_user
      return render :text => 'Not Allowed', :status => :forbidden
    end
  end
end
