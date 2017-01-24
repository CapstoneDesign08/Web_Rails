class TestJob < ApplicationJob
  include ActiveJob::TrafficControl::Throttle

  throttle threshold: 1, period: 10.second, drop: false
  # 넣어줄 특정 큐 이름
  queue_as :test_queue

  def perform(*id)
    # 실행할 작업
    @applicant = Applicant.find_by(id: id)
    @applicant.log = nil
    @applicant.save
    @docker = get_docker @applicant.id

    begin
      delete_docker
      test_docker
      @command = ['bash', '-c', 'gradle test']
      @print = @docker.exec(@command)
      @log =  @print.to_s
      # puts @print

      @test_pass = @log.scan("PASSED")
      @test_total = @log.scan("com.")
      @applicant.log = "PASSED : #{@test_pass.size} / FAILED  :  #{@test_total.size - @test_pass.size}"
      @applicant.save

      # delete
      delete_docker

    rescue
     delete_docker
     puts "applicant_#{@applicant.id} docker run failed"
    end
  end

  def get_docker(id)
    begin
      return Docker::Container.get("applicant_#{id}_test")
    rescue
      return nil
    end
  end

end
