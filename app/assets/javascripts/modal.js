$(document).on('turbolinks:load', function () {
  $('.view-modal li').click(function() {
    var imgSrc = $(this).children().attr('src');
    $('.bigimg').children().attr('src', imgSrc);
    $('.modal').fadeIn();
    $('body,html').css('overflow-y', 'hidden');
    return false
  });

  $('.close-btn').click(function() {
    $('.modal').fadeOut();
    $('body,html').css('overflow-y', 'visible');
    return false
  });
});
