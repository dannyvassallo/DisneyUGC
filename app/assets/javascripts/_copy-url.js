var client = new ZeroClipboard( $('.copy') );

client.on( "ready", function( readyEvent ) {

  client.on( "aftercopy", function( event ) { 
    var msg = "Copied URL: " + event.data["text/plain"];
    Materialize.toast(msg, 5000, 'green darken-4');
  } );
} );