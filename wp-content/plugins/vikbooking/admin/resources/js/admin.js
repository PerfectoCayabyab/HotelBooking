/**
 * Callback used to post a survey form after clicking
 * a button contained within a RSS feed.
 *
 * @param 	mixed  button  The button element.
 *
 * @return 	boolean
 */
function vboRssSubmitSurvey(button) {
	// recover closest modal
	var modal = jQuery(button).closest('.modal[id^="jmodal"]');

	if (!modal.length) {
		// abort, modal not found
		return false;
	}

	// take form inside the modal
	var form = modal.find('form');

	if (!form.length) {
		// abort, no specified forms
		return false;
	}

	// retrieve feed ID from modal data
	var feedId = modal.attr('data-feed-id');
	var submitDate;

	if (typeof localStorage !== 'undefined') {
		// get submission date of the survey, if any
		submitDate = localStorage.getItem('vikbooking.rss.survey.' + feedId);
	}

	// disable button to avoid double submit
	jQuery(button).prop('disabled', true);

	// extract title from modal
	var subject = jQuery(modal).find('.modal-header h3').text().trim();

	// serialize form to array
	var data = form.serializeArray();
	// push subject within form
	data.push({name: 'subject', value: subject});

	// create request promise
	new Promise((resolve, reject) => {
		// check whether the feed ID has been already submitted
		if (submitDate) {
			reject('Survey already submitted on ' + submitDate);
			return false;
		}

		// make self AJAX request to post survey
		doAjax(
			'admin-ajax.php?action=vikbooking&task=feedback.survey',
			jQuery.param(data),
			function(resp) {
				resolve(resp);
			},
			function(err) {
				reject(err);
			}
		);
	}).then((data) => {
		if (typeof localStorage !== 'undefined') {
			// register survey within the pool to avoid several submissions
			localStorage.setItem('vikbooking.rss.survey.' + feedId, new Date().toUTCString());
		}
	}).catch((error) => {
		console.error(error);
	}).finally(() => {
		// look for a button to auto-dismiss the modal
		var closeBtn = modal.find('#rss-feed-dismiss');

		if (closeBtn.length) {
			// trigger click to dismiss the modal
			closeBtn.trigger('click');
		} else {
			// otherwise manually close the modal
			wpCloseJModal(modal.attr('id'));
		}
	});
}