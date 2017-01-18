class RunJob < ApplicationJob
  # 넣어줄 특정 큐 이름
  queue_as :run_queue

  around_enqueue do |job, block|
    # 실행 전에 해야하는 작업
    block.call
    # 실행 후에 해야하는 작업
  end

  def perform(*id)
    # 실행할 작업
    @applicant = Applicant.find_by(id: id)
    @docker = get_docker @applicant.id

    begin
      if @docker
        @docker.delete(:force => true)
      end
      @docker = Docker::Container.create(
          'name': "applicant_#{@applicant.id}_run",
          'Image': 'cs2012/springs',
          'Tty': true,
          'Interactive': true,
          'ExposedPorts': { '8080/tcp' => {} },
          'HostConfig': {'PortBindings': {'8080/tcp' => [{'HostPort': "110#{@applicant.id}"}]},
                         'Binds': ["/home/user/RubymineProjects/Web_Rails/unzip/#{@applicant.id}:/home"]
          })

      @docker.start
      @command = ['bash', '-c', 'gradle run']
      @docker.exec(@command, detach: true)

      #slepp 30 초 떄문에 30초 뒤에 접근 이 문제만 해결하면 될듯
      #sleep 30
     # if @docker
      # @docker.delete(force: true)
      #end
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
