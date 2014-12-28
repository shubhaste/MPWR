# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
    $('#products').dataTable({
      "aoColumnDefs": [
          { 'bSortable': false, 'aTargets': [3] }
       ]
	})
    sPaginationType: "full_numbers"
    bJQueryUI: true
    bProcessing: true
    bServerSide: true
    aoColumnDefs: [ { "bSortable": false, "aTargets": [ 1, 3 ] } ]
    sAjaxSource: $('#products').data('source')
