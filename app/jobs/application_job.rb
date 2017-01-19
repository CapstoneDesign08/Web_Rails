class ApplicationJob < ActiveJob::Base
  def test_docker
    @docker = Docker::Container.create(
        'name': "applicant_#{@applicant.id}_test",
        'Image': 'cs2012/springs',
        'Tty': true,
        'Interactive': true,
        'ExposedPorts': { '8080/tcp' => {} },
        'HostConfig': {'PortBindings': {'8080/tcp' => [{'HostPort': "100#{@applicant.id}"}]},
        'Binds': ["/home/jeonhyochang/Web_Rails/unzip/#{@applicant.id}:/home"]
    })

    @docker.start
    #@command = ['bash', '-c', 'gradle clean']
    #@docker.exec(@command, detach: true)
    @command = ['bash', '-c', 'gradle test']

  end

  def run_docker
    @docker = Docker::Container.create(
        'name': "applicant_#{@applicant.id}_run",
        'Image': 'cs2012/springs',
        'Tty': true,
        'Interactive': true,
        'ExposedPorts': { '8080/tcp' => {} },
        'HostConfig': {'PortBindings': {'8080/tcp' => [{'HostPort': "110#{@applicant.id}"}]},
        'Binds': ["/home/jeonhyochang/Web_Rails/unzip/#{@applicant.id}:/home"]
    })

    @docker.start
    @command = ['bash', '-c', 'gradle run']
    @docker.exec(@command, detach: true)

    #slepp 30 초 떄문에 30초 뒤에 접근 이 문제만 해결하면 될듯
    #sleep 30
    # if @docker
    # @docker.delete(force: true)
    #end
  end

  def delete_docker
    if @docker
      @docker.delete(force: true)
    end
  end

end
