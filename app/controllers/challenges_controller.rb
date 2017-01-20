class ChallengesController < ApplicationController
  before_action :set_challenge, only: [:show, :destroy, :update, :edit]

  def index
    @challenges = Challenge.all
  end

  def new
    @challenge = Challenge.new
  end

  def create
    @challenge = Challenge.new(challenge_params)
    if @challenge.save
      redirect_to challenges_path
    else
      render 'new'
    end
  end

  def destroy
    @challenge.destroy
    redirect_to challenges_path
  end

  def show
    @applicant = Applicant.where(challenge_id: params[:id]).find_by(token: params[:token])
    if @applicant
      log_in @applicant
    else
      @applicant = Applicant.where(challenge_id: params[:id]).find_by(token: session[:token])
      render json: {error: 'Not Authorized'}, status: 401 unless @applicant
    end

  end

  def update
    respond_to do |format|

      if @challenge.update(challenge_params)
        format.html {redirect_to @challenge, notice: 'Applicant was successfully updated'}
      else
        format.html {render :edit}
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_challenge
    @challenge = Challenge.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def challenge_params
    params.require(:challenge).permit(:title, :description)
  end
end
