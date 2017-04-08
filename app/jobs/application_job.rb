class ApplicationJob < ActiveJob::Base

  # unzip폴더의 경로를 입력하세요
  @project_unzip_path = "/home/user/RubymineProjects/Web_Rails"

  def test_docker
    @docker = Docker::Container.create(
        'name': "applicant_#{@applicant.id}_test",
        'Image': 'dennischa50/springs',
        'Tty': true,
        'Interactive': true,
        'ExposedPorts': { '8080/tcp' => {} },
        'HostConfig': {'PortBindings': {'8080/tcp' => [{'HostPort': "100#{@applicant.id}"}]},
        'Binds': ["#{@project_unzip_path}/unzip/#{@applicant.id}/:/home"]
    })

    @docker.start
    @command = ['bash', '-c', 'gradle clean']
    @docker.exec(@command)

  end

  def run_docker
    @docker = Docker::Container.create(
        'name': "applicant_#{@applicant.id}_run",
        'Image': 'feed/dennischa50/springs',
        'Tty': true,
        'Interactive': true,
        'ExposedPorts': { '8080/tcp' => {} },
        'HostConfig': {'PortBindings': {'8080/tcp' => [{'HostPort': "110#{@applicant.id}"}]},
        'Binds': ["#{@project_unzip_path}/unzip/#{@applicant.id}:/home"]
    })

    @docker.start
    @command = ['bash', '-c', 'gradle run']
    @docker.exec(@command, detach: true)
  end

  def delete_docker
    if @docker
      @docker.delete(force: true)
    end
  end

end
