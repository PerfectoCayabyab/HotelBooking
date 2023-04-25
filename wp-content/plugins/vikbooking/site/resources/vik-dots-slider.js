/**
 * @package     VikBooking
 * @subpackage  vikDotsSlider
 * @version 	1.2.0
 * @author      Alessio Gaggii - E4J srl
 * @copyright   Copyright (C) 2021 E4J srl. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE
 * @link        https://e4j.com - https://vikwp.com
 */

(function($) {

	var VikDotsSlider = function(elem, options) {

		this.sliderElement = elem;
		this.sliderDataName = 'vik-dots-slider-id';
		this.sliderIdPrefix = 'vik-dots-slider-id-';
		this.xDown = null;
		this.yDown = null;
		this.preloadedImages = [];
		this.currentSlide = 0;
		this.previousSlide = 0;
		this.sliderContainer = null;

		this.defaultSettings = {
			images: [],
			captions: [],
			containerClass: 'vik-dots-slider-container',
			containerHeight: '200px',
			innerClass: 'vik-dots-slider-inner',
			slidesClass: 'vik-dots-slider-slides',
			slideClass: 'vik-dots-slider-slide',
			captionClass: 'vik-dots-slider-slide-caption',
			slideStartClass: 'vik-dots-slider-slide-start',
			slideLeftCurrClass: 'vik-dots-slider-slide-leftcurr',
			slideLeftNextClass: 'vik-dots-slider-slide-leftnext',
			slideRightNextClass: 'vik-dots-slider-slide-rightnext',
			slideRightCurrClass: 'vik-dots-slider-slide-rightcurr',
			dotsContainerClass: 'vik-dots-slider-dots',
			dotClass: 'vik-dots-slider-dot',
			activeDotClass: 'vik-dots-slider-dot-active',
			hasmoreDotClass: 'vik-dots-slider-dot-hasmore',
			maxDots: 5,
			navButContainerClass: 'vik-dots-slider-navbuttons',
			navButClass: 'vik-dots-slider-navbutton',
			navButPrevClass: 'vik-dots-slider-navbutton-prev',
			navButNextClass: 'vik-dots-slider-navbutton-next',
			navButPrevContent: '&lt;',
			navButNextContent: '&gt;',
			enableGestures: true,
			onDisplaySlide: function() {},
		};

		this.settings = $.extend(true, {}, this.defaultSettings, options);

		this.options = function(options) {
			return options ? $.extend(true, this.settings, options) : this.settings;
		};

		this.countSlides = function() {
			return this.settings.images.length;
		};

		this.generateSliderId = function() {
			return ((parseInt(Math.random() * 1000)) + '');
		};

		this.goToSlide = function(e) {
			if (e) {
				e.preventDefault();
			}
			// retrieve dot from data passed to event handler
			var dot = jQuery(e.data.dot);
			var gotopos = dot.data('pos');
			if (gotopos == null || gotopos == this.currentSlide) {
				return false;
			}
			if (gotopos > this.currentSlide) {
				// show requested slide navigating left
				this.showSlide((gotopos + 1));
			} else {
				// show requested slide navigating right
				this.showSlide((gotopos + 1), true);
			}
		};

		this.prevSlide = function(e) {
			if (e) {
				e.preventDefault();
			}
			var gotopos = this.currentSlide - 1;
			if (gotopos < 0) {
				gotopos = (this.countSlides() - 1);
			} else if (gotopos >= this.countSlides()) {
				gotopos = 0;
			}
			if (gotopos == this.currentSlide) {
				return false;
			}
			if (gotopos > this.currentSlide) {
				// show requested slide navigating left
				this.showSlide((gotopos + 1));
			} else {
				// show requested slide navigating right
				this.showSlide((gotopos + 1), true);
			}
		};

		this.nextSlide = function(e) {
			if (e) {
				e.preventDefault();
			}
			var gotopos = this.currentSlide + 1;
			if (gotopos < 0) {
				gotopos = (this.countSlides() - 1);
			} else if (gotopos >= this.countSlides()) {
				gotopos = 0;
			}
			if (gotopos == this.currentSlide) {
				return false;
			}
			if (gotopos > this.currentSlide) {
				// show requested slide navigating left
				this.showSlide((gotopos + 1));
			} else {
				// show requested slide navigating right
				this.showSlide((gotopos + 1), true);
			}
		};

		this.getSlide = function(i) {
			if (this.sliderContainer == null) {
				return [];
			}

			return this.sliderContainer.find('.' + this.settings.slideClass + '[data-pos="' + i + '"]');
		};

		this.getDot = function(i) {
			if (this.sliderContainer == null) {
				return [];
			}

			return this.sliderContainer.find('.' + this.settings.dotClass + '[data-pos="' + i + '"]');
		};

		this.getDotByIndex = function(i) {
			if (this.sliderContainer == null) {
				return [];
			}

			return this.sliderContainer.find('.' + this.settings.dotClass).eq(i);
		};

		this.showSlide = function(pos, right) {
			if (this.sliderContainer == null) {
				return false;
			}

			var animatingClasses = [
				this.settings.slideLeftCurrClass,
				this.settings.slideLeftNextClass,
				this.settings.slideRightNextClass,
				this.settings.slideRightCurrClass,
			];
			var removeClasses = animatingClasses.join(' ');

			if (!pos) {
				pos = ((this.currentSlide + 1) < this.countSlides() ? (this.currentSlide + 2) : 1);
			}

			--pos;
			// update previous slide
			this.getSlide(this.previousSlide).removeClass(removeClasses);

			if (!right) {
				this.getSlide(pos).removeClass(removeClasses).addClass(this.settings.slideLeftNextClass);
				this.getSlide(this.currentSlide).removeClass(removeClasses).addClass(this.settings.slideLeftCurrClass);
			} else {
				this.getSlide(pos).removeClass(removeClasses).addClass(this.settings.slideRightNextClass);
				this.getSlide(this.currentSlide).removeClass(removeClasses).addClass(this.settings.slideRightCurrClass);
			}

			this.previousSlide = this.currentSlide;
			this.currentSlide = pos;

			var currentDot = this.getDot(this.currentSlide);
			if (currentDot.length) {
				currentDot.addClass(this.settings.activeDotClass);
			}
			var prevDot = this.getDot(this.previousSlide);
			if (prevDot.length) {
				prevDot.removeClass(this.settings.activeDotClass);
			}

			// update dots pos attributes in case max dots was reached
			if (this.countSlides() > this.settings.maxDots && this.settings.maxDots > 1) {
				// dots cannot represent all slides
				var isFirstSlide = (this.currentSlide === 0);
				var isLastSlide = ((this.currentSlide + 1) == this.countSlides());

				if (isFirstSlide) {
					// renumber dots from the beginning
					for (var d = 0; d < this.settings.maxDots; d++) {
						var dot = this.getDotByIndex(d);
						if (dot.length) {
							dot.data('pos', d).attr('data-pos', d);
							if (d === 0) {
								dot.addClass(this.settings.activeDotClass).removeClass(this.settings.hasmoreDotClass);
							} else {
								dot.removeClass(this.settings.activeDotClass);
								if (d === (this.settings.maxDots - 1)) {
									dot.addClass(this.settings.hasmoreDotClass);
								}
							}
						}
					}
				} else if (isLastSlide) {
					// renumber dots from the end
					var missingdots = (this.countSlides() - this.settings.maxDots);
					for (var d = 0; d < this.settings.maxDots; d++) {
						var dot = this.getDotByIndex(d);
						if (dot.length) {
							var newpos = d + missingdots;
							dot.data('pos', newpos).attr('data-pos', newpos);
							if (d === (this.settings.maxDots - 1)) {
								dot.addClass(this.settings.activeDotClass).removeClass(this.settings.hasmoreDotClass);
							} else {
								dot.removeClass(this.settings.activeDotClass);
								if (d === 0) {
									dot.addClass(this.settings.hasmoreDotClass);
								}
							}
						}
					}
				} else  {
					// we are in the middle, renumber dots
					var dotselindex = (this.currentSlide + 1) < this.settings.maxDots ? this.currentSlide : (this.settings.maxDots - 2);
					var dotaddpos = (this.currentSlide + 1) < this.settings.maxDots ? 0 : (this.currentSlide - this.settings.maxDots + 2);
					var dothasmoreindex = (this.currentSlide + 1) >= this.settings.maxDots ? [0, dotselindex + 1] : [-1, this.settings.maxDots - 1];
					for (var d = 0; d < this.settings.maxDots; d++) {
						var dot = this.getDotByIndex(d);
						if (dot.length) {
							var newpos = d + dotaddpos;
							dot.data('pos', newpos).attr('data-pos', newpos);
							if (d == dotselindex) {
								dot.addClass(this.settings.activeDotClass);
							} else {
								dot.removeClass(this.settings.activeDotClass);
							}
							if (d === dothasmoreindex[0] || d === dothasmoreindex[1]) {
								dot.addClass(this.settings.hasmoreDotClass);
							} else {
								dot.removeClass(this.settings.hasmoreDotClass);
							}
						}
					}
				}
			}
		};

		this.generateNavButtons = function() {
			var navbuttons = $('<div></div>').addClass(this.settings.navButContainerClass);
			if (this.countSlides() < 2) {
				return navbuttons;
			}
			var navprev = $('<span></span>').addClass(this.settings.navButClass + ' ' + this.settings.navButPrevClass).append(this.settings.navButPrevContent).on('click', this.prevSlide.bind(this));
			var navnext = $('<span></span>').addClass(this.settings.navButClass + ' ' + this.settings.navButNextClass).append(this.settings.navButNextContent).on('click', this.nextSlide.bind(this));
			navbuttons.append(navprev).append(navnext);

			return navbuttons;
		};

		this.generateDots = function() {
			var dots = $('<div></div>').addClass(this.settings.dotsContainerClass);
			var tot_slides = this.countSlides();
			if (this.settings.maxDots < 1 || tot_slides < 2) {
				return dots;
			}
			var canfitall = (this.settings.maxDots >= tot_slides);
			for (var i = 0; i < tot_slides; i++) {
				// generate dot, set pos attribute
				var dot = $('<span></span>').addClass(this.settings.dotClass).data('pos', i).attr('data-pos', i);
				// define click handler by passing the collection and by binding thisArg to the class instance
				dot.on('click', {dot: dot}, this.goToSlide.bind(this))
				if (i == this.currentSlide) {
					dot.addClass(this.settings.activeDotClass);
				}
				if (!canfitall && i == (this.settings.maxDots - 1)) {
					dot.addClass(this.settings.hasmoreDotClass);
				}
				dots.append(dot);
				if ((i + 1) == this.settings.maxDots) {
					break;
				}
			}
			
			return dots;
		};

		this.generateSlides = function() {
			var slides = $('<div></div>').addClass(this.settings.slidesClass);
			for (var i = 0; i < this.countSlides(); i++) {
				var slide = $('<div></div>').data('pos', i).attr('data-pos', i).addClass(this.settings.slideClass);
				if (i == this.currentSlide) {
					slide.addClass(this.settings.slideStartClass);
				}
				if (this.settings.captions.hasOwnProperty(i) && this.settings.captions[i].length) {
					var caption = $('<span></span>').addClass(this.settings.captionClass).text(this.settings.captions[i]);
					slide.append(caption);
				}
				var photo = $('<img src="' + this.settings.images[i] + '" />');
				slide.append(photo);

				// fire onDisplaySlide callback by passing the whole slide content
				this.settings.onDisplaySlide.call(slide);

				// append slide
				slides.append(slide);
			}
			
			return slides;
		};

		this.sliderTouches = function(e) {
			if (!this.settings.enableGestures) {
				return false;
			}
			if (e.touches) {
				// JS
				return e.touches;
			}
			if (e.originalEvent.touches) {
				// jQuery
				return e.originalEvent.touches;
			}
			return false;
		};

		this.sliderTouchStart = function(e) {
			var firstTouch = this.sliderTouches(e)[0];
			if (firstTouch === false) {
				return;
			}
			this.xDown = firstTouch.clientX;
			this.yDown = firstTouch.clientY;
		};

		this.sliderTouchMove = function(e) {
			if (!this.xDown || !this.yDown || this.countSlides() < 2) {
				return;
			}
			// register touch positions
			var xUp = e.touches[0].clientX;
			var yUp = e.touches[0].clientY;
			var xDiff = this.xDown - xUp;
			var yDiff = this.yDown - yUp;

			// detect gesture type
			if (Math.abs(xDiff) > Math.abs(yDiff)) {
				if (xDiff > 0) {
					// left swipe, navigate forward
					this.nextSlide(e);
				} else {
					// right swipe, navigate backward
					this.prevSlide(e);
				}
			} else {
				if (yDiff > 0) {
					// up swipe is ignored
				} else {
					// down swipe is ignored
				}
			}
			
			// reset vars to handle the next touch gesture
			this.xDown = null;
			this.yDown = null;
		};

		this.registerGestures = function(elem) {
			if (!elem) {
				return;
			}
			elem.addEventListener('touchstart', this.sliderTouchStart.bind(this), false);
			elem.addEventListener('touchmove', this.sliderTouchMove.bind(this), false);
		};

		this.preloadURLs = function(urls) {
			if (urls == null || !urls.length) {
				return;
			}
			for (var i = 0; i < urls.length; i++) {
				var photoslide = (new Image()).src = urls[i];
				this.preloadedImages.push(photoslide);
			}
		};

		this.display = function() {
			// update global vars
			this.currentSlide = 0;
			this.previousSlide = (this.countSlides() - 1);

			// if an instance is already present in the current element, remove it
			if (this.sliderElement.find('.' + this.settings.containerClass).length) {
				this.sliderElement.find('.' + this.settings.containerClass).remove();
			}

			// generate slider random ID
			var sliderId = this.generateSliderId();

			// generate slider container by updating global var
			this.sliderContainer = $('<div></div>').addClass(this.settings.containerClass).data(this.sliderDataName, sliderId).attr('id', this.sliderIdPrefix + sliderId);

			// register gesture events for mobiles
			this.registerGestures(this.sliderContainer[0]);

			// builder slider inner
			var inner = $('<div></div>').addClass(this.settings.innerClass).css('height', this.settings.containerHeight);
			
			// build slider container
			this.sliderContainer.append(
				inner.append(
					this.generateSlides().append(
						this.generateNavButtons()
					)
				).append(
					this.generateDots()
				)
			);

			// append slider to current selector
			this.sliderElement.append(this.sliderContainer);
		};

		this.update = function() {
			this.destroy();
			this.display();
		};

		this.destroy = function() {
			this.sliderContainer.remove();
		};

		this.preloadImages = function(gallery) {
			gallery = gallery[0];
			if (gallery == null) {
				return false;
			}
			
			var preloadQueue = {};
			
			for (var gallery_id in gallery) {
				if (!gallery.hasOwnProperty(gallery_id)) {
					continue;
				}
				if (typeof gallery[gallery_id] == 'string' && gallery[gallery_id].indexOf('http') >= 0) {
					// we have an array of photo URLs
					var photoslide = (new Image()).src = gallery[gallery_id];
					this.preloadedImages.push(photoslide);
					continue;
				}
				if (typeof gallery[gallery_id] == 'object' && gallery[gallery_id].length) {
					// we have a gallery object with the photos of each room so we queue the preloading
					for (var i = 0; i < gallery[gallery_id].length; i++) {
						if (!preloadQueue.hasOwnProperty(i)) {
							preloadQueue[i] = [];
						}
						// push the photo url for later loading
						preloadQueue[i].push(gallery[gallery_id][i]);
					}
				}
			}

			// if some preloading was queued, define the loading intervals
			var queue_timer = 0;
			for (var i in preloadQueue) {
				if (!preloadQueue.hasOwnProperty(i)) {
					continue;
				}
				// schedule preloading with timeout
				setTimeout(this.preloadURLs.bind(this, preloadQueue[i]), queue_timer);
				// increase timer for next scheduling (1 second per photo)
				queue_timer += (1000 * preloadQueue[i].length);
			}

			return this.preloadedImages;
		};

	};

	$.fn.vikDotsSlider = function(methodOrOptions) {

		var method = typeof methodOrOptions === 'string' ? methodOrOptions : null;

		if (method) {
			var sliderInstances = [];

			function getVikDotsSliderInstance() {
				var vikDotsSlider = $(this).data('vikDotsSlider');
				sliderInstances.push(vikDotsSlider);
			}

			this.each(getVikDotsSliderInstance);

			var args    = (arguments.length > 1) ? Array.prototype.slice.call(arguments, 1) : null;
			var results = [];

			function applyMethod(index) {
				var vikDotsSlider = sliderInstances[index];

				if (!vikDotsSlider) {
					if (method == 'preloadImages') {
						// preloadImages is the only method that can be called before instantiating vikDotsSlider
						vikDotsSlider = new VikDotsSlider($(this), {});
						var result = vikDotsSlider[method].call(vikDotsSlider, $(this));
						results.push(result);
						return;
					} else {
						console.error('$.vikDotsSlider not instantiated yet');
						results.push(null);
						return;
					}
				}

				if (typeof vikDotsSlider[method] === 'function') {
					var result = vikDotsSlider[method].apply(vikDotsSlider, args);
					results.push(result);
				} else {
					console.error('Method \'' + method + '\' is undefined in $.vikDotsSlider');
				}
			}

			this.each(applyMethod);

			return (results.length > 1) ? results : results[0];
		} else {
			var options = (typeof methodOrOptions === 'object') ? methodOrOptions : null;

			function init() {
				var vikDotsSlider = new VikDotsSlider($(this), options);

				vikDotsSlider.display();

				$(this).data('vikDotsSlider', vikDotsSlider);
			}

			return this.each(init);
		}

	};

})(jQuery);
