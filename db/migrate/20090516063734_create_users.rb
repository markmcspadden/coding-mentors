class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.text :master_skills
      t.text :intermediate_skills
      t.text :newbie_skills
      t.string :remote_availability
      t.string :local_availability
      t.boolean :available_to_mentor
      t.boolean :available_to_be_mentored

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
