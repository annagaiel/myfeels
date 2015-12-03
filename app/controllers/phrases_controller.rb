class PhrasesController < ApplicationController
  before_action :set_phrase, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]

  def index
    @phrases = Phrase.all
  end

  def new
    @phrase = Phrase.new
  end

  def create
    @phrase = current_user.phrases.create(phrase_params)

    if @phrase.valid?
      redirect_to phrases_path, notice: "Saved..."
    else
      render :new, :status => :unprocessable_entity
    end
  end

  def show
    @phrase = Phrase.where(:id => params[:id]).first
    if @phrase.blank?
      render :text => "Phrase is Not Found", :status => :not_found
    end
    @comment = Comment.new
  end


  def edit
    set_phrase
    allowed_user
  end

  def update
    allowed_user

    @phrase.update_attributes(phrase_params)

    if @phrase.valid?
      redirect_to phrase_path(@phrase), notice: "Updated..."
    else
      render :edit, :status => :unprocessable_entity
    end
  end

  def destroy
    set_phrase
    allowed_user

    @phrase.destroy
    redirect_to phrase_path, notice: "Deleted ..."
  end

  private

  def set_phrase
      @phrase = Phrase.find(params[:id])
  end

  def phrase_params
    params.require(:phrase).permit(:phrase, :author, :background, :foreground, :font)
  end

  def allowed_user
    if @phrase.user != current_user
      return render :text => 'Not Allowed', :status => :forbidden
    end
  end
end
