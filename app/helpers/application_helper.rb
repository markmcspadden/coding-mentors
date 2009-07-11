# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def current_user
    @current_user
  end
  
  def display_date(datetime)
    datetime.strftime("%B %d, %Y")
  end
end
