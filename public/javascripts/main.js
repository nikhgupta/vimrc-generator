$(document).ready(function() {
  /* generate button affix */
  $('#generate-config').affix({
    offset: {
      top: $('form#customize-config').offset().top
    }
  });

  /* Scroll sidebar affix when being cut off */
  $('body').on('activate.bs.scrollspy', function(e) {
    $menu = $('ul#doc-menu')
    $el = $menu.find('li.active');
    elTop = $el.position().top
    mnTop = $menu.position().top
    winHt = $(window).height()

    if ($("ul#doc-menu").hasClass('affix') && winHt - elTop - mnTop <
      200) {
      $('.doc-menu').css({
        "top": (mnTop - 200) + "px"
      })
    }

    if ($("ul#doc-menu").hasClass('affix') && mnTop + elTop < 200) {
      pos = mnTop + 200 > 15 ? 15 : mnTop + 200
      $('.doc-menu').css({
        "top": pos + "px"
      })
    };
  });
});
