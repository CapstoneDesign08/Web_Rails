class ApplicationJob < ActiveJob::Base
  def test_docker
    delete_docker
    @docker = Docker::Container.create(
        'name': "applicant_#{@applicant.id}_test",
        'Image': 'cs2012/springs',
        'Tty': true,
        'Interactive': true,
        'ExposedPorts': { '8080/tcp' => {} },
        'HostConfig': {'PortBindings': {'8080/tcp' => [{'HostPort': "100#{@applicant.id}"}]},
        'Binds': ["/home/user/RubyonRails/Web_Rails/unzip/#{@applicant.id}:/home"]
    })
    @docker.start
    @command = ['bash', '-c', 'gradle clean']
    @docker.exec(@command)
    @command = ['bash', '-c', 'gradle test']
  end

  def run_docker
    delete_docker
    @docker = Docker::Container.create(
        'name': "applicant_#{@applicant.id}_run",
        'Image': 'cs2012/springs',
        'Tty': true,
        'Interactive': true,
        'ExposedPorts': { '8080/tcp' => {} },
        'HostConfig': {'PortBindings': {'8080/tcp' => [{'HostPort': "110#{@applicant.id}"}]},
        'Binds': ["/home/user/RubyonRails/Web_Rails/unzip/#{@applicant.id}:/home"]
    })
    @docker.start
    @command = ['bash', '-c', 'gradle run']
    @docker.exec(@command, detach: true)
  end

  def delete_docker
    if @docker
      @docker.delete(force: true)
      @docker = nil
    end
  end

end
