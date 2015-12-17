$(document).ready(function(){
      $('.parallax').parallax();
      $(".typing").typed({
            strings: ["MILAN", "PARIS", "LONDON", "MOSCOW", "NEW YORK"],
            typeSpeed: 200,
            backDelay: 500,
            backSpeed: 100,
            loop: true
      });
});

// Materialize.toast(message, displayLength, className, completeCallback);
  Materialize.toast('I am a toast!', 4000); // 4000 is the duration of the toast