function myfunction(view) {
    console.log('hello');
    if (view == "data") {
      document.getElementById("appbody").innerHTML = '<p>To Be Implemented - Data</p>';
    }
    if (view == "metrics") {
      document.getElementById("appbody").innerHTML = '<p>To Be Implemented - Metrics</p>';
    }
    if (view == "geo") {
      $("#appbody").load("/partials/sample_content.ejs");

        var my_div = $("#appbody");
        $("#HButton").on("click", function () {
          $.ajax({
             url: "/partials/sample_content"
          })
          .done(function( data ) {
             console.log( "Sample of data:", data );
             $('#holder').html(data.message);
          });
        });

      // document.getElementById("appbody").innerHTML = "<div> <% include partials/sample_content %> </div>";
    }
 }
