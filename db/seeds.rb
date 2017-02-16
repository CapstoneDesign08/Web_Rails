# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

challenge01 = Challenge.create(:title => 'Feed Test',
                      :goal => 'Spring을 활용한 다양한 기능 완성하기',
                      :information => '회원가입기능
  - /join주소에서 Join.html페이지를 띄운다.
  - 가입하기 버튼구현 (/login  --> /join 주소이동)
  - Join페이지에서 아이디와 패스워드를 입력하면 DB에 아이디와 패스워드가 입력이 되도록 구현( /join  -->  /login )
  - 중복된 아이디가 있는지 체크 만약 이미 존재하면 에러페이지를 띄우도록 한다.(ErrorPage.html)


로그인기능
  - /login 주소에서 Login.html페이지를 띄운다.
  - DB에 존재하는 아이디와 그에 해당하는 패스워드 입력시 해당 아이디의 상태가 로그인으로 변경( /login -->  /feed )
  - DB에 존재하지 않는 아이디 입력시 에러페이지를 띄우도록 한다.(ErrorPage.html)
  - 입력한 해당 아이디가 이미 로그인중인 상태라면 에러페이지를 띄우도록 한다.(ErrorPage.html)


게시물등록기능
  - /feed주소에서 Feed.html페이지를 띄운다.
  - "/feed"주소로 가게되면 해당아이디의 정보와 다른사용자들의 게시물들이 제대로 보여지도록 구현
  - 자신이 작성한 게시물수 , 팔로우수, 팔로워수가 반영되여 보여짐
  - 로그아웃을 하게되면 제대로 상태가 바뀌도록 구현한다. ("/feed" --> "/login")
  - 아이디를 클릭시 해당아이디의 페이지로 넘어가도록 한다. ("/feed" --> "/{userId}")


개인페이지기능
  - 홈으로 버튼 구현 ("/{userId}"  --> "/feed")
  - 로그인한 아이디의 개인페이지일 경우 로그아웃을 하게되면 상태가 바뀌도록 구현한다. ("/{userId}" --> "/login")
  - 개인페이지로 넘어갔을때 로그인한 아이디의 개인페이지이면 "MyPage.html"을 띄우고 다른 사용자의 개인페이지이면 "PersonalPage.html"을 띄운다.
  - 로그인한 아이디의 개인페이지에는 자신이 작성한 게시물과 자신이 팔로우한 사용자가 작성한 게시물들을 보여준다.
  - 다른 사용자의 개인페이지는 그 사용자가 작성한 게시물들만 보여준다.


팔로우기능
  - 다른 사용자의 개인페이지에 들어가 팔로우등록과 팔로우취소를 할수있도록 하고 DB에 등록되도록 만든다.',
                      :description => 'Tip
  - mysql workbench에 "feed"라는 스키마를 생성하고 "src/main/java/com.feed/application.properties"에서 spring.datasource.password에 본인의 mysql password를 입력하시오.')
challenge02 = Challenge.create(:title => 'test02',
                     :description => '테스트02')
challenge01.save
challenge02.save

user01 = Applicant.create(:name => 'Cha',
                      :email => 'aaa@gmail.com',
                      :challenge => challenge01)
user02 = Applicant.create(:name => 'Jeon',
                          :email => 'bbb@gmail.com',
                          :challenge => challenge02)
user03 = Applicant.create(:name => 'Hong01',
                          :email => 'ccc@gmail.com',
                          :challenge => challenge01)
user04 = Applicant.create(:name => 'Jung',
                          :email => 'ddd@gmail.com',
                          :challenge => challenge02)
user05 = Applicant.create(:name => 'Hong02',
                          :email => 'eee@gmail.com',
                          :challenge => challenge01)
user01.save
user02.save
user03.save
user04.save
user05.save