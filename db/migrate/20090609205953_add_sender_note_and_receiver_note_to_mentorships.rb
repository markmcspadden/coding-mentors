class AddSenderNoteAndReceiverNoteToMentorships < ActiveRecord::Migration
  def self.up
    add_column :mentorships, :sender_note, :text
    add_column :mentorships, :receiver_note, :text
  end

  def self.down
    remove_column :mentorships, :sender_note
    remove_column :mentorships, :receiver_note
  end
end
