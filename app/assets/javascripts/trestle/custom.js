// This file may be used for providing additional customizations to the Trestle
// admin. It will be automatically included within all admin pages.
//
// For organizational purposes, you may wish to define your customizations
// within individual partials and `require` them here.
//
//  e.g. //= require "trestle/custom/my_custom_js"
$(document).on('turbolinks:load', function() {
  $('#company_select').change(function() {
    var companyId = $(this).val();

    $.ajax({
      url: '/api/v1/groups.json',
      data: {
        company_id: companyId
      },
      success: function(data) {
        var groupSelect = $('#group_select');
        groupSelect.empty();

        $.each(data, function(index, group) {
          groupSelect.append($('<option></option>').attr('value', group.id).text(group.name));
        });
      }
    });
  });
});