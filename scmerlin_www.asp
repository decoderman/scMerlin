<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<link rel="shortcut icon" href="images/favicon.png">
<link rel="icon" href="images/favicon.png">
<title>scMerlin</title>
<link rel="stylesheet" type="text/css" href="/index_style.css">
<link rel="stylesheet" type="text/css" href="/form_style.css">
<style>
p{font-weight:bolder}thead.collapsible-jquery{color:#fff;padding:0;width:100%;border:none;text-align:left;outline:none;cursor:pointer}.SettingsTable{text-align:left}.SettingsTable input{text-align:left;margin-left:3px!important}.SettingsTable input.savebutton{text-align:center;margin-top:5px;margin-bottom:5px;border-right:solid 1px #000;border-left:solid 1px #000;border-bottom:solid 1px #000}.SettingsTable td.savebutton{border-right:solid 1px #000;border-left:solid 1px #000;border-bottom:solid 1px #000;background-color:#4d595d}.SettingsTable .cronbutton{text-align:center;min-width:50px;width:50px;height:23px;vertical-align:middle}.SettingsTable select{margin-left:3px!important}.SettingsTable label{margin-right:10px!important;vertical-align:top!important}.SettingsTable th{background-color:#1F2D35!important;background:#2F3A3E!important;border-bottom:none!important;border-top:none!important;font-size:12px!important;color:#fff!important;padding:4px!important;font-weight:bolder!important;padding:0!important}.SettingsTable td{word-wrap:break-word!important;overflow-wrap:break-word!important;border-right:none;border-left:none}.SettingsTable span.settingname{background-color:#1F2D35!important;background:#2F3A3E!important}.SettingsTable td.settingname{border-right:solid 1px #000;border-left:solid 1px #000;background-color:#1F2D35!important;background:#2F3A3E!important;width:35%!important}.SettingsTable td.settingvalue{text-align:left!important;border-right:solid 1px #000}.SettingsTable td.servicename{border-right:solid 1px #000;border-left:solid 1px #000;background-color:#1F2D35!important;background:#2F3A3E!important;width:30%!important}.SettingsTable td.servicevalue{text-align:center!important;border-right:solid 1px #000;width:20%!important;padding-left:4px!important}.SettingsTable span.servicespan{font-size:10px!important}.SettingsTable th:first-child{border-left:none!important}.SettingsTable th:last-child{border-right:none!important}.SettingsTable .invalid{background-color:#8b0000!important}.SettingsTable .disabled{background-color:#CCC!important;color:#888!important}div.sortTableContainer{height:500px;overflow-y:scroll;width:745px;border:1px solid #000}.sortTable{table-layout:fixed!important;border:none}thead.sortTableHeader th{background-image:linear-gradient(#92a0a5 0%,#66757c 100%);border-top:none!important;border-left:none!important;border-right:none!important;border-bottom:1px solid #000!important;font-weight:bolder;padding:2px;text-align:center;color:#fff;position:sticky;top:0}thead.sortTableHeader th:first-child,thead.sortTableHeader th:last-child{border-right:none!important}thead.sortTableHeader th:last-child{text-align:left!important;padding-left:4px!important}thead.sortTableHeader th:first-child,thead.sortTableHeader td:first-child{border-left:none!important}tbody.sortTableContent td:last-child,tbody.sortTableContent tr.sortNormalRow td:last-child,tbody.sortTableContent tr.sortAlternateRow td:last-child{text-align:left!important;padding-left:4px!important}tbody.sortTableContent td{border-bottom:1px solid #000!important;border-left:none!important;border-right:1px solid #000!important;border-top:none!important;padding:2px;text-align:center;overflow:hidden!important;white-space:nowrap!important;font-size:12px!important}tbody.sortTableContent tr.sortRow:nth-child(odd) td{background-color:#2F3A3E!important}tbody.sortTableContent tr.sortRow:nth-child(even) td{background-color:#475A5F!important}th.sortable{cursor:pointer}td.metricname{background-color:#1F2D35!important;background:#2F3A3E!important;width:50px!important}.restartbutton{text-align:center!important;min-width:75px;width:75px;vertical-align:middle}td.addonpageurl:nth-child(even){border:1px solid #000!important;text-align:center!important;background-color:#475A5F!important}td.addonpageurl:nth-child(odd){border:1px solid #000!important;text-align:center!important;background-color:#1F2D35!important;background:#2F3A3E!important}td.addonpageurl:nth-child(even) span{background-color:#475A5F!important}td.addonpageurl:nth-child(odd) span{background-color:#1F2D35!important;background:#2F3A3E!important}td.addonpageurl a{font-weight:bolder!important;text-decoration:underline!important}span.addonpageurl{color:#FC0;font-size:10px!important}.nodata{height:65px!important;border:none!important;text-align:center!important;font:bolder 48px Arial!important}
</style>
<script language="JavaScript" type="text/javascript" src="/ext/shared-jy/jquery.js"></script>
<script language="JavaScript" type="text/javascript" src="/ext/shared-jy/moment.js"></script>
<script language="JavaScript" type="text/javascript" src="/ext/shared-jy/chart.js"></script>
<script language="JavaScript" type="text/javascript" src="/ext/shared-jy/hammerjs.js"></script>
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
var custom_settings;
function LoadCustomSettings(){
	custom_settings = <% get_custom_settings(); %>;
	for(var prop in custom_settings) {
		if(Object.prototype.hasOwnProperty.call(custom_settings, prop)) {
			if(prop.indexOf('scmerlin') != -1 && prop.indexOf('scmerlin_version') == -1){
				eval('delete custom_settings.'+prop)
			}
		}
	}
}

/**----------------------------------------**/
/** Modified by Martinski W. [2024-Apr-21] **/
/**----------------------------------------**/
var nvramtotal = <% sysinfo("nvram.total"); %> / 1024;
let jffsTotalStr = "<% sysinfo("jffs.total"); %>";
let jffs_Usage = '';
let jffs_Used = 0.0, jffs_Total = 0.0, jffs_Free = 0.0;

/**----------------------------------------------**/
/** Added/Modified by Martinski W. [2024-Apr-29] **/
/**----------------------------------------------**/
const NTPReadyCheck=
{
   prevSetting: 'UNKNOWN',
   nextSetting: 'UNKNOWN',
   showCompletedMsg: false,
   showWarningAlert: false,
   buttonHintMsg: 'Apply and save selected option for NTP Ready startup check',
   enabledDoneMsg: 'NTP Ready check is ENABLED.',
   disabledDoneMsg: 'NTP Ready check is DISABLED.',
   waitToEnableMsg: 'Enabling NTP Ready check...',
   waitToDisableMsg: 'Disabling NTP Ready check...',
   disabledAlertMsg:
       '**WARNING**\n' +
       'You have now disabled the \"NTP Ready\" check. This is generally not recommended\n' +
       'unless you have some very specific conditions (e.g. WAN state is not connected).\n' +
       'Remember to re-enable the \"NTP Ready\" check as soon as you possibly can.\n\n'
};

/**-------------------------------------**/
/** Added by Martinski W. [2024-Apr-21] **/
/**-------------------------------------**/
function JFFS_GetUsageInfo()
{
    jffs_Usage = "<% sysinfo("jffs.usage"); %>";
    if ((jffsTotalStr == '' ||
         jffsTotalStr == 'Not implemented') &&
        jffs_Usage.indexOf('/') != -1)
    {   /** "Used / Total MB" **/
        let jffsTemp = jffs_Usage.split(' ');
        jffs_Used = parseFloat(jffsTemp[0]);
        jffs_Total = parseFloat(jffsTemp[2]);
        jffs_Free = (jffs_Total - jffs_Used);
    }
    else
    {
        jffs_Free = parseFloat("<% sysinfo("jffs.free"); %>");
        jffs_Total = parseFloat("<% sysinfo("jffs.total"); %>");
        jffs_Used = (jffs_Total - jffs_Free);
        /** "Used / Total MB" **/
        jffs_Usage = jffs_Used.toFixed(2) + " / " + jffs_Total.toFixed(2) + " MB";
    }
}

/**----------------------------------------**/
/** Modified by Martinski W. [2024-Apr-21] **/
/**----------------------------------------**/
/* Taken from firmware WebUI, Tools_SysInfo.asp */
function update_sysinfo(e){
	$j.ajax({
		url: '/ajax_sysinfo.asp',
		dataType: 'script',
		error: function(xhr) {
		setTimeout(update_sysinfo, 1000);
	},
		success: function(response){
			JFFS_GetUsageInfo();
			nvramtotal = <% sysinfo("nvram.total"); %> / 1024;
			show_memcpu();
			Draw_Chart('MemoryUsage');
			if(parseInt(mem_stats_arr[5]) != 0){
				Draw_Chart('SwapUsage');
			}
			else{
				Draw_Chart_NoData('SwapUsage','No swap file configured');
			}
			Draw_Chart('nvramUsage');
			Draw_Chart('jffsUsage');
			setTimeout(update_sysinfo, 3000);
		}
	});
}

/**----------------------------------------**/
/** Modified by Martinski W. [2024-Apr-21] **/
/**----------------------------------------**/
function show_memcpu(){
	document.getElementById('mem_total_td').innerHTML = mem_stats_arr[0] + ' MB';
	document.getElementById('mem_free_td').innerHTML = mem_stats_arr[1] + ' MB';
	document.getElementById('mem_buffer_td').innerHTML = mem_stats_arr[2] + ' MB';
	document.getElementById('mem_cache_td').innerHTML = mem_stats_arr[3] + ' MB';
	document.getElementById('nvram_td').innerHTML = round(mem_stats_arr[6]/1024,2).toFixed(2) + ' / ' + nvramtotal + ' KB';
	document.getElementById('jffs_td').innerHTML = jffs_Usage;
	
	if(parseInt(mem_stats_arr[5]) == 0){
		document.getElementById('mem_swap_td').innerHTML = '<span>No swap configured</span>';
	}
	else{
		document.getElementById('mem_swap_td').innerHTML = mem_stats_arr[4] + ' / ' + mem_stats_arr[5] + ' MB';
	}
}

/**----------------------------------------**/
/** Modified by Martinski W. [2024-Jun-01] **/
/**----------------------------------------**/
let band_5GHz_1_supported=false,
    band_5GHz_2_supported=false,
    band_6GHz_1_supported=false,
    band_6GHz_2_supported=false;
let band_24GHz_supported = band2g_support;

if (typeof wl_info == 'undefined' || wl_info == null)
{
    band_5GHz_1_supported = band5g_support;
    band_5GHz_2_supported = band5g2_support;
    band_6GHz_1_supported = band6g_support;
}
else
{
    band_5GHz_1_supported = wl_info.band5g_support;
    band_5GHz_2_supported = wl_info.band5g_2_support;
    if (typeof wl_info.band6g_support != 'undefined')
    { band_6GHz_1_supported = wl_info.band6g_support; }
    if (typeof wl_info.band6g_2_support != 'undefined')
    { band_6GHz_2_supported = wl_info.band6g_2_support; }
}

/**----------------------------------------**/
/** Modified by Martinski W. [2024-Jun-01] **/
/**----------------------------------------**/
function GetTemperatureValue (bandIDstr)
{
    let temperatureVal="[N/A]";

    switch (bandIDstr)
    {
        case '2.4GHz':
            if (productid == 'GT-BE98' ||
                productid == 'GT-BE98_PRO' ||
                productid == 'GT-AXE16000')
            {
                if (typeof curr_coreTmp_wl3_raw != 'undefined' && curr_coreTmp_wl3_raw != null)
                { temperatureVal = curr_coreTmp_wl3_raw; }
                else if (typeof curr_coreTmp_3_raw != 'undefined' && curr_coreTmp_3_raw != null)
                { temperatureVal = curr_coreTmp_3_raw; }
            }
            else if (typeof curr_coreTmp_wl0_raw != 'undefined' && curr_coreTmp_wl0_raw != null)
            { temperatureVal = curr_coreTmp_wl0_raw; }
            else if (typeof curr_coreTmp_0_raw != 'undefined' && curr_coreTmp_0_raw != null)
            { temperatureVal = curr_coreTmp_0_raw; }
            else if (typeof curr_coreTmp_2_raw != 'undefined' && curr_coreTmp_2_raw != null)
            { temperatureVal = curr_coreTmp_2_raw; }
            break;

        case '5GHz_1':
            if (productid == 'GT-BE98' ||
                productid == 'GT-BE98_PRO' ||
                productid == 'GT-AXE16000')
            {
                if (typeof curr_coreTmp_wl0_raw != 'undefined' && curr_coreTmp_wl0_raw != null)
                { temperatureVal = curr_coreTmp_wl0_raw; }
                else if (typeof curr_coreTmp_0_raw != 'undefined' && curr_coreTmp_0_raw != null)
                { temperatureVal = curr_coreTmp_0_raw; }
            }
            else if (typeof curr_coreTmp_wl1_raw != 'undefined' && curr_coreTmp_wl1_raw != null)
            { temperatureVal = curr_coreTmp_wl1_raw; }
            else if (typeof curr_coreTmp_1_raw != 'undefined' && curr_coreTmp_1_raw != null)
            { temperatureVal = curr_coreTmp_1_raw; }
            else if (typeof curr_coreTmp_5_raw != 'undefined' && curr_coreTmp_5_raw != null)
            { temperatureVal = curr_coreTmp_5_raw; }
            break;

        case '5GHz_2':
            if (productid == 'GT-BE98' ||
                productid == 'GT-AXE16000')
            {
                if (typeof curr_coreTmp_wl1_raw != 'undefined' && curr_coreTmp_wl1_raw != null)
                { temperatureVal = curr_coreTmp_wl1_raw; }
                else if (typeof curr_coreTmp_1_raw != 'undefined' && curr_coreTmp_1_raw != null)
                { temperatureVal = curr_coreTmp_1_raw; }
            }
            else if (typeof curr_coreTmp_wl2_raw != 'undefined' && curr_coreTmp_wl2_raw != null)
            { temperatureVal = curr_coreTmp_wl2_raw; }
            else if (typeof curr_coreTmp_0_raw != 'undefined' && curr_coreTmp_0_raw != null &&
                     typeof curr_coreTmp_2_raw != 'undefined' && curr_coreTmp_2_raw != null)
            { temperatureVal = curr_coreTmp_2_raw; }
            else if (typeof curr_coreTmp_52_raw != 'undefined' && curr_coreTmp_52_raw != null)
            { temperatureVal = curr_coreTmp_52_raw; }
            break;

        case '6GHz_1':
            if (productid == 'GT-BE98_PRO')
            {
                if (typeof curr_coreTmp_wl1_raw != 'undefined' && curr_coreTmp_wl1_raw != null)
                { temperatureVal = curr_coreTmp_wl1_raw; }
                else if (typeof curr_coreTmp_1_raw != 'undefined' && curr_coreTmp_1_raw != null)
                { temperatureVal = curr_coreTmp_1_raw; }
            }
            else if (typeof curr_coreTmp_wl2_raw != 'undefined' && curr_coreTmp_wl2_raw != null)
            { temperatureVal = curr_coreTmp_wl2_raw; }
            else if (typeof curr_coreTmp_0_raw != 'undefined' && curr_coreTmp_0_raw != null &&
                     typeof curr_coreTmp_2_raw != 'undefined' && curr_coreTmp_2_raw != null)
            { temperatureVal = curr_coreTmp_2_raw; }
            break;

        case '6GHz_2':
            if (productid == 'GT-BE98_PRO')
            {
                if (typeof curr_coreTmp_wl2_raw != 'undefined' && curr_coreTmp_wl2_raw != null)
                { temperatureVal = curr_coreTmp_wl2_raw; }
            }
            break;
    }
    return (temperatureVal);
}

/**----------------------------------------**/
/** Modified by Martinski W. [2024-Jun-01] **/
/**----------------------------------------**/
function update_temperatures()
{
	$j.ajax({
		url: '/ajax_coretmp.asp',
		dataType: 'script',
		error: function(xhr){
		update_temperatures();
	},
	success: function(response)
	{
		code = '<b>2.4 GHz: </b><span>' + GetTemperatureValue ('2.4GHz') + '</span>';

		if (band_5GHz_2_supported)
		{
			code += '&nbsp;&nbsp;-&nbsp;&nbsp;<b>5 GHz-1: </b><span>' + GetTemperatureValue ('5GHz_1') + '</span>';
			code += '&nbsp;&nbsp;-&nbsp;&nbsp;<b>5 GHz-2: </b><span>' + GetTemperatureValue ('5GHz_2') + '</span>';
		}
		else if (band_5GHz_1_supported)
		{
			code += '&nbsp;&nbsp;-&nbsp;&nbsp;<b>5 GHz: </b><span>' + GetTemperatureValue ('5GHz_1') + '</span>';
		}

		if (band_6GHz_2_supported)
		{   /** Wi-Fi 7 Quad-Band Routers **/
			code += '&nbsp;&nbsp;-&nbsp;&nbsp;<b>6 GHz-1: </b><span>' + GetTemperatureValue ('6GHz_1') + '</span>';
			code += '&nbsp;&nbsp;-&nbsp;&nbsp;<b>6 GHz-2: </b><span>' + GetTemperatureValue ('6GHz_2') + '</span>';
		}
		else if (band_6GHz_1_supported)
		{   /** AXE-class Tri-Band or Quad-Band Routers **/
			code += '&nbsp;&nbsp;-&nbsp;&nbsp;<b>6 GHz: </b><span>' + GetTemperatureValue ('6GHz_1') + '</span>';
		}

		var CPUTemp = '';
		if (typeof curr_cpuTemp == 'undefined' || curr_cpuTemp == null)
		{ CPUTemp = curr_coreTmp_cpu; }
		else
		{ CPUTemp = curr_cpuTemp; }
		
		if (CPUTemp != ''){
			code +='&nbsp;&nbsp;-&nbsp;&nbsp;<b>CPU: </b><span>' + parseInt(CPUTemp) +'&deg;C</span>';
		}
		document.getElementById('temp_td').innerHTML = code;
		setTimeout(update_temperatures, 3000);
		}
	});
}
/* End firmware functions */

var arrayproclistlines=[],sortnameproc="CPU%",sortdirproc="desc",arraycronjobs=[],sortnamecron="Name",sortdircron="asc",tmout=null;Chart.defaults.global.defaultFontColor="#CCC",Chart.Tooltip.positioners.cursor=function(t,e){return e};var $j=jQuery.noConflict();function SetCurrentPage(){document.form.next_page.value=window.location.pathname.substring(1),document.form.current_page.value=window.location.pathname.substring(1)}var srvnamelist=["dnsmasq","wan","httpd","wireless","vsftpd","samba","ddns","ntpd/chronyd"],srvdesclist=["DNS/DHCP Server","Internet Connection","Web Interface","WiFi","FTP Server","Samba","DDNS client","Timeserver"],srvnamevisiblelist=[!0,!1,!0,!1,!0,!1,!1,!0],sortedAddonPages=[];function initial(){SetCurrentPage(),LoadCustomSettings(),show_menu(),Draw_Chart_NoData("nvramUsage","Data loading..."),Draw_Chart_NoData("jffsUsage","Data loading..."),Draw_Chart_NoData("MemoryUsage","Data loading..."),Draw_Chart_NoData("SwapUsage","No swap file configured"),$j("#sortTableCron").empty(),$j("#sortTableCron").append(BuildSortTableHtmlNoData()),$j("#sortTableProcesses").empty(),$j("#sortTableProcesses").append(BuildSortTableHtmlNoData());for(var t="",e=1;e<3;e++)t+=BuildVPNServerTable(e);$j("#table_config").after(t);var r="";for(e=1;e<6;e++)r+=BuildVPNClientTable(e);$j("#table_config").after(r);var s="";for(e=0;e<srvnamelist.length;e++)s+=BuildServiceTable(srvnamelist[e],srvdesclist[e],srvnamevisiblelist[e],e);$j("#table_config").after(s),document.formScriptActions.action_script.value="start_scmerlingetaddonpages;start_scmerlingetcronjobs",document.formScriptActions.submit(),setTimeout(load_addonpages,5e3),setTimeout(get_cronlist_file,5e3),get_proclist_file(),Get_NTPWatchdogEnabled_File(),Get_NTPReadyCheck_Option(),Get_DNSmasqWatchdogEnabled_File(),update_temperatures(),update_sysinfo(),ScriptUpdateLayout(),AddEventHandlers()}function ScriptUpdateLayout(){var t=GetVersionNumber("local"),e=GetVersionNumber("server");$j("#scmerlin_version_local").text(t),t!=e&&"N/A"!=e&&($j("#scmerlin_version_server").text("Updated version available: "+e),showhide("btnChkUpdate",!1),showhide("scmerlin_version_server",!0),showhide("btnDoUpdate",!0))}function reload(){location.reload(!0)}function update_status(){$j.ajax({url:"/ext/scmerlin/detect_update.js",dataType:"script",error:function(t){setTimeout(update_status,1e3)},success:function(){"InProgress"==updatestatus?setTimeout(update_status,1e3):(document.getElementById("imgChkUpdate").style.display="none",showhide("scmerlin_version_server",!0),"None"!=updatestatus?($j("#scmerlin_version_server").text("Updated version available: "+updatestatus),showhide("btnChkUpdate",!1),showhide("btnDoUpdate",!0)):($j("#scmerlin_version_server").text("No update available"),showhide("btnChkUpdate",!0),showhide("btnDoUpdate",!1)))}})}function CheckUpdate(){showhide("btnChkUpdate",!1),document.formScriptActions.action_script.value="start_scmerlincheckupdate",document.formScriptActions.submit(),document.getElementById("imgChkUpdate").style.display="",setTimeout(update_status,2e3)}function DoUpdate(){document.form.action_script.value="start_scmerlindoupdate",document.form.action_wait.value=15,$j("#auto_refresh").prop("checked",!1),null!=tmout&&clearTimeout(tmout),showLoading(),document.form.submit()}function RestartService(t){showhide("btnRestartSrv_"+t,!1),showhide("txtRestartSrv_"+t,!1),document.formScriptActions.action_script.value="start_scmerlinservicerestart"+t,document.formScriptActions.submit(),document.getElementById("imgRestartSrv_"+t).style.display="",setTimeout(service_status,1e3,t)}function service_status(t){$j.ajax({url:"/ext/scmerlin/detect_service.js",dataType:"script",error:function(e){setTimeout(service_status,1e3,t)},success:function(){"InProgress"==servicestatus?setTimeout(service_status,1e3,t):(document.getElementById("imgRestartSrv_"+t).style.display="none","Done"==servicestatus?(showhide("txtRestartSrv_"+t,!0),setTimeout(showhide,3e3,"txtRestartSrv_"+t,!1),setTimeout(showhide,3250,"btnRestartSrv_"+t,!0)):showhide("txtRestartSrvError_"+t,!0))}})}function GetVersionNumber(t){var e;return"local"==t?e=custom_settings.scmerlin_version_local:"server"==t&&(e=custom_settings.scmerlin_version_server),void 0===e||null==e?"N/A":e}function BuildSortTableHtmlNoData(){return"<tr>",'<td colspan="3" class="nodata">',"Data loading...","</td>","</tr>","</table>",'<table width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="sortTable"><tr><td colspan="3" class="nodata">Data loading...</td></tr></table>'}function BuildSortTableHtml(t){var e='<table border="0" cellpadding="0" cellspacing="0" width="100%" class="sortTable">';if("sortTableProcesses"==t){e+='<col style="width:50px;">',e+='<col style="width:50px;">',e+='<col style="width:75px;">',e+='<col style="width:50px;">',e+='<col style="width:50px;">',e+='<col style="width:55px;">',e+='<col style="width:50px;">',e+='<col style="width:55px;">',e+='<col style="width:740px;">',e+='<thead class="sortTableHeader">',e+="<tr>",e+="<th class=\"sortable\" onclick=\"SortTable('sortTableProcesses','arrayproclistlines',this.innerHTML,'sortnameproc','sortdirproc')\">PID</th>",e+="<th class=\"sortable\" onclick=\"SortTable('sortTableProcesses','arrayproclistlines',this.innerHTML,'sortnameproc','sortdirproc')\">PPID</th>",e+="<th class=\"sortable\" onclick=\"SortTable('sortTableProcesses','arrayproclistlines',this.innerHTML,'sortnameproc','sortdirproc')\">USER</th>",e+="<th class=\"sortable\" onclick=\"SortTable('sortTableProcesses','arrayproclistlines',this.innerHTML,'sortnameproc','sortdirproc')\">STAT</th>",e+="<th class=\"sortable\" onclick=\"SortTable('sortTableProcesses','arrayproclistlines',this.innerHTML,'sortnameproc','sortdirproc')\">VSZ</th>",e+="<th class=\"sortable\" onclick=\"SortTable('sortTableProcesses','arrayproclistlines',this.innerHTML,'sortnameproc','sortdirproc')\">VSZ%</th>",e+="<th class=\"sortable\" onclick=\"SortTable('sortTableProcesses','arrayproclistlines',this.innerHTML,'sortnameproc','sortdirproc')\">CPU</th>",e+="<th class=\"sortable\" onclick=\"SortTable('sortTableProcesses','arrayproclistlines',this.innerHTML,'sortnameproc','sortdirproc')\">CPU%</th>",e+="<th class=\"sortable\" onclick=\"SortTable('sortTableProcesses','arrayproclistlines',this.innerHTML,'sortnameproc','sortdirproc')\">COMMAND</th>",e+="</tr>",e+="</thead>",e+='<tbody class="sortTableContent">';for(var r=0;r<arrayproclistlines.length;r++)e+='<tr class="sortRow">',e+="<td>"+arrayproclistlines[r].PID+"</td>",e+="<td>"+arrayproclistlines[r].PPID+"</td>",e+="<td>"+arrayproclistlines[r].USER+"</td>",e+="<td>"+arrayproclistlines[r].STAT+"</td>",e+="<td>"+arrayproclistlines[r].VSZ+"</td>",e+="<td>"+arrayproclistlines[r].VSZP+"</td>",e+="<td>"+arrayproclistlines[r].CPU+"</td>",e+="<td>"+arrayproclistlines[r].CPUP+"</td>",e+="<td>"+arrayproclistlines[r].COMMAND+"</td>",e+="</tr>"}else if("sortTableCron"==t){e+='<col style="width:175px;">',e+='<col style="width:45px;">',e+='<col style="width:45px;">',e+='<col style="width:45px;">',e+='<col style="width:45px;">',e+='<col style="width:45px;">',e+='<col style="width:740px;">',e+='<thead class="sortTableHeader">',e+="<tr>",e+="<th class=\"sortable\" onclick=\"SortTable('sortTableCron','arraycronjobs',this.innerHTML,'sortnamecron','sortdircron')\">Name</th>",e+="<th class=\"sortable\" onclick=\"SortTable('sortTableCron','arraycronjobs',this.innerHTML,'sortnamecron','sortdircron')\">Min</th>",e+="<th class=\"sortable\" onclick=\"SortTable('sortTableCron','arraycronjobs',this.innerHTML,'sortnamecron','sortdircron')\">Hour</th>",e+="<th class=\"sortable\" onclick=\"SortTable('sortTableCron','arraycronjobs',this.innerHTML,'sortnamecron','sortdircron')\">DayM</th>",e+="<th class=\"sortable\" onclick=\"SortTable('sortTableCron','arraycronjobs',this.innerHTML,'sortnamecron','sortdircron')\">Month</th>",e+="<th class=\"sortable\" onclick=\"SortTable('sortTableCron','arraycronjobs',this.innerHTML,'sortnamecron','sortdircron')\">DayW</th>",e+="<th class=\"sortable\" onclick=\"SortTable('sortTableCron','arraycronjobs',this.innerHTML,'sortnamecron','sortdircron')\">Command</th>",e+="</tr>",e+="</thead>",e+='<tbody class="sortTableContent">';for(r=0;r<arraycronjobs.length;r++)e+='<tr class="sortRow">',e+="<td>"+arraycronjobs[r].Name+"</td>",e+="<td>"+arraycronjobs[r].Min+"</td>",e+="<td>"+arraycronjobs[r].Hour+"</td>",e+="<td>"+arraycronjobs[r].DayM+"</td>",e+="<td>"+arraycronjobs[r].Month+"</td>",e+="<td>"+arraycronjobs[r].DayW+"</td>",e+="<td>"+arraycronjobs[r].Command+"</td>",e+="</tr>"}return e+="</tbody>",e+="</table>"}function Get_NTPWatchdogEnabled_File(){$j.ajax({url:"/ext/scmerlin/watchdogenabled.htm",dataType:"text",error:function(t){document.form.scMerlin_NTPwatchdog.value="Disable",$j("#scMerlin_NTPwatchdog_Status").text("Currently: DISABLED")},success:function(t){document.form.scMerlin_NTPwatchdog.value="Enable",$j("#scMerlin_NTPwatchdog_Status").text("Currently: ENABLED")}})}function Save_NTPWatchdog(){document.form.action_script.value="start_scmerlin_NTPwatchdog"+document.form.scMerlin_NTPwatchdog.value,document.form.action_wait.value=4,$j("#auto_refresh").prop("checked",!1),null!=tmout&&clearTimeout(tmout),showLoading(),document.form.submit(),setTimeout(Get_NTPWatchdogEnabled_File,4e3)}function Get_DNSmasqWatchdogEnabled_File(){$j.ajax({url:"/ext/scmerlin/tailtaintdnsenabled.htm",dataType:"text",error:function(t){document.form.scMerlin_DNSmasqWatchdog.value="Disable",$j("#scMerlin_DNSmasqWatchdog_Status").text("Currently: DISABLED")},success:function(t){document.form.scMerlin_DNSmasqWatchdog.value="Enable",$j("#scMerlin_DNSmasqWatchdog_Status").text("Currently: ENABLED")}})}function Save_DNSmasqWatchdog(){document.form.action_script.value="start_scmerlin_DNSmasqWatchdog"+document.form.scMerlin_DNSmasqWatchdog.value,document.form.action_wait.value=4,$j("#auto_refresh").prop("checked",!1),null!=tmout&&clearTimeout(tmout),showLoading(),document.form.submit(),setTimeout(Get_DNSmasqWatchdogEnabled_File,4e3)}const WaitMsgPopupBox={waitCounter:0,waitMaxSecs:0,waitTimerOn:!1,waitTimerID:null,waitMsgBox:null,waitMsgTemp:"",waitMsgBoxID:"myWaitMsgPopupBoxID",CloseMsg:function(){this.waitTimerOn=!1,this.waitCounter=0,this.waitMaxSecs=0,this.waitMsgTemp="",null!=this.waitTimerID&&(clearTimeout(this.waitTimerID),this.waitTimerID=null),null!=this.waitMsgBox&&this.waitMsgBox.close()},StartMsg:function(t,e,r){this.waitTimerOn||(this.waitTimerOn=!0,this.waitCounter=0,this.waitMsgTemp="",this.waitMaxSecs=Math.round(e/1e3),this.ShowTimedMsg(t,r))},ShowTimedMsg:function(t,e){if(this.waitCounter>this.waitMaxSecs)return void this.CloseMsg();if(!this.waitTimerOn)return;this.waitMsgBox=document.getElementById(this.waitMsgBoxID),null==this.waitMsgBox&&(this.waitMsgBox=document.body.appendChild(document.createElement("dialog")),this.waitMsgBox.setAttribute("id",this.waitMsgBoxID));let r=this.waitCounter+1;0==this.waitCounter&&this.waitMsgBox.close(),e?e&&(this.waitMsgBox.innerText=t+` [${r}]`):(0==this.waitCounter?this.waitMsgTemp=t+"\n >":this.waitMsgTemp=this.waitMsgTemp+">",this.waitMsgBox.innerText=this.waitMsgTemp),0==this.waitCounter&&this.waitMsgBox.showModal(),this.waitCounter=r,this.waitTimerID=setTimeout((function(){WaitMsgPopupBox.ShowTimedMsg(t,e)}),1e3)},ShowMsg:function(t,e){this.waitMsgBox=document.getElementById(this.waitMsgBoxID),null==this.waitMsgBox&&(this.waitMsgBox=document.body.appendChild(document.createElement("dialog")),this.waitMsgBox.setAttribute("id",this.waitMsgBoxID)),this.waitMsgBox.close(),this.waitMsgBox.innerText=t,this.waitMsgBox.showModal(),setTimeout((function(){WaitMsgPopupBox.waitMsgBox.close()}),e)}},AlertMsgBox={alertMsgBox:null,alertMsgBoxID:"myAlertMsgPopupBoxID",BuildAlertBox:function(t){let e;const r=t.split("\n");e='<div name="alertMsgBox" id="myAlertMsgBox"><div class = "message">';for(var s=0;s<r.length;s++)e+="<p>"+r[s]+"</p>";return e+='</div><div style="text-align:center"><button class="button_gen" id="myAlertBoxOKButton" style="margin-top:15px;" onclick="AlertMsgBox.CloseAlert();">OK</button></div></div>',e},CloseAlert:function(){null!=this.alertMsgBox&&this.alertMsgBox.close()},ShowAlert:function(t){this.alertMsgBox=document.getElementById(this.alertMsgBoxID),null==this.alertMsgBox&&(this.alertMsgBox=document.body.appendChild(document.createElement("dialog")),this.alertMsgBox.setAttribute("id",this.alertMsgBoxID)),this.alertMsgBox.close(),this.alertMsgBox.innerHTML=this.BuildAlertBox(t),this.alertMsgBox.showModal()}};var theButtonBackStyle=null;function SetButtonGenState(t,e,r){e?(document.getElementById(t).disabled=!1,document.getElementById(t).title=r,null!=theButtonBackStyle&&(document.getElementById(t).style.background=theButtonBackStyle)):(0==document.getElementById(t).disabled&&(theButtonBackStyle=document.getElementById(t).style.background),document.getElementById(t).disabled=!0,document.getElementById(t).title=r,document.getElementById(t).style.background="grey")}function SetNTPReadyCheckButtonState(t,e){let r;r=t?NTPReadyCheck.buttonHintMsg:e,SetButtonGenState("btnSaveNTPcheck",t,r)}function Get_NTPReadyCheck_Option(){$j.ajax({url:"/ext/scmerlin/NTP_Ready_Config.htm",dataType:"text",error:function(t){document.form.scMerlin_NTPcheck.value="Disable",NTPReadyCheck.prevOptionValue="DISABLED",WaitMsgPopupBox.CloseMsg(),SetNTPReadyCheckButtonState(!0,null),$j("#scMerlin_NTPcheck_Status").text("Currently: DISABLED")},success:function(t){let e=t.split("\n");e=e.filter(Boolean);let r,s,a,o,n,i=e.length,l="";for(var c=0;c<i;c++)r=e[c].match(/^NTP_Ready_Check=/),s=e[c].indexOf("#"),-1==s&&null!=r&&(a=e[c].split("="),o=a[0],n=a[1],document.form.scMerlin_NTPcheck.value="ENABLED"==n?"Enable":"Disable");"ENABLED"==n?NTPReadyCheck.showCompletedMsg&&(l=NTPReadyCheck.enabledDoneMsg):"DISABLED"==n&&("ENABLED"==NTPReadyCheck.prevSetting&&NTPReadyCheck.showWarningAlert?l=NTPReadyCheck.disabledAlertMsg:"DISABLED"==NTPReadyCheck.prevSetting&&NTPReadyCheck.showCompletedMsg&&(l=NTPReadyCheck.disabledDoneMsg)),$j("#scMerlin_NTPcheck_Status").text("Currently: "+n),WaitMsgPopupBox.CloseMsg(),""!=l&&AlertMsgBox.ShowAlert(l),SetNTPReadyCheckButtonState(!0,null),NTPReadyCheck.prevSetting=n,NTPReadyCheck.showCompletedMsg=!1,NTPReadyCheck.showWarningAlert=!1}})}function Save_NTPReadyCheck_Option(){let t=0,e="",r=document.form.scMerlin_NTPcheck.value,s="start_scmerlin_NTPcheck"+r;"Enable"==r?(NTPReadyCheck.nextSetting="ENABLED",e=NTPReadyCheck.waitToEnableMsg):(NTPReadyCheck.nextSetting="DISABLED",e=NTPReadyCheck.waitToDisableMsg),NTPReadyCheck.showCompletedMsg=!0,NTPReadyCheck.prevSetting==NTPReadyCheck.nextSetting?(t=2e3,NTPReadyCheck.showWarningAlert=!1):(t=4e3,NTPReadyCheck.showWarningAlert=!0),SetNTPReadyCheckButtonState(!1,e),WaitMsgPopupBox.StartMsg(e,8e3,!1),document.formScriptActions.action_script.value=s,document.formScriptActions.submit(),setTimeout(Get_NTPReadyCheck_Option,t)}function load_addonpages(){$j.ajax({url:"/ext/scmerlin/addonwebpages.htm",dataType:"text",error:function(t){setTimeout(load_addonpages,1e3)},success:function(t){var e=t.split("\n");e=e.filter(Boolean);for(var r=0;r<e.length;r++)try{var s=e[r].split(","),a=new Object;a.NAME=s[0].trim(),a.URL=s[1].trim(),sortedAddonPages.push(a)}catch{}sortedAddonPages=sortedAddonPages.sort((function(t,e){return t.NAME.toLowerCase().localeCompare(e.NAME.toLowerCase())}));var o="";for(r=0;r<sortedAddonPages.length;r++)o+=BuildAddonPageTable(sortedAddonPages[r].NAME,sortedAddonPages[r].URL,r);$j("#table_config").after(o),AddEventHandlers()}})}function get_cronlist_file(){$j.ajax({url:"/ext/scmerlin/scmcronjobs.htm",dataType:"text",error:function(t){tmout=setTimeout(get_cronlist_file,1e3)},success:function(t){ParseCronJobs(t)}})}function ParseCronJobs(t){var e=t.split("\n");e=e.filter(Boolean),arraycronjobs=[];for(var r=0;r<e.length;r++)try{var s=e[r].split(","),a=new Object;a.Name=s[0].trim().replace(/^\"/,"").replace(/\"$/,""),a.Min=s[1].trim().replace(/^\"/,"").replace(/\"$/,"").replace(/\|/,","),a.Hour=s[2].trim().replace(/^\"/,"").replace(/\"$/,"").replace(/\|/,","),a.DayM=s[3].trim().replace(/^\"/,"").replace(/\"$/,"").replace(/\|/,","),a.Month=s[4].trim().replace(/^\"/,"").replace(/\"$/,"").replace(/\|/,","),a.DayW=s[5].trim().replace(/^\"/,"").replace(/\"$/,"").replace(/\|/,","),a.Command=s[6].trim().replace(/^\"/,"").replace(/\"$/,""),arraycronjobs.push(a)}catch{}SortTable("sortTableCron","arraycronjobs",sortnamecron+" "+sortdircron.replace("desc","↑").replace("asc","↓").trim(),"sortnamecron","sortdircron")}function get_proclist_file(){$j.ajax({url:"/ext/scmerlin/top.htm",dataType:"text",error:function(t){tmout=setTimeout(get_proclist_file,1e3)},success:function(t){ParseProcList(t),document.getElementById("auto_refresh").checked&&(tmout=setTimeout(get_proclist_file,5e3))}})}function ParseProcList(t){var e=t.split("\n");e=e.filter(Boolean),arrayproclistlines=[];for(var r=0;r<e.length;r++)try{var s=e[r].split(","),a=new Object;a.PID=s[0].trim(),a.PPID=s[1].trim(),a.USER=s[2].trim(),a.STAT=s[3].trim(),a.VSZ=s[4].trim(),a.VSZP=s[5].trim(),a.CPU=s[6].trim(),a.CPUP=s[7].trim(),a.COMMAND=s[8].trim(),arrayproclistlines.push(a)}catch{}SortTable("sortTableProcesses","arrayproclistlines",sortnameproc+" "+sortdirproc.replace("desc","↑").replace("asc","↓").trim(),"sortnameproc","sortdirproc")}function GetCookie(t,e){return null!=cookie.get("scm_"+t)?cookie.get("scm_"+t):"string"==e?"":"number"==e?0:void 0}function SetCookie(t,e){cookie.set("scm_"+t,e,3650)}function AddEventHandlers(){$j(".collapsible-jquery").off("click").on("click",(function(){$j(this).siblings().toggle("fast",(function(){"none"==$j(this).css("display")?SetCookie($j(this).siblings()[0].id,"collapsed"):(SetCookie($j(this).siblings()[0].id,"expanded"),"routermemory"==$j(this).siblings()[0].id?(Draw_Chart("MemoryUsage"),0!=parseInt(mem_stats_arr[5])?Draw_Chart("SwapUsage"):Draw_Chart_NoData("SwapUsage","No swap file configured")):"routerstorage"==$j(this).siblings()[0].id&&(Draw_Chart("nvramUsage"),Draw_Chart("jffsUsage")))}))})),$j(".collapsible-jquery").each((function(t,e){"collapsed"==GetCookie($j(this)[0].id,"string")?$j(this).siblings().toggle(!1):$j(this).siblings().toggle(!0)})),$j("#auto_refresh").off("click").on("click",(function(){ToggleRefresh()}))}function SortTable(tableid,arrayid,sorttext,sortname,sortdir){window[sortname]=sorttext.replace("↑","").replace("↓","").trim();var sorttype="number",sortfield=window[sortname];switch(window[sortname]){case"VSZ%":sortfield="VSZP";break;case"CPU%":sortfield="CPUP";break;case"USER":case"STAT":case"COMMAND":case"Name":case"Command":sorttype="string";break}"string"==sorttype?-1==sorttext.indexOf("↓")&&-1==sorttext.indexOf("↑")||-1!=sorttext.indexOf("↓")?(eval(arrayid+" = "+arrayid+".sort((a,b) => (a."+sortfield+".toLowerCase() > b."+sortfield+".toLowerCase()) ? 1 : ((b."+sortfield+".toLowerCase() > a."+sortfield+".toLowerCase()) ? -1 : 0));"),window[sortdir]="asc"):(eval(arrayid+" = "+arrayid+".sort((a,b) => (a."+sortfield+".toLowerCase() < b."+sortfield+".toLowerCase()) ? 1 : ((b."+sortfield+".toLowerCase() < a."+sortfield+".toLowerCase()) ? -1 : 0));"),window[sortdir]="desc"):"number"==sorttype&&(-1==sorttext.indexOf("↓")&&-1==sorttext.indexOf("↑")||-1!=sorttext.indexOf("↓")?(eval(arrayid+" = "+arrayid+".sort((a,b) => parseFloat(getNum(a."+sortfield+'.replace("m","000"))) - parseFloat(getNum(b.'+sortfield+'.replace("m","000"))));'),window[sortdir]="asc"):(eval(arrayid+" = "+arrayid+".sort((a,b) => parseFloat(getNum(b."+sortfield+'.replace("m","000"))) - parseFloat(getNum(a.'+sortfield+'.replace("m","000"))));'),window[sortdir]="desc")),$j("#"+tableid).empty(),$j("#"+tableid).append(BuildSortTableHtml(tableid)),$j("#"+tableid).find(".sortable").each((function(t,e){e.innerHTML==window[sortname]&&("asc"==window[sortdir]?e.innerHTML=window[sortname]+" ↑":e.innerHTML=window[sortname]+" ↓")}))}function getNum(t){if(isNaN(t)){if("*"==t)return-10;if(-1!=t.indexOf("*/"))return-5;if(-1!=t.indexOf("/"))return t.split("/")[0];if("Sun"==t)return 0;if("Mon"==t)return 1;if("Tue"==t)return 2;if("Wed"==t)return 3;if("Thu"==t)return 4;if("Fri"==t)return 5;if("Sat"==t)return 6}return t}function ToggleRefresh(){1==$j("#auto_refresh").prop("checked")?get_proclist_file():null!=tmout&&clearTimeout(tmout)}function BuildAddonPageTable(t,e,r){var s="";if(0==r&&(s+='<div style="line-height:10px;">&nbsp;</div>',s+='<table width="100%" border="1" align="center" cellpadding="2" cellspacing="0" bordercolor="#6b8fa3" class="FormTable SettingsTable" style="border:0px;" id="table_services">',s+='<thead class="collapsible-jquery" id="addonpages">',s+='<tr><td colspan="4">WebUI Addons (click to expand/collapse)</td></tr>',s+="</thead>"),0!=r&&r%4!=0||(s+="<tr>"),s+='<td class="addonpageurl"><a href="'+e.substring(e.lastIndexOf("/")+1)+'">'+t+'</a><br /><span class="addonpageurl">'+e.substring(e.lastIndexOf("/")+1)+"</span></td>",r>0&&(r+1)%4==0&&(s+="</tr>"),r==sortedAddonPages.length-1){if(sortedAddonPages.length%4!=0){for(var a=4-sortedAddonPages.length%4,o=0;o<a;o++)s+='<td class="addonpageurl"></td>';s+="</tr>"}s+="</table>"}return s}function BuildServiceTable(t,e,r,s){var a="";return 0==s&&(a+='<div style="line-height:10px;">&nbsp;</div>',a+='<table width="100%" border="1" align="center" cellpadding="2" cellspacing="0" bordercolor="#6b8fa3" class="FormTable SettingsTable" style="border:0px;" id="table_services">',a+='<thead class="collapsible-jquery" id="servicescontrol">',a+='<tr><td colspan="4">Services (click to expand/collapse)</td></tr>',a+="</thead>"),0!=s&&s%2!=0||(a+="<tr>"),a+=r?'<td class="servicename">'+e+' <span class="settingname">('+t+")</span></td>":'<td class="servicename">'+e+"</td>",a+='<td class="servicevalue">',a+='<input type="button" class="button_gen restartbutton" onclick="RestartService(\''+(t=t.replace("/",""))+'\');" value="Restart" id="btnRestartSrv_'+t+'">',a+='<span id="txtRestartSrv_'+t+'" style="display:none;" class="servicespan">Done</span>',a+='<span id="txtRestartSrvError_'+t+'" style="display:none;" class="servicespan">Invalid - service disabled</span>',a+='<img id="imgRestartSrv_'+t+'" style="display:none;vertical-align:middle;" src="images/InternetScan.gif"/>',a+="</td>",s>0&&(s+1)%2==0&&(a+="</tr>"),s==srvnamelist.length-1&&(a+="</table>"),a}function BuildVPNClientTable(loopindex){var vpnclientshtml="",vpnclientname="vpnclient"+loopindex,vpnclientdesc=eval("document.form.vpnc"+loopindex+"_desc").value;return 1==loopindex&&(vpnclientshtml+='<div style="line-height:10px;">&nbsp;</div>',vpnclientshtml+='<table width="100%" border="1" align="center" cellpadding="2" cellspacing="0" bordercolor="#6b8fa3" class="FormTable SettingsTable" style="border:0px;" id="table_vpnclients">',vpnclientshtml+='<thead class="collapsible-jquery" id="vpnclientscontrol">',vpnclientshtml+='<tr><td colspan="4">VPN Clients (click to expand/collapse)</td></tr>',vpnclientshtml+="</thead>"),1!=loopindex&&(loopindex+1)%2!=0||(vpnclientshtml+="<tr>"),vpnclientshtml+='<td class="servicename">VPN Client '+loopindex,vpnclientshtml+='<br /><span class="settingname">('+vpnclientdesc+")</span></td>",vpnclientshtml+='<td class="servicevalue">',vpnclientshtml+='<input type="button" class="button_gen restartbutton" onclick="RestartService(\''+vpnclientname+'\');" value="Restart" id="btnRestartSrv_'+vpnclientname+'">',vpnclientshtml+='<span id="txtRestartSrv_'+vpnclientname+'" style="display:none;" class="servicespan">Done</span>',vpnclientshtml+='<span id="txtRestartSrvError_'+vpnclientname+'" style="display:none;" class="servicespan">Invalid - VPN Client disabled</span>',vpnclientshtml+='<img id="imgRestartSrv_'+vpnclientname+'" style="display:none;vertical-align:middle;" src="images/InternetScan.gif"/>',vpnclientshtml+="</td>",5==loopindex&&(vpnclientshtml+='<td class="servicename"></td><td class="servicevalue"></td>'),loopindex>1&&loopindex%2==0&&(vpnclientshtml+="</tr>"),5==loopindex&&(vpnclientshtml+="</table>"),vpnclientshtml}function BuildVPNServerTable(t){var e="",r="vpnserver"+t;return 1==t&&(e+='<div style="line-height:10px;">&nbsp;</div>',e+='<table width="100%" border="1" align="center" cellpadding="2" cellspacing="0" bordercolor="#6b8fa3" class="FormTable SettingsTable" style="border:0px;" id="table_vpnservers">',e+='<thead class="collapsible-jquery" id="vpnserverscontrol">',e+='<tr><td colspan="4">VPN Servers (click to expand/collapse)</td></tr>',e+="</thead>",e+="<tr>"),e+='<td class="servicename">VPN Server '+t+"</td>",e+='<td class="servicevalue">',e+='<input type="button" class="button_gen restartbutton" onclick="RestartService(\''+r+'\');" value="Restart" id="btnRestartSrv_'+r+'">',e+='<span id="txtRestartSrv_'+r+'" style="display:none;" class="servicespan">Done</span>',e+='<span id="txtRestartSrvError_'+r+'" style="display:none;" class="servicespan">Invalid - VPN Server disabled</span>',e+='<img id="imgRestartSrv_'+r+'" style="display:none;vertical-align:middle;" src="images/InternetScan.gif"/>',e+="</td>",2==t&&(e+="</tr>",e+="</table>"),e}function round(t,e){return Number(Math.round(t+"e"+e)+"e-"+e)}function Draw_Chart_NoData(t,e){document.getElementById("canvasChart"+t).width="265",document.getElementById("canvasChart"+t).height="250",document.getElementById("canvasChart"+t).style.width="265px",document.getElementById("canvasChart"+t).style.height="250px";var r=document.getElementById("canvasChart"+t).getContext("2d");r.save(),r.textAlign="center",r.textBaseline="middle",r.font="normal normal bolder 22px Arial",r.fillStyle="white",r.fillText(e,135,125),r.restore()}function Draw_Chart(t){var e=[],r=[],s=[],a="",o="";"MemoryUsage"==t?(e=[1*mem_stats_arr[0]-1*mem_stats_arr[1]-1*mem_stats_arr[2]-1*mem_stats_arr[3],mem_stats_arr[1],mem_stats_arr[2],mem_stats_arr[3]],r=["Used","Free","Buffers","Cache"],s=["#5eaec0","#12cf80","#ceca09","#9d12c4"],a="Memory Usage",o="MB"):"SwapUsage"==t?(e=[mem_stats_arr[4],1*mem_stats_arr[5]-1*mem_stats_arr[4]],r=["Used","Free"],s=["#135fee","#1aa658"],a="Swap Usage",o="MB"):"nvramUsage"==t?(e=[round(mem_stats_arr[6]/1024,2).toFixed(2),round(1*nvramtotal-1*mem_stats_arr[6]/1024,2).toFixed(2)],r=["Used","Free"],s=["#5eaec0","#12cf80"],a="NVRAM Usage",o="KB"):"jffsUsage"==t&&(e=[jffs_Used,jffs_Free],r=["Used","Free"],s=["#135fee","#1aa658"],a="JFFS Usage",o="MB");var n=window["Chart"+t];null!=n&&n.destroy();var i=document.getElementById("canvasChart"+t).getContext("2d");n=new Chart(i,{type:"pie",options:{segmentShowStroke:!1,segmentStrokeColor:"#000",maintainAspectRatio:!1,animation:{duration:0},hover:{animationDuration:0},responsiveAnimationDuration:0,legend:{onClick:null,display:!0,position:"left",labels:{fontColor:"#ffffff"}},title:{display:!0,text:a,position:"top"},tooltips:{callbacks:{title:function(t,e){return e.labels[t[0].index]},label:function(t,e){return round(e.datasets[t.datasetIndex].data[t.index],2).toFixed(2)+" "+o}},mode:"point",position:"cursor",intersect:!0},scales:{xAxes:[{display:!1,gridLines:{display:!1},scaleLabel:{display:!1},ticks:{display:!1}}],yAxes:[{display:!1,gridLines:{display:!1},scaleLabel:{display:!1},ticks:{display:!1}}]}},data:{labels:r,datasets:[{data:e,borderWidth:1,backgroundColor:s,borderColor:"#000000"}]}}),window["Chart"+t]=n}

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
<div class="formfonttitle" id="scripttitle" style="text-align:center;">scMerlin</div>
<div style="margin:10px 0 10px 5px;" class="splitLine"></div>
<div class="formfontdesc">scMerlin allows you to use easily control the most common services/scripts on your router. scMerlin also augments your router's WebUI with a Sitemap and dynamic submenus for the main left menu of Asuswrt-Merlin.</div>
<table width="100%" border="1" align="center" cellpadding="2" cellspacing="0" bordercolor="#6b8fa3" class="FormTable" style="border:0px;" id="table_buttons">
<thead class="collapsible-jquery" id="scripttools">
<tr><td colspan="2">Utilities (click to expand/collapse)</td></tr>
</thead>
<tr>
<th width="20%">Version information</th>
<td>
<span id="scmerlin_version_local" style="color:#FFFFFF;"></span>
&nbsp;&nbsp;&nbsp;
<span id="scmerlin_version_server" style="display:none;">Update version</span>
&nbsp;&nbsp;&nbsp;
<input type="button" class="button_gen" onclick="CheckUpdate();" value="Check" id="btnChkUpdate">
<img id="imgChkUpdate" style="display:none;vertical-align:middle;" src="images/InternetScan.gif"/>
<input type="button" class="button_gen" onclick="DoUpdate();" value="Update" id="btnDoUpdate" style="display:none;">
&nbsp;&nbsp;&nbsp;
</td>
</tr>
</table>

<div style="line-height:10px;">&nbsp;</div>
<table width="100%" border="1" align="center" cellpadding="2" cellspacing="0" bordercolor="#6b8fa3" class="FormTable SettingsTable" style="border:0px;" id="table_config">
<thead class="collapsible-jquery" id="scriptconfig">
<tr><td colspan="2">Configuration (click to expand/collapse)</td></tr>
</thead>

<!--
**----------------------------------------**
** Modified by Martinski W. [2024-Apr-29] **
**----------------------------------------**
-->
<tr class="even" id="rowEnableNTPwatchdog">
<td class="settingname">Enable NTP boot watchdog script<br/></td>
<td class="settingvalue">
<input type="radio" name="scMerlin_NTPwatchdog" id="scMerlin_NTPwatchdog_Enabled" class="input" value="Enable">Yes
<input type="radio" name="scMerlin_NTPwatchdog" id="scMerlin_NTPwatchdog_Disabled" class="input" value="Disable" checked>No
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" style="margin-left:100px;" onclick="Save_NTPWatchdog();" value="Save" id="btnSaveNTPwatchdog" class="button_gen savebutton" title="Apply and save selected option for NTP boot watchdog script" name="button">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span id="scMerlin_NTPwatchdog_Status" style="color:#FFCC00;"></span>
</td>
</tr>

<!--
**-------------------------------------**
** Added by Martinski W. [2024-Apr-28] **
**-------------------------------------**
-->
<tr class="even" id="rowEnableNTPReadyCheck">
<td class="settingname">Enable NTP Ready startup check<br/></td>
<td class="settingvalue">
<input type="radio" name="scMerlin_NTPcheck" id="scMerlin_NTPcheck_Enabled" class="input" value="Enable">Yes
<input type="radio" name="scMerlin_NTPcheck" id="scMerlin_NTPcheck_Disabled" class="input" value="Disable" checked>No
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" style="margin-left:100px;" onclick="Save_NTPReadyCheck_Option();" value="Save" id="btnSaveNTPcheck" class="button_gen savebutton" title="" name="button">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span id="scMerlin_NTPcheck_Status" style="color:#FFCC00;"></span>
</td>
</tr>

<!--
**-------------------------------------**
** Added by Martinski W. [2024-Apr-29] **
**-------------------------------------**
-->
<tr class="even" id="rowEnableDNSmasqWatchdog">
<td class="settingname">Enable 'dnsmasq tainted' watchdog script<br/></td>
<td class="settingvalue">
<input type="radio" name="scMerlin_DNSmasqWatchdog" id="scMerlin_DNSmasqWatchdog_Enabled" class="input" value="Enable">Yes
<input type="radio" name="scMerlin_DNSmasqWatchdog" id="scMerlin_DNSmasqWatchdog_Disabled" class="input" value="Disable" checked>No
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" style="margin-left:100px;" onclick="Save_DNSmasqWatchdog();" value="Save" id="btnSaveDNSmasqWatchdog" class="button_gen savebutton" title="Apply and save selected option for 'dnsmasq tainted' watchdog script" name="button">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span id="scMerlin_DNSmasqWatchdog_Status" style="color:#FFCC00;"></span>
</td>
</tr>
</table>

<!-- Insert service control tables here -->

<!-- Start Entware table -->
<div style="line-height:10px;">&nbsp;</div>
<table width="100%" border="1" align="center" cellpadding="2" cellspacing="0" bordercolor="#6b8fa3" class="FormTable SettingsTable" style="border:0px;" id="table_entware">
<thead class="collapsible-jquery" id="entwarecontrol">
<tr><td colspan="2">Entware (click to expand/collapse)</td></tr>
</thead>
<tr>
<td class="settingname">Entware applications</td>
<td class="settingvalue">
<input type="button" class="button_gen restartbutton" onclick="RestartService('entware');" value="Restart" id="btnRestartSrv_entware">
<span id="txtRestartSrv_entware" style="display:none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Done</span>
<span id="txtRestartSrvError_entware" style="display:none;">Invalid - Entware not running</span>
<img id="imgRestartSrv_entware" style="display:none;vertical-align:middle;" src="images/InternetScan.gif"/>
&nbsp;&nbsp;&nbsp;
</td>
</tr>
</table>
<!-- End Entware table -->
<div style="line-height:10px;">&nbsp;</div>
<table width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable">
<thead class="collapsible-jquery" id="router">
<tr>
<td>Router (click to expand/collapse)</td>
</tr>
</thead>
<tr><td align="center" style="padding: 0px;">
<table width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable SettingsTable">
<thead class="collapsible-jquery" id="routertemps">
<tr>
<td colspan="2">Temperatures (click to expand/collapse)</td>
</tr>
</thead>
<tr>
<td class="servicename">Temperatures</td>
<td id="temp_td" class="settingvalue"></td>
</tr>
</table>
<div style="line-height:10px;">&nbsp;</div>
<table width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable">
<thead class="collapsible-jquery" id="routermemory">
<tr>
<td colspan="4">Memory (click to expand/collapse)</td>
</tr>
</thead>
<tr>
<td class="metricname">Total</td>
<td id="mem_total_td" width="125px" style="width:125px;"></td>
<td id="ram_chart" rowspan="5" style="padding-left:4px;width:265px;" width="265px">
<div style="background-color:#2f3e44;border-radius:10px;width:265px;" id="divChartMemoryUsage">
<canvas id="canvasChartMemoryUsage" height="250" />
</div>
</td>
<td id="swap_chart" rowspan="5" style="padding-left:4px;width:265px;" width="265px">
<div style="background-color:#2f3e44;border-radius:10px;width:265px;" id="divChartSwapUsage">
<canvas id="canvasChartSwapUsage" height="250" />
</div>
</td>
</tr>
<tr>
<td class="metricname">Free</td>
<td id="mem_free_td" style="width:125px;"></td>
</tr>
<tr>
<td class="metricname">Buffers</td>
<td id="mem_buffer_td" style="width:125px;"></td>
</tr>
<tr>
<td class="metricname">Cache</td>
<td id="mem_cache_td" style="width:125px;"></td>
</tr>
<tr>
<td class="metricname">Swap</td>
<td id="mem_swap_td" style="width:125px;"></td>
</tr>
</table>
<div style="line-height:10px;">&nbsp;</div>
<table width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable">
<thead class="collapsible-jquery" id="routerstorage">
<tr>
<td colspan="4">Internal Storage (click to expand/collapse)</td>
</tr>
</thead>
<tr>
<td class="metricname">NVRAM</td>
<td id="nvram_td" style="width:125px;"></td>
<td id="nvram_chart" rowspan="2" style="padding-left:4px;width:265px;" width="265px">
<div style="background-color:#2f3e44;border-radius:10px;width:265px;" id="divChartnvramUsage">
<canvas id="canvasChartnvramUsage" height="250" />
</div>
</td>
<td id="jffs_chart" rowspan="2" style="padding-left:4px;width:265px;" width="265px">
<div style="background-color:#2f3e44;border-radius:10px;width:265px;" id="divChartjffsUsage">
<canvas id="canvasChartjffsUsage" height="250" />
</div>
</td>
</tr>
<tr>
<td class="metricname">JFFS</td>
<td id="jffs_td" style="width:125px;"></td>
</tr>
</table>

<!-- Start Cron table -->
<div style="line-height:10px;">&nbsp;</div>
<table width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable" id="scm_table_cron">
<thead class="collapsible-jquery" id="thead_cron">
<tr><td>Cron Jobs (click to expand/collapse)</td></tr>
</thead>
<tr>
<td align="center" style="padding: 0px;">
<div id="sortTableCron" class="sortTableContainer" style="height:300px;"></div>
</td>
</tr>
</table>
<!-- End Cron table -->

<!-- Start Process List -->
<div style="line-height:10px;">&nbsp;</div>
<table width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable" id="scm_table_proclist">
<col style="width:35%;">
<col style="width:65%;">
<thead class="collapsible-jquery" id="proclist">
<tr><td colspan="2">Process List (click to expand/collapse)</td></tr>
</thead>
<tr class="even">
<th>Update automatically?</th>
<td>
<label style="color:#FFCC00;display:block;">
<input type="checkbox" checked="" id="auto_refresh" style="padding:0;margin:0;vertical-align:middle;position:relative;top:-1px;" />&nbsp;&nbsp;Table will refresh every 5s</label>
</td>
</tr>
<tr style="line-height:5px;"><td colspan="2">&nbsp;</td></tr>
<tr>
<td colspan="2" align="center" style="padding: 0px;">
<div id="sortTableProcesses" class="sortTableContainer"></div>
</td>
</tr>
</table>
<!-- End Process List -->
</td>
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
<form method="post" name="formScriptActions" action="/start_apply.htm" target="hidden_frame">
<input type="hidden" name="productid" value="<% nvram_get("productid"); %>">
<input type="hidden" name="current_page" value="">
<input type="hidden" name="next_page" value="">
<input type="hidden" name="action_mode" value="apply">
<input type="hidden" name="action_script" value="">
<input type="hidden" name="action_wait" value="">
</form>
<div id="footer">
</div>
</body>
</html>
