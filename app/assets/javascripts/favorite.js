$(document).on('turbolinks:load', function () {
  $('.favorite-btn').click(function () {
    $('.favorite-btn').toggleClass('active');
  });
});
