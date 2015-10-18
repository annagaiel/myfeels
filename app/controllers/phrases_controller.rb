class PhrasesController < ApplicationController
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
      redirect_to phrases_path
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
    @phrase = Phrase.find(params[:id])

    if @phrase.user != current_user
      return render :text => 'Not Allowed', :status => :forbidden
    end
  end

  def update
    @phrase = Phrase.find(params[:id])

    if @phrase.user != current_user
      return render :text => 'Not Allowed', :status => :forbidden
    end

    @phrase.update_attributes(phrase_params)

    if @phrase.valid?
      redirect_to phrase_path(@phrase)
    else
      render :new, :status => :unprocessable_entity
    end
  end

  def delete
    @phrase = Phrase.find(params[:id])

    if @phrase.user != current_user
      return render :text => 'Not Allowed', :status => :forbidden
    end

    @phrase.destroy
    redirect_to phrase_path
  end

  private

  def phrase_params
    params.require(:phrase).permit(:phrase, :author, :background, :foreground, :font)
  end
end
