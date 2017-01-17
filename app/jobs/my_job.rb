class MyJob < ApplicationJob
  # 넣어줄 특정 큐 이름
  queue_as :docker_queue

  around_enqueue do |job, block|
    # 실행 전에 해야하는 작업
    block.call
    # 실행 후에 해야하는 작업
    @docker.stop
  end

  def perform(*id)
    # 실행할 작업
    @applicant = Applicant.find_by(id: id)
    @docker = get_docker @applicant.id

    begin
      @docker.start

      @command = ['bash', '-c', 'gradle clean']
      @docker.exec(@command, detach: true)
      @command = ['bash', '-c', 'gradle test']

      @log =  @docker.exec(@command).to_s
      @i = @log.index('completed')

      @applicant.log = "PASSED : #{@log[@i-8]} / FAILED  :  #{@log[@i + 11]}"
      @applicant.save

    rescue
      if @docker
        @docker.delete(force: true)
      end
        puts "applicant_#{@applicant.id} docker run failed"
    end
  end

  def get_docker(id)
    begin
      return Docker::Container.get("applicant_#{id}")
    rescue
      return nil
    end
  end

end
