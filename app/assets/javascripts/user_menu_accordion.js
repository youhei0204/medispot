$(document).on('turbolinks:load', function () {
  $(function(){
    $('#icon').click(function(){
      $(this).next('.user-menu-inner').toggleClass("active");
    });
  });
});
