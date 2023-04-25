/* VikFXThumbSlide v1.1 */

jQuery.noConflict();
jQuery.VikFXThumbSlide = function () {
	var thumbslides = [],
		defaultsettings = {
			// Default Settings
			fadeTime : 600,
			timeForSlideInSlideshow : 2500,
			startIndex : 1,
			startSlideshowAtLoad : false,
			thumbnailActivationEvent : "click",
			useFadingIn : true,
			useFadingOut : true,
			useFadeWhenNotSlideshow : true,
			useFadeForSlideshow : true,
			loopSlideshow : true,
			usePreloading : true,
			useAltAsTooltip : false,
			mainImageClass : "vikfx-thumbslide-image",
			captionContainerClass : "vikfx-thumbslide-caption",
			fadeContainerClass : "vikfx-thumbslide-fade-container",
			thumbnailContainerClass: "vikfx-thumbslide-thumbnails",
			useNavigationControls: true,
			previousLinkClass : "vikfx-thumbslide-previous-image",
			nextLinkClass : "vikfx-thumbslide-next-image",
			startSlideShowClass : "vikfx-thumbslide-start-slideshow",
			stopSlideShowClass : "vikfx-thumbslide-stop-slideshow"
		},

		set = function (settings) {
			thumbslides.push(jQuery.extend({}, defaultsettings, settings));
		},
		
		fix = function (fxselector) {
			var nowc = 0;
			jQuery(fxselector).each(function () {
				if(thumbslides.length < jQuery(fxselector).length && !thumbslides[nowc]) {
					thumbslides[nowc] = thumbslides[(nowc - 1)];
				}
				nowc++;
			});
		},
		
		init = function (fxselector) {
			fix(fxselector);
			var counter = 0;
			jQuery(fxselector).each(function () {
				var elm = jQuery(this),
					
					// Element references
					settings = thumbslides[counter++],
					mainImage = elm.find("." + settings.mainImageClass),
					captionContainer = elm.find("." + settings.captionContainerClass),
					fadeContainer = elm.find("." + settings.fadeContainerClass),
					useNavigationControls = settings.useNavigationControls,
					previousLink = elm.find("." + settings.previousLinkClass),
					nextLink = elm.find("." + settings.nextLinkClass),
					startSlideShowLink = elm.find("." + settings.startSlideShowClass),
					stopSlideShowLink = elm.find("." + settings.stopSlideShowClass),
					thumbnailContainer = elm.find("." + settings.thumbnailContainerClass),
					thumbnailEvent = settings.thumbnailActivationEvent,
					thumbnailLinks,
					
					// General image settings
					usePreloading = settings.usePreloading,
					useAltAsTooltip = settings.useAltAsTooltip,
					images = settings.images,
					startIndex = (settings.startIndex > 0)? (settings.startIndex - 1) : settings.startIndex,
					imageIndex = startIndex,
					currentImageIndex = imageIndex,
					
					// General fade settings
					useFadingIn = settings.useFadingIn,
					useFadingOut = settings.useFadingOut,
					useFadeWhenNotSlideshow = settings.useFadeWhenNotSlideshow,
					useFadeForSlideshow = settings.useFadeForSlideshow,
					loopSlideshow = settings.loopSlideshow,
					fadeTime = settings.fadeTime,
					timeForSlideInSlideshow = settings.timeForSlideInSlideshow,
					startSlideshowAtLoad = settings.startSlideshowAtLoad,
					slideshowPlaying = false,
					timer,
					
					// Sets main image
					setImage = function () {
						if (!images.hasOwnProperty(imageIndex)) {
							return;
						}
						// Set main image values
						var imageItem = images[imageIndex];
						mainImage.attr({
							src : imageItem.image,
							alt : imageItem.alt
						});
						
						//Caption
						if(imageItem.hasOwnProperty("caption") && imageItem.caption.length > 0) {
							captionContainer.html("<div>"+imageItem.caption+"</div>");
						}else {
							captionContainer.html("");
						}
						
						// If the alt text should be used as the tooltip
						if (useAltAsTooltip) {
							mainImage.attr("title", imageItem.alt);
						}
						
						if (!loopSlideshow) {
							// Enabling/disabling previous link
							if (imageIndex === 0) {
								previousLink.addClass("vikfx-thumbslide-disabled");
							}
							else {
								previousLink.removeClass("vikfx-thumbslide-disabled");
							}
						
							// Enabling/disabling next link
							if (imageIndex === (images.length - 1)) {
								nextLink.addClass("vikfx-thumbslide-disabled");
							}
							else {
								nextLink.removeClass("vikfx-thumbslide-disabled");
							}
						}
						
						// Keeping a reference to the current image index
						currentImageIndex = imageIndex;
						
						// Adding/removing classes from thumbnail
						if (thumbnailContainer[0]) {							
							thumbnailLinks.removeClass("vikfx-thumbslide-selected-thumbnail");
							jQuery(thumbnailLinks[imageIndex]).addClass("vikfx-thumbslide-selected-thumbnail");
						}
					},
					
					// Navigate to previous image
					prev = function () {
						if (imageIndex > 0 || loopSlideshow) {
							if (imageIndex === 0) {
								imageIndex = (images.length -1);
							}
							else {
								imageIndex = --imageIndex;
							}
							if (useFadingOut && (useFadeWhenNotSlideshow || slideshowPlaying) && imageIndex !== currentImageIndex) {
								fadeContainer.stop();
								fadeContainer.fadeTo(fadeTime, 0, function () {
									setImage(imageIndex);									
								});	
							}
							else {
								if (useFadingIn && imageIndex !== currentImageIndex) {
									fadeContainer.css("opacity", "0");
								}
								setImage(imageIndex);
							}
						}
					},
					
					// Navigate to next image
					next = function (specifiedIndex) {
						if (imageIndex < (images.length -1) || typeof specifiedIndex !== "undefined" || loopSlideshow) {
							if (typeof specifiedIndex !== "undefined") {
								imageIndex = specifiedIndex;
							}
							else if (imageIndex === (images.length-1)) {
								imageIndex = 0;
							}
							else {
								imageIndex = ++imageIndex;
							}
							if (useFadingOut && (useFadeWhenNotSlideshow || slideshowPlaying) && imageIndex !== currentImageIndex) {
								fadeContainer.stop();
								fadeContainer.fadeTo(fadeTime, 0, function () {
									setImage(imageIndex);									
								});
							}
							else {
								if (useFadingIn && imageIndex !== currentImageIndex) {
									fadeContainer.css("opacity", "0");
								}	
								setImage(imageIndex);
							}
						}
						else {
							stopSlideshow();
						}
					},
					
					// Start slideshow
					startSlideshow = function () {
						slideshowPlaying = true;
						startSlideShowLink.css('display', 'none');
						stopSlideShowLink.css('display', 'inline-block');
						clearTimeout(timer);
						timer = setTimeout(function () {
							next();
						}, timeForSlideInSlideshow);
					},
					
					// Stop slideshow
					stopSlideshow = function () {
						clearTimeout(timer);
						slideshowPlaying = false;
						startSlideShowLink.css('display', 'inline-block');
						stopSlideShowLink.css('display', 'none');
					};

				// Fade in/show image when it has loaded
				mainImage[0].onload = function () {
					if (useFadingIn && (useFadeWhenNotSlideshow || slideshowPlaying)) {
						fadeContainer.fadeTo(fadeTime, 1, function () {
							if (slideshowPlaying) {
								clearTimeout(timer);
								timer = setTimeout(function () {
									next();
								}, timeForSlideInSlideshow);
							}
						});
					}
					else {
						fadeContainer.css("opacity", "1");
						fadeContainer.show();
						if (slideshowPlaying) {
							clearTimeout(timer);
							timer = setTimeout(function () {
								next();
							}, timeForSlideInSlideshow);
						}
					}
				};
				
				mainImage[0].onerror = function () {
					fadeContainer.css("opacity", "1");
					if (slideshowPlaying) {
						clearTimeout(timer);
						timer = setTimeout(function () {
							next();
						}, timeForSlideInSlideshow);
					}
				};
										
				// Previous image click
				previousLink.click(function (evt) {
					prev();
					return false;
				});
				
				// Next image click
				nextLink.click(function (evt) {
					next();
					return false;
				});
				
				// Start slideshow click
				startSlideShowLink.click(function () {
					startSlideshow();
					return false;
				});
				
				// Stop slideshow click
				stopSlideShowLink.click(function () {
					stopSlideshow();
					return false;
				});
				
				// Shows navigation links
				if(useNavigationControls) {
					previousLink.css('display', 'inline-block');
					nextLink.css('display', 'inline-block');
					startSlideShowLink.css('display', 'inline-block');
				}
				
				// Thumbnail references
				if (thumbnailContainer[0]) {
					thumbnailLinks = jQuery(thumbnailContainer).find("a");
					jQuery(thumbnailLinks[imageIndex]).addClass("vikfx-thumbslide-selected-thumbnail");
					for (var i=0, il=thumbnailLinks.length, thumbnailLink; i<il; i++) {
						thumbnailLink = jQuery(thumbnailLinks[i]);
						thumbnailLink.data("linkIndex", i);
						thumbnailLink.bind(thumbnailEvent, function (evt) {
							next(jQuery(this).data("linkIndex"));
							this.blur();
							return false;
						});
					}
				}
				
				// Sets initial image
				setImage();
				
				// If play slideshow at load
				if (startSlideshowAtLoad) {
					startSlideshow();
				}
				
				if (usePreloading) {
					var imagePreLoadingContainer = jQuery("<div />").appendTo(document.body).css("display", "none");
					for (var j=0, jl=images.length, image; j<jl; j++) {
						jQuery('<img src="' + images[j].image + '" alt="" />').appendTo(imagePreLoadingContainer);
					}
				}
			});
		};
	return {
		set : set,
		init : init
	};
}();
