class MyJob < ApplicationJob
  # 넣어줄 특정 큐 이름
  queue_as :docker_queue

  before_enqueue do |job|
    # 잡 인스턴스로 처리해야하는 작업
    app_id = Applicant.all.find_by(id: job.arguments)

    @docker = Docker::Container.create(
        'name': "applicant_#{app_id.id}",
        'Image': 'springs',
        'ExposedPorts': { '8080/tcp' => {} },
        'HostConfig': {'PortBindings': {'8080/tcp' => [{'HostPort': "100#{app_id.id}"}]},
        'Binds': ["/home/jeonhyochang/asd/Web_Rails/unzip/#{app_id.id}:/home"]
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
