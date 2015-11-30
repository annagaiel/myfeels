class EmotionsController < ApplicationController

  def index
    @emotion = Emotion.new
    @emotions = current_user.cup.emotions
  end

  def create
    @emotion = current_user.cup.emotions.create(emotions_params)

    if @emotion.valid?
      redirect_to emotions_path, notice: "Saved emotion"
    else
      @emotions = current_user.cup.emotions
      render :index, :status => :unprocessable_entity
    end
  end

  def bulk_delete
    #Emotion.delete(params[:emotion_ids])
    params[:emotion_ids].each do |id|
      current_user.cup.emotions.delete(Emotion.find(id))
    end

    redirect_to emotions_path, notice: params[:emotion_ids].nil? ? "Please select" : "Deleted emotions"
  end

  private

  def emotions_params
    params.require(:emotion).permit(:name, :is_positive)
  end
end
