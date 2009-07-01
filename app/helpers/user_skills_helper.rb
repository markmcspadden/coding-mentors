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
end
