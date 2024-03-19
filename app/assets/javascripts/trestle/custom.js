$(document).on('turbolinks:load', function () {
  text = $('#select2-document_document_level_id-container').text()

  if (text == 'Tài liệu cấp 1') {
    $('#document_group_ids').empty().closest('.row').hide();
    $('#document_group_id').empty().closest('.row').hide();
  } else if (text == 'Tài liệu cấp 2') {
    $('#document_company_id').empty().closest('.row').hide();
    $('#document_group_id').empty().closest('.row').hide();
  } else if (text == 'Tài liệu cấp 3') {
    $('#document_company_id').empty().closest('.row').hide();
    $('#document_group_ids').empty().closest('.row').hide();
  }
  else if (text == 'Tài liệu cấp 4') {
    $('#document_company_id').empty().closest('.row').hide();
    $('#document_group_ids').empty().closest('.row').hide();
    $('#document_group_id').empty().closest('.row').hide();
  }

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
      console.log(documentLevelId);
      $('#document_company_id').empty().closest('.row').hide();
      $('#document_group_ids').empty().closest('.row').hide();
      $('#document_group_id').empty().closest('.row').hide();
    }
  });

  $('input[data-id="concac"]').change(function () {
    if($(this).is(':checked')) {
      $('#news_company_id').closest('.row').hide();
      $('#news_group_ids').closest('.row').hide();
    } else {
      $('#news_company_id').closest('.row').show();
      $('#news_group_ids').closest('.row').show();
    }
  });

  if($('#company_id').val()) {
    $('#check-box-news').hide();
    $('#news_group_ids').closest('.row').hide();
  } else {
    $('#check-box-news').show();
    $('#news_group_ids').closest('.row').show();
  }

  $('#news_company_id').change(function() {
    if($(this).val()) {
      $('.check-box-news').closest('.row').hide();
      $('#news_group_ids').closest('.row').hide();
    } else {
      $('.check-box-news').closest('.row').show();
      $('#news_group_ids').closest('.row').show();
    }
  });

  if($('#group_ids').val()) {
    $('#check-box-news').hide();
    $('#news_group_id').closest('.row').hide();
  } else {
    $('#check-box-news').show();
    $('#news_group_id').closest('.row').show();
  }

  $('#news_group_ids').change(function() {
    if($(this).val()) {
      $('.check-box-news').closest('.row').hide();
      $('#news_group_id').closest('.row').hide();
    }
  });

  $('#news_group_ids').on('select2:unselect', function(e) {
    if($(this).val() == null || $(this).val().length == 0) {
      console.log(123123);
      $('.check-box-news').closest('.row').show();
      $('#news_group_id').closest('.row').show();
    }
  });
});