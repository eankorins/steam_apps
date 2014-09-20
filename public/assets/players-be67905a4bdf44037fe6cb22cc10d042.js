(function() {
  jQuery(function() {
    return $('#hero_id').change(function() {
      var e, hid, u;
      e = $('#hero_id');
      hid = e.val();
      u = e.data('url') + "/hero_matches.js?hero_id=" + hid;
      return $.ajax({
        type: 'GET',
        dataType: 'HTML',
        url: u,
        error: function(a, status, error) {
          return alert(error);
        },
        success: function(data, status, a) {
          $('#pgrid').empty().append(data);
          return false;
        }
      });
    });
  });

}).call(this);
