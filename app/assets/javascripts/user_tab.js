$(document).on('turbolinks:load', function () {
  $(function () {
    let tabs = $(".tab");
    $(".tab").on("click", function () {
      $(".tab.active").removeClass("active");
      $(this).addClass("active");
      const index = tabs.index(this);
      $(".content").removeClass("show").eq(index).addClass("show");
    })
  })
})
