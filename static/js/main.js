$(function() {
  $("#linkButton").on("click", function(e) {
    $.post("/submit", {"video": $("#url").val()});
    $("#url").val("");
    $("#linkButton").blur();
    alert("Submitted! The song play/appear in the queue once it is loaded.");
  });
  $("#volup").on("click", function(e) {
    $("#volup").blur();
    $.get("/volup");
  });
  $("#voldown").on("click", function(e) {
    $("#voldown").blur();
    $.get("/voldown");
  });
  $("#skipButton").on("click", function(e) {
    $("#skipButton").blur();
    $.get("/skip");
  });
  $('#url').keypress(function(e) {
    if (e.keyCode == 13) {
      $('#linkButton').click();
      e.preventDefault();
    }
  });

  setInterval(function() {
    $.getJSON("/queue", function(q) {
        things = '';
        $("#playing").html('<p>'+q[0]+'</p>');

        for(var a=1; a<q.length; a++) {
            things += '<li><span>'+q[a]+'</span></li>'
        }
        $("#queue").html(things);
    });
  }, 1000);
});
