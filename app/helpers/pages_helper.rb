module PagesHelper
  
  def title_skills(learn_skill, teach_skill)
    learn_text = content_tag("span", h(learn_skill.to_s), :class => "title_skill")
    teach_text = content_tag("span", h(teach_skill.to_s), :class => "title_skill") 
    
    "Learn #{learn_text} &nbsp;&nbsp;<small>or</small>&nbsp;&nbsp; Teach #{teach_text}"
  end
  
end
