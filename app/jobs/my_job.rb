class MyJob < ApplicationJob
  # 넣어줄 특정 큐 이름
  queue_as :docker_queue

  before_enqueue do |job|
    # 잡 인스턴스로 처리해야하는 작업
    @applicant = Applicant.find_by(id: job.arguments[1])

    @docker = Docker::Container.create(
        'name': "applicant_#{@applicant.id}",
        'Image': 'springs',
        'ExposedPorts': { '8080/tcp' => {} },
        'HostConfig': {'PortBindings': {'8080/tcp' => [{'HostPort': "100#{@applicant.id}"}]},
        'Binds': ["/home/jeonhyochang/asd/Web_Rails/unzip/#{@applicant.id}:/home"]
    })
    @docker.start
  end

  around_perform do |job, block|
    # 실행 전에 해야하는 작업
    block.call
    # 실행 후에 해야하는 작업
  end

  def perform(*args)
    # 나중에 실행할 작업
  end
end
