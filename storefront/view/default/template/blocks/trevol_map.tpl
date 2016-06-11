<style type="text/css">
.map {
	opacity: 0.2;
}

.map_airport {
	position: absolute;
	display:none;
	font-size:14px;
	cursor:pointer;
	z-index:100;
}

.map_region_icon {
	position: absolute;
	display:block;
	font-size:14px;
	cursor:pointer;
	z-index:100;
}

.map_city_primary {
	position: absolute;
	display:none;
	font-size:18px;
	font-weight:bold;
	cursor:pointer;
	z-index:100;
}

.map_city {
	position: absolute;
	display:none;
	font-size:12px;
	font-weight:bold;
	cursor:pointer;
	z-index:90;
}

.map_city_small {
	position: absolute;
	display:none;
	font-size:12px;
	font-weight:bold;
	cursor:pointer;
	z-index:80;
}

.map_region {
	position: absolute;
	display:none;
	font-size:16px;
	color:#CCC;
	cursor:pointer;
	z-index:50;
}
</style>
<!-- TEMPORARY DISABLED
<div style="position:fixed; top: 90px; right:0px; z-index:800;">
	<a class="btn btn-info btn-block text-center" style="margin:auto;">
    	<i class="fa fa-compass fa-fw fa-2x fa-inverse" style="margin:auto;"></i>
        <br /><span class="fa-inverse">Map</span>
    </a>
</div>
-->
<a id="map" name="map"></a>
<div class="sidewidt hidden-xs">
	<span class="text-uppercase section-title">MAP</span>
    <div class="text-center" style="padding:10px; background-color:#EEF8FA; min-width:450px; min-height:450px;">
        <div style="position:relative; width:430px; height:430px; margin:auto;">
            <!-- Map -->
            <img class="map" src="resources/image/map/japan.png"/>
            
            <!-- Title -->
            <h1 style="position: absolute; bottom:0px; right:10px;">Japan</h1>
            
            <!-- Marker Airport -->
            <a class="map_airport" style="top:65px; left:315px;" href="<?php echo $link['chitose_airport'];?>"><i class="fa fa-plane fa-fw"></i>Shin-Chitose</a>
            <a class="map_airport" style="top:265px; left:280px;"><i class="fa fa-plane fa-fw"></i>Haneda</a>
            <a class="map_airport" style="top:280px; left:290px;"><i class="fa fa-plane fa-fw"></i>Narita</a>
            <a class="map_airport" style="top:300px; left:185px;"><i class="fa fa-plane fa-fw"></i>Kansai</a>
            
            <!-- Marker Region -->
            <a class="map_region_icon" style="top:25px; left:300px;" href="<?php echo $link['hokkaido'];?>"><img src="resources/image/icon/hokkaido.png"/><br />Hokkaido</a>
            <a class="map_region_icon" style="top:120px; left:280px;" href="<?php echo $link['tohoku'];?>"><img src="resources/image/icon/tohoku.png"/><br />Tohoku</a>
            <a class="map_region_icon" href="<?php echo $link['kanto'];?>" style="top:200px; left:270px;"><img src="resources/image/icon/tokyo.png"/><br />Kanto<br /><span class="small">(Tokyo)</span></a>
            <a class="map_region_icon" href="<?php echo $link['chubu'];?>" style="top:235px; left:220px;"><img src="resources/image/icon/fuji.png"/><br />Chubu</a>
            <a class="map_region_icon" href="<?php echo $link['kansai'];?>" style="top:260px; left:155px;"><img src="resources/image/icon/osaka.png"/><br />Kansai<br /><span class="small">(Osaka, Kyoto)</span></a>
            <a class="map_region_icon" href="<?php echo $link['chugoku'];?>" style="top:235px; left:100px;"><img src="resources/image/icon/chugoku.png"/><br />Chugoku</a>
            <!--<a class="map_region_icon" style="top:310px; left:120px;"><img src="resources/image/icon/shikoku.png"/><br />Shikoku</a>-->
            <a class="map_region_icon" href="<?php echo $link['kyushu'];?>"  style="top:310px; left:40px;"><img src="resources/image/icon/kyushu.png"/><br />Kyushu</a>
            
            <!-- Marker Prefecture -->
            <a class="map_region" style="top:40px; left:325px;" href="<?php echo $link['hokkaido'];?>">Hokkaido</a>
            <a class="map_region" style="top:150px; left:300px;" href="<?php echo $link['tohoku'];?>">Tohoku</a>
            <a class="map_region" style="top:250px; left:280px;" href="<?php echo $link['kanto'];?>">Kanto</a>
            <a class="map_region" style="top:255px; left:220px;" href="<?php echo $link['chubu'];?>">Chubu</a>
            <a class="map_region" style="top:305px; left:185px;" href="<?php echo $link['kansai'];?>">Kansai</a>
            <a class="map_region" style="top:275px; left:120px;" href="<?php echo $link['chugoku'];?>">Chugoku</a>
            <a class="map_region" style="top:320px; left:125px;" href="<?php echo $link['shikoku'];?>">Shikoku</a>
            <a class="map_region" style="top:350px; left:75px;" href="<?php echo $link['kyushu'];?>">Kyushu</a>
    
            <!-- Marker City -->
            <a class="map_city" style="top:60px; left:305px;" href="<?php echo $link['sapporo'];?>"><i class="fa fa-map-marker fa-fw"></i>Sapporo</a>
            <a class="map_city_small" style="top:90px; left:295px;" href="<?php echo $link['hakodate'];?>"><i class="fa fa-map-marker fa-fw"></i>Hakodate</a>
            <a class="map_city_primary" style="top:270px; left:280px;" href="<?php echo $link['tokyo'];?>"><i class="fa fa-star fa-fw"></i>Tokyo</a>
            <a class="map_city_small" style="top:190px; left:310px;" href="<?php echo $link['sendai'];?>"><i class="fa fa-map-marker fa-fw"></i>Sendai</a>
            <a class="map_city_small" style="top:240px; left:230px;" href="<?php echo $link['takayama'];?>"><i class="fa fa-map-marker fa-fw"></i>Takayama</a>
            <a class="map_city_small" style="top:290px; left:240px;" href="<?php echo $link['nagoya'];?>"><i class="fa fa-map-marker fa-fw"></i>Nagoya</a>
            <a class="map_city_small" style="top:270px; left:190px;" href="<?php echo $link['kyoto'];?>"><i class="fa fa-map-marker fa-fw"></i>Kyoto</a>
            <a class="map_city" style="top:285px; left:180px;" href="<?php echo $link['osaka'];?>"><i class="fa fa-map-marker fa-fw"></i>Osaka</a>
            <a class="map_city_small" style="top:295px; left:110px;" href="<?php echo $link['hiroshima'];?>"><i class="fa fa-map-marker fa-fw"></i>Hiroshima</a>
            <a class="map_city_small" style="top:310px; left:60px;" href="<?php echo $link['fukuoka'];?>"><i class="fa fa-map-marker fa-fw"></i>Fukuoka</a>
            
            <!-- Show Region-->
            <a id="button_hide_region_icon_on_map" class="btn btn-link selected" style="position:absolute; top:10px; left:10px; display:block; color:#C00;" onclick="hide_region_icon_on_map()">
                <i class="fa fa-map-marker fa-fw"></i> Region
            </a>
            <a id="button_show_region_icon_on_map"  class="btn btn-link" style="position:absolute; top:10px; left:10px; display:none; " onclick="show_region_icon_on_map()">
                <i class="fa fa-map-marker fa-fw"></i> Region
            </a>
            
            <!-- Show City-->
            <a id="button_hide_city_on_map" class="btn btn-link selected" style="position:absolute; top:30px; left:10px; display:none; color:#C00;" onclick="hide_city_on_map()">
                <i class="fa fa-map-marker fa-fw"></i> City
            </a>
            <a id="button_show_city_on_map"  class="btn btn-link" style="position:absolute; top:30px; left:10px; display:block; " onclick="show_city_on_map()">
                <i class="fa fa-map-marker fa-fw"></i> City
            </a>
            
            <!-- Show Airport-->
            <a id="button_hide_airport_on_map" class="btn btn-link selected" style="position:absolute; top:50px; left:10px; display:none; color:#C00;" onclick="hide_airport_on_map()">
                <i class="fa fa-plane fa-fw"></i> Airport
            </a>
            <a id="button_show_airport_on_map"  class="btn btn-link" style="position:absolute; top:50px; left:10px; display:display; " onclick="show_airport_on_map()">
                <i class="fa fa-plane fa-fw"></i> Airport
            </a>
            
        </div>
    </div>
</div>

<script>
	function show_airport_on_map() {
		var map_airport = document.getElementsByClassName("map_airport").length;
		for(i = 0; i < map_airport; i++) {
			document.getElementsByClassName("map_airport")[i].style.display = "block";
		}
		document.getElementById("button_show_airport_on_map").style.display = "none";
		document.getElementById("button_hide_airport_on_map").style.display = "block";
		hide_region_icon_on_map() ;
		hide_city_on_map();
	}
	
	function hide_airport_on_map() {
		var map_airport = document.getElementsByClassName("map_airport").length;
		for(i = 0; i < map_airport; i++) {
			document.getElementsByClassName("map_airport")[i].style.display = "none";
		}
		document.getElementById("button_show_airport_on_map").style.display = "block";
		document.getElementById("button_hide_airport_on_map").style.display = "none";
	}
	
	function show_region_icon_on_map() {
		var map_region_icon = document.getElementsByClassName("map_region_icon").length;
		for(i = 0; i < map_region_icon; i++) {
			document.getElementsByClassName("map_region_icon")[i].style.display = "block";
		}
		document.getElementById("button_show_region_icon_on_map").style.display = "none";
		document.getElementById("button_hide_region_icon_on_map").style.display = "block";
		hide_airport_on_map() ;
		hide_city_on_map();
	}
	
	function hide_region_icon_on_map() {
		var map_region_icon = document.getElementsByClassName("map_region_icon").length;
		for(i = 0; i < map_region_icon; i++) {
			document.getElementsByClassName("map_region_icon")[i].style.display = "none";
		}
		document.getElementById("button_show_region_icon_on_map").style.display = "block";
		document.getElementById("button_hide_region_icon_on_map").style.display = "none";
	}
	
	function show_city_on_map() {
		var map_city = document.getElementsByClassName("map_city").length;
		for(i = 0; i < map_city; i++) {
			document.getElementsByClassName("map_city")[i].style.display = "block";
		}
		var map_city_small = document.getElementsByClassName("map_city_small").length;
		for(i = 0; i < map_city_small; i++) {
			document.getElementsByClassName("map_city_small")[i].style.display = "block";
		}
		var map_city_primary = document.getElementsByClassName("map_city_primary").length;
		for(i = 0; i < map_city_primary; i++) {
			document.getElementsByClassName("map_city_primary")[i].style.display = "block";
		}
		var map_region = document.getElementsByClassName("map_region").length;
		for(i = 0; i < map_region; i++) {
			document.getElementsByClassName("map_region")[i].style.display = "block";
		}
		document.getElementById("button_show_city_on_map").style.display = "none";
		document.getElementById("button_hide_city_on_map").style.display = "block";
		hide_airport_on_map();
		hide_region_icon_on_map();
	}
	
	function hide_city_on_map() {
		var map_city = document.getElementsByClassName("map_city").length;
		for(i = 0; i < map_city; i++) {
			document.getElementsByClassName("map_city")[i].style.display = "none";
		}
		
		var map_city_small = document.getElementsByClassName("map_city_small").length;
		for(i = 0; i < map_city_small; i++) {
			document.getElementsByClassName("map_city_small")[i].style.display = "none";
		}
		var map_city_primary = document.getElementsByClassName("map_city_primary").length;
		for(i = 0; i < map_city_primary; i++) {
			document.getElementsByClassName("map_city_primary")[i].style.display = "none";
		}
		var map_region = document.getElementsByClassName("map_region").length;
		for(i = 0; i < map_region; i++) {
			document.getElementsByClassName("map_region")[i].style.display = "none";
		}
		document.getElementById("button_show_city_on_map").style.display = "block";
		document.getElementById("button_hide_city_on_map").style.display = "none";
	}
</script>

