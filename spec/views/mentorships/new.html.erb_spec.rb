require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/mentorships/new.html.erb" do
  include MentorshipsHelper
  
  before(:each) do
    assigns[:mentorship] = stub_model(Mentorship,
      :new_record? => true,
      :mentee_id => 1,
      :mentor_id => 1,
      :sender_id => 1,
      :receiver_id => 1
    )
  end

  it "renders new mentorship form" do
    pending "I don't spec views"
    
    render
    
    response.should have_tag("form[action=?][method=post]", mentorships_path) do
      with_tag("input#mentorship_mentee_id[name=?]", "mentorship[mentee_id]")
      with_tag("input#mentorship_mentor_id[name=?]", "mentorship[mentor_id]")
      with_tag("input#mentorship_sender_id[name=?]", "mentorship[sender_id]")
      with_tag("input#mentorship_receiver_id[name=?]", "mentorship[receiver_id]")
    end
  end
end


