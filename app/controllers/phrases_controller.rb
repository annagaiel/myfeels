class PhrasesController < ApplicationController
  before_action :set_phrase, only: [:edit, :update, :delete]
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
  end


  def edit
    if @phrase.user != current_user
      return render :text => 'Not Allowed', :status => :forbidden
    end
  end

  def update
    if @phrase.user != current_user
      return render :text => 'Not Allowed', :status => :forbidden
    end

    @phrase.update_attributes(phrase_params)

    if @phrase.valid?
      redirect_to phrase_path(@phrase), notice: "Updated..."
    else
      render :edit, :status => :unprocessable_entity
    end
  end

  def delete
    if @phrase.user != current_user
      return render :text => 'Not Allowed', :status => :forbidden
    end

    @phrase.destroy
    redirect_to phrase_path
  end

  private

  def set_phrase
      @phrase = Phrase.find(params[:id])
  end

  def phrase_params
    params.require(:phrase).permit(:phrase, :author, :background, :foreground, :font)
  end
end
