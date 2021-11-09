document.addEventListener("turbolinks:before-cache", function(){
  $('.slider.slick-initialized').slick('unslick');
})
$(document).on('turbolinks:load', function () {
  $(function () {
    $('.spot-slider').slick({
      arrows: false, 
      autoplay: true,
      speed: 700,
      autoplaySpeed: 5000
    });
    $('.slider-no-allow').slick({
      arrows: false, 
      autoplay: true,
      speed: 900,
      autoplaySpeed: 3000
    });
    $('.thumbnail').slick({
      infinite: true,
      slidesToShow: 8,
      focusOnSelect: true,
      asNavFor: '.slider'
    });
  });
});
