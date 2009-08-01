require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/mentorships/index.html.erb" do
  include MentorshipsHelper
  
  before(:each) do
    assigns[:mentorships] = [
      stub_model(Mentorship,
        :mentee_id => 1,
        :mentor_id => 1,
        :sender_id => 1,
        :receiver_id => 1
      ),
      stub_model(Mentorship,
        :mentee_id => 1,
        :mentor_id => 1,
        :sender_id => 1,
        :receiver_id => 1
      )
    ]
  end

  it "renders a list of mentorships" do
    pending "Not specing views"
    render
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end

