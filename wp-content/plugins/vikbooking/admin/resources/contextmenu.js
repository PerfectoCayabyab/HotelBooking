/**
 * jQuery add-on used to support context menus.
 * Here's a list of supported options.
 * 
 * @author 	E4J srl
 *
 * - trigger         string    The command that should trigger the popup menu. Accepts the
 *                             following values: click|doubleclick|rightclick|hover.
 *                             Click will be used by default.
 * - placement       string    Where the popup should be displayed in relation to the target.
 *                             Accepts the following values: auto|top|right|bottom|left.
 *                             Auto will be used by default (at the mouse coordinates).
 * - class           string    An optional class to use for individual styling.
 * - buttons         object[]  A list of buttons to include within the popup menu. See the options
 *                             of the buttons for further details.
 * - onShow          function  An optional callback to invoke when the popup menu is displayed.
 * - onHide          function  An optional callback to invoke when the popup menu is dismissed.
 * - darkMode        mixed     Flag for dark mode layout, which accepts 3 possible values:
 *                             true|false|null. Pass true to always force the dark mode, false to
 *                             always use the light mode, null to auto-detect the proper mode
 *                             according to the preferred theme of the browser.
 * - clickable       boolean   Flag used to check whether the root element should prevent the
 *                             browser selection by applying specific CSS rules. False by default.
 * - lockScroll      boolean   Flag used to prevent the document scroll when the context menu
 *                             pops up. True by default.
 * - hideOnEsc       boolean   Choose whether the context menu should be closed when ESC key is
 *                             pressed. Always true by default.
 * - formatShortcut  mixed     An optional callback that can be used to format the shortcut symbols.
 *
 * Here's a list of options supported by the buttons. Any other property of the button will
 * be accessible by the internal methods.
 *
 * - icon       mixed     Either a function, an image URL, an image instance or a font icon
 *                        to display before the button text. In case of a function, it will be
 *                        used as callback to define an image/icon at runtime.
 * - text       string    The text to display for the popup menu button.
 * - action     function  The callback to dispatch when the button gets clicked.
 * - class      string    An optional class to use for individual styling.
 * - disabled   mixed     Either a function or a boolean to check whether the button should 
 *                        be clicked or not. The button is never disabled by default.
 * - visible    mixed     Either a function or a boolean to check whether the button should 
 *                        be displayed or not. The button is always visible by default.
 * - separator  boolean   Flag used to check whether the popup should include a separator after the
 *                        button. False by default.
 * - shortcut   mixed     An array of commands to represent the shortcut that will trigger the action
 *                        via keyboard. The array must contain one and only one character or symbol.
 *                        The array may contain one ore more modifiers, which must be specified first.
 *
 * List of methods supported by the add-on.
 *
 * - show     Manually displays the popup menu.
 * - hide     Manually disposes the popup menu.
 * - destroy  Destroys the popup attached to the element.
 * - config   Returns the configuration of the popup.
 * - buttons  Getter/setter of the popup buttons.
 *
 * It is possible to update each setting configuration by using the same
 * name of the property and the related value to set. Leave the set argument
 * empty to simply access the current property value. In example:
 *
 * jQuery(target).vboContextMenu(  'trigger', 'click');
 * jQuery(target).vboContextMenu('placement',  'auto');
 */
(function($) {
	/**
	 * Popup menu trigger setup.
	 *
	 * @param 	object 	root     The selector element.
	 * @param 	string 	trigger  The trigger to use.
	 * @param 	mixed	prev     The previous trigger.
	 *
	 * @return 	string  The trigger event.
	 */
	var vikPopupMenuTrigger = function(root, trigger, prev) {
		// check if the trigger was already registered
		if (prev) {
			// detach previous trigger
			$(root).off(prev.toLowerCase());
		}

		if (!trigger) {
			// abort in case of missing trigger
			return false;
		}

		// normalize trigger event
		switch (trigger.toLowerCase()) {
			case 'mouseover':
			case 'hover':
				trigger = 'mouseover';
				break;

			case 'dblclick':
			case 'doubleclick':
			case 'double-click':
				trigger = 'dblclick';
				break;

			case 'contextmenu':
			case 'rightclick':
			case 'right-click':
				trigger = 'contextmenu';
				break;

			default:
				trigger = 'click';
		};

		// scan all the registered elements
		$(root).each(function() {
			// register new trigger
			$(this).on(trigger, function(event) {
				// always prevent default event
				event.preventDefault();

				// open popup
				vikPopupMenuShow(this, event);
			});
		});

		return trigger;
	};

	/**
	 * Popup menu clickable setup.
	 *
	 * @param 	object 	 root  The selector element.
	 * @param 	boolean  flag  True to make the root clickable.
	 * @param 	mixed	 prev  The flag previously set, if any.
	 *
	 * @return 	self
	 */
	var vikPopupMenuClickable = function(root, flag, prev) {
		if (prev) {
			// remove CSS class used to disable the selection from root element 
			$(root).removeClass('vik-context-menu-disable-selection');
		}

		if (flag) {
			// add CSS class to root element to disable the selection
			$(root).addClass('vik-context-menu-disable-selection');
		}

		return root;
	};

	/**
	 * Initializes the popup menu.
	 *
	 * @param 	object 	root     The selector element.
	 * @param 	object 	options  A configuration object.
	 *
	 * @return 	self
	 */
	var vikPopupMenuInit = function(root, options) {
		// inject the specified options within the default configuration
		options = $.extend($.vboContextMenu.defaults, options);

		// register the popup configuration for being used later
		vikPopupMenuConfig(root, options);

		// register trigger to show the popup menu
		options.trigger = vikPopupMenuTrigger(root, options.trigger);

		// normalize buttons
		vikPopupMenuButtons(root, options.buttons);

		// handle clickable property
		vikPopupMenuClickable(root, options.clickable);

		// register callback to dispatch the action of a button when its shortcut is pressed
		$(document).on('keydown.contextmenu.vikbooking', function(event) {
			// ignore the event with this namespace because it will end up
			// to catch also the plain keydown event
			if (event.namespace == 'contextmenu.vikbooking') {
				return true;
			}

			// go ahead only in case the focus is not help by a text field
			if ($(document.activeElement).is('input,textarea') == true) {
				// prevent shortcuts from catching typed characters
				return true;
			}

			// retrieve popup configuration
			var config = vikPopupMenuConfig(root);

			// in case ESC was pressed, check if we should hide the popup
			if (config.hideOnEsc && event.keyCode == 27) {
				// auto-close the context menu
				vikPopupMenuHide(root);
				return true;
			}

			// iterate all registered buttons
			$.each(config.buttons, (i, btn) => {
				// make sure we have a shortcut and an action to execute
				if (!btn.shortcut || !btn.action) {
					// nothing to do here, go ahead
					return true;
				}

				// check whether the shortcut is pressed
				if (event.originalEvent.shortcut(btn.shortcut)) {
					// launch callback to check whether the button is disabled
					// or simply rely on the specified boolean
					var disabled = typeof btn.disabled === 'function' ? btn.disabled(root, config) : btn.disabled; 

					// trigger action only in case the button is not disabled
					if (!disabled) {
						// stop event propagation
						event.preventDefault();
						event.stopPropagation();
						
						// dispatch button action
						btn.action(root, event);
					}

					return false;
				}
			});
		});

		return root;
	};

	/**
	 * Getter and setter of the popup configuration.
	 *
	 * @param 	object 	root  The selector element.
	 * @param 	mixed 	data  The popup configuration to set. When omitted,
	 * 						  the method will act as a getter.
	 *
	 * @param 	mixed 	Returns the configuration when the data argument is
	 * 					missing. Otherwise itself will be returned.
	 */
	var vikPopupMenuConfig = function(root, data) {
		if (typeof data === 'undefined') {
			// GETTER: return popup configuration.
			// Clone the object in order to prevent manual edits to
			// the configuration properties.
			return Object.assign({}, $(root).data('popupConfiguration'));
		}

		// SETTER: update popup configuration
		return $(root).data('popupConfiguration', data);
	};

	/**
	 * Creates and shows the popup menu.
	 *
	 * @param 	object 	root   The selector element.
	 * @param 	Event   event  The dispatcher DOM event.
	 *
	 * @return 	self
	 */
	var vikPopupMenuShow = function(root, event) {
		if ($('.vik-context-menu').length) {
			// do not go ahead in case a context menu is visible
			return root;
		}

		// retrieve configuration
		var config = vikPopupMenuConfig(root);

		// prepare context menu structure
		var popup = $('<div class="vik-context-menu"><ul></ul></div>');

		// in case of a custom class, add it
		if (config.class) {
			popup.addClass(config.class);
		}

		// look for dark mode
		if (config.darkMode === true) {
			// turn dark mode on
			popup.addClass('dark-mode');
		} else if (config.darkMode === false) {
			// suppress dark mode
			popup.addClass('light-mode');
		}

		// iterate registered buttons and append them one by one
		$.each(config.buttons, function(i, btn) { 
			// launch callback to check whether the button should be displayed
			// or simply rely on the specified boolean
			var visible = typeof btn.visible === 'function' ? btn.visible(root, config) : btn.visible;

			if (!visible) {
				// skip button and go ahead
				return true;
			}

			// prepare button structure
			var popupBtn = $('<a></a>');

			if (btn.icon) {
				var icon;

				if (typeof btn.icon === 'function') {
					// we have a function, launch the callback
					// to extract the image at runtime
					icon = btn.icon(root, config);
				} else {
					// use it plain
					icon = btn.icon;
				}

				if (icon instanceof Image) {
					// we have an image instance
					icon = $(icon);
				} else if (typeof icon === 'string') {
					if (icon.indexOf('/') !== -1) {
						// we have an image URL
						icon = $('<img>').attr('src', icon);
					} else {
						// we probably have a font icon
						icon = $('<i></i>').addClass(icon);
					}
				}

				// leave as is in case a jQuery instance was passed

				// wrap icon in a parent and append all to button
				popupBtn.append($('<span class="button-icon"></span>').append(icon));
			}

			// insert text button
			popupBtn.append($('<span class="button-text"></span>').html(btn.text));

			// check if the button specified a shortcut
			if (btn.shortcut) {
				// map shortcut elements
				var cmd = btn.shortcut.map(function(k) {
					var keyCode = k;

					switch (k) {
						case 'alt':   k = "&#8997;"; break;
						case 'ctrl':  k = "&#8963;"; break;
						case 'shift': k = "&#8679;"; break;
						case 'meta':  k = "&#8984;"; break;
						// backspace
						case 8:       k = '<i class="fas fa-backspace"></i>'; break;
						// enter
						case 13:      k = '&#9166;'; break;
						// space
						case 32:      k = 'Space'; break;
						// arrow up
						case 37:      k = '<i class="fas fa-long-arrow-alt-left"></i>'; break;
						// arrow up
						case 38:      k = '<i class="fas fa-long-arrow-alt-up"></i>'; break;
						// arrow right
						case 39:      k = '<i class="fas fa-long-arrow-alt-right"></i>'; break;
						// arrow down
						case 40:      k = '<i class="fas fa-long-arrow-alt-down"></i>'; break;
						// character
						default: 	  k = typeof k === 'string' ? k.toUpperCase() : '';
					}

					// look for a custom function used to format shortcuts
					if (typeof config.formatShortcut === 'function') {
						// launch the callback
						k = config.formatShortcut(keyCode, k);
					}

					return k;
				});

				cmd = cmd.join('');

				// wrap the shortcut between parenthesis in case of no modifiers
				if (cmd.length == 1) {
					cmd = '(' + cmd + ')';
				}

				// insert shortcut button
				popupBtn.append($('<span class="button-shortcut"></span>').html(cmd));
			}

			// launch callback to check whether the button should be disabled
			// or simply rely on the specified boolean
			var disabled = typeof btn.disabled === 'function' ? btn.disabled(root, config) : btn.disabled; 

			// check whether the button is disabled
			if (disabled) {
				popupBtn.addClass('disabled');
			} else {
				// register button click event
				popupBtn.on('click', function(event) {
					// look for an action callback
					if (btn.action) {
						// dispatch callback
						btn.action(root, event);	
					}
					
					// always dismiss the popup when a button gets clicked
					vikPopupMenuHide(root);
				});
			}

			// in case of a custom class, add it
			if (btn.class) {
				popupBtn.addClass(btn.class);
			}

			// wrap button within a parent for <ul> compliance
			var popupItem = $('<li></li>').append(popupBtn);

			// in case of a separator, add a specific class
			if (btn.separator) {
				popupItem.addClass('separator');
			}

			// wrap button within a parent and add to popup
			popup.find('ul').append(popupItem);
		});

		// hide the popup before appending it
		popup.hide();

		// append button to body
		$('body').append(popup);

		// calculate popup position
		vikPopupMenuCalcPosition(root, popup, event);

		if (config.lockScroll) {
			// prevent document from scrolling
			$('body').addClass('lock-scroll');
		}

		// show popup
		popup.show();

		// look for a specific callback to be triggered on opening
		if (config.onShow) {
			// trigger show callback
			config.onShow(root, popup);
		}

		// Register callback to auto dismiss the popup when clicked outside.
		// Use mousedown event because it will be execured before any other
		// supported trigger, so that the context menus can be shown on cascade.
		$(document).on('mousedown.contextmenu.vikbooking', function(event) {
			// ignore the event with this namespace because it will end up
			// to catch also the plain mousedown event
			if (event.namespace == 'contextmenu.vikbooking') {
				return false;
			}

			if (!popup.is(':visible')) {
				// dialog not visible
				return false;
			}

			// get list of buttons
			var links = popup.find('a');
			
			// make sure we haven't clicked the popup or a link
			if (!popup.is(event.target) && popup.has(event.target).length === 0
				&& !links.is(event.target) && links.has(event.target).length === 0) {
				// auto close popup when clicked outside
				vikPopupMenuHide(root);

				event.stopPropagation();
				event.preventDefault();

				return false;
			}
		});

		return root;
	};

	/**
	 * Hides the popup menu.

	 * @param 	object 	root  The selector element.
	 *
	 * @return 	self
	 */
	var vikPopupMenuHide = function(root) {
		// go ahead only in case a popup is open
		if ($('.vik-context-menu').length) {
			// destroy any existing popup menu because we do not support
			// more than a popup per time
			$('.vik-context-menu').remove();

			// always restore scroll functions
			$('body').removeClass('lock-scroll');

			// turn off proxy
			$(document).off('mousedown.contextmenu.vikbooking');

			// get popup configuration
			var config = vikPopupMenuConfig(root);

			// look for a specific callback to be triggered on dismiss
			if (config.onHide) {
				// trigger hide callback
				config.onHide(root);
			}
		}

		return root;
	};

	/**
	 * Destroys the popup menu.

	 * @param 	object 	root  The selector element.
	 *
	 * @return 	self
	 */
	var vikPopupMenuDestroy = function(root) {
		// in case the popup was open, close it first
		vikPopupMenuHide(root);

		// detach keyboard listener
		$(document).off('keydown.contextmenu.vikbooking');

		// remove CSS class used to disable the selection from root element 
		$(root).removeClass('vik-context-menu-disable-selection');

		// get popup configuration
		var config = vikPopupMenuConfig(root);

		// detach previous event without attaching a new one
		vikPopupMenuTrigger(root, null, config.trigger);

		// detach clickable property
		vikPopupMenuClickable(root, null, config.clickable);
		
		// then destroy the registered data
		return vikPopupMenuConfig(root, null);
	};

	/**
	 * Getter and setter of the popup buttons.
	 *
	 * @param 	object 	root  The selector element.
	 * @param 	mixed 	data  The popup buttons to set. When omitted,
	 * 						  the method will act as a getter.
	 *
	 * @param 	mixed 	Returns the buttons list when the data argument is
	 * 					missing. Otherwise itself will be returned.
	 */
	var vikPopupMenuButtons = function(root, data) {
		// get configuration
		var config = vikPopupMenuConfig(root);

		if (typeof data === 'undefined') {
			// return popup buttons
			return config.buttons;
		}

		// make sure the buttons property is an Array
		if (!Array.isArray(data)) {
			throw 'Invalid buttons, an Array was expected.';
		}

		// set specified buttons
		config.buttons = data;

		// iterate all buttons
		for (var i = 0; i < config.buttons.length; i++) {
			// create default button properties
			config.buttons[i] = $.extend({
				icon:      null,
				text:      '',
				action:    null,
				shortcut:  null,
				class:     '',
				disabled:  false,
				visible:   true,
				separator: false,
			}, config.buttons[i]);

			// make sure we have an array
			if (!Array.isArray(config.buttons[i].shortcut)) {
				// invalid shortcut
				config.buttons[i].shortcut = null;
			}
		}

		// register configuration
		return vikPopupMenuConfig(root, config);
	};

	/**
	 * Calculates and sets the proper position of the popup.
	 *
	 * @param 	object 	root   The selector element.
	 * @param 	mixed 	popup  The popup element.
	 * @param 	mixed   event  The dispatcher DOM event.
	 *
	 * @param 	self
	 */
	var vikPopupMenuCalcPosition = function(root, popup, event) {
		// get popup configuration
		var config = vikPopupMenuConfig(root);

		// in case of "auto" placement, we need to make sure
		// that we own an event to access the mouse coordinates
		if (config.placement == 'auto' && !event) {
			// no event was passed, fallback to right
			config.placement = 'right';
		}

		// calculate root offset
		var rootOffset = $(root).offset();
		// calculate root size
		var rootWidth  = $(root).outerWidth();
		var rootHeight = $(root).outerHeight();
		// calculate popup size
		var popupWidth  = $(popup).outerWidth();
		var popupHeight = $(popup).outerHeight();

		var x, y;

		// display popup above the root, centered
		if (config.placement == 'top') {
			x = rootOffset.left + rootWidth / 2 - popupWidth / 2;
			y = rootOffset.top - popupHeight - 4;
		}
		// display popup above the root, to the right
		else if (config.placement == 'top-right') {
			x = rootOffset.left + rootWidth - popupWidth;
			y = rootOffset.top - popupHeight - 4;
		}
		// display popup above the root, to the left
		else if (config.placement == 'top-left') {
			x = rootOffset.left;
			y = rootOffset.top - popupHeight - 4;
		}
		// display the popup below the root, centered
		else if (config.placement == 'bottom') {
			x = rootOffset.left + rootWidth / 2 - popupWidth / 2;
			y = rootOffset.top + rootHeight + 4;
		}
		// display the popup below the root, to the right
		else if (config.placement == 'bottom-right') {
			x = rootOffset.left + rootWidth - popupWidth;
			y = rootOffset.top + rootHeight + 4;
		}
		// display the popup below the root, to the left
		else if (config.placement == 'bottom-left') {
			x = rootOffset.left;
			y = rootOffset.top + rootHeight + 4;
		}
		// display the popup before the root
		else if (config.placement == 'left') {
			x = rootOffset.left - popupWidth - 4;
			y = rootOffset.top + rootHeight / 2 - popupHeight / 2;
		}
		// display the popup after the root
		else if (config.placement == 'right') {
			x = rootOffset.left + rootWidth + 4;
			y = rootOffset.top + rootHeight / 2 - popupHeight / 2;
		}
		// display the popup at the mouse coordinates
		else {
			x = event.pageX;
			y = event.pageY;
		}

		// calculate screen size
		var screenWidth  = $(window).width();
		var screenHeight = $(window).height();
		// calculate window scrolls
		var windowScrollLeft = $(window).scrollLeft();
		var windowScrollTop  = $(window).scrollTop();

		// use 4 pixel as minimum value
		x = Math.max(4, x);
		y = Math.max(4, y);

		// make sure the popup doesn't exceed the screen width
		if (x + popupWidth + 4 > screenWidth) {
			x = screenWidth - popupWidth - 4;
		}

		// make sure the popup doesn't exceed the screen height
		if (y + popupHeight + 4 > screenHeight + windowScrollTop) {
			y = screenHeight - popupHeight - 4 + windowScrollTop;
		}

		$(popup).css('top', y).css('left', x);

		return root;
	};

	// register listener to auto-close the popup when clicked outside
	$(document).on('mousedown', function() {
		// we need to propagate the event with a proxy so that we can safely
		// detach the registered callbacks when the popup gets closed
		$(document).trigger('mousedown.contextmenu.vikbooking');
	});

	// register listener to dispatch the actions of the buttons via keyboard
	$(document).on('keydown', function() {
		// we need to propagate the event with a proxy so that we can safely
		// detach the registered callbacks when the popup gets destroyed
		$(document).trigger('keydown.contextmenu.vikbooking');
	});

	// register the jQuery callback
	$.fn.vboContextMenu = function(method, data) {
		if (!method) {
			method = {};
		}

		// immediately exit in case of no elements found
		if ($(this).length == 0) {
			return this;
		}

		// initialize popup events
		if (typeof method === 'object') {
			return vikPopupMenuInit(this, method);
		}
		// check if we should dismiss the popup
		else if (typeof method === 'string' && method.match(/^(close|dismiss|hide)$/i)) {
			return vikPopupMenuHide(this);
		}
		// check if we should open the popup
		else if (typeof method === 'string' && method.match(/^(show|open)$/i)) {
			return vikPopupMenuShow(this);
		}
		// check if we destroy the popup
		else if (typeof method === 'string' && method.match(/^(destroy)$/i)) {
			return vikPopupMenuDestroy(this);
		}
		// check if we should return the popup configuration
		else if (typeof method === 'string' && method.match(/^(config|configuration|options)$/i)) {
			return vikPopupMenuConfig(this);
		}
		// check if we should handle with the popup buttons
		else if (typeof method === 'string' && method.match(/^(buttons)$/i)) {
			// use getter/setter according to the specified arguments
			return vikPopupMenuButtons(this, data);
		}
		// fallback to configuration setting getter/setter
		else {
			// access configuration
			var config = vikPopupMenuConfig(this);

			// check if the second argument was passed
			if (typeof data !== 'undefined') {
				if (method == 'trigger') {
					// register trigger before updating the configuration
					data = vikPopupMenuTrigger(this, data, config.trigger);
				} else if (method == 'clickable') {
					// handle clickable property
					vikPopupMenuClickable(this, data, config.clickable);
				}

				// register argument within configuration
				config[method] = data;

				// refresh configuration and return self instance
				return vikPopupMenuConfig(this, config);
			}

			// return configuration setting
			return config[method];
		}

		return this;
	};

	// define the default configuration to use for the context menu
	$.vboContextMenu = {
		defaults: {
			trigger:        'click',
			placement:      'auto',
			class:          '',
			buttons:        [],
			onShow:         null,
			onHide:         null,
			clickable:      false,
			lockScroll:     true,
			darkMode:       null,
			hideOnEsc:      true,
			formatShortcut: null,
		},
	};

	/**
	 * Checks if the KeyBoard event matches the given shortcut.
	 *
	 * @param 	array 	 keys 	The shortcut representation.
	 *
	 * @return 	boolean  True if matches, otherwise false.
	 */
	KeyboardEvent.prototype.shortcut = function(keys) {
		// get modifiers list
		var modifiers = keys.slice(0);
		// pop character from modifiers
		var keyCode = modifiers.pop();

		if (typeof keyCode === 'string') {
			// get ASCII
			keyCode = keyCode.toUpperCase().charCodeAt(0);
		}

		// make sure the modifiers are lower case
		modifiers = modifiers.map(function(mod) {
			return mod.toLowerCase();
		});

		var ok = false;

		// validate key code
		if (this.keyCode == keyCode) {
			// validate modifiers
			ok = true;
			var lookup = ['meta', 'shift', 'alt', 'ctrl'];

			for (var i = 0; i < lookup.length && ok; i++) {
				// check if modifiers is pressed
				var mod = this[lookup[i] + 'Key'];

				if (mod) {
					// if pressed, the shortcut must specify it
					ok &= modifiers.indexOf(lookup[i]) !== -1;
				} else {
					// if not pressed, the shortcut must not include it
					ok &= modifiers.indexOf(lookup[i]) === -1;
				}
			}
		}

		return ok;
	}
})(jQuery);