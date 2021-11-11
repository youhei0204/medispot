$(document).on('turbolinks:load', function () {
  $('.cancel-like').click(function () {
    count = Number($(this).children('.like-count').text()) -1;
    $(this).next('.add-like').children('.like-count').text(count);
    $(this).toggleClass('active');
    $(this).next('.add-like').toggleClass('active');
  });
  $('.add-like').click(function () {
    count = Number($(this).children('.like-count').text()) +1;
    $(this).prev('.cancel-like').children('.like-count').text(count);
    $(this).toggleClass('active');
    $(this).prev('.cancel-like').toggleClass('active');
  });
});
