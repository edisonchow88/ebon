<style>
.feedback_login_background {
	position:fixed;
	top:0;
	left:0;
	z-index:2000;
	width: 100vw;
	min-height: 100vh;
	background:rgba(0,0,0,0.8);
}

.feedback_login {
	color:#FFF;
	padding:15px;
	position:absolute;
	top:25%;
	left:50%;
	width:300px;
	margin-left: -150px; /*set to a negative number 1/2 of your width*/
}

.feedback_bar {
	position:fixed;
	bottom:1em;
	right:1em;
	z-index:2000;
	width:80vw;
}

.feedback_end_trial_button {
	text-align:right;
}
</style>

<div id="feedback_login_background" class="feedback_login_background" style="display:none;">
	<div class="feedback_login text-center">
    	<div>
            <span class="fa-stack fa-5x">
                <i class="fa fa-circle fa-stack-2x" style="color:#f0ad4e"></i>
                <i class="fa fa-rocket fa-stack-1x fa-inverse"></i>
            </span>
        </div>
        <div>Welcome to TREVOL</div>
        <div style="color:#CCC;"">Your feedback is important</div>
        <div id="feedback_login_warning" class="margin-top-half text-warning"></div>
        <div class="input-group margin-top">
        	<input id="input_trial_fullname" class="form-control" type="text" placeholder="Full Name" />
        	<div class="input-group-btn"><a class="btn btn-warning" onclick="start_trial();">Start Trial</a></div>
        </div>
    </div>
</div>

<!--
<div class="feedback_bar" style="display:block;">
	<div class="input-group margin-top">
    	<div class="input-group-btn"><a class="btn btn-danger" onclick="end_trial();">End Trial</a></div>
        <span class="input-group-addon">Edison:</span>
        <input id="input_trial_feedback" class="form-control" type="text" placeholder="Feedback" style="margin-left:-2px;" />
        <div class="input-group-btn"><a class="btn btn-warning" onclick="send_feedback();" style="margin-left:-4px;">Send</a></div>
    </div>
</div>
-->

<div class="feedback_end_trial_button margin-bottom">
	<span>Hi, </span><span>Edison</span>&nbsp;
	<div style="display:inline-block;"><a class="btn btn-danger" onclick="end_trial();">End Trial</a></div>
</div>


<div id="feedback_email_background" class="feedback_login_background" style="display:none;">
	<div class="feedback_login text-center">
    	<div>
            <i class="fa fa-smile-o fa-5x"></i>
        </div>
        <div style="font-size:24px;">Thank You</div>
        <div class="margin-top" style="color:#CCC;"">Fill in your email if like to receive updates</div>
        <div id="feedback_email_warning" class="margin-top-half text-warning"></div>
        <div class="input-group margin-top">
        	<input id="input_trial_email" class="form-control" type="text" placeholder="Email address" />
        	<div class="input-group-btn"><a class="btn btn-warning" onclick="send_email();">Send</a></div>
        </div>
        <div class="margin-top-half"><a class="btn btn-default btn-block" onclick="restart_trial();">No, thanks</a></div>
    </div>
</div>

<div id="feedback_update_background" class="feedback_login_background" style="display:none;">
	<div class="feedback_login text-center">
    	<div>
            <i class="fa fa-paper-plane fa-5x"></i>
        </div>
        <div style="font-size:24px;">Sent</div>
        <div class="margin-top" style="color:#CCC;"">We will keep you updated</div>
        <div class="margin-top"><a class="btn btn-warning btn-block" onclick="restart_trial();">Start New Trial</a></div>
    </div>
</div>

<script>
function start_trial() {
	if(document.getElementById('input_trial_fullname').value == '') {
		document.getElementById('feedback_login_warning').innerHTML = "Please fill in your name";
	}
	else {
		setCookie('trial',document.getElementById('input_trial_fullname').value,1);
		document.getElementById('feedback_login_background').style.display = "none";
	}
}

function end_trial() {
	setCookie('trial',document.getElementById('input_trial_fullname').value,-1);
	setCookie('draft','',-1);
	document.getElementById('feedback_email_background').style.display = "block";
}

function send_email() {
	if(document.getElementById('input_trial_email').value == '') {
		document.getElementById('feedback_email_warning').innerHTML = "Please fill in your email";
	}
	else {
		document.getElementById('feedback_update_background').style.display = "block";
		document.getElementById('feedback_email_background').style.display = "none";
	}
}

function restart_trial() {
	document.getElementById('feedback_login_background').style.display = "block";
	document.getElementById('feedback_email_background').style.display = "none";
	document.getElementById('feedback_update_background').style.display = "none";
}
</script>