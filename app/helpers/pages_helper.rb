module PagesHelper
  
  def title_skills(learn_skill, teach_skill)
    learn_skill_text = h(learn_skill.to_s)
    teach_skill_text = h(teach_skill.to_s)
    
    learn_link = link_to(learn_skill_text, search_path(:q => learn_skill_text), :class => "title_skill")
    teach_link = link_to(teach_skill_text, search_path(:q => teach_skill_text), :class => "title_skill")
    
    "Learn #{learn_link} &nbsp;&nbsp;<small>or</small>&nbsp;&nbsp; Teach #{teach_link}"
  end
  
end
