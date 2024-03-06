// $(document).on('turbolinks:load', function() {

//   $('#document_group_ids').empty().prop('disabled', true);
//   $('#document_group_id').empty().prop('disabled', true);

//   $('.delete-button').click(function() {
//     var id = $(this).attr('id');
//     var companyId = $(this).data('company-id');
//     var dataIndex = $(this).data('index');
//     var button = $(this);
//     console.log(id);
//     $.ajax({
//       url: + id + '/delete',
//       data: {
//         company_id: companyId
//       },
//       type: 'DELETE',
//       success: function(result) {
//         console.log(34534534);
//         var companySelectId = 'employee_company_employees_attributes_' + dataIndex + '_company_id';
//         var groupSelectId = 'employee_group_employees_attributes_' + dataIndex + '_group_id';
//         $('#' + companySelectId).next('.select2-container').remove();
//         $('#' + groupSelectId).next('.select2-container').remove();
//         $('#' + companySelectId).remove();
//         $('#' + groupSelectId).remove();

//         $("label[for='" + companySelectId + "']").remove();
//         $("label[for='" + groupSelectId + "']").remove();
//         button.remove();
//       }
//     });
//   });

//   $('#document_document_level_id').change(function() {
//     var documentLevelId = $(this).val();

//     if (documentLevelId == '1') {
//       $('#document_group_ids').empty().prop('disabled', true);
//       $('#document_group_id').empty().prop('disabled', true);
//       $.ajax({
//         url: '/admin/documents/document_level_default',
//         data: {
//           document_level_id: documentLevelId
//         },
//         success: function(data) {
//           var companySelectId = $('#document_company_id');
//           companySelectId.empty().prop('disabled', false);

//           $.each(data, function(index, group) {
//             companySelectId.append($('<option></option>').attr('value', group.id).text(group.name));
//           });
//         }
//       });
//     } else if (documentLevelId == '2') {
//       $('#document_company_id').empty().prop('disabled', true);
//       $('#document_group_id').empty().prop('disabled', true);
//       $.ajax({
//         url: '/admin/documents/document_level',
//         data: {
//           document_level_id: documentLevelId
//         },
//         success: function(data) {
//           var groupSelectIds = $('#document_group_ids');
//           groupSelectIds.empty().prop('disabled', false);

//           $.each(data, function(index, group) {
//             groupSelectIds.append($('<option></option>').attr('value', group.id).text(group.name));
//           });
//         }
//       });
//     } else if (documentLevelId == '3') {
//       $('#document_company_id').empty().prop('disabled', true);
//       $('#document_group_ids').empty().prop('disabled', true);
//       $.ajax({
//         url: '/admin/documents/document_level',
//         data: {
//           document_level_id: documentLevelId
//         },
//         success: function(data) {
//           var groupSelectId = $('#document_group_id');

//           groupSelectId.empty().prop('disabled', false);

//           $.each(data, function(index, group) {
//             groupSelectId.append($('<option></option>').attr('value', group.id).text(group.name));
//           });
//         }
//       });
//     }
//     else if (documentLevelId == '4') {
//       $('#document_company_id').empty().prop('disabled', true);
//       $('#document_group_ids').empty().prop('disabled', true);
//       $('#document_group_id').empty().prop('disabled', true);
//     }
//   });

//   var newCompanyField;

//   $(document).on('change', '[id^="employee_company_employees_company_id_"]', function() {
//     var companyId = $(this).val();
//     var that = this;

//     $.ajax({
//       url: '/admin/employees/groups_for_company',
//       data: {
//         company_id: companyId
//       },
//       success: function(data) {
//         var groupSelect = $('#employee_group_employees_group_id_' + $(that).attr('id').split('_').pop());
//         groupSelect.empty();


//         $.each(data, function(index, group) {
//           groupSelect.append($('<option></option>').attr('value', group.id).text(group.name));
//         });
//       }
//     });
//   });

//   $(document).on('change', 'select[id^="employee_company_employees_attributes_"]', function() {
//     var companyId = $(this).val();
//     var that = this;

//     $.ajax({
//       url: '/admin/employees/groups_for_company',
//       data: {
//         company_id: companyId
//       },
//       success: function(data) {
//         var idParts = $(that).attr('id').split('_');
//         var idSuffix = idParts[idParts.length - 3];

//         console.log(idSuffix);

//         var groupSelect = $('select[id="employee_group_employees_attributes_' + idSuffix + '_group_id"]');
//         groupSelect.empty();

//         $.each(data, function(index, group) {
//           groupSelect.append($('<option></option>').attr('value', group.id).text(group.name));
//         });

//         groupSelect.trigger('change');
//       }
//     });
//   });

//   $('#add_company_and_group').click(function(e) {
//     var timestamp = new Date().getTime();

//     $.get('/admin/employees/companies', function(companies) {
//       newCompanyField = $('<select></select>')
//         .attr('id', 'employee_company_employees_company_id_' + timestamp)
//         .attr('name', 'employee[company_employees_attributes][' + timestamp + '][company_id]')
//         .append(companies.map(function(company) {
//           return $('<option></option>').attr('value', company.id).text(company.name);
//         }));

//       $('#companies').append(newCompanyField);

//       newCompanyField.select2();

//       newCompanyField.on('select2:opening', function() {
//         console.log('Select2 is being opened');
//       });
//     });

//     console.log(12312321);

//     $.get('/admin/employees/groups', function(groups) {
//       var newGroupField = $('<select></select>')
//         .attr('id', 'employee_group_employees_group_id_' + timestamp)
//         .attr('name', 'employee[group_employees_attributes][' + timestamp + '][group_id]')
//         .append(groups.map(function(group) {
//           return $('<option></option>').attr('value', group.id).text(group.name);
//         }));

//       $('#groups').append(newGroupField);

//       newGroupField.select2();

//       newGroupField.on('select2:opening', function() {
//         var companyId = newCompanyField.val();
//         $.ajax({
//           url: '/admin/employees/groups_for_company',
//           data: {
//             company_id: companyId
//           },
//           success: function(data) {
//             newGroupField.empty();

//             $.each(data, function(index, group) {
//               newGroupField.append($('<option></option>').attr('value', group.id).text(group.name));
//             });
//           }
//         });
//       });
//     });
//     var deleteButton = $('<button></button>')
//     .text('Delete')
//     .data('timestamp', timestamp)
//     .click(function() {
//       var timestamp = $(this).data('timestamp');
//       var companySelectId = 'employee_company_employees_company_id_' + timestamp;
//       var groupSelectId = 'employee_group_employees_group_id_' + timestamp;

//       $('#' + companySelectId).next('.select2-container').remove();
//       $('#' + groupSelectId).next('.select2-container').remove();

//       $('#' + companySelectId).remove();
//       $('#' + groupSelectId).remove();

//       $(this).remove();
//     });

//   $('#companies').append(deleteButton);
//   });
// });