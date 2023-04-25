(function() {
	tinymce.PluginManager.add('vbo-shortcodes', function(editor, url) {
		// add Button to Visual Editor Toolbar
		editor.addButton('vbo-shortcodes', {
			title: 'VikBooking Shortcodes List',
			cmd: 'vbo-shortcodes',
			icon: 'wp_code'
		});

		editor.addCommand('vbo-shortcodes', function() {
			openVikBookingShortcodes(editor);
		});

	});
})();

var shortcodes_editor = null;

function openVikBookingShortcodes(editor) {

	shortcodes_editor = editor;

	var html = '';

	for (var group in VIKBOOKING_SHORTCODES) {

		html += '<div class="shortcodes-block">';
		html += '<div class="shortcodes-group"><a href="javascript: void(0);" onclick="toggleVikBookingShortcode(this);">' + group + '</a></div>';
		html += '<div class="shortcodes-container">';

		for (var i = 0; i < VIKBOOKING_SHORTCODES[group].length; i++) {
			var row = VIKBOOKING_SHORTCODES[group][i];

			html += '<div class="shortcode-record" onclick="selectVikBookingShortcode(this);" data-code=\'' + row.shortcode + '\'">';
			html += '<div class="maindetails">' + row.name + '</div>';
			html += '<div class="subdetails">';
			html += '<small class="postid">Post ID: ' + row.post_id + '</small>';
			html += '<small class="createdon">Created On: ' + row.createdon + '</small>';
			html += '</div>';
			html += '</div>';
		}

		html += '</div></div>';
	}

	jQuery('body').append(
		'<div id="vbo-shortcodes-backdrop" class="vbo-tinymce-backdrop"></div>\n'+
		'<div id="vbo-shortcodes-wrap" class="vbo-tinymce-modal wp-core-ui has-text-field" role="dialog" aria-labelledby="link-modal-title">\n'+
			'<form id="vbo-shortcodes" tabindex="-1">\n'+
				'<h1>VikBooking Shortcodes List</h1>\n'+
				'<button type="button" onclick="dismissVikBookingShortcodes();" class="vbo-tinymce-dismiss"><span class="screen-reader-text">Close</span></button>\n'+
				'<div class="vbo-tinymce-body">' + html + '</div>\n'+
				'<div class="vbo-tinymce-submitbox">\n'+
					'<div id="vbo-tinymce-cancel">\n'+
						'<button type="button" class="button" onclick="dismissVikBookingShortcodes();">Cancel</button>\n'+
					'</div>\n'+
					'<div id="vbo-tinymce-update">\n'+
						'<button type="button" class="button button-primary" disabled onclick="putVikBookingShortcode();">Add</button>\n'+
					'</div>\n'+
				'</div>\n'+
			'</form>\n'+
		'</div>\n'
	);

	jQuery('#vbo-shortcodes-backdrop').on('click', function() {
		dismissVikBookingShortcodes();
	});
}

function dismissVikBookingShortcodes() {
	jQuery('#vbo-shortcodes-backdrop, #vbo-shortcodes-wrap').remove();
}

function toggleVikBookingShortcode(link) {
	var next = jQuery(link).parent().next();
	var show = next.is(':visible') ? false : true;

	jQuery('.shortcodes-container').slideUp();

	if (show) {
		next.slideDown();
	}
}

function selectVikBookingShortcode(record) {
	jQuery('.shortcode-record').removeClass('selected');
	jQuery(record).addClass('selected');

	jQuery('#vbo-tinymce-update button').prop('disabled', false);
}

function putVikBookingShortcode() {
	var shortcode = jQuery('.shortcode-record.selected').data('code');

	shortcodes_editor.execCommand('mceReplaceContent', false, shortcode);

	dismissVikBookingShortcodes();
}
