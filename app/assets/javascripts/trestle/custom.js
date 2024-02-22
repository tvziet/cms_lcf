$(document).on('turbolinks:load', function() {
  var newCompanyField;

  $(document).on('change', '[id^="employee_company_employees_company_id_"]', function() {
    var companyId = $(this).val();

    $.ajax({
      url: '/admin/employees/groups_for_company',
      data: {
        company_id: companyId
      },
      success: function(data) {
        var groupSelect = $('#employee_group_employees_group_id_' + $(this).attr('id').split('_').pop());
        groupSelect.empty();

        $.each(data, function(index, group) {
          groupSelect.append($('<option></option>').attr('value', group.id).text(group.name));
        });
      }
    });
  });

  $('#add_company_and_group').click(function(e) {
    var timestamp = new Date().getTime();

    $.get('/admin/employees/companies', function(companies) {
      newCompanyField = $('<select></select>')
        .attr('id', 'employee_company_employees_company_id_' + timestamp)
        .attr('name', 'employee[company_employees_attributes][' + timestamp + '][company_id]')
        .append(companies.map(function(company) {
          return $('<option></option>').attr('value', company.id).text(company.name);
        }));

      $('#companies').append(newCompanyField);

      newCompanyField.select2();

      newCompanyField.on('select2:opening', function() {
        console.log('Select2 is being opened');
      });
    });

    $.get('/admin/employees/groups', function(groups) {
      var newGroupField = $('<select></select>')
        .attr('id', 'employee_group_employees_group_id_' + timestamp)
        .attr('name', 'employee[group_employees_attributes][' + timestamp + '][group_id]')
        .append(groups.map(function(group) {
          return $('<option></option>');
        }));

      $('#groups').append(newGroupField);

      newGroupField.select2();

      newGroupField.on('select2:opening', function() {
        console.log(1233);
        var companyId = newCompanyField.val();
        $.ajax({
          url: '/admin/employees/groups_for_company',
          data: {
            company_id: companyId
          },
          success: function(data) {
            newGroupField.empty();

            $.each(data, function(index, group) {
              newGroupField.append($('<option></option>').attr('value', group.id).text(group.name));
            });
          }
        });
      });
    });
  });
});