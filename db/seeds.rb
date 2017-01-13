# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

challenge01 = Challenge.create(:title => 'test01',
                      :description => '테스트01')
challenge02 = Challenge.create(:title => 'test02',
                     :description => '테스트02')
challenge03 = Challenge.create(:title => 'test03',
                     :description => '테스트03')
challenge01.save
challenge02.save
challenge03.save

user01 = Applicant.create(:name => 'Cha',
                      :email => 'aaa@gmail.com',
                      :challenge => challenge01)
user02 = Applicant.create(:name => 'Jeon',
                          :email => 'bbb@gmail.com',
                          :challenge => challenge02)
user03 = Applicant.create(:name => 'Hong01',
                          :email => 'ccc@gmail.com',
                          :challenge => challenge03)
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