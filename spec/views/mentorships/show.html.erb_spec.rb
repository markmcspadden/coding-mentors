require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/mentorships/show.html.erb" do
  include MentorshipsHelper
  before(:each) do
    assigns[:mentorship] = @mentorship = stub_model(Mentorship,
      :mentee_id => 1,
      :mentor_id => 1,
      :sender_id => 1,
      :receiver_id => 1
    )
  end

  it "renders attributes in <p>" do
    pending "I don't spec views"
    
    render
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/1/)
  end
end

