$(document).on('turbolinks:load', function () {
  $(function(){
    $('#icon').click(function(){
      $(this).next('.user-menu-inner').toggleClass("active");
    });
    $(document).click(function(event){
      var target = $(event.target);
      if(target.attr('id') != 'icon' && target.not('user-menu-inner')) {
        $('.user-menu-inner').removeClass('active');
      }
    });
  });
});
