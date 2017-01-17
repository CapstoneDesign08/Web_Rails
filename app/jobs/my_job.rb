class MyJob < ApplicationJob
  # 넣어줄 특정 큐 이름
  queue_as :docker_queue
=begin
  before_enqueue do |job|
    # 잡 인스턴스로 처리해야하는 작업
  end
=end

  around_enqueue do |job, block|
    # 실행 전에 해야하는 작업
    block.call
    # 실행 후에 해야하는 작업
  end

  def perform(*id)
    # 나중에 실행할 작업
    set_docker(id)
    @applicant = Applicant.all.find_by(id: id)
    @command = ['bash', '-c', 'gradle clean']
    begin
      @docker.exec(@command)
      @command = ['bash', '-c', 'gradle test']
      @applicant.log = @docker.exec(@command)
    rescue
      @applicant.log = 'Fail'
    end

  end


  def set_docker(*id)
    begin
      @docker = Docker::Container.get("applicant_#{id}")
    rescue
      @docker = nil
    end
  end
end
