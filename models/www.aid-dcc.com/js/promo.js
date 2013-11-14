!function() {
  $("#slides").slides({preload: !0,generateNextPrev: !1,slideSpeed: 1200,slideEasing: "easeOutCubic",animationStart: function() {
      return $(".caption").stop(), $(".caption").animate({opacity: 0}, 1)
    },animationComplete: function() {
      return $(".caption").delay(500).animate({opacity: 1}, 1)
    },slidesLoaded: function() {
      return $(".caption").animate({opacity: 1}, 1)
    },play: 1e4,pause: 1e4})
}.call(this);
