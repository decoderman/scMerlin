<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<link rel="shortcut icon" href="images/favicon.png">
<link rel="icon" href="images/favicon.png">
<title>SiteMap</title>
<link rel="stylesheet" type="text/css" href="/index_style.css">
<link rel="stylesheet" type="text/css" href="/form_style.css">
<style>
</style>
<script language="JavaScript" type="text/javascript" src="/ext/shared-jy/jquery.js"></script>
<script language="JavaScript" type="text/javascript" src="/state.js"></script>
<script language="JavaScript" type="text/javascript" src="/general.js"></script>
<script language="JavaScript" type="text/javascript" src="/popup.js"></script>
<script language="JavaScript" type="text/javascript" src="/help.js"></script>
<script language="JavaScript" type="text/javascript" src="/ext/shared-jy/detect.js"></script>
<script language="JavaScript" type="text/javascript" src="/tmhist.js"></script>
<script language="JavaScript" type="text/javascript" src="/tmmenu.js"></script>
<script language="JavaScript" type="text/javascript" src="/client_function.js"></script>
<script language="JavaScript" type="text/javascript" src="/validator.js"></script>
<script>
var $j = jQuery.noConflict(); //avoid conflicts on John's fork (state.js)

function SetCurrentPage(){
	document.form.next_page.value = window.location.pathname.substring(1);
	document.form.current_page.value = window.location.pathname.substring(1);
}

function initial(){
	SetCurrentPage();
	show_menu();
	GenerateSiteMap();
}

function reload(){
	location.reload(true);
}

function GenerateSiteMap(){
	var myMenu = [];
	
	if(typeof menuList == 'undefined' || menuList == null){
		setTimeout(GenerateSiteMap,1000);
		return;
	}
	
	for(var i = 0; i < menuList.length; i++){
		var myobj = {};
		myobj.menuName = menuList[i].menuName;
		myobj.index = menuList[i].index;
		
		var myTabs = menuList[i].tab.filter(function(item){
			return !menuExclude.tabs.includes(item.url);
		});
		myTabs = myTabs.filter(function(item){
			if(item.tabName == '__INHERIT__' && item.url == 'NULL'){
				return false;
			}
			else{
				return true;
			}
		});
		myTabs = myTabs.filter(function(item){
			if(item.tabName == '__HIDE__' && item.url == 'NULL'){
				return false;
			}
			else{
				return true;
			}
		});
		myTabs = myTabs.filter(function(item){
			return item.url.indexOf('TrafficMonitor_dev') == -1;
		});
		myTabs = myTabs.filter(function(item){
			return item.url != 'AdaptiveQoS_Adaptive.asp';
		});
		myobj.tabs = myTabs;
		
		myMenu.push(myobj);
	}
	
	myMenu = myMenu.filter(function(item) {
		return !menuExclude.menus.includes(item.index);
	});
	myMenu = myMenu.filter(function(item) {
		return item.index != 'menu_Split';
	});
	
	var sitemapstring = '';
	
	for(var i = 0; i < myMenu.length; i++){
		if(myMenu[i].tabs[0].tabName == '__HIDE__' && myMenu[i].tabs[0].url != 'NULL'){
			sitemapstring += '<span style="font-size:14px;background-color:#4D595D;"><b><a style="color:#FFCC00;background-color:#4D595D;" href="'+myMenu[i].tabs[0].url+'" target="_blank">'+myMenu[i].menuName+'</a></b></span><br>';
		}
		else{
			sitemapstring += '<span style="font-size:14px;background-color:#4D595D;"><b>'+myMenu[i].menuName+'</b></span><br>';
		}
			for(var i2 = 0; i2 < myMenu[i].tabs.length; i2++){
				if(myMenu[i].tabs[i2].tabName == '__HIDE__'){
					continue;
				}
				var tabname = myMenu[i].tabs[i2].tabName;
				var taburl = myMenu[i].tabs[i2].url;
				if(tabname == '__INHERIT__'){
					tabname = taburl.split('.')[0];
				}
				if(taburl.indexOf('redirect.htm') != -1){
					taburl = '/ext/shared-jy/redirect.htm';
				}
				sitemapstring += '<a style="text-decoration:underline;background-color:#4D595D;" href="'+taburl+'" target="_blank">'+tabname+'</a><br>';
			}
		sitemapstring += '<br>';
	}
	$j('#sitemapcontent').html(sitemapstring);
}
</script>
</head>
<body onload="initial();">
<div id="TopBanner"></div>
<div id="Loading" class="popup_bg"></div>
<iframe name="hidden_frame" id="hidden_frame" src="about:blank" width="0" height="0" frameborder="0"></iframe>
<form method="post" name="form" id="ruleForm" action="/start_apply.htm" target="hidden_frame">
<input type="hidden" name="action_script" value="start_scmerlin">
<input type="hidden" name="current_page" value="">
<input type="hidden" name="next_page" value="">
<input type="hidden" name="modified" value="0">
<input type="hidden" name="action_mode" value="apply">
<input type="hidden" name="action_wait" value="60">
<input type="hidden" name="first_time" value="">
<input type="hidden" name="SystemCmd" value="">
<input type="hidden" name="preferred_lang" id="preferred_lang" value="<% nvram_get("preferred_lang"); %>">
<input type="hidden" name="firmver" value="<% nvram_get("firmver"); %>">
<input type="hidden" name="vpnc1_desc" value="<% nvram_get("vpn_client1_desc"); %>">
<input type="hidden" name="vpnc2_desc" value="<% nvram_get("vpn_client2_desc"); %>">
<input type="hidden" name="vpnc3_desc" value="<% nvram_get("vpn_client3_desc"); %>">
<input type="hidden" name="vpnc4_desc" value="<% nvram_get("vpn_client4_desc"); %>">
<input type="hidden" name="vpnc5_desc" value="<% nvram_get("vpn_client5_desc"); %>">
<input type="hidden" name="amng_custom" id="amng_custom" value="">
<table class="content" align="center" cellpadding="0" cellspacing="0">
<tr>
<td width="17">&nbsp;</td>
<td valign="top" width="202">
<div id="mainMenu"></div>
<div id="subMenu"></div></td>
<td valign="top">
<div id="tabMenu" class="submenuBlock"></div>
<table width="98%" border="0" align="left" cellpadding="0" cellspacing="0">
<tr>
<td valign="top">
<table width="760px" border="0" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTitle" id="FormTitle">
<tbody>
<tr bgcolor="#4D595D">
<td valign="top">
<div>&nbsp;</div>
<div class="formfonttitle" id="scripttitle" style="text-align:center;">Sitemap</div>
<div style="margin:10px 0 10px 5px;" class="splitLine"></div>
<div class="formfontdesc">This page shows a dynamically generated sitemap of the router WebUI. Provided by scMerlin.</div>
<table width="100%" border="1" align="center" cellpadding="2" cellspacing="0" bordercolor="#6b8fa3" class="FormTable SettingsTable" style="border:0px;" id="table_sitemap">
<tr class="even" id="rowsitemap">
<td colspan="2" border="0" style="border:0px;background-color:#4D595D;">
<div id="sitemapcontent" style="height:100%;background-color:#4D595D;"></div>
</td>
<!-- End Sitemap -->
</tr>
</table>
</td>
</tr>
</tbody>
</table></td>
</tr>
</table>
</td>
</tr>
</table>
</form>
<div id="footer">
</div>
</body>
</html>
