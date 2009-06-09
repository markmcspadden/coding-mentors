class CreateMentorshipSkills < ActiveRecord::Migration
  def self.up
    create_table :mentorship_skills do |t|
      t.integer :mentorship_id
      t.integer :skill_id

      t.timestamps
    end
  end

  def self.down
    drop_table :mentorship_skills
  end
end
