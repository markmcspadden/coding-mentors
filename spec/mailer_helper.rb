require File.dirname(__FILE__) + '/spec_helper.rb'

module MailerSpecHelper
  private

  def read_fixture(action)
    IO.readlines("#{FIXTURES_PATH}/mailers/#{action}")
  end
end