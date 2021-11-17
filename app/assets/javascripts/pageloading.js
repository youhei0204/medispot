$(function () {
  var webStorage = function () {
    if (sessionStorage.getItem('access') != 0 ) {
      sessionStorage.setItem('access', 0);
      $('#toppage').hide();
      $('.top-block').show();
      $('#loading').show();

      setInterval(function(){
        if ($('.loading-text').text().length < 10){
          $('.loading-text').append('.')
        }else{
          $('.loading-text').text('Loading')
        }
      },500);

      $(window).on('load', function () {
        $('#loading').fadeOut(800);
        $('#toppage').fadeIn(1500);
      });

      setTimeout(function(){stopload()},5000);

      function stopload(){
        $('#loading').fadeOut(800);
        $('#toppage').fadeIn(1500);
      }
    }
  }
  webStorage();
});
