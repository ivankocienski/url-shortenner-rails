
var form_submitter = {

  csrf: '',

  submit: function() {

    var url = $( "form input[name='url']" ).val();

    $.ajax({
      type: 'POST',
      url: '/c',
      data: { url: url, authenticity_token: form_submitter.csrf },

      success: function( data ) {

        var url = data['url'];

        var link = $('p#shortenned a' );

        if( link.length > 0 ) {
          link.attr( 'href', url );
          link.html(url);

        } else {
          
          var html = "<p id='shortenned'>";
          html += "<a href='" + url + "'>" + url + "</a>";
          html += "</p>";

          $('#page').append( html );
        }

      }
    });

    return false;
  }
};

