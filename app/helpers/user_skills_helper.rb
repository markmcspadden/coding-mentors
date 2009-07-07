module UserSkillsHelper
  
  # OPTIMIZE: This is going to be REALLLLY SLOW at more than 100 Skills
  def user_skill_auto_complete(user, user_skill = nil)
    element_id = user_skill ? "edit_user_skill_#{user_skill.id}" : "new_user_skill"
    
    js = <<-EOS
            <script type="text/javascript">
              new Autocompleter.Local($('#{element_id}').getInputs('text', 'user_skill[skill_name]').first(), 'autocomplete_skill_name', [ #{ Skill.all.reject{ |s| user.skills.include?(s) }.collect{ |s| "\"#{escape_javascript(s.name)}\"" }.join(",") } ], {});
            </script>
          EOS
    
    js
  end
  
  def display_user_skill(user_skill)
    content_tag(:span, user_skill_image(user_skill), :class => "user_skill_images") +
    user_skill.skill.name
  end
  
  def user_skill_image(user_skill)
    total = 7
    on = user_skill.level
    off = total - on
    
    images = ""
    
    on.times { images << on_image }
    off.times { images << off_image }
    
    images
  end
  
  def on_image
    image_tag "pill_on.png", :alt => "On", :class => "user_skill_image"
  end
  def off_image
    image_tag "pill_off.png", :alt => "Off", :class => "user_skill_image"
  end
end
