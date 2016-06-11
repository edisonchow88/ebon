<style>
.banner {
	position: relative;
	background-color:#000;
}

.banner :hover {
	cursor:pointer;
}

.banner_description {
	padding:7px 15px 15px 15px;
	border:thin solid #CCC;
	width:100%;
	background-color:#FFF;
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

@media screen and (min-width: 796px) {
      .banner_description {
		 position: absolute;
         bottom:0px;
		 background-color:#000;
		 border:none;
		 opacity:0.6;
		 color:#FFF;
      }
	  
	  .banner_description .text-info {
		  color:#FFF;
	  }
}
</style>

<div class="banner">
    <a class="banner_content" href="<?php echo $itinerary1; ?>">
        <img src="resources/image/banner/hokkaido_winter.jpg" width="100%"/>
        <div class="banner_description">
            <div class="row">
                <div class="col-xs-12 text-info" style="font-size:20px;">White Hokkaido Love Story</div>
            </div>
            <div class="row margin-top-half">
                <div class="col-xs-3 text-center border-right margin-left-minus">
                    <div style="font-size:24px;">6</div>
                    <div class="small">DAYS</div>
                </div>
                <div class="col-xs-3 text-center border-right">
                    <div style="font-size:24px;">&#9731;</div>
                    <div class="small">DEC-MAR</div>
                </div>
                <div class="col-xs-6 col-md-5 small padding-left">
                    <div>Rusutsu Ski</div>
                    <div>Otaru Canal</div>
                    <div>Noboribetsu Hot Spring</div>
                </div>
                <div class="hidden-xs hidden-sm col-md-1 small text-right">
                    <i class="fa fa-chevron-right fa-3x"></i>
                </div>
            </div>
        </div>
    </a>
</div>

<div class="banner margin-top">
    <a class="banner_content" href="<?php echo $itinerary2; ?>">
        <img src="resources/image/banner/hokkaido_pinkmoss.jpg" width="100%"/>
        <div class="banner_description">
            <div class="row">
                <div class="col-xs-12 text-info" style="font-size:20px;">Hokkaido Pink Moss</div>
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
                <div class="col-xs-6 col-md-5 small padding-left">
                    <div>Takinoue Pink Moss</div>
                    <div>Akan National Park</div>
                    <div>Sounkyo Hot Spring</div>
                </div>
                <div class="hidden-xs hidden-sm col-md-1 small text-right">
                    <i class="fa fa-chevron-right fa-3x"></i>
                </div>
            </div>
        </div>
    </a>
</div>

<div class="banner margin-top">
    <a class="banner_content" href="<?php echo $itinerary3; ?>">
        <img src="resources/image/banner/hokkaido_lavender.jpg" width="100%"/>
        <div class="banner_description">
            <div class="row">
                <div class="col-xs-12 text-info" style="font-size:20px;">Hokkaido Purple Romance</div>
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
                <div class="col-xs-6 col-md-5 small padding-left">
                    <div>Furano Lavender</div>
                    <div>Yubari Melon</div>
                    <div>Noboribetsu Hot Spring</div>
                </div>
                <div class="hidden-xs hidden-sm col-md-1 small text-right">
                    <i class="fa fa-chevron-right fa-3x"></i>
                </div>
            </div>
        </div>
    </a>
</div>