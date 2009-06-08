class CreateUserSkills < ActiveRecord::Migration
  def self.up
    create_table :user_skills do |t|
      t.integer :user_id
      t.integer :skill_id
      t.integer :level

      t.timestamps
    end
  end

  def self.down
    drop_table :user_skills
  end
end
