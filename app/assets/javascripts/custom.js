$(document).on('click', '.quantity', function() {
  var product_id = $(this).attr('product_id')
  var url = $(this).attr('url')
  $.ajax({
    url: url,
    type: 'patch',
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
  })
})

$(document).on('change','.category_products',function() {
  var category_id = $('select.category_products :selected').val()
  $.ajax({
    url: '/dashboard',
    type: 'get',
    data: { "category_id": category_id }
  })
})
