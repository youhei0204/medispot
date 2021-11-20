$(document).on('turbolinks:load', function () {
    $(document).click(function(event){
      var target = $(event.target);
      if(target.attr('id') != 'notification' && target.not('.notification-box')) {
        $('.notification-box').remove();
      }
    });
});
