$(function () {
    // Initialize the jQuery File Upload widget:
    $('#fileupload').fileupload();
    // 
    // Load existing files:
		if ($('form#fileupload').length > 0){
			$.getJSON($('form#fileupload').prop('action')+".json", function (files) {
	      var fu = $('#fileupload').data('fileupload'), 
	        template;
	      fu._adjustMaxNumberOfFiles(-files.length);
	      template = fu._renderDownload(files)
	        .appendTo($('#fileupload .files'));
	      // Force reflow:
	      fu._reflow = fu._transition && template.length &&
	        template[0].offsetWidth;
	      template.addClass('in');
	    });	
		}
});