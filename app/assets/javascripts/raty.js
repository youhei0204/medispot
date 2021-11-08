$(document).on('turbolinks:load', function () {
  $(function () {
    $('.rate').empty();
    $('.rate').raty({
      readOnly: true,
      score: $(this).attr('data-score'),
      path: '/assets/',
      number: 5
    });
  });
});
