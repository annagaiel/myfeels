class EmotionsController < ApplicationController

  def index
    @emotion = Emotion.new
    @emotions = current_user.cup.emotions
  end

  def create
    @emotion = current_user.cup.emotions.create(emotions_params)

    if @emotion.valid?
      redirect_to cup_path, noticed: "Saved emotion"
    else
      @emotions = current_user.cup.emotions
      render :index, :status => :unprocessable_entity
    end
  end

  private

  def emotions_params
    params.require(:emotion).permit(:name, :is_positive)
  end
end
