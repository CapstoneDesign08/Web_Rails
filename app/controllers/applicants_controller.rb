class ApplicantsController < ApplicationController
  before_action :set_applicant, only: [:show, :edit, :update, :destroy]
  before_action :set_docker, only: [:update, :show]

  def index
    @applicants = Applicant.all
  end

  def show
    begin
      @docker.start
      @command = ['bash', '-c', 'gradle clean']
      @docker.exec(@command,detach: true)
      @command = ['bash', '-c', 'gradle run']
      puts @docker.exec(@command, detach: true)
    rescue
      puts  "Docker Run Fail"
    end
  end

  def new
    @challenges = Challenge.all
    @applicant = Applicant.new
  end

  def edit
    @challenges = Challenge.all

  end

  def create
    @challenges = Challenge.all

    @applicant = Applicant.new(applicant_params)
    respond_to do |format|
      if @applicant.save
        format.html { redirect_to @applicant, notice: 'Applicant was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @applicant.update(applicant_params)
        format.html {redirect_to @applicant.challenge, notice: 'Applicant was successfully updated'}
        if @applicant.attachment
          output = system("unzip -o ./public/#{@applicant.attachment} -d ./unzip/#{@applicant.id} ")
          puts  "output is #{output}"
          output = system("sudo rm -r ./unzip/#{@applicant.id}/src/test")
          puts  "output is #{output}"
          output = system("sudo cp -r ./tmp/test ./unzip/#{@applicant.id}/src")
          puts "output is #{output}"
          output = system("sudo rm -f ./public/#{@applicant.attachment}")
          puts "output is #{output}"
          output = system("cd ./unzip/#{@applicant.id} && zip -r ../../public#{@applicant.attachment} ./*")
          puts "output is #{output}"

          if @docker
            @docker.delete(:force => true)
          end
          @docker = Docker::Container.create(
              'name': "applicant_#{@applicant.id}",
              'Image': 'cs2012/springs',
              'Tty': true,
              'Interactive': true,
              'ExposedPorts': { '8080/tcp' => {} },
              'HostConfig': {'PortBindings': {'8080/tcp' => [{'HostPort': "100#{@applicant.id}"}]},
              'Binds': ["/home/user/Web_Rails/unzip/#{@applicant.id}:/home"]
          })
          MyJob.perform_later @applicant.id
        end
      else
        format.html {render :edit}
      end
    end
    @applicant.update(applicant_params)
  end

  def destroy
      @applicant.destroy
    respond_to do |format|
      format.html {redirect_to applicants_url, notice: 'Applicant was successfully destroyed. ' }
    end
  end

  def page

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_applicant
    @applicant = Applicant.find(params[:id])
  end

  def set_docker
    begin
    @docker = Docker::Container.get("applicant_#{@applicant.id}")
    rescue
      @docker = nil
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def applicant_params
    params.require(:applicant).permit(:name, :email, :score, :token, :challenge_id, :attachment, :id)
  end
end

