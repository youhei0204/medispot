$(function () {
  var webStorage = function () {
    if (sessionStorage.getItem('access') != 0 ) {
      sessionStorage.setItem('access', 0);
      $('#toppage').hide();
      $('#loading').show();

      setInterval(function(){
        if ($('.loading-text').text().length < 10){
          $('.loading-text').append('.')
        }else{
          $('.loading-text').text('Loading')
        }
      },500);

      $(window).load(function () {
        $('#loading').fadeOut(800);
        $('#toppage').fadeIn(700);
      });

      function stopload(){
        $('#loading').fadeOut(800);
        $('#toppage').fadeIn(700);
        console.log('ssss')
      }
      setTimeout(stopload(),2500);
    }
  }
  webStorage();
});
