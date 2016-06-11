<script type="text/javascript" src="storefront/view/default/javascript/jssor-slider/jssor.slider.min.js"></script>
<!-- use jssor.slider.debug.js instead for debug -->

<script>
	jssor_1_slider_init = function() {
		
		var jssor_1_SlideoTransitions = [
		  [{b:5500,d:3000,o:-1,r:240,e:{r:2}}],
		  [{b:-1,d:1,o:-1,c:{x:51.0,t:-51.0}},{b:0,d:1000,o:1,c:{x:-51.0,t:51.0},e:{o:7,c:{x:7,t:7}}}],
		  [{b:-1,d:1,o:-1,sX:9,sY:9},{b:1000,d:1000,o:1,sX:-9,sY:-9,e:{sX:2,sY:2}}],
		  [{b:-1,d:1,o:-1,r:-180,sX:9,sY:9},{b:2000,d:1000,o:1,r:180,sX:-9,sY:-9,e:{r:2,sX:2,sY:2}}],
		  [{b:-1,d:1,o:-1},{b:3000,d:2000,y:180,o:1,e:{y:16}}],
		  [{b:-1,d:1,o:-1,r:-150},{b:7500,d:1600,o:1,r:150,e:{r:3}}],
		  [{b:10000,d:2000,x:-379,e:{x:7}}],
		  [{b:10000,d:2000,x:-379,e:{x:7}}],
		  [{b:-1,d:1,o:-1,r:288,sX:9,sY:9},{b:9100,d:900,x:-1400,y:-660,o:1,r:-288,sX:-9,sY:-9,e:{r:6}},{b:10000,d:1600,x:-200,o:-1,e:{x:16}}]
		];
		
		var jssor_1_options = {
		  $AutoPlay: false,
		  $SlideDuration: 800,
		  $SlideEasing: $Jease$.$OutQuint,
		  $CaptionSliderOptions: {
			$Class: $JssorCaptionSlideo$,
			$Transitions: jssor_1_SlideoTransitions
		  },
		  $ArrowNavigatorOptions: {
			$Class: $JssorArrowNavigator$
		  },
		  $BulletNavigatorOptions: {
			$Class: $JssorBulletNavigator$
		  }
		};
		
		var jssor_1_slider = new $JssorSlider$("jssor_1", jssor_1_options);
		
		//responsive code begin
		//you can remove responsive code if you don't want the slider scales while window resizing
		function ScaleSlider() {
			var refSize = jssor_1_slider.$Elmt.parentNode.clientWidth;
			if (refSize) {
				refSize = Math.min(refSize, 1920);
				jssor_1_slider.$ScaleWidth(refSize);
			}
			else {
				window.setTimeout(ScaleSlider, 30);
			}
		}
		ScaleSlider();
		$Jssor$.$AddEvent(window, "load", ScaleSlider);
		$Jssor$.$AddEvent(window, "resize", ScaleSlider);
		$Jssor$.$AddEvent(window, "orientationchange", ScaleSlider);
		//responsive code end
	};
</script>

<style>
	
	/* jssor slider bullet navigator skin 05 css */
	/*
	.jssorb05 div           (normal)
	.jssorb05 div:hover     (normal mouseover)
	.jssorb05 .av           (active)
	.jssorb05 .av:hover     (active mouseover)
	.jssorb05 .dn           (mousedown)
	*/
	.jssorb05 {
		position: absolute;
	}
	.jssorb05 div, .jssorb05 div:hover, .jssorb05 .av {
		position: absolute;
		/* size of bullet elment */
		width: 16px;
		height: 16px;
		background: url('image/jssor-slider/b05.png') no-repeat;
		overflow: hidden;
		cursor: pointer;
	}
	.jssorb05 div { background-position: -7px -7px; }
	.jssorb05 div:hover, .jssorb05 .av:hover { background-position: -37px -7px; }
	.jssorb05 .av { background-position: -67px -7px; }
	.jssorb05 .dn, .jssorb05 .dn:hover { background-position: -97px -7px; }

	/* jssor slider arrow navigator skin 22 css */
	/*
	.jssora22l                  (normal)
	.jssora22r                  (normal)
	.jssora22l:hover            (normal mouseover)
	.jssora22r:hover            (normal mouseover)
	.jssora22l.jssora22ldn      (mousedown)
	.jssora22r.jssora22rdn      (mousedown)
	*/
	.jssora22l, .jssora22r {
		display: block;
		position: absolute;
		/* size of arrow element */
		width: 40px;
		height: 58px;
		cursor: pointer;
		background: url('image/jssor-slider/a22.png') center center no-repeat;
		overflow: hidden;
	}
	.jssora22l { background-position: -10px -31px; }
	.jssora22r { background-position: -70px -31px; }
	.jssora22l:hover { background-position: -130px -31px; }
	.jssora22r:hover { background-position: -190px -31px; }
	.jssora22l.jssora22ldn { background-position: -250px -31px; }
	.jssora22r.jssora22rdn { background-position: -310px -31px; }
	
	.banner {
		position: relative;
		background-color:#000;
	}
	
	.banner :hover {
		cursor:pointer;
	}
	
	.border-right {
		border-right: thin solid #CCC;
	}
	
	.padding-left {
		padding-left: 7px;
	}
	
	.margin-left-minus {
		margin-left: -15px;
	}
	
	.banner_description {
		padding:7px 15px 15px 15px;
		width:100%;
		position: absolute;
		bottom:0px;
		border:none;
		color:#FFF;
		text-shadow: 1px 2px 8px #000
	}
	
	.banner_description .text-info {
		color:#FFF;
	}
	
</style>

<a id="itinerary" name="itinerary"></a>
<div class="sidewidt"> <!-- you need this parent div to act as width controller -->
	<div class="row">
    	<div class="col-xs-12">
        	<span class="text-uppercase section-title">Itineraries&nbsp;</span>
            <a href="<?php echo $itineraries; ?>">( See all itineraries )</a>
        </div>
    </div>
    <div id="jssor_1" style="position: relative; margin: 0; top: 0px; left: 0px; width: 800px; height: 400px; overflow: hidden; visibility: hidden;">
        <!-- Loading Screen -->
        <div data-u="loading" style="position: absolute; top: 0px; left: 0px;">
            <div style="filter: alpha(opacity=70); opacity: 0.7; position: absolute; display: block; top: 0px; left: 0px; width: 100%; height: 100%;"></div>
            <div style="position:absolute;display:block;background:url('image/jssor-slider/loading.gif') no-repeat center center;top:0px;left:0px;width:100%;height:100%;"></div>
        </div>
        <div data-u="slides" style="cursor: default; position: relative; top: 0px; left: 0px; width: 800px; height: 400px; overflow: hidden;">
        	
            <!-- Slide 1-->
            <div data-p="225.00" style="display: none;">
            	<div class="banner">
                    <a class="banner_content" href="<?php echo $itinerary3; ?>">
                        <img data-u="image" src="resources/image/banner/hokkaido_lavender.jpg" width="100%"/>
                        <div class="banner_description">
                            <div class="row">
                                <div class="col-xs-12 text-info" style="font-size:36px;">Hokkaido Purple Romance</div>
                            </div>
                            <div class="row margin-top-half">
                                <div class="col-xs-3 text-center border-right margin-left-minus">
                                    <div style="font-size:24px;">7</div>
                                    <div class="small">DAYS</div>
                                </div>
                                <div class="col-xs-3 text-center border-right">
                                    <div style="font-size:24px;">&#10047;</div>
                                    <div class="small">JUL-AUG</div>
                                </div>
                                <div class="col-xs-6 small padding-left">
                                    <div>Furano Lavender</div>
                                    <div>Yubari Melon</div>
                                    <div>Noboribetsu Hot Spring</div>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
            
            <!--Slide 2-->
            <div data-p="225.00" style="display: none;">
                <div class="banner">
                    <a class="banner_content" href="<?php echo $itinerary2; ?>">
                        <img data-u="image" src="resources/image/banner/hokkaido_pinkmoss.jpg" width="100%"/>
                        <div class="banner_description">
                            <div class="row">
                                <div class="col-xs-12 text-info" style="font-size:36px;">Hokkaido Pink Moss</div>
                            </div>
                            <div class="row margin-top-half">
                                <div class="col-xs-3 text-center border-right margin-left-minus">
                                    <div style="font-size:24px;">7</div>
                                    <div class="small">DAYS</div>
                                </div>
                                <div class="col-xs-3 text-center border-right">
                                    <div style="font-size:24px;">&#10047;</div>
                                    <div class="small">JUN-JUL</div>
                                </div>
                                <div class="col-xs-6 small padding-left">
                                    <div>Takinoue Pink Moss</div>
                                    <div>Akan National Park</div>
                                    <div>Sounkyo Hot Spring</div>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
            
            <!-- Slide 3-->
            <div data-p="225.00" style="display: none;">
            	<div class="banner">
                    <a class="banner_content" href="<?php echo $itinerary1; ?>">
                        <img data-u="image" src="resources/image/banner/hokkaido_winter.jpg" />
                        <div class="banner_description">
                        	<div class="row">
                                <div class="col-xs-12 text-info" style="font-size:36px;">White Hokkaido Love Story</div>
                            </div>
                            <div class="row">
                                <div class="col-xs-3 text-center border-right margin-left-minus">
                                    <div style="font-size:24px;">6</div>
                                    <div class="small">DAYS</div>
                                </div>
                                <div class="col-xs-3 text-center border-right">
                                    <div style="font-size:24px;">&#9731;</div>
                                    <div class="small">DEC-MAR</div>
                                </div>
                                <div class="col-xs-6 small padding-left">
                                    <div>Rusutsu Ski</div>
                                    <div>Otaru Canal</div>
                                    <div>Noboribetsu Hot Spring</div>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        
        </div>
        <!-- Bullet Navigator -->
        <div data-u="navigator" class="jssorb05" style="top:16px;right:16px;" data-autocenter="1">
            <!-- bullet navigator item prototype -->
            <div data-u="prototype" style="width:16px;height:16px;"></div>
        </div>
        <!-- Arrow Navigator -->
        <span data-u="arrowleft" class="jssora22l" style="top:0px;left:12px;width:40px;height:58px;" data-autocenter="2"></span>
        <span data-u="arrowright" class="jssora22r" style="top:0px;right:12px;width:40px;height:58px;" data-autocenter="2"></span>
    </div>
</div>
    
<script>
	jssor_1_slider_init();
</script>