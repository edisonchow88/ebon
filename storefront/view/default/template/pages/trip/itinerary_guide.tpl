<style>
	.spacer-bar {
		min-height:20px;
	}
	
	#section-itinerary-guide {
		text-align:left;
	}
	
	#section-itinerary-guide-header {
		padding:7px;
		border-bottom:solid thin #EEE;
	}
	
	#section-itinerary-guide-header .input-group {
		border-radius:10px;
	}
	
	#section-itinerary-guide-header .form-control {
		border-radius:10px;
	}
	
	#section-itinerary-guide-header .btn-simple {
		padding-right:0;
		padding-left:0;
	}
	
	#section-itinerary-guide-header-close {
		font-size:24px;
		line-height:14px;
	}
	
	#section-itinerary-guide-content {
		padding:7px;
		overflow-y:auto;
		overflow-x:hidden;
	}
</style>

<div id="section-itinerary-guide">
    <div id="section-itinerary-guide-header">
        <div class="row">
            <div class="spacer-bar hidden-xs hidden-sm col-md-12 col-lg-12"></div>
        </div>
        <div class="row">
            <div class="input-group pull-left inline col-xs-12 col-sm-12 col-md-12 col-lg-9">
                <input class="form-control" type="text" placeholder='Search ...'  />
            </div>
            <div class="inline pull-right col-md-12 col-lg-3">
                <a 
                	class="btn btn-simple hidden-xs hidden-sm hidden-md pull-right" 
                	onclick="close_section_content('guide');"
                    data-toggle='tooltip' 
                    data-placement='bottom' 
                    title='Close Guide' 
                >
                	<i class="fa fa-fw" id="section-itinerary-guide-header-close">&times;</i>
                </a>
                <a 
                	class="btn btn-simple hidden-xs hidden-sm hidden-md pull-right" 
                	onclick="open_section_content('guide');"
                    data-toggle='tooltip' 
                    data-placement='bottom' 
                    title='Expand Guide' 
                >
                	<i class="fa fa-fw fa-arrows-alt"></i>
                </a>
            </div>
        </div>
    </div>
    <div id="section-itinerary-guide-content">
        <div><a><span>Malaysia</span> ></a></div>
    </div>
</div>