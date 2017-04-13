# encoding: euc-kr
class TestJob < ApplicationJob
  # 넣어줄 특정 큐 이름
  queue_as :test_queue

  def perform(*id)
    # 실행할 작업
    @applicant = Applicant.find_by(id: id)
    @applicant.log = nil
    @applicant.score = 0
    @applicant.save
    @docker = get_docker @applicant.id

      begin
      delete_docker
      test_docker
      @command = ['bash', '-c', 'gradle test']
      @print = @docker.exec(@command)
      #puts @print
      puts "---------------------------------------"


      @answer = "answer : "
      for i in 0..1
          @print[i].each do |tmp|
            @answer.concat(tmp)
          end
      end

    puts @answer


      #puts @print.to_s.encode("UTF-8", "EUC-KR")

      @numberOfPassed = @answer.scan("PASSED").size
      @arrFailMessages = @answer.scan(/\$[^#]+#/)

      if @arrFailMessages.size > 1
        @failMessage = "FAIL LOG : \n"
        @arrFailMessages.each do |tmp|
        @failMessage = @failMessage.concat(tmp)
        end
      else
        @failMessage = "SUCCESS"
      end


      @applicant.log = @failMessage
      @applicant.score = (@numberOfPassed * 5) + 5
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
