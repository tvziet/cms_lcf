$(document).on('turbolinks:load', function() {



  $('.delete-button').each(function() {
    var dataIndex = $(this).data('index');
    var companyId = $(this).data('company-id');
    var groupId = $(this).data('group-id');
    // Add any other data attributes you want to check here

    // Check if the data attributes have the correct values
    // If any of the data attributes are not as expected, hide the delete button
    if (companyId === undefined || groupId === undefined) {
      $(this).hide();
    }
  });

  // $('#document_group_ids').empty().closest('.row').hide();
  // $('#document_group_id').empty().closest('.row').hide();
  $('#document_group_ids').closest('.row').hide();
  $('#document_group_id').closest('.row').hide();

  $('.delete-button').click(function() {
    var companyId = $(this).data('company-id');
    var groupId = $(this).data('group-id');
    var dataIndex = $(this).data('index');
    var button = $(this);
    var inputId = 'employee_group_employees_attributes_' + dataIndex + '_id';
    var inputValue = $('#' + inputId).val();
    console.log(groupId);
    console.log(id);
    console.log(button);
    $.ajax({
      url: + groupId + '/delete',
      data: {
        company_id: companyId,
        group_id: groupId
      },
      type: 'DELETE',
      success: function(result) {
        var url = window.location.pathname; // Get the current URL path
        var urlParts = url.split('/'); // Split the URL into parts
        var employeeId = urlParts[urlParts.length - 1]; // Get the last part of the URL
        var companySelectId = 'employee_company_employees_attributes_' + dataIndex + '_company_id';
        var groupSelectId = 'employee_group_employees_attributes_' + dataIndex + '_group_id';
        var inputId = 'employee_group_employees_attributes_' + dataIndex + '_id'; // ID of the input element
        $('#' + companySelectId).next('.select2-container').remove();
        $('#' + groupSelectId).next('.select2-container').remove();
        $('#' + companySelectId).remove();
        $('#' + groupSelectId).remove();
        $('#' + inputId).remove(); // Remove the input element

        $("label[for='" + companySelectId + "']").remove();
        $("label[for='" + groupSelectId + "']").remove();
        button.remove();

          window.location.href = '/admin/employees/' + employeeId + '#!tab-work_info';
          window.location.reload();
      }
    });
  });

  $('#document_document_level_id').change(function() {
    var documentLevelId = $(this).val();

    console.log(documentLevelId);

    if (documentLevelId == '1') {
      $('#document_group_ids').empty().closest('.row').hide();
      $('#document_group_id').empty().closest('.row').hide();
      $.ajax({
        url: '/admin/documents/document_level_default',
        data: {
          document_level_id: documentLevelId
        },
        success: function(data) {
          var companySelectId = $('#document_company_id');
          companySelectId.empty().closest('.row').show();

          $.each(data, function(index, group) {
            companySelectId.append($('<option></option>').attr('value', group.id).text(group.name));
          });
        }
      });
    } else if (documentLevelId == '2') {
      $('#document_company_id').empty().closest('.row').hide();
      $('#document_group_id').empty().closest('.row').hide();
      $.ajax({
        url: '/admin/documents/document_level',
        data: {
          document_level_id: documentLevelId
        },
        success: function(data) {
          var groupSelectIds = $('#document_group_ids');
          groupSelectIds.empty().closest('.row').show();

          $.each(data, function(index, group) {
            groupSelectIds.append($('<option></option>').attr('value', group.id).text(group.name));
          });
        }
      });
    } else if (documentLevelId == '3') {
      $('#document_company_id').empty().closest('.row').hide();
      $('#document_group_ids').empty().closest('.row').hide();
      $.ajax({
        url: '/admin/documents/document_level',
        data: {
          document_level_id: documentLevelId
        },
        success: function(data) {
          var groupSelectId = $('#document_group_id');

          groupSelectId.empty().closest('.row').show();

          $.each(data, function(index, group) {
            groupSelectId.append($('<option></option>').attr('value', group.id).text(group.name));
          });
        }
      });
    }
    else if (documentLevelId == '4') {
      $('#document_company_id').empty().closest('.row').hide();
      $('#document_group_ids').empty().closest('.row').hide();
      $('#document_group_id').empty().closest('.row').hide();
    }
  });

  var newCompanyField;

  $(document).on('change', '[id^="employee_company_employees_company_id_"]', function() {
    var companyId = $(this).val();
    var that = this;

    $.ajax({
      url: '/admin/employees/groups_for_company',
      data: {
        company_id: companyId
      },
      success: function(data) {
        var groupSelect = $('#employee_group_employees_group_id_' + $(that).attr('id').split('_').pop());
        groupSelect.empty();


        $.each(data, function(index, group) {
          groupSelect.append($('<option></option>').attr('value', group.id).text(group.name));
        });
      }
    });
  });

  $(document).on('change', 'select[id^="employee_company_employees_attributes_"]', function() {
    var companyId = $(this).val();
    var that = this;

    $.ajax({
      url: '/admin/employees/groups_for_company',
      data: {
        company_id: companyId
      },
      success: function(data) {
        var idParts = $(that).attr('id').split('_');
        var idSuffix = idParts[idParts.length - 3];

        console.log(idSuffix);

        var groupSelect = $('select[id="employee_group_employees_attributes_' + idSuffix + '_group_id"]');
        groupSelect.empty();

        $.each(data, function(index, group) {
          groupSelect.append($('<option></option>').attr('value', group.id).text(group.name));
        });

        groupSelect.trigger('change');
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

    console.log(12312321);

    $.get('/admin/employees/groups', function(groups) {
      var newGroupField = $('<select></select>')
        .attr('id', 'employee_group_employees_group_id_' + timestamp)
        .attr('name', 'employee[group_employees_attributes][' + timestamp + '][group_id]')
        .append(groups.map(function(group) {
          return $('<option></option>').attr('value', group.id).text(group.name);
        }));

      $('#groups').append(newGroupField);

      newGroupField.select2();

      newGroupField.on('select2:opening', function() {
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
    var deleteButton = $('<button></button>')
    .text('Xoá công ty và phòng ban')
    .addClass('delete-button')
    .data('timestamp', timestamp)
    .click(function() {
      var timestamp = $(this).data('timestamp');
      var companySelectId = 'employee_company_employees_company_id_' + timestamp;
      var groupSelectId = 'employee_group_employees_group_id_' + timestamp;

      $('#' + companySelectId).next('.select2-container').remove();
      $('#' + groupSelectId).next('.select2-container').remove();

      $('#' + companySelectId).remove();
      $('#' + groupSelectId).remove();

      $(this).remove();
    });

  $('#companies').append(deleteButton);
  });
});