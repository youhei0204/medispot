$(document).on('turbolinks:load', function () {
  $(function () {
    var dataBox = new DataTransfer();
    var file_field = document.querySelector('input[type=file]');

    $('#img-file').change(function () {
      $.each(this.files, function (i, file) {
        dataBox.items.add(file)
        file_field.files = dataBox.files
        initial_image_num = $(".initial-image").length 
        var fileReader = new FileReader();
        fileReader.readAsDataURL(file);

        fileReader.onloadend = function () {
          var src = fileReader.result
          var html = `<div class='image-box', data-image="${file.name}">
                      <div class='item-image'>
                        <img src=${src}>
                      </div>
                      <div class='delete-box'>
                        <div class='image-delete cursor-pointer'>削除</div>
                      </div>
                    </div>`
          $('.add-image-box').before(html);
        };
        const MAX_IMAGE_UPLOAD_NUM = 4
        if ( initial_image_num + file_field.files.length >= MAX_IMAGE_UPLOAD_NUM) {
          $('.add-image-box').css('display', 'none')
          return false;
        }
      });
    });

    $(document).on("click", '.image-delete', function () {
      var target_image = $(this).parent().parent()
      var target_name = $(target_image).data('image')
      if (file_field.files.length == 1) {
        $('input[type=file]').val(null)
        dataBox.clearData();
      } else {
        $.each(file_field.files, function (i, input) {
          if (input.name == target_name) {
            dataBox.items.remove(i)
          }
        })
        file_field.files = dataBox.files
      }
      target_image.remove()
      $('.add-image-box').show()
    })
  });
});
