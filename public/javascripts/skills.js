function resetAvailableSkills(skillsArray) {
  availableSkills = skillsArray;
}

// Allows our inline edits to have autocomplete
// OPTIMIZE: This will get stupid slow very quickly
function attachAutoComplete(userSkillId) {
  var formId = 'edit_user_skill_' + userSkillId;
  var acContainerId = 'autocomplete_skill_name_' + userSkillId;

  // Dynamically adding our autocomplete container
  new Insertion.Bottom($(formId), "<div id=\"" + acContainerId + "\" class=\"autocomplete\"></div>");

  // Create the autocompleter
  new Autocompleter.Local($(formId).getInputs('text', 'user_skill[skill_name]').first(), acContainerId, availableSkills, {});
}