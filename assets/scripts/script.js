$(function () {
  $(".dashboard ul li a.list").on("click", function () {
    let el = $(`.${$(this).data("list")}`);
    if ($(`.${$(this).data("list")}.sublinks`).css("display") === "none") {
      el.slideDown(600);
    } else {
      el.slideUp(600);
    }
  });
  $(".show-dashboard").on("click", function () {
    $(".dashboard").animate({ left: "0" }, 700);
  });
  $(".x").on("click", function () {
    $(".dashboard").animate({ left: "-99.8vw" }, 700);
  });
  $("main .content nav .user span").click(function () {
    $("main .content nav .user .logout").fadeToggle(700);
  });
});
