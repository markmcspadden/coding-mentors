class CreateMentorships < ActiveRecord::Migration
  def self.up
    create_table :mentorships do |t|
      t.integer :mentee_id
      t.integer :mentor_id
      t.integer :sender_id
      t.integer :receiver_id
      t.datetime :accepted_at
      t.datetime :rejected_at
      t.datetime :completed_at

      t.timestamps
    end
  end

  def self.down
    drop_table :mentorships
  end
end
