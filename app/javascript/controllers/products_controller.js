import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  connect() {
    $(".product_addons").select2({
      placeholder: "Select your Addoos",
      multiple: true,
      maximumSelectionLength: 3
    });

    $(".add_to_cart_button").click(function(e) {
      e.preventDefault();
      var formData = new FormData();
	     formData.append('product_id', $(this).attr('product_id'));
       alert($(this).attr('product_id'))
      // $.ajax({
      //   headers: {
      //     'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
      //   },
      //   url: '/get_product_addon/' + this.value,
      //   method: "get",
      //   processData: false,
      //   cache: false,
      //   error: function(XMLHttpRequest, errorTextStatus, error) {
      //    alert("Failed to submit : " + errorTextStatus + " ;" + error);
      //   },
      //   success: function(data) {
      //    $("select#product_addon option").remove();
      //    var row = ""
      //    $.each(data, function(i, j) {
      //     row = "<option value=\"" + j[1] + "\">" + j[0] + "</option>";
      //     $(row).appendTo("select#product_addon");
      //    });
      //   }
      //  });
    });
  }
}
