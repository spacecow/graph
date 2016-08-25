$(function(){
  var glossary_id = "#relation_target_id";
  $(glossary_id).tokenInput($(glossary_id).data('url'), {
    propertyToSearch: 'name',
    tokenLimit: 1
  });
});
