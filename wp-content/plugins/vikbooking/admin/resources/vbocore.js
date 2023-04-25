/**
 * VikBooking Core v1.6.1
 * Copyright (C) 2023 E4J s.r.l. All Rights Reserved.
 * http://www.gnu.org/licenses/gpl-2.0.html GNU/GPL
 * https://vikwp.com | https://e4j.com | https://e4jconnect.com
 */
(function($, w) {
	'use strict';

	w['VBOCore'] = class VBOCore {

		/**
		 * Proxy to support static injection of params.
		 */
		constructor(params) {
			if (typeof params === 'object') {
				VBOCore.setOptions(params);
			}
		}

		/**
		 * Inject options by overriding default properties.
		 * 
		 * @param 	object 	params
		 * 
		 * @return 	self
		 */
		static setOptions(params) {
			if (typeof params === 'object') {
				VBOCore.options = Object.assign(VBOCore.options, params);
			}

			return VBOCore;
		}

		/**
		 * Getter for admin_widgets private options property.
		 * 
		 * @return 	array
		 */
		static get admin_widgets() {
			return VBOCore.options.admin_widgets;
		}

		/**
		 * Getter for multitask open event private property.
		 * 
		 * @return 	string
		 */
		static get multitask_open_event() {
			return VBOCore.options.multitask_open_event;
		}

		/**
		 * Getter for multitask close event private property.
		 * 
		 * @return 	string
		 */
		static get multitask_close_event() {
			return VBOCore.options.multitask_close_event;
		}

		/**
		 * Getter for multitask shortcut event private property.
		 * 
		 * @return 	string
		 */
		static get multitask_shortcut_event() {
			return VBOCore.options.multitask_shortcut_ev;
		}

		/**
		 * Getter for multitask seach focus shortcut event private property.
		 * 
		 * @return 	string
		 */
		static get multitask_searchfs_event() {
			return VBOCore.options.multitask_searchfs_ev;
		}

		/**
		 * Getter for multitask event widget modal rendered.
		 * 
		 * @return 	string
		 */
		static get widget_modal_rendered() {
			return VBOCore.options.widget_modal_rendered;
		}

		/**
		 * Getter for widget modal dismiss event.
		 * 
		 * @return 	string
		 */
		static get widget_modal_dismissed() {
			return VBOCore.options.widget_modal_dismissed;
		}

		/**
		 * Parses an AJAX response error object.
		 * 
		 * @param 	object  err
		 * 
		 * @return  bool
		 */
		static isConnectionLostError(err) {
			if (!err || !err.hasOwnProperty('status')) {
				return false;
			}

			return (
				err.statusText == 'error'
				&& err.status == 0
				&& (err.readyState == 0 || err.readyState == 4)
				&& (!err.hasOwnProperty('responseText') || err.responseText == '')
			);
		}

		/**
		 * Ensures AJAX requests that fail due to connection errors are retried automatically.
		 * 
		 * @param 	string  	url
		 * @param 	object 		data
		 * @param 	function 	success
		 * @param 	function 	failure
		 * @param 	number 		attempt
		 */
		static doAjax(url, data, success, failure, attempt) {
			const AJAX_MAX_ATTEMPTS = 3;

			if (attempt === undefined) {
				attempt = 1;
			}

			return $.ajax({
				type: 'POST',
				url: url,
				data: data
			}).done(function(resp) {
				if (success !== undefined) {
					// launch success callback function
					success(resp);
				}
			}).fail(function(err) {
				/**
				 * If the error is caused by a site connection lost, and if the number
				 * of retries is lower than max attempts, retry the same AJAX request.
				 */
				if (attempt < AJAX_MAX_ATTEMPTS && VBOCore.isConnectionLostError(err)) {
					// delay the retry by half second
					setTimeout(function() {
						// re-launch same request and increase number of attempts
						console.log('Retrying previous AJAX request');
						VBOCore.doAjax(url, data, success, failure, (attempt + 1));
					}, 500);
				} else {
					// launch the failure callback otherwise
					if (failure !== undefined) {
						failure(err);
					}
				}

				// always log the error in console
				console.log('AJAX request failed' + (err.status == 500 ? ' (' + err.responseText + ')' : ''), err);
			});
		}

		/**
		 * Matches a keyword against a text.
		 * 
		 * @param 	string 	search 	the keyword to search.
		 * @param 	string 	text 	the text to compare.
		 * 
		 * @return 	bool
		 */
		static matchString(search, text) {
			return ((text + '').indexOf(search) >= 0);
		}

		/**
		 * Initializes the multitasking panel for the admin widgets.
		 * 
		 * @param 	object 	params 	the panel object params.
		 * 
		 * @return 	bool
		 */
		static prepareMultitasking(params) {
			var panel_opts = {
				selector: 		 "",
				sclass_l_small:  "vbo-sidepanel-right",
				sclass_l_large:  "vbo-sidepanel-large",
				btn_trigger: 	 "",
				search_selector: "#vbo-sidepanel-search-input",
				search_nores: 	 ".vbo-sidepanel-add-widgets-nores",
				close_selector:  ".vbo-sidepanel-dismiss-btn",
				t_layout_small:	 ".vbo-sidepanel-layout-small",
				t_layout_large:  ".vbo-sidepanel-layout-large",
				wclass_base_sel: ".vbo-admin-widgets-widget-output",
				wclass_l_small:  "vbo-admin-widgets-container-small",
				wclass_l_large:  "vbo-admin-widgets-container-large",
				addws_selector:	 ".vbo-sidepanel-add-widgets",
				addw_selector:	 ".vbo-sidepanel-add-widget",
				addw_modal_cls:  "vbo-widget-render-modal",
				addwfs_selector: ".vbo-sidepanel-add-widget-focussed",
				wtags_selector:	 ".vbo-sidepanel-widget-tags",
				addw_data_attr:  "data-vbowidgetid",
				actws_selector:  ".vbo-sidepanel-active-widgets",
				editw_selector:  ".vbo-sidepanel-edit-widgets-trig",
				rmwidget_class:  "vbo-admin-widgets-widget-remove",
				rmwidget_icn: 	 "",
				dtcwidget_class: "vbo-admin-widgets-widget-detach",
				dtctarget_class: "vbo-admin-widget-head",
				dtcwidget_icn: 	 "",
				notif_selector:  ".vbo-sidepanel-notifications-btn",
				notif_on_class:  "vbo-sidepanel-notifications-on",
				notif_off_class: "vbo-sidepanel-notifications-off",
				open_class: 	 "vbo-sidepanel-open",
				close_class: 	 "vbo-sidepanel-close",
				cur_widget_cls:  "vbo-admin-widgets-container-small",
			};

			if (typeof params === 'object') {
				panel_opts = Object.assign(panel_opts, params);
			}

			if (!panel_opts.btn_trigger || !panel_opts.selector) {
				console.error('Got no trigger or selector');
				return false;
			}

			// push panel options
			VBOCore.setOptions({
				panel_opts: panel_opts,
			});

			// setup browser notifications
			VBOCore.setupNotifications();

			// count active widgets on current page
			var tot_active_widgets = VBOCore.options.admin_widgets.length;
			if (tot_active_widgets > 0) {
				// hide add-widgets container
				$(panel_opts.addws_selector).hide();

				// register listener for input search blur
				VBOCore.registerSearchWidgetsBlur();
			}

			// register click event on trigger button
			$(VBOCore.options.panel_opts.btn_trigger).on('click', function() {
				var side_panel = $(VBOCore.options.panel_opts.selector);
				if (side_panel.hasClass(VBOCore.options.panel_opts.open_class)) {
					// hide panel
					VBOCore.side_panel_on = false;
					VBOCore.emitMultitaskEvent(VBOCore.multitask_close_event);
					side_panel.addClass(VBOCore.options.panel_opts.close_class).removeClass(VBOCore.options.panel_opts.open_class);
					// always hide add-widgets container
					$(VBOCore.options.panel_opts.addws_selector).hide();
					// check if we are currently editing
					var is_editing = ($('.' + VBOCore.options.panel_opts.editmode_class).length > 0);
					if (is_editing) {
						// deactivate editing mode
						VBOCore.toggleWidgetsPanelEditing(null);
					}
				} else {
					// show panel
					VBOCore.side_panel_on = true;
					VBOCore.emitMultitaskEvent(VBOCore.multitask_open_event);
					side_panel.addClass(VBOCore.options.panel_opts.open_class).removeClass(VBOCore.options.panel_opts.close_class);
					if (!VBOCore.options.admin_widgets.length) {
						// set focus on search widgets input with delay for the opening animation
						setTimeout(function() {
							$(VBOCore.options.panel_opts.search_selector).focus();
						}, 300);
					}
				}
			});

			// register close/dismiss button
			$(VBOCore.options.panel_opts.close_selector).on('click', function() {
				$(VBOCore.options.panel_opts.btn_trigger).trigger('click');
			});

			// register toggle layout buttons
			$(VBOCore.options.panel_opts.t_layout_large).on('click', function() {
				// large layout
				$(VBOCore.options.panel_opts.selector).addClass(VBOCore.options.panel_opts.sclass_l_large).removeClass(VBOCore.options.panel_opts.sclass_l_small);
				$(VBOCore.options.panel_opts.wclass_base_sel).addClass(VBOCore.options.panel_opts.wclass_l_large).removeClass(VBOCore.options.panel_opts.wclass_l_small);
				VBOCore.options.panel_opts.cur_widget_cls = VBOCore.options.panel_opts.sclass_l_large;
			});
			$(VBOCore.options.panel_opts.t_layout_small).on('click', function() {
				// small layout
				$(VBOCore.options.panel_opts.selector).addClass(VBOCore.options.panel_opts.sclass_l_small).removeClass(VBOCore.options.panel_opts.sclass_l_large);
				$(VBOCore.options.panel_opts.wclass_base_sel).addClass(VBOCore.options.panel_opts.wclass_l_small).removeClass(VBOCore.options.panel_opts.wclass_l_large);
				VBOCore.options.panel_opts.cur_widget_cls = VBOCore.options.panel_opts.sclass_l_small;
			});

			// register listener for esc key pressed
			$(document).keyup(function(e) {
				if (!VBOCore.side_panel_on) {
					return;
				}
				if ((e.key && e.key === "Escape") || (e.keyCode && e.keyCode == 27)) {
					$(VBOCore.options.panel_opts.btn_trigger).trigger('click');
				}
			});

			// register listener for input search focus
			$(VBOCore.options.panel_opts.search_selector).on('focus', function() {
				// always show add-widgets container
				var widget_focus_class = VBOCore.options.panel_opts.addwfs_selector.replace('.', '');
				$(VBOCore.options.panel_opts.addw_selector).removeClass(widget_focus_class);
				$(VBOCore.options.panel_opts.addws_selector).show();
			});

			// register listener on input search widget
			$(VBOCore.options.panel_opts.search_selector).keyup(function(e) {
				// get the keyword to look for
				var keyword = $(this).val();
				// counting matching widgets
				var matching = 0;
				var first_matched = null;
				var widget_focus_class = VBOCore.options.panel_opts.addwfs_selector.replace('.', '');

				// adjust widgets to be displayed
				if (!keyword.length) {
					// show all widgets for selection
					$(VBOCore.options.panel_opts.addw_selector).show();
					// hide "no results"
					$(VBOCore.options.panel_opts.search_nores).hide();
					// all widgets are matching
					matching = $(VBOCore.options.panel_opts.addw_selector).length;
				} else {
					// make the keyword lowercase
					keyword = (keyword + '').toLowerCase();
					// parse all widget's description tags
					$(VBOCore.options.panel_opts.addw_selector).each(function() {
						var elem  = $(this);
						var descr = elem.find(VBOCore.options.panel_opts.wtags_selector).text();
						if (VBOCore.matchString(keyword, descr)) {
							elem.show();
							matching++;
							if (!first_matched) {
								// store the first widget that matched
								first_matched = elem.attr(VBOCore.options.panel_opts.addw_data_attr);
							}
						} else {
							elem.hide();
						}
					});
					// check how many widget matched
					if (matching > 0) {
						// hide "no results"
						$(VBOCore.options.panel_opts.search_nores).hide();
					} else {
						// show "no results"
						$(VBOCore.options.panel_opts.search_nores).show();
					}
				}

				// check for shortcuts
				if (!e.key) {
					return;
				}

				// handle Enter key press to add a widget
				if (e.key === "Enter") {
					// on Enter key pressed, add the first matching widget or the focussed one
					var load_wid_id  = null;
					var focussed_wid = $(VBOCore.options.panel_opts.addwfs_selector + ':visible').first();

					if (focussed_wid.length) {
						load_wid_id = focussed_wid.attr(VBOCore.options.panel_opts.addw_data_attr);
					} else if (first_matched) {
						load_wid_id = first_matched;
					}

					if (!load_wid_id) {
						// no widget to render found
						return;
					}

					if (e.shiftKey === true) {
						// widget modal rendering
						VBOCore.renderModalWidget(load_wid_id);

						return;
					}

					// widget multitask panel rendering
					VBOCore.addWidgetToPanel(load_wid_id);
					$(VBOCore.options.panel_opts.search_selector).trigger('blur');

					return;
				}

				// handle arrow keys selection
				if (matching > 0 && (e.key === 'ArrowDown' || e.key === 'ArrowUp')) {
					// on arrow key pressed, select the next or prev widget
					var addws_element  = $(VBOCore.options.panel_opts.addws_selector);
					var addws_cont_pos = addws_element.offset().top;
					var addws_otheight = addws_element.outerHeight();
					var addws_scrolltp = addws_element.scrollTop();

					if (e.key === 'ArrowDown') {
						var default_widg = $(VBOCore.options.panel_opts.addw_selector + ':visible').first();
					} else {
						var default_widg = $(VBOCore.options.panel_opts.addw_selector + ':visible').last();
					}
					var focussed_wid = $(VBOCore.options.panel_opts.addwfs_selector + ':visible').first();
					var addw_height  = default_widg.outerHeight();
					var focussed_pos = default_widg.offset().top + addw_height;

					if (focussed_wid.length) {
						focussed_wid.removeClass(widget_focus_class);
						if (e.key === 'ArrowDown') {
							var goto_wid = focussed_wid.nextAll(VBOCore.options.panel_opts.addw_selector + ':visible').first();
						} else {
							var goto_wid = focussed_wid.prevAll(VBOCore.options.panel_opts.addw_selector + ':visible').first();
						}
						if (goto_wid.length) {
							goto_wid.addClass(widget_focus_class);
							focussed_pos = goto_wid.offset().top + addw_height;
						} else {
							default_widg.addClass(widget_focus_class);
						}
					} else {
						default_widg.addClass(widget_focus_class);
					}

					if (focussed_pos > (addws_cont_pos + addws_otheight)) {
						addws_element.scrollTop(focussed_pos - addws_cont_pos - addw_height + addws_scrolltp);
					} else if (focussed_pos < 0) {
						addws_element.scrollTop(0);
					}
				}
			});

			// register listener for adding widgets
			$(VBOCore.options.panel_opts.addw_selector).on('click', function(e) {
				var widget_id = $(this).attr(VBOCore.options.panel_opts.addw_data_attr);
				if (!widget_id || !widget_id.length) {
					return false;
				}

				// determine widget rendering method
				if (e && e.target) {
					let cktarget = $(e.target);
					if (e.shiftKey === true || (cktarget.hasClass(VBOCore.options.panel_opts.addw_modal_cls) || cktarget.parent().hasClass(VBOCore.options.panel_opts.addw_modal_cls))) {
						// widget modal rendering
						VBOCore.renderModalWidget(widget_id);

						return;
					}
				}

				// widget multitask panel rendering
				VBOCore.addWidgetToPanel(widget_id);
			});

			// register listener for updating multitask sidepanel with debounce
			document.addEventListener(VBOCore.options.multitask_save_event, VBOCore.debounceEvent(VBOCore.saveMultitasking, 1000));

			// subscribe to event for multitask shortcut
			document.addEventListener(VBOCore.multitask_shortcut_event, function() {
				// toggle multitask panel
				$(VBOCore.options.panel_opts.btn_trigger).trigger('click');
			});

			// subscribe to event for multitask search focus shortcut
			document.addEventListener(VBOCore.multitask_searchfs_event, function() {
				// focus search multitask widgets
				$(VBOCore.options.panel_opts.search_selector).trigger('focus');
			});

			// register click event on edit widgets button
			$(VBOCore.options.panel_opts.editw_selector).on('click', function() {
				VBOCore.toggleWidgetsPanelEditing(null);
			});

			// register detach widget buttons
			$('.' + VBOCore.options.panel_opts.dtcwidget_class).each(function() {
				let widget_wrapper 	 = $(this).parent(VBOCore.options.panel_opts.wclass_base_sel);
				let detach_widget_id = widget_wrapper.attr(VBOCore.options.panel_opts.addw_data_attr);
				let detach_to_target = widget_wrapper.find('.' + VBOCore.options.panel_opts.dtctarget_class);
				if (detach_to_target.length) {
					// move detach wrapper onto the target (widget head)
					$(this).prependTo(detach_to_target);
				}

				if (!detach_widget_id) {
					return;
				}

				// register detach action
				$(this).on('click', function() {
					// detach widget, meaning do a modal rendering
					VBOCore.renderModalWidget(detach_widget_id);
				});
			});
		}

		/**
		 * Registers the blur event for the search widgets input.
		 */
		static registerSearchWidgetsBlur() {
			if (VBOCore.options.active_listeners.hasOwnProperty('registerSearchWidgetsBlur')) {
				// listener is already registered
				return true;
			}

			$(VBOCore.options.panel_opts.search_selector).on('blur', function(e) {
				if (e && e.relatedTarget) {
					if (e.relatedTarget.classList.contains(VBOCore.options.panel_opts.addw_selector.replace('.', ''))) {
						// add new widget was clicked, abort hiding process or click event won't fire on target element
						return;
					}
				}
				var keyword = $(this).val();
				if (!keyword.length) {
					// hide add-widgets container
					$(VBOCore.options.panel_opts.addws_selector).hide();
				}
			});

			// register flag for listener active
			VBOCore.options.active_listeners['registerSearchWidgetsBlur'] = 1;
		}

		/**
		 * Removes the blur event handler for the search widgets input.
		 */
		static unregisterSearchWidgetsBlur() {
			if (!VBOCore.options.active_listeners.hasOwnProperty('registerSearchWidgetsBlur')) {
				// nothing to unregister
				return true;
			}

			$(VBOCore.options.panel_opts.search_selector).off('blur');

			// delete flag for listener active
			delete VBOCore.options.active_listeners['registerSearchWidgetsBlur'];
		}

		/**
		 * Adds a widget identifier to the multitask panel.
		 * 
		 * @param 	string 	widget_id 	the widget identifier string to add.
		 */
		static addWidgetToPanel(widget_id) {
			if (!VBOCore.options.widget_ajax_uri || !VBOCore.options.panel_opts || !Object.keys(VBOCore.options.panel_opts).length) {
				throw new Error('Multitask panel options are missing');
			}
			// prepend container to panel
			var widget_classes = [VBOCore.options.panel_opts.wclass_base_sel.replace('.', ''), VBOCore.options.panel_opts.cur_widget_cls];
			var widget_div = '<div class="' + widget_classes.join(' ') + '" ' + VBOCore.options.panel_opts.addw_data_attr + '="' + widget_id + '" style="display: none;"></div>';
			var widget_elem = $(widget_div);
			$(VBOCore.options.panel_opts.actws_selector).prepend(widget_elem);

			// always hide add-widgets container
			$(VBOCore.options.panel_opts.addws_selector).hide();

			// trigger debounced map saving event
			VBOCore.emitMultitaskEvent();

			// register listener for input search blur
			VBOCore.registerSearchWidgetsBlur();

			// render widget
			var call_method = 'render';
			VBOCore.doAjax(
				VBOCore.options.widget_ajax_uri,
				{
					widget_id: widget_id,
					call: 	   call_method,
					vbo_page:  VBOCore.options.current_page,
					vbo_uri:   VBOCore.options.current_page_uri,
					multitask: 1,
				},
				(response) => {
					// display widgets editing button
					VBOCore.toggleWidgetsPanelEditing(true);
					// parse response
					try {
						var obj_res = typeof response === 'string' ? JSON.parse(response) : response;
						if (obj_res.hasOwnProperty(call_method)) {
							// populate widget HTML content and display it
							widget_elem.html(obj_res[call_method]).fadeIn();

							// always scroll active widgets list to top
							$(VBOCore.options.panel_opts.actws_selector).scrollTop(0);

							// register detach widget button
							setTimeout(() => {
								let detach_elem = $('<div></div>').addClass(VBOCore.options.panel_opts.dtcwidget_class).html(VBOCore.options.panel_opts.dtcwidget_icn);
								let detach_to_target = widget_elem.find('.' + VBOCore.options.panel_opts.dtctarget_class);
								if (detach_to_target.length) {
									// move detach wrapper onto the target (widget head)
									detach_elem.prependTo(detach_to_target);
								}
								// register detach action
								detach_elem.on('click', function() {
									// detach widget, meaning do a modal rendering
									VBOCore.renderModalWidget(widget_id);
								});
							}, 500);
						} else {
							console.error('Unexpected JSON response', obj_res);
						}
					} catch(err) {
						console.error('could not parse JSON response', err, response);
					}
				},
				(error) => {
					console.error(error.responseText);
				}
			);
		}

		/**
		 * Toggles the edit mode of the multitask widgets panel.
		 * 
		 * @param 	bool 	added 	true if a widget was just added, false if it was just removed.
		 */
		static toggleWidgetsPanelEditing(added) {
			// check if we are currently editing
			var is_editing = ($('.' + VBOCore.options.panel_opts.editmode_class).length > 0);

			// the triggerer button
			var triggerer = $(VBOCore.options.panel_opts.editw_selector);

			// check added action status
			if (added === true) {
				// show button for edit mode
				triggerer.show();
				return;
			}

			// grab all widgets
			var editing_widgets = $(VBOCore.options.panel_opts.wclass_base_sel);

			if (added === false) {
				if (!editing_widgets.length) {
					// hide button for edit mode after removing the last widget
					triggerer.hide();
				}
				return;
			}

			if (is_editing) {
				// deactivate editing mode
				editing_widgets.removeClass(VBOCore.options.panel_opts.editmode_class);
				$('.' + VBOCore.options.panel_opts.rmwidget_class).remove();
				// toggle triggerer button active class
				triggerer.removeClass(VBOCore.options.panel_opts.editw_selector.substr(1) + '-active');
			} else {
				// activate editing mode by looping through all widgets
				editing_widgets.each(function() {
					// build remove-widget element
					var rm_widget = $('<div></div>').addClass(VBOCore.options.panel_opts.rmwidget_class).on('click', function() {
						VBOCore.removeWidgetFromPanel(this);
					}).html(VBOCore.options.panel_opts.rmwidget_icn);
					// add editing class and prepend removing element
					$(this).addClass(VBOCore.options.panel_opts.editmode_class).prepend(rm_widget);
				});
				// toggle triggerer button active class
				triggerer.addClass(VBOCore.options.panel_opts.editw_selector.substr(1) + '-active');
			}
		}

		/**
		 * Handles the removal of a widget from the multitask panel.
		 * 
		 * @param 	object 	element
		 */
		static removeWidgetFromPanel(element) {
			if (!element) {
				console.error('Invalid widget element to remove', element);
				return false;
			}
			var widget_cont = $(element).parent(VBOCore.options.panel_opts.wclass_base_sel);
			if (!widget_cont || !widget_cont.length) {
				console.error('Could not find widget container to remove', element);
				return false;
			}
			var widget_id = widget_cont.attr(VBOCore.options.panel_opts.addw_data_attr);
			if (!widget_id || !widget_id.length) {
				console.error('Empty widget id to remove', element);
				return false;
			}
			// find the index of the widget to remove in the panel
			var widget_index = $(VBOCore.options.panel_opts.wclass_base_sel).index(widget_cont);
			if (widget_index < 0) {
				console.error('Empty widget index to remove', widget_cont);
				return false;
			}
			// make sure the index in the array matches the id
			if (!VBOCore.options.admin_widgets.hasOwnProperty(widget_index) || VBOCore.options.admin_widgets[widget_index]['id'] != widget_id) {
				console.error('Unmatching widget index or id', VBOCore.options.admin_widgets, widget_index, widget_id);
				return false;
			}
			// remove this widget from the array
			VBOCore.options.admin_widgets.splice(widget_index, 1);

			// remove element from document
			widget_cont.remove();

			// check widgets editing button status
			VBOCore.toggleWidgetsPanelEditing(false);

			// trigger debounced map saving event
			VBOCore.emitMultitaskEvent();

			if (!VBOCore.options.admin_widgets.length) {
				// unregister listener for input search blur
				VBOCore.unregisterSearchWidgetsBlur();
			}
		}

		/**
		 * Emits an event related to the multitask features or a custom event, with optional data.
		 */
		static emitMultitaskEvent(ev_name, ev_data) {
			var def_ev_name = VBOCore.options.multitask_save_event;
			if (typeof ev_name === 'string') {
				def_ev_name = ev_name;
			}

			if (typeof ev_data !== 'undefined' && ev_data) {
				// trigger the custom event
				document.dispatchEvent(new CustomEvent(def_ev_name, {bubbles: true, detail: ev_data}));
				return;
			}

			// trigger the event
			document.dispatchEvent(new Event(def_ev_name));
		}

		/**
		 * Proxy for dispatching an event to the document with optional data.
		 */
		static emitEvent(ev_name, ev_data) {
			if (typeof ev_name !== 'string' || !ev_name.length) {
				return;
			}

			return VBOCore.emitMultitaskEvent(ev_name, ev_data);
		}

		/**
		 * Attempts to save the multitask widgets for this page.
		 */
		static saveMultitasking() {
			// gather the list of active widgets
			var active_widgets = [];
			var cur_admin_widgets = [];
			$(VBOCore.options.panel_opts.actws_selector).find(VBOCore.options.panel_opts.wclass_base_sel).each(function() {
				var widget_id = $(this).attr(VBOCore.options.panel_opts.addw_data_attr);
				if (widget_id && widget_id.length) {
					// push id in list
					active_widgets.push(widget_id);
					// push object with dummy name for global widgets
					cur_admin_widgets.push({
						id: widget_id,
						name: widget_id,
					});
				}
			});

			// update multitask widgets map for this page
			VBOCore.doAjax(
				VBOCore.options.multitask_ajax_uri,
				{
					call: 'updateMultitaskingMap',
					call_args: [
						VBOCore.options.current_page,
						active_widgets,
						0
					],
				},
				(response) => {
					try {
						var obj_res = typeof response === 'string' ? JSON.parse(response) : response;
						if (obj_res.hasOwnProperty('result') && obj_res['result']) {
							// set current widgets
							VBOCore.setOptions({
								admin_widgets: cur_admin_widgets
							});
						} else {
							console.error('Unexpected or invalid JSON response', response);
						}
					} catch(err) {
						console.error('could not parse JSON response', err, response);
					}
				},
				(error) => {
					console.error(error.responseText);
				}
			);
		}

		/**
		 * Sets up the browser notifications within the multitask panel, if supported.
		 */
		static setupNotifications() {
			if (!('Notification' in window)) {
				// browser does not support notifications
				$(VBOCore.options.panel_opts.notif_selector).hide();
				return false;
			}

			if (Notification.permission && Notification.permission === 'granted') {
				// permissions were granted already
				$(VBOCore.options.panel_opts.notif_selector)
					.addClass(VBOCore.options.panel_opts.notif_on_class)
					.attr('title', VBOCore.options.tn_texts.notifs_enabled);
				return true;
			}

			// notifications supported, but perms not granted
			$(VBOCore.options.panel_opts.notif_selector)
				.addClass(VBOCore.options.panel_opts.notif_off_class)
				.attr('title', VBOCore.options.tn_texts.notifs_disabled);

			// register click-event listener on button to enable notifications
			$(VBOCore.options.panel_opts.notif_selector).on('click', function() {
				VBOCore.requestNotifPerms();
			});

			// subscribe to the multitask-panel-open event to show the status of the notifications
			document.addEventListener(VBOCore.multitask_open_event, function() {
				if (VBOCore.notificationsEnabled() === false) {
					// add "shaking" class to notifications button
					$(VBOCore.options.panel_opts.notif_selector).addClass('shaking');
				}
			});

			// subscribe to the multitask-panel-close event to update the status of the notifications
			document.addEventListener(VBOCore.multitask_close_event, function() {
				// always remove "shaking" class from notifications button
				$(VBOCore.options.panel_opts.notif_selector).removeClass('shaking');
			});
		}

		/**
		 * Sets up the browser notifications within the given selector, if supported.
		 * 
		 * @param 	string 	selector 	the element query selector.
		 */
		static suggestNotifications(selector) {
			if (!selector) {
				return false;
			}

			if (!('Notification' in window)) {
				// browser does not support notifications
				$(selector).hide();
				return false;
			}

			if (Notification.permission && Notification.permission === 'granted') {
				// permissions were granted already
				$(selector)
					.addClass(VBOCore.options.panel_opts.notif_on_class)
					.attr('title', VBOCore.options.tn_texts.notifs_enabled);
				return true;
			}

			// notifications supported, but perms not granted
			$(selector)
				.addClass(VBOCore.options.panel_opts.notif_off_class)
				.attr('title', VBOCore.options.tn_texts.notifs_disabled);

			// register click-event listener on button to enable notifications
			$(selector).on('click', function() {
				VBOCore.requestNotifPerms(selector);
			});

			// add "shaking" class to make the selector more appealing
			$(selector).addClass('shaking');

			// remove the "shaking" class after some time
			setTimeout(() => {
				$(selector).removeClass('shaking');
			}, 2000);
		}

		/**
		 * Tells whether the notifications are enabled, disabled, not supported.
		 */
		static notificationsEnabled() {
			if (!('Notification' in window)) {
				// not supported
				return null;
			}

			if (Notification.permission && Notification.permission === 'granted') {
				// enabled
				return true;
			}

			// disabled
			return false;
		}

		/**
		 * Attempts to request the notifications permissions to the browser.
		 * For security reasons, this should run upon a user gesture (click).
		 * 
		 * @param 	string 	selector 	optional element query selector.
		 */
		static requestNotifPerms(selector) {
			if (!('Notification' in window)) {
				// browser does not support notifications
				return false;
			}

			// run permissions request in a try-catch statement to support all browsers
			try {
				// handle promise-based version to request permissions
				Notification.requestPermission().then((permission) => {
					VBOCore.handleNotifPerms(permission, selector);
				});
			} catch(e) {
				// run the callback-based version
				Notification.requestPermission(function(permission) {
					VBOCore.handleNotifPerms(permission, selector);
				});
			}
		}

		/**
		 * Handles the notifications permission response (from callback or promise resolved).
		 * 
		 * @param 	string 	selector 	optional element query selector.
		 */
		static handleNotifPerms(permission, selector) {
			// check the permission status from the Notification object interface
			if ((Notification.permission && Notification.permission === 'granted') || (typeof permission === 'string' && permission === 'granted')) {
				// permissions granted!
				$((selector || VBOCore.options.panel_opts.notif_selector))
					.removeClass(VBOCore.options.panel_opts.notif_off_class)
					.addClass(VBOCore.options.panel_opts.notif_on_class)
					.attr('title', VBOCore.options.tn_texts.notifs_enabled);

				// dispatch an immediate notification to congratulate with the activation
				let notif = new Notification(VBOCore.options.tn_texts.congrats, {
					body: VBOCore.options.tn_texts.notifs_enabled,
					tag:  'vbo_notification_congrats'
				});

				return true;
			} else {
				// permissions denied :(
				$((selector || VBOCore.options.panel_opts.notif_selector))
					.removeClass(VBOCore.options.panel_opts.notif_on_class)
					.addClass(VBOCore.options.panel_opts.notif_off_class)
					.attr('title', VBOCore.options.tn_texts.notifs_disabled);

				// show alert message
				console.error('Permission denied for enabling browser notifications', permission);
				alert(VBOCore.options.tn_texts.notifs_disabled_help);
			}

			return false;
		}

		/**
		 * Given a date-time string, returns a Date object representation.
		 * 
		 * @param 	string 	dtime_str 	the date-time string in "Y-m-d H:i:s" format.
		 */
		static getDateTimeObject(dtime_str) {
			// instantiate a new date object
			var date_obj = new Date();

			// parse date-time string
			let dtime_parts = dtime_str.split(' ');
			let date_parts  = dtime_parts[0].split('-');
			if (dtime_parts.length != 2 || date_parts.length != 3) {
				// invalid military format
				return date_obj;
			}
			let time_parts = dtime_parts[1].split(':');

			// set accurate date-time values
			date_obj.setFullYear(date_parts[0]);
			date_obj.setMonth((parseInt(date_parts[1]) - 1));
			date_obj.setDate(parseInt(date_parts[2]));
			date_obj.setHours(parseInt(time_parts[0]));
			date_obj.setMinutes(parseInt(time_parts[1]));
			date_obj.setSeconds(0);
			date_obj.setMilliseconds(0);

			// return the accurate date object
			return date_obj;
		}

		/**
		 * Given a list of schedules, enqueues notifications to watch.
		 * 
		 * @param 	array|object 	schedules 	list of or one notification object(s).
		 * 
		 * @return 	bool
		 */
		static enqueueNotifications(schedules) {
			if (!Array.isArray(schedules) || !schedules.length) {
				if (typeof schedules === 'object' && schedules.hasOwnProperty('dtime')) {
					// convert the single schedule to an array
					schedules = [schedules];
				} else {
					// invalid argument passed
					return false;
				}
			}

			for (var i in schedules) {
				if (!schedules.hasOwnProperty(i) || typeof schedules[i] !== 'object') {
					continue;
				}
				VBOCore.notifications.push(schedules[i]);
			}

			// setup the timeouts to schedule the notifications
			return VBOCore.scheduleNotifications();
		}

		/**
		 * Schedule the trigger timings for each notification.
		 */
		static scheduleNotifications() {
			if (!VBOCore.notifications.length) {
				// no notifications to be scheduled
				return false;
			}
			if (VBOCore.notificationsEnabled() !== true) {
				// notifications not enabled
				console.info('Browser notifications disabled or unsupported.');
			}

			// gather current date-timing information
			const now_date = new Date();
			const now_time = now_date.getTime();

			// parse all notifications to schedule the timers if not set
			for (let i = 0; i < VBOCore.notifications.length; i++) {
				let notif = VBOCore.notifications[i];

				if (typeof notif !== 'object' || !notif.hasOwnProperty('dtime')) {
					// invalid notification object, unset it
					VBOCore.notifications.splice(i, 1);
					continue;
				}

				// check if timer has been set
				if (!notif.hasOwnProperty('id_timer')) {
					// estimate trigger timing
					let in_ms = 0;
					// check for imminent notifications
					if (typeof notif.dtime === 'string' && notif.dtime.indexOf('now') >= 0) {
						// imminent ones will be delayed by one second
						in_ms = 1000;
					} else {
						// check overdue date-time (notif.dtime can also be a Date object instance)
						let nexp = VBOCore.getDateTimeObject(notif.dtime);
						in_ms = nexp.getTime() - now_time;
					}
					if (in_ms > 0) {
						// schedule notification trigger
						let id_timer = setTimeout(() => {
							VBOCore.dispatchNotification(notif);
						}, in_ms);
						// set timer on notification object
						VBOCore.notifications[i]['id_timer'] = id_timer;
					}
				}
			}

			return true;
		}

		/**
		 * Deregister all scheduled notifications.
		 */
		static unscheduleNotifications() {
			if (!VBOCore.notifications.length) {
				// no notifications scheduled
				return false;
			}

			for (let i = 0; i < VBOCore.notifications.length; i++) {
				let notif = VBOCore.notifications[i];

				if (typeof notif === 'object' && notif.hasOwnProperty('id_timer')) {
					// unset timeout for this notification
					clearTimeout(notif['id_timer']);
				}
			}

			// reset pool
			VBOCore.notifications = [];
		}

		/**
		 * Update or delete a previously scheduled notification.
		 * 
		 * @param 	object 			match_props  map of properties to match.
		 * @param 	string|number  	newdtime 	 the new date time to schedule (0 for deleting).
		 * 
		 * @return 	null|bool 					 true only if a notification matched.
		 */
		static updateNotification(match_props, newdtime) {
			if (!VBOCore.notifications.length) {
				// no notifications set, terminate
				return null;
			}

			if (typeof match_props !== 'object') {
				// no properties to match the notification
				return null;
			}

			// gather current date-timing information
			const now_date = new Date();
			const now_time = now_date.getTime();

			// parse all notifications scheduled
			for (let i = 0; i < VBOCore.notifications.length; i++) {
				let notif = VBOCore.notifications[i];

				let all_matched = true;
				let to_matching = false;
				for (let prop in match_props) {
					if (!match_props.hasOwnProperty(prop)) {
						continue;
					}
					to_matching = true;
					if (!notif.hasOwnProperty(prop) || notif[prop] != match_props[prop]) {
						all_matched = false;
						break;
					}
				}

				if (all_matched && to_matching) {
					// notification object found
					if (notif.hasOwnProperty('id_timer')) {
						// unset previous timeout for this notification
						clearTimeout(notif['id_timer']);
					}
					// update or delete scheduled notification
					if (newdtime === 0) {
						// delete notification from queue
						VBOCore.notifications.splice(i, 1);
					} else {
						// update timing scheduler
						let in_ms = 0;
						// check for imminent notifications
						if (typeof newdtime === 'string' && newdtime.indexOf('now') >= 0) {
							// imminent ones will be delayed by one second
							in_ms = 1000;
						} else {
							// check overdue date-time (newdtime can also be a Date object instance)
							let nexp = VBOCore.getDateTimeObject(newdtime);
							in_ms = nexp.getTime() - now_time;
						}
						if (in_ms > 0) {
							// schedule notification trigger
							let id_timer = setTimeout(() => {
								VBOCore.dispatchNotification(notif);
							}, in_ms);
							// set timer on notification object
							VBOCore.notifications[i]['id_timer'] = id_timer;
						}
						// update date-time value on notification object
						VBOCore.notifications[i]['dtime'] = newdtime;
					}

					// terminate parsing and return true
					return true;
				}
			}

			// notification object not found
			return false;
		}

		/**
		 * Dispatch the notification object.
		 * Expected notification properties:
		 * 
		 * {
		 *		id: 		number
		 * 		type: 		string
		 * 		dtime: 		string|Date
		 *		build_url: 	string|null
		 * }
		 * 
		 * @param 	object 	notif 	the notification object.
		 */
		static dispatchNotification(notif) {
			if (typeof notif !== 'object') {
				return false;
			}

			// subscribe to building notification data
			VBOCore.buildNotificationData(notif).then((data) => {
				// dispatch the notification

				// check if the click event should be registered
				let func_nodes;
				if (data.onclick && typeof data.onclick === 'string') {
					let callback_parts = data.onclick.split('.');
					while (callback_parts.length) {
						// compose window static method string to avoid using eval()
						let tmp = callback_parts.shift();
						if (!func_nodes) {
							func_nodes = window[tmp];
						} else {
							func_nodes = func_nodes[tmp];
						}
					}
				}

				// prepare properties to delete the notification from queue
				let match_props = {};
				for (let prop in notif) {
					if (!notif.hasOwnProperty(prop) || prop == 'id_timer') {
						continue;
					}
					match_props[prop] = notif[prop];
				}

				// check browser Notifications API
				if (VBOCore.notificationsEnabled() !== true) {
					// notifications not enabled, fallback to toast message
					let toast_notif_data = {
						title: 	data.title,
						body:  	data.message,
						icon:  	data.icon,
						delay: 	{
							min: 6000,
							max: 20000,
							tolerance: 4000,
						},
						action: () => {
							VBOToast.dispose(true);
						},
						sound: VBOCore.options.notif_audio_url
					};
					if (func_nodes) {
						toast_notif_data.action = function() {
							func_nodes(data);
						};
					} else if (typeof data.onclick === 'function') {
						toast_notif_data.action = function() {
							data.onclick.call(data);
						};
					}
					VBOToast.enqueue(new VBOToastMessage(toast_notif_data));

					// delete dispatched notification from queue
					VBOCore.updateNotification(match_props, 0);

					return;
				}

				// use the browser's native Notifications API
				let browser_notif = new Notification(data.title, {
					body: data.message,
					icon: data.icon,
					tag:  'vbo_notification'
				});

				if (func_nodes) {
					// register notification click event
					browser_notif.addEventListener('click', () => {
						func_nodes(data);
					});
				} else if (typeof data.onclick === 'function') {
					browser_notif.addEventListener('click', () => {
						data.onclick.call(data);
					});
				}

				// delete dispatched notification from queue
				VBOCore.updateNotification(match_props, 0);

			}).catch((error) => {
				console.error(error);
			});
		}

		/**
		 * Asynchronous build of the notification data object for dispatch.
		 * Minimum expected notification display data properties:
		 * 
		 * {
		 *		title: 	 string
		 * 		message: string
		 * 		icon: 	 string
		 *		onclick: function
		 * }
		 * 
		 * @param 	object 	notif 	the scheduled notification object.
		 * 
		 * @return 	Promise
		 */
		static buildNotificationData(notif) {
			return new Promise((resolve, reject) => {
				// notification object validation
				if (typeof notif !== 'object') {
					reject('Invalid notification object');
					return;
				}

				if (!notif.hasOwnProperty('build_url') || !notif.build_url) {
					// building callback not necessary
					if (!notif.title && !notif.message) {
						reject('Unexpected notification object');
						return;
					}
					// we expect the notification to be built already
					resolve(notif);
					return;
				}

				// build the notification data
				VBOCore.doAjax(
					notif.build_url,
					{
						payload: JSON.stringify(notif)
					},
					(response) => {
						// parse response
						try {
							var obj_res = typeof response === 'string' ? JSON.parse(response) : response;
							if (obj_res.hasOwnProperty('title')) {
								resolve(obj_res);
							} else {
								reject('Unexpected JSON response');
							}
						} catch(err) {
							reject('could not parse JSON response');
						}
					},
					(error) => {
						reject(error.responseText);
					}
				);
			});
		}

		/**
		 * Handle a navigation towards a given URL.
		 * Common handler for browser notifications click.
		 * 
		 * @param 	object 	data 	notification display data payload.
		 */
		static handleGoto(data) {
			if (typeof data !== 'object' || !data.hasOwnProperty('gotourl') || !data.gotourl) {
				console.error('Could not handle the goto operation', data);
				return;
			}

			if (typeof data.openWindow !== 'undefined' || typeof document === 'undefined') {
				// open a new window
				window.open(data.gotourl);
				return;
			}

			// redirect
			document.location.href = data.gotourl;
		}

		/**
		 * Handle the display of a notification through a widget.
		 * Common handler for browser notifications displayed through
		 * a widget modal rendering.
		 * 
		 * @param 	object 	data 	notification display data payload.
		 */
		static handleDisplayWidgetNotification(data) {
			try {
				// validate handler
				if (!VBOCore.options.is_vbo && !VBOCore.options.is_vcm) {
					throw new Error('Vik Booking must handle this');
				}

				// validate payload
				if (typeof data !== 'object' || !data.hasOwnProperty('widget_id') || !data['widget_id']) {
					throw new Error('Invalid widget payload');
				}

				// parse handler
				if (VBOCore.options.is_vcm) {
					// the operation is handled by Vik Channel Manager
					VBOCore.loadAdminWidgetAssets(data).then((assets) => {
						// append assets to DOM
						assets.forEach((asset) => {
							if (!$('link#' + asset['id']).length) {
								$('head').append('<link rel="stylesheet" id="' + asset['id'] + '" href="' + asset['href'] + '" media="all" />');
							}
						});
						// widget modal rendering handled by Vik Channel Manager
						let modal_data = VBOCore.renderModalWidget(data['widget_id'], data, false);
						if (modal_data.hasOwnProperty('dismissed_event')) {
							// register event to unload all assets
							document.addEventListener(modal_data['dismissed_event'], () => {
								assets.forEach((asset) => {
									if ($('link#' + asset['id']).length) {
										$('link#' + asset['id']).remove();
									}
								});
							});
						}
					}).catch((error) => {
						throw new Error(error);
					});
				} else {
					// widget modal rendering handled by Vik Booking
					VBOCore.renderModalWidget(data['widget_id'], data, false);
				}
			} catch(e) {
				// fallback to a regular link
				VBOCore.handleGoto(data);
			}
		}

		/**
		 * Asynchronous loading of CSS assets required to render
		 * an admin widget outside Vik Booking.
		 * 
		 * @param 	object 	data 	the optional widget payload data.
		 * 
		 * @return 	Promise
		 */
		static loadAdminWidgetAssets(data) {
			return new Promise((resolve, reject) => {
				// the remote assets URI must be set
				if (!VBOCore.options.assets_ajax_uri) {
					reject('Missing remote assets URI');
					return;
				}

				if (typeof data !== 'object') {
					data = {};
				}

				// make the request
				VBOCore.doAjax(
					VBOCore.options.assets_ajax_uri,
					data,
					(response) => {
						// parse response
						try {
							var obj_res = typeof response === 'string' ? JSON.parse(response) : response;
							if (!Array.isArray(obj_res)) {
								reject('Unexpected JSON response');
							}
							resolve(obj_res);
						} catch(err) {
							reject('could not parse JSON response');
						}
					},
					(error) => {
						reject(error.responseText);
					}
				);
			});
		}

		/**
		 * Register the latest data to watch for the preloaded admin widgets.
		 * 
		 * @param 	object 	watch_data
		 */
		static registerWatchData(watch_data) {
			if (typeof watch_data !== 'object' || watch_data == null) {
				VBOCore.widgets_watch_data = null;
				return false;
			}

			// set watch-data map
			VBOCore.widgets_watch_data = watch_data;

			// schedule watching interval
			if (VBOCore.watch_data_interval == null) {
				VBOCore.watch_data_interval = window.setInterval(VBOCore.watchWidgetsData, 60000);
			}
		}

		/**
		 * Periodic widgets data watching for new events.
		 */
		static watchWidgetsData() {
			if (typeof VBOCore.widgets_watch_data !== 'object' || VBOCore.widgets_watch_data == null) {
				return;
			}

			// call on new events
			VBOCore.doAjax(
				VBOCore.options.watchdata_ajax_uri,
				{
					watch_data: JSON.stringify(VBOCore.widgets_watch_data),
				},
				(response) => {
					try {
						var obj_res = typeof response === 'string' ? JSON.parse(response) : response;
						if (obj_res.hasOwnProperty('watch_data')) {
							// update watch data map for next schedule
							VBOCore.widgets_watch_data = obj_res['watch_data'];
							// check for notifications
							if (obj_res.hasOwnProperty('notifications') && Array.isArray(obj_res['notifications'])) {
								// dispatch notifications
								for (var i = 0; i < obj_res['notifications'].length; i++) {
									VBOCore.dispatchNotification(obj_res['notifications'][i]);
								}
							}
						} else {
							console.error('Unexpected or invalid JSON response', response);
						}
					} catch(err) {
						console.error('could not parse JSON response', err, response);
					}
				},
				(error) => {
					console.error(error.responseText);
				}
			);
		}

		/**
		 * Widget modal rendering.
		 * 
		 * @param 	string 	widget_id 	the widget identifier to render.
		 * @param 	any 	data 		the optional multitask data to inject.
		 * @param 	bool 	hide_panel 	if false, the multitask panel elements will remain unchanged.
		 * 
		 * @return 	object 				the multitask data injected object merged with modal options.
		 */
		static renderModalWidget(widget_id, data, hide_panel) {
			// build the default widget payload
			let modal_js_id = Math.floor(Math.random() * 100000);
			let widget_data = {
				_modalRendering: 1,
				_modalJsId: modal_js_id,
				_modalTitle: VBOCore.options.tn_texts.admin_widget,
			};

			if (typeof data !== 'object') {
				data = {};
			}

			// merge default payload options with given options
			data = Object.assign(widget_data, data);

			// define unique modal event names to avoid conflicts
			let dismiss_event = 'vbo-dismiss-widget-modal' + modal_js_id;
			let loading_event = 'vbo-loading-widget-modal' + modal_js_id;

			// define the modal options
			let modal_options = {
				suffix: 	     'widget-modal',
				extra_class:     'vbo-modal-rounded vbo-modal-tall vbo-modal-nofooter',
				title: 		     data._modalTitle,
				body_prepend: 	 true,
				dismiss_event:   dismiss_event,
				loading_event:   loading_event,
				loading_body:    VBOCore.options.default_loading_body,
				dismissed_event: VBOCore.options.widget_modal_dismissed + modal_js_id,
				event_data: 	 widget_data,
			};

			// display modal
			let widget_modal = VBOCore.displayModal(modal_options);

			if (hide_panel !== false) {
				// blur search widget input, hide multitask panel
				$(VBOCore.options.panel_opts.search_selector).trigger('blur');
				VBOCore.emitEvent(VBOCore.multitask_shortcut_event);
			}

			// start loading
			VBOCore.emitEvent(loading_event);

			// render admin widget
			VBOCore.renderAdminWidget(widget_id, data).then((content) => {
				// stop loading and append widget content to modal
				VBOCore.emitEvent(loading_event);
				widget_modal.append(content);
			}).catch((error) => {
				// dismiss modal and display error
				VBOCore.emitEvent(dismiss_event);
				alert(error);
			});

			return Object.assign(data, modal_options);
		}

		/**
		 * Renders an admin widget.
		 * 
		 * @param 	string 	widget_id 	the widget identifier string to add.
		 * @param 	any 	data 		the optional multitask data to inject.
		 * 
		 * @return 	Promise
		 */
		static renderAdminWidget(widget_id, data) {
			return new Promise((resolve, reject) => {
				if (!VBOCore.options.widget_ajax_uri) {
					reject('Could not add admin widget');
					return;
				}

				var call_method = 'render';
				VBOCore.doAjax(
					VBOCore.options.widget_ajax_uri,
					{
						widget_id: 		widget_id,
						call: 	   		call_method,
						vbo_page:  		VBOCore.options.current_page,
						vbo_uri:   		VBOCore.options.current_page_uri,
						multitask: 		1,
						multitask_data: data,
					},
					(response) => {
						// parse response
						try {
							var obj_res = typeof response === 'string' ? JSON.parse(response) : response;
							if (!obj_res.hasOwnProperty(call_method)) {
								reject('Unexpected JSON response');
								return;
							}
							resolve(obj_res[call_method]);
						} catch(err) {
							reject('could not parse JSON response');
						}
					},
					(error) => {
						reject(error.responseText);
					}
				);
			});
		}

		/**
		 * Helper method used to copy the text of an
		 * input element within the clipboard.
		 *
		 * Clipboard copy will take effect only in case the
		 * function is handled by a DOM event explicitly
		 * triggered by the user, such as a "click".
		 *
		 * @param 	any 	input 	The input containing the text to copy.
		 *
		 * @return 	Promise
		 */
		static copyToClipboard(input) {
			// register and return promise
			return new Promise((resolve, reject) => {
				// define a fallback function
				var fallback = function(input) {
					// focus the input
					input.focus();
					// select the text inside the input
					input.select();

					try {
						// try to copy with shell command
						var copy = document.execCommand('copy');

						if (copy) {
							// copied successfully
							resolve(copy);
						} else {
							// unable to copy
							reject(copy);
						}
					} catch (error) {
						// unable to exec the command
						reject(error);
					}
				};

				// look for navigator clipboard
				if (!navigator || !navigator.clipboard) {
					// navigator clipboard not supported, use fallback
					fallback(input);
					return;
				}

				// try to copy within the clipboard by using the navigator
				navigator.clipboard.writeText(input.value).then(() => {
					// copied successfully
					resolve(true);
				}).catch((error) => {
					// revert to the fallback
					fallback(input);
				});
			});
		}

		/**
		 * Helper method used to display a modal window dinamycally.
		 *
		 * @param 	object 	options 	The options to render the modal.
		 *
		 * @return 	object 				The modal content element wrapper.
		 */
		static displayModal(options) {
			var def_options = {
				suffix: 	     (Math.floor(Math.random() * 100000)) + '',
				extra_class:     null,
				title: 		     '',
				body: 		     '',
				body_prepend:    false,
				footer_left:     null,
				footer_right:    null,
				dismiss_event:   null,
				dismissed_event: null,
				onDismiss: 	     null,
				loading_event:   null,
				loading_body:    VBOCore.options.default_loading_body,
				event_data: 	 null,
			};

			// merge default options with given options
			options = Object.assign(def_options, options);

			// create the modal dismiss function
			var modal_dismiss_fn = (e) => {
				custom_modal.fadeOut(400, () => {
					// invoke callback for onDismiss
					if (typeof options.onDismiss === 'function') {
						options.onDismiss.call(custom_modal, e);
					}

					// check if modal did register to the loading event
					if (options.loading_event) {
						// we can now un-register from the loading event until a new modal is displayed and will register to it again
						document.removeEventListener(options.loading_event, modal_handle_loading_event_fn);
					}

					// check if we should fire the given modal dismissed event
					if (options.dismissed_event) {
						VBOCore.emitEvent(options.dismissed_event, options.event_data);
					}

					// remove modal from DOM
					custom_modal.remove();
				});
			};

			// create the modal loading event handler function
			var modal_handle_loading_event_fn = (e) => {
				// toggle modal loading
				if ($('.vbo-modal-overlay-content-backdrop').length) {
					// hide loading
					$('.vbo-modal-overlay-content-backdrop').remove();

					// do not proceed
					return;
				}

				// show loading
				var modal_loading = $('<div></div>').addClass('vbo-modal-overlay-content-backdrop');
				var modal_loading_body = $('<div></div>').addClass('vbo-modal-overlay-content-backdrop-body');
				if (options.loading_body) {
					modal_loading_body.append(options.loading_body);
				}
				modal_loading.append(modal_loading_body);

				// append backdrop loading to modal content
				modal_content.prepend(modal_loading);
			};

			// build modal content
			var custom_modal = $('<div></div>').addClass('vbo-modal-overlay-block vbo-modal-overlay-' + options.suffix).css('display', 'block');
			var modal_dismiss = $('<a></a>').addClass('vbo-modal-overlay-close');
			modal_dismiss.on('click', modal_dismiss_fn);
			custom_modal.append(modal_dismiss);

			var modal_content = $('<div></div>').addClass('vbo-modal-overlay-content vbo-modal-overlay-content-' + options.suffix);
			if (options.extra_class && typeof options.extra_class === 'string') {
				modal_content.addClass(options.extra_class);
			}

			var modal_head = $('<div></div>').addClass('vbo-modal-overlay-content-head');
			var modal_head_close = $('<span></span>').addClass('vbo-modal-overlay-close-times').html('&times;');
			modal_head_close.on('click', modal_dismiss_fn);
			modal_head.append(options.title).append(modal_head_close);

			var modal_body = $('<div></div>').addClass('vbo-modal-overlay-content-body vbo-modal-overlay-content-body-scroll');
			var modal_content_wrapper = $('<div></div>').addClass('vbo-modal-' + options.suffix + '-wrap');
			if (typeof options.body === 'string') {
				modal_content_wrapper.html(options.body);
			} else {
				modal_content_wrapper.append(options.body);
			}
			modal_body.append(modal_content_wrapper);

			// modal footer
			var modal_footer = null;
			if (options.footer_left || options.footer_right) {
				modal_footer = $('<div></div>').addClass('vbo-modal-overlay-content-footer');
				if (options.footer_left) {
					var modal_footer_left = $('<div></div>').addClass('vbo-modal-overlay-content-footer-left').append(options.footer_left);
					modal_footer.append(modal_footer_left);
				}
				if (options.footer_right) {
					var modal_footer_right = $('<div></div>').addClass('vbo-modal-overlay-content-footer-right').append(options.footer_right);
					modal_footer.append(modal_footer_right);
				}

			}

			// finalize modal contents
			modal_content.append(modal_head).append(modal_body);
			if (modal_footer) {
				modal_content.append(modal_footer);
			}
			custom_modal.append(modal_content);

			// register to the dismiss event
			if (options.dismiss_event) {
				document.addEventListener(options.dismiss_event, function vbo_core_handle_dismiss_event(e) {
					// make sure the same event won't propagate again, unless a new modal is displayed (multiple displayModal calls)
					e.target.removeEventListener(e.type, vbo_core_handle_dismiss_event);

					// invoke the modal dismiss function
					modal_dismiss_fn(e);
				});
			}

			// register to the toggle-loading event
			if (options.loading_event) {
				// let a function handle it so that removing the event listener will be doable
				document.addEventListener(options.loading_event, modal_handle_loading_event_fn);
			}

			// append (or prepend) modal to body
			if ($('.vbo-modal-overlay-' + options.suffix).length) {
				$('.vbo-modal-overlay-' + options.suffix).remove();
			}
			if (options.body_prepend) {
				$('body').prepend(custom_modal);
			} else {
				$('body').append(custom_modal);
			}

			// return the content wrapper element of the new modal
			return modal_content_wrapper;
		}

		/**
		 * Debounce technique to group a flurry of events into one single event.
		 */
		static debounceEvent(func, wait, immediate) {
			var timeout;
			return function() {
				var context = this, args = arguments;
				var later = function() {
					timeout = null;
					if (!immediate) func.apply(context, args);
				};
				var callNow = immediate && !timeout;
				clearTimeout(timeout);
				timeout = setTimeout(later, wait);
				if (callNow) {
					func.apply(context, args);
				}
			}
		}

		/**
		 * Throttle guarantees a constant flow of events at a given time interval.
		 * Runs immediately when the event takes place, but can be delayed.
		 */
		static throttleEvent(method, delay) {
			var time = Date.now();
			return function() {
				if ((time + delay - Date.now()) < 0) {
					method();
					time = Date.now();
				}
			}
		}

		/**
		 * Tells whether localStorage is supported.
		 * 
		 * @return 	boolean
		 */
		static storageSupported() {
			return typeof localStorage !== 'undefined';
		}

		/**
		 * Gets an item from localStorage.
		 * 
		 * @param 	string 	keyName 	the storage key identifier.
		 * 
		 * @return 	any
		 */
		static storageGetItem(keyName) {
			if (!VBOCore.storageSupported()) {
				return null;
			}

			return localStorage.getItem(keyName);
		}

		/**
		 * Sets an item to localStorage.
		 * 
		 * @param 	string 	keyName 	the storage key identifier.
		 * @param 	any 	value 		the value to store.
		 * 
		 * @return 	boolean
		 */
		static storageSetItem(keyName, value) {
			if (!VBOCore.storageSupported()) {
				return false;
			}

			try {
				if (typeof value === 'object') {
					value = JSON.stringify(value);
				}

				localStorage.setItem(keyName, value);
			} catch(e) {
				return false;
			}

			return true;
		}

		/**
		 * Removes an item from localStorage.
		 * 
		 * @param 	string 	keyName 	the storage key identifier.
		 * 
		 * @return 	boolean
		 */
		static storageRemoveItem(keyName) {
			if (!VBOCore.storageSupported()) {
				return false;
			}

			localStorage.removeItem(keyName);

			return true;
		}

		/**
		 * Returns the name of the storage identifier for the given scope.
		 * 
		 * @param 	string 	scope 	the admin menu scope.
		 * 
		 * @return 	string 			the requested admin menu storage identifier.
		 */
		static getStorageScopeName(scope) {
			let storage_scope_name = VBOCore.options.admin_menu_actions_nm;

			if (typeof scope === 'string' && scope.length) {
				if (scope.indexOf('.') !== 0) {
					scope = '.' + scope;
				}
				storage_scope_name += scope;
			}

			return storage_scope_name;
		}

		/**
		 * Returns a list of admin menu action objects or an empty array.
		 * 
		 * @param 	string 	scope 	the admin menu scope.
		 * 
		 * @return 	Array
		 */
		static getAdminMenuActions(scope) {
			let menu_actions = VBOCore.storageGetItem(VBOCore.getStorageScopeName(scope));

			if (!menu_actions) {
				return [];
			}

			try {
				menu_actions = JSON.parse(menu_actions);
				if (!Array.isArray(menu_actions) || !menu_actions.length) {
					menu_actions = [];
				}
			} catch(e) {
				return [];
			}

			return menu_actions;
		}

		/**
		 * Builds an admin menu action object with a proper href property.
		 * 
		 * @param 	object 	action 	the action to build.
		 * 
		 * @return 	object
		 */
		static buildAdminMenuAction(action) {
			if (typeof action !== 'object' || !action || !action.hasOwnProperty('name')) {
				throw new Error('Invalid action object');
			}

			var action_base = action.hasOwnProperty('href') && typeof action['href'] == 'string' ? action['href'] : window.location.href;
			var action_url;

			if (action_base.indexOf('http') !== 0) {
				// relative URL
				action_url = new URL(action_base, window.location.href);
			} else {
				// absolute URL
				action_url = new URL(action_base);
			}

			// build proper href with a relative URL
			action['href'] = action_url.pathname + action_url.search;

			return action;
		}

		/**
		 * Registers an admin menu action object.
		 * 
		 * @param 	object 	action 	the action to build.
		 * @param 	string 	scope 	the admin menu scope.
		 * 
		 * @return 	boolean
		 */
		static registerAdminMenuAction(action, scope) {
			// build menu action object
			let menu_action_entry = VBOCore.buildAdminMenuAction(action);

			let menu_actions = VBOCore.getAdminMenuActions(scope);

			// make sure we are not pushing a duplicate and count pinned actions
			let pinned_actions = 0;
			let unpinned_index = [];
			for (let i = 0; i < menu_actions.length; i++) {
				if (menu_actions[i]['href'] == menu_action_entry['href']) {
					return false;
				}
				if (menu_actions[i].hasOwnProperty('pinned') && menu_actions[i]['pinned']) {
					pinned_actions++;
				} else {
					unpinned_index.push(i);
				}
			}

			if (pinned_actions >= VBOCore.options.admin_menu_maxactions) {
				// no more space to register a new menu action for this admin menu
				return false;
			}

			// splice or pop before prepending to keep current indexes
			let tot_menu_actions = menu_actions.length;
			if (++tot_menu_actions > VBOCore.options.admin_menu_maxactions) {
				if (unpinned_index.length) {
					menu_actions.splice(unpinned_index[unpinned_index.length - 1], 1);
				} else {
					menu_actions.pop();
				}
			}

			// prepend new admin menu action
			menu_actions.unshift(menu_action_entry);

			return VBOCore.storageSetItem(VBOCore.getStorageScopeName(scope), menu_actions);
		}

		/**
		 * Updates an existing admin menu action object.
		 * 
		 * @param 	object 	action 	the action to build.
		 * @param 	string 	scope 	the admin menu scope.
		 * @param 	number 	index 	optional menu action index.
		 * 
		 * @return 	boolean
		 */
		static updateAdminMenuAction(action, scope, index) {
			// build menu action object
			let menu_action_entry = VBOCore.buildAdminMenuAction(action);

			let menu_actions = VBOCore.getAdminMenuActions(scope);

			if (!menu_actions.length) {
				return false;
			}

			if (typeof index === 'undefined') {
				// find the proper index to update by href
				for (let i = 0; i < menu_actions.length; i++) {
					if (menu_actions[i]['href'] == menu_action_entry['href']) {
						index = i;
						break;
					}
				}
			}

			if (isNaN(index) || !(index in menu_actions)) {
				// menu entry index not found
				return false;
			}

			menu_actions[index] = menu_action_entry;

			return VBOCore.storageSetItem(VBOCore.getStorageScopeName(scope), menu_actions);
		}
	}

	/**
	 * These used to be private static properties (static #options),
	 * but they are only supported by quite recent browsers (especially Safari).
	 * It's too risky, so we decided to keep the class properties public
	 * without declaring them as static inside the class declaration.
	 * 
	 * @var  object
	 */
	VBOCore.options = {
		is_vbo: 				false,
		is_vcm: 				false,
		widget_ajax_uri: 		null,
		assets_ajax_uri: 		null,
		multitask_ajax_uri: 	null,
		watchdata_ajax_uri: 	null,
		current_page: 			null,
		current_page_uri: 		null,
		client: 				'admin',
		panel_opts: 			{},
		admin_widgets: 			[],
		notif_audio_url: 		'',
		active_listeners: 		{},
		tn_texts: 				{
			notifs_enabled: 		'Browser notifications are enabled!',
			notifs_disabled: 		'Browser notifications are disabled',
			notifs_disabled_help: 	"Could not enable browser notifications.\nThis feature is available only in secure contexts (HTTPS).",
			admin_widget: 			'Admin widget',
			congrats: 				'Congratulations!',
		},
		default_loading_body: 	'....',
		multitask_save_event: 	'vbo-admin-multitask-save',
		multitask_open_event: 	'vbo-admin-multitask-open',
		multitask_close_event: 	'vbo-admin-multitask-close',
		multitask_shortcut_ev: 	'vbo_multitask_shortcut',
		multitask_searchfs_ev: 	'vbo_multitask_search_focus',
		widget_modal_rendered: 	'vbo-admin-widget-modal-rendered',
		widget_modal_dismissed: 'vbo-widget-modal-dismissed',
		admin_menu_maxactions: 	3,
		admin_menu_actions_nm: 	'vikbooking.admin_menu.actions',
	};

	/**
	 * @var  bool
	 */
	VBOCore.side_panel_on = false;

	/**
	 * @var  array
	 */
	VBOCore.notifications = [];

	/**
	 * @var  object
	 */
	VBOCore.widgets_watch_data = null;

	/**
	 * @var  number
	 */
	VBOCore.watch_data_interval = null;

})(jQuery, window);