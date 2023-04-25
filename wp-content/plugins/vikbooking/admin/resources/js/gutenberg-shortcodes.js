(function(wp) {

	/**
	 * Registers a new block provided a unique name and an object defining its behavior.
	 * @link https://github.com/WordPress/gutenberg/tree/master/blocks#api
	 */
	var registerBlockType = wp.blocks.registerBlockType;

	/**
	 * Returns a new element of given type. Element is an abstraction layer atop React.
	 * @link https://github.com/WordPress/gutenberg/tree/master/packages/element#element
	 */
	var el = wp.element.createElement;

	/**
	 * Retrieves the translation of text.
	 * @link https://github.com/WordPress/gutenberg/tree/master/i18n#api
	 */
	var __ = wp.i18n.__;

	/**
	 * This variable is used to keep the very first shortcode
	 * after the loading of the page.
	 */
	var currentShortcode = null;

	/**
	 * Every block starts by registering a new block type definition.
	 * @link https://wordpress.org/gutenberg/handbook/block-api/
	 */
	registerBlockType('vikbooking/gutenberg-shortcodes', {
		/**
		 * This is the block display title, which can be translated with `i18n` functions.
		 * The block inserter will show this name.
		 */
		title: __('VikBooking Shortcode', 'vikbooking'),

		/**
		 * This is the block description, which is displayed within the right sidebar.
		 */
		description: __('Add a shortcode configured through VikBooking.', 'vikbooking'),

		/**
		 * The icon can be a DASHICON or a SVG entity.
		 */
		icon: 'building',

		/**
		 * Blocks are grouped into categories to help users browse and discover them.
		 * The categories provided by core are `common`, `embed`, `formatting`, `layout` and `widgets`.
		 */
		category: 'widgets',

		/**
		 * Sometimes a block could have aliases that help users discover it while searching.
		 * You can do so by providing an array of terms (which can be translated).
		 * It is only allowed to add as much as three terms per block.
		 */
		keywords: [
			__('shortcodes'), __('list'), __('page'),
		],

		/**
		 * Optional block extended support features.
		 */
		supports: {
			// do not edit as HTML
			html: false,

			// use the block just once per post
			multiple: false,

			// don't allow the block to be converted into a reusable block
			reusable: false,
		},

		/**
		 * Attributes provide the structured data needs of a block.
		 * They can exist in different forms when they are serialized, 
		 * but they are declared together under a common interface.
		 */
		attributes: {
			shortcode: {
				type: 'string',
				source: 'html',
				selector: 'div',
			},
			toggler: {
				type: 'string',
				default: '0',
			}
		},

		/**
		 * The edit function describes the structure of your block in the context of the editor.
		 * This represents what the editor will render when the block is used.
		 * @link https://wordpress.org/gutenberg/handbook/block-edit-save/#edit
		 *
		 * @param 	Object 	 props 	Properties passed from the editor.
		 *
		 * @return 	Element  Element to render.
		 */
		edit: function(props) {

			// iterate vikbooking shortcodes to build select options
			var options = [];

			var shortcodes_boxes = [];

			if (currentShortcode === null) {
				// if not set, define current value
				currentShortcode = props.attributes.shortcode;
			}

			// insert empty option
			options.push({
				label: __('- pick a shortcode -', 'vikbooking'),
				value: '',
			});

			// evaluate if toggler checkbox is checked
			var togglerChecked = props.attributes.toggler && props.attributes.toggler == '1';

			for (var group in VIKBOOKING_SHORTCODES_BLOCK) {
				var groups = VIKBOOKING_SHORTCODES_BLOCK[group];

				for (var i = 0; i < groups.length; i++) {
					var data = groups[i];

					var post_id  = parseInt(data.post_id);

					// push option only in case:
					// - toggler is enabled (see all)
					// - the shortcode is not assigned to any post
					// - the shortcode is equals to the current one
					if (togglerChecked || !post_id || data.shortcode == currentShortcode) {

						options.push({
							label: data.name,
							value: data.shortcode,
						});

						// build ASSIGNEE field
						var assigneeField = null;

						if (post_id && data.shortcode != currentShortcode) {
							assigneeField = el(
								'a',
								{
									href: 'javascript:void(0);',
									onClick: function() {
										alert(__('This shortcode is already used by a different post. If you select this shortcode, it will be detached from the existing post and assigned to this new post.', 'vikbooking'));
									},
								},
								el(
									'span',
									{
										className: 'assigned',
									},
									__('Post #', 'vikbooking') + post_id
								)
							);
						} else {
							// safe shortcode
							assigneeField = el('span', {}, (post_id ? __('Post #', 'vikbooking') + post_id : '--'));
						}

						// check if the box should be displayed
						var toggled = props.attributes.shortcode == data.shortcode;

						// setup information div
						shortcodes_boxes.push(el(
							'div',
							{
								className: 'vikbooking-shortcode-info-box' + (toggled ? ' toggled' : ''),
							},
							// create child elements
							el(
								'div',
								{
									className: 'vbo-sh-info-control'
								},
								[
									el('label', {}, __('Type:', 'vikbooking')),
									el('span', {}, group),
								]
							),
							el(
								'div',
								{
									className: 'vbo-sh-info-control'
								},
								[
									el('label', {}, __('Name:', 'vikbooking')),
									el('span', {}, data.name),
								]
							),
							el(
								'div',
								{
									className: 'vbo-sh-info-control'
								},
								[
									el('label', {}, __('Created on:', 'vikbooking')),
									el('span', {}, data.createdon),
								]
							),
							el(
								'div',
								{
									className: 'vbo-sh-info-control'
								},
								[
									el('label', {}, __('Assignee:', 'vikbooking')),
									assigneeField
								]
							),
							el(
								'div',
								{
									className: 'vbo-sh-info-control'
								},
								el(
									wp.components.TextareaControl,
									{
										label: __('Shortcode:', 'vikbooking'),
										value: data.shortcode,
										readonly: true,
									}
								)
							),
						));
					}
				}
			}

			// build SVG for shortcode dashicon
			var svg = el(
				'svg',
				{
					className: 'dashicon dashicons-shortcode',
					role: 'img',
					focusable: false,
					xmlns: 'http://www.w3.org/2000/svg',
					width: '20',
					height: '20',
					viewBox: '0 0 20 20',
				},
				el(
					'path',
					{
						d: 'M6 14H4V6h2V4H2v12h4M7.1 17h2.1l3.7-14h-2.1M14 4v2h2v8h-2v2h4V4',
					}
				)
			);

			/**
			 * Use the new version of InspectorControls
			 * provided by WordPress 5.4, if supported.
			 * 
			 * @since 	1.3.1
			 */
			var InspectorControls;

			if (wp.blockEditor && wp.blockEditor.InspectorControls) {
				// use new version
				InspectorControls = wp.blockEditor.InspectorControls;
			} else {
				// fallback to the older one
				InspectorControls = wp.editor.InspectorControls;
			}

			// setup inspector (right-side area)
			var controls = el(
				// create InspectorControls element
				InspectorControls,
				// define inspector properties
				{
					key: 'controls',
				},
				// add accordion
				el(
					wp.components.PanelBody,
					{
						title: __('Shortcode'),
						initialOpen: true,
					},
					// add shortcodes information
					shortcodes_boxes,
					el(
						wp.components.ToggleControl,
						{
							label: 'See all',
							checked: togglerChecked,
							help: togglerChecked ? __('Display all the existing shortcodes.', 'vikbooking') : __('Toggle to display also the shortcodes that are already assigned to a post.', 'vikbooking'),
							onChange: function(toggler) {
								props.setAttributes({toggler: toggler ? "1" : "0"});
							}
						}
					)
				)
			);

			return [
				controls,
				el(
					// create <div> wrapper
					'div',
					// define wrapper properties
					{
						className: 'vbo-shortcode-admin-wrapper',
					},
					// <div> contains select
					el(
						// create <select> for shortcode
						wp.components.SelectControl,
						// define select properties
						{
							label: [svg, __('Shortcode')],
							value: props.attributes.shortcode,
							onChange: function(shortcode) {
								props.setAttributes({shortcode: shortcode});
							},
							options: options,
							className: 'wp-block-shortcode',
						}
					)
				)
			];
		},

		/**
		 * The save function defines the way in which the different attributes should be combined
		 * into the final markup, which is then serialized by Gutenberg into `post_content`.
		 * @link https://wordpress.org/gutenberg/handbook/block-edit-save/#save
		 *
		 * @return 	Element  Element to render.
		 */
		 save: function(props) {
			var shortcode = props.attributes.shortcode;

			return el(
				'div',
				{
					className: props.className,
				},
				shortcode
			);
		}
	});

})(window.wp);
