class CupsController < ApplicationController
  def show
  end

  def clear_all
    current_user.cup.emotions.destroy_all
    redirect_to cup_path, notice: "Cleared Cup"
  end

end
