class CreateApplicants < ActiveRecord::Migration[5.0]
  def change
    create_table :applicants do |t|
      t.string :name
      t.string :email
      t.string :token
      t.integer :score

      t.belongs_to :challenge, index:true

      t.timestamps
    end
  end
end
