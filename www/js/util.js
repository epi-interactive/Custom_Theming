// URL input binding
// This input binding is very similar to textInputBinding from
// shiny.js.
var navInputBinding = new Shiny.InputBinding();

// An input binding must implement these methods
$.extend(navInputBinding, {

  // This returns a jQuery object with the DOM element
  find: function(scope) {
    return $(scope).find('[nav-container]');
  },
  // return the ID of the DOM element
  getId: function(el) {
    return el.id;
  },
  // Given the DOM element for the input, return the value
  getValue: function(el) {
    var sel =  $(el).data("selected");
    return sel;
  },
  // Given the DOM element for the input, set the value
  setValue: function(el, value) {},
  // Set up the event listeners so that interactions with the
  // input will result in data being sent to server.
  // callback is a function that queues data to be sent to
  // the server.
  subscribe: function(el, callback) {
    $(el).on('click.navInputBinding', function(event) {
      $(el).data("selected", $(event.target).closest("[nav-to]").attr("nav-to"));
      callback(false);
      // When called with true, it will use the rate policy,
      // which in this case is to debounce at 500ms.
    });
  },
  // Remove the event listeners
  unsubscribe: function(el) {
    $(el).off('.navInputBinding');
  },

  // This returns a full description of the input's state.
  // Note that some inputs may be too complex for a full description of the
  // state to be feasible.
  getState: function(el) {
    /*return {
      label: $(el).parent().find('label[for="' + $escape(el.id) + '"]').text(),
      value: el.value
    };*/
  },

  // The input rate limiting policy
  getRatePolicy: function() {
    return {
      // Can be 'debounce' or 'throttle'
      policy: 'debounce',
      delay: 500
    };
  }
});

Shiny.inputBindings.register(navInputBinding, 'shiny.navInput');

$(document.body).on("click", ".filter-title",
function (e) {
  Shiny.onInputChange($(e.currentTarget).closest('.filter-group').attr('id'), $(e.currentTarget).text());
});

Shiny.addCustomMessageHandler("sendInput", function(e){
  console.log(e);
  Shiny.onInputChange(e.id, e.val);
});

$(document.body).on("click", "[click-spin]",
function (e) {
  $(e.currentTarget).find('i.fa').addClass('fa-spin')
  .closest('button').prop('disabled', true);
});

Shiny.addCustomMessageHandler("clearSpinner",
  function(id) {
	  $('#'+id).find('.fa').removeClass('fa-spin')
	  .closest('button').prop('disabled', false);
  }
);


//Only checking that you are putting in a number
$(document.body).on('keydown', "input[type='number']", function(e) {
  var inp = $(e.currentTarget);
  
  //store intial state once only!
  if(!inp.data("oldval")){
    inp.data("oldval", inp.val());
  }
  if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
             // Allow: Ctrl+A, Command+A
            (e.keyCode === 65 && (e.ctrlKey === true || e.metaKey === true)) || 
             // Allow: home, end, left, right, down, up
            (e.keyCode >= 35 && e.keyCode <= 40)) {
                 // let it happen, don't do anything
                 return;
        }
        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }
});

//check aftermath of input
$(document.body).on('input', "input[type='number']", function(e){
  var inp = $(e.currentTarget);
  if(inp.data("oldval") === inp.val()){
    e.preventDefault();
    return;
  }
  
  var max = inp.attr('max');
  var min = inp.attr('min');
  if(max && (parseFloat(inp.val()) > parseFloat(max))){
    e.preventDefault();
    inp.val(inp.data("oldval"));
    return;
  }
  if(min && (parseFloat(inp.val()) < parseFloat(min))){
    e.preventDefault();
    inp.val(inp.data("oldval"));
    return;
  }
  //new value is valid, update the 'oldval'
  inp.data("oldval", inp.val());
});

var footer;
$(
  footer = $('#footer')
)

Shiny.addCustomMessageHandler("unfade-page", function(e) {
  console.log('fading');
    $(".load-fade").addClass("out");
})





