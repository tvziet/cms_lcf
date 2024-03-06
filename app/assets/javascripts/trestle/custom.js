$(document).on('turbolinks:load', function () {
  $('#document_group_ids').closest('.row').hide();
  $('#document_group_id').closest('.row').hide();

  $('#document_document_level_id').change(function () {
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
        success: function (data) {
          var companySelectId = $('#document_company_id');
          companySelectId.empty().closest('.row').show();

          $.each(data, function (index, group) {
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
        success: function (data) {
          var groupSelectIds = $('#document_group_ids');
          groupSelectIds.empty().closest('.row').show();

          $.each(data, function (index, group) {
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
        success: function (data) {
          var groupSelectId = $('#document_group_id');

          groupSelectId.empty().closest('.row').show();

          $.each(data, function (index, group) {
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
});