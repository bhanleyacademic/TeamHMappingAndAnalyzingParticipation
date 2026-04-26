// JScript File

var dtSelectedDate;
var CalendarMonths;
var intDatePickerLength;
var ctrlName;
var oPopup;
var relativePath;

function fnDisablePromptDialog()
{
}

function InitializeCalendar(relativePath) {
	if (relativePath == undefined)
	{
		this.relativePath = "../";	
	}
	else
	{
		this.relativePath = relativePath;
	}
	
	this.CalendarMonths = new Array("January","February","March","April","May","June","July","August","September","October","November","December");
}

function fnShowCalendar(objControl,ctrlName) {	
    
    var intTop, intLeft;

    if (document.all(ctrlName).disabled == true)  return;
	this.ctrlName = ctrlName;		
    
	var strDate = document.all(ctrlName).value.split("/");		

    if(strDate.length >= 2)
	    dtSelectedDate = new Date(strDate[1] + "/" + strDate[0] + "/" + strDate[2]);
	else
	   dtSelectedDate = new Date();		

	if (dtSelectedDate == "NaN")
		dtSelectedDate = new Date();		

    if ( event.y  <= (document.body.clientHeight - 140) )
	    intTop = window.event.y;
    else
	    intTop = window.event.y - 140 - 20;
		
    if ( window.event.x  <= (document.body.clientWidth - 220) )
	    intLeft = window.event.x;
    else	
	    intLeft = window.event.x - 220 + 10;
    
	fnDisplayPopup(intLeft, intTop, fnBuildContent());	
	
}


function fnChangeMonth(incr) {
	var intMonth;
	intMonth = dtSelectedDate.getMonth();	
	intMonth = intMonth + incr;
	
	if (intMonth == 0){
		intMonth = 12;
		fnChangeYear(-1)
	} else if (intMonth == 13) {
		intMonth = 1;
		fnChangeYear(1);
	}
	
	var dtFindDate = new Date(dtSelectedDate.getYear(), intMonth , dtSelectedDate.getDate());	
	if ( dtFindDate.getMonth() != intMonth )
		dtSelectedDate = new Date(dtSelectedDate.getYear() , intMonth ,1);		
	else
		dtSelectedDate = new Date(dtSelectedDate.getYear(), intMonth , dtSelectedDate.getDate());	
	
}

function fnChangeYear(incr) {
	var intYear;
	intYear = dtSelectedDate.getFullYear();
	intYear = intYear + incr;	
	dtSelectedDate = new Date(intYear, dtSelectedDate.getMonth(), dtSelectedDate.getDate());	
}

function fnDisplayPopup(leftX, topY, content) {
	var tmpStr;
	oPopup = window.createPopup();
	var oPopupBody = oPopup.document.body;	
	
	tmpStr = "<HTML><HEAD></HEAD>" + 
				"<SCRIPT>function fnRefresh(content) {dvContent.innerHTML=content}</SCRIPT>" +
				"<STYLE> .WeekDay {font-size: 11px;color: #333374;font-family: Verdana,Arial,Helvetica,Sans-serif;} " + 
				" .WeekHead{font-size: 11px;color: #ffffff;font-family: Verdana,Arial,Helvetica,Sans-serif;background-color: #333374;} " + 
				" .WeekEnd{font-size: 11px;color: navy;font-family: Verdana,Arial,Helvetica,Sans-serif;background-color: #aec3dc;} " +
				" .HighlightColor{font-size: 11px;color: #000000;font-weight:bold;font-family: Verdana,Arial,Helvetica,Sans-serif;background-color: #c0e3f4;}"  +
				" .linkButton{cursor:hand;color:000080;} </STYLE>" + 
				"<BODY STYLE='border-top:0px;border-left:0px;border-right:0px;border-bottom:0px;' scroll=no topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0><div style='filter:alpha(opacity=50)' ID=dvContent>"
			
	oPopup.document.write(tmpStr + content + "</div></BODY></HTML>");
	oPopup.show(leftX, topY, 203, 158, document.body);
}

function fnBuildContent() 
{
try 
{

	var tmpStr
	
	intDatePickerLength = 0;
	
	var tmpDateStr = fnGetDateList(dtSelectedDate);
	
	if (intDatePickerLength == 6 )
	{
		tmpStr = "<table border=0 width=100% STYLE='border-top:solid 1px gray;border-left:solid 1px gray;border-right:solid 1px gray;border-bottom:solid 1px gray;' cellspacing=0 cellpadding=0><tr class=Weekend><td><table  border=0 cellpadding=3 width=100% class=Weekend><tr><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeMonth(-1);fnRefresh(parent.fnBuildContent());'><img src="+ relativePath +"images/Calendar_Down.gif></a></td> " +
				" <td width=130 ALIGN=CENTER class=Weekend>" + this.CalendarMonths[dtSelectedDate.getMonth()] +"</td><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeMonth(1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Up.gif></a></td>" + 
				" <td ALIGN=CENTER WIDTH=10><a class=linkbutton onClick='javascript:parent.fnChangeYear(-1);fnRefresh(parent.fnBuildContent());'><IMG SRC='" + relativePath + "images/Calendar_down.gif'></a></td> " +
				" <td ALIGN=CENTER class=Weekend width=30>" + dtSelectedDate.getFullYear() +"</td><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeYear(1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Up.gif></a></td>" + 					
				" </tr></table></td></tr><tr><td>"										
	}
	else
	{
		tmpStr = "<table border=0 width=100% STYLE='border-top:solid 1px gray;border-left:solid 1px gray;border-right:solid 1px gray;border-bottom:solid 1px gray;' cellspacing=0 cellpadding=0><tr class=Weekend><td><table  border=0 cellpadding=5 width=100% class=Weekend><tr><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeMonth(-1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Down.gif></a></td> " +
				" <td width=130 ALIGN=CENTER class=Weekend>" + this.CalendarMonths[dtSelectedDate.getMonth()] +"</td><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeMonth(1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Up.gif></a></td>" + 
				" <td ALIGN=CENTER WIDTH=10><a class=linkbutton onClick='javascript:parent.fnChangeYear(-1);fnRefresh(parent.fnBuildContent());'><IMG SRC='" + relativePath + "images/Calendar_down.gif'></a></td> " +
				" <td ALIGN=CENTER class=Weekend width=30>" + dtSelectedDate.getFullYear() +"</td><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeYear(1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Up.gif></a></td>" + 					
				" </tr></table></td></tr><tr><td>"										
	}
	
	if (intDatePickerLength == 6 )
		tmpDateStr = tmpDateStr.replace("~!$",3);
	else
		tmpDateStr = tmpDateStr.replace("~!$",4);
		
	
		
	tmpStr += tmpDateStr;
	tmpStr += "</td></tr></table>";
} catch(ex) {
	alert(ex.message);}	
	return tmpStr;
}

function fnSetValue(dtDate) 
{	
	dtSelectedDate = new Date(dtDate);	
	document.all(ctrlName).value = fnGetDateUK(new Date(dtDate)); 		
	oPopup.hide();
}

function fnGetDateList(dtDate)
{
	var dtCurrDate = new Date(dtDate);
	dtCurrDate.setDate(1);
	
	var strDates;
	var intCount
	strDates = '<table border="0" cellspacing="0" cellpadding="~!$" width="100%">'
	
	// For Table Head
	
	strDates += '<tr><td class="WeekHead">Sun</td>';
	strDates += '<td class="WeekHead">Mon</td>';
	strDates += '<td class="WeekHead">Tue</td>';
	strDates += '<td class="WeekHead">Wed</td>';
	strDates += '<td class="WeekHead">Thu</td>';
	strDates += '<td class="WeekHead">Fri</td>';
	strDates += '<td class="WeekHead">Sat</td></tr>';
	
	
	// For empty space of the month
	for (intCount=1;intCount<=dtCurrDate.getDay();intCount++)
	{
		if ( intCount == 1 )
			strDates += '<tr><td class="WeekEnd">&nbsp;</td>';
		else
			strDates += '<td class="WeekDay">&nbsp;</td>';
	}
	
	var bolContinue = true;
	intCount  = 1;
	var intEndWeekCount = 0
	intDatePickerLength = 0
	
	while (bolContinue)
	{
		var strDate;
		
		// to display only current months date
		if ( intEndWeekCount == 0 )
			strDate = '<a class="LinkButton" onclick="javascript:parent.fnSetValue(' + "'" + fnGetDate(intCount,dtCurrDate) + "'" + ');">' + intCount + '</a>' ; 
		else
			strDate = '';
			
		if ((dtCurrDate.getDate() == dtDate.getDate() ) && (dtCurrDate.getMonth() == dtDate.getMonth())) 
		{
			strDates += '<td class="HighlightColor">' + strDate + '</td>';
			
			if ( intDatePickerLength == 0 )
				intDatePickerLength++;
				
			if ( dtCurrDate.getDay() == 0 )
				intDatePickerLength++;
		}
		else
		{
			switch (dtCurrDate.getDay())
			{
				case 0:
					strDates += '<tr><td class="WeekEnd">' + strDate + '</td>';
					intDatePickerLength++;
					break;
				case 6:
					strDates += '<td class="WeekEnd">' + strDate + '</td></tr>';
					if ( intDatePickerLength == 0 )
						intDatePickerLength++;
					break;
				default:
					strDates += '<td class="WeekDay">' + strDate + '</td>';
					if ( intDatePickerLength == 0 )
						intDatePickerLength++;
			}
		}
			
		intCount++;
		
		// continue until the end of the month and end of the week
		// to be returned
		if ( (intEndWeekCount != 0) && ( dtCurrDate.getDay() == 6 ) )
			bolContinue = false;
		
		// adding date
		dtCurrDate.setDate(dtCurrDate.getDate() + 1);
		
		// checking current month and give month are same
		// if true display the month
		// else we need add white space till the end of the week
		
		if ( dtCurrDate.getMonth() != dtDate.getMonth())
			intEndWeekCount++;
		
	}
	
	strDates += '</table>' 
	
	return strDates;
	
}



function fnGetDate(intDate,dtCurrDate)
{
	var strDate;
	
	// Adding month, month starts from 0 so getMonth return 0 for jan
	// and 11 dec and so on..
	if ( parseInt(dtCurrDate.getMonth(),10) < 9 )
		strDate = '0' + new String(parseInt(dtCurrDate.getMonth(),10) + 1);
	else
		strDate = dtCurrDate.getMonth()+ 1;
	
	strDate+= '/';
	
	// date part
	if ( parseInt(intDate,10) < 10 )
		strDate += '0' + new String(parseInt(intDate,10));
	else
		strDate += intDate
		
	strDate+= '/' + dtCurrDate.getFullYear();
	
	// year part
	return strDate;
		
}

function fnGetDateUK(dtCurrDate)
{
	var strDate;
	
	// date part
	if ( parseInt(dtCurrDate.getDate(),10) < 10 )
		strDate = '0' + new String(parseInt(dtCurrDate.getDate(),10));
	else
		strDate = dtCurrDate.getDate();
	
	strDate += '/';
	
	// Adding month, month starts from 0 so getMonth return 0 for jan
	// and 11 dec and so on..
	if ( parseInt(dtCurrDate.getMonth(),10) < 9 )
		strDate += '0' + new String(parseInt(dtCurrDate.getMonth(),10) + 1);
	else
		strDate += dtCurrDate.getMonth()+ 1;

		
	strDate += '/' + dtCurrDate.getFullYear();
	
	// year part
	return strDate;
		
}

function handleDocumentClick(){
	fnEnablePromptDialog();
}
var dtSelectedDate;
var CalendarMonths;
var intDatePickerLength;
var ctrlName;
var oPopup;
var relativePath;

function fnDisablePromptDialog()
{
}

function InitializeCalendar(relativePath) {
	if (relativePath == undefined)
	{
		this.relativePath = "../";	
	}
	else
	{
		this.relativePath = relativePath;
	}
	
	this.CalendarMonths = new Array("January","February","March","April","May","June","July","August","September","October","November","December");
}

function fnShowCalendar(objControl,ctrlName) {	
    
    var intTop, intLeft;

    if (document.all(ctrlName).disabled == true)  return;
	this.ctrlName = ctrlName;		
    
	var strDate = document.all(ctrlName).value.split("/");		

    if(strDate.length >= 2)
	    dtSelectedDate = new Date(strDate[1] + "/" + strDate[0] + "/" + strDate[2]);
	else
	   dtSelectedDate = new Date();		

	if (dtSelectedDate == "NaN")
		dtSelectedDate = new Date();		

    if ( event.y  <= (document.body.clientHeight - 140) )
	    intTop = window.event.y;
    else
	    intTop = window.event.y - 140 - 20;
		
    if ( window.event.x  <= (document.body.clientWidth - 220) )
	    intLeft = window.event.x;
    else	
	    intLeft = window.event.x - 220 + 10;
    
	fnDisplayPopup(intLeft, intTop, fnBuildContent());	
	
}


function fnChangeMonth(incr) {
	var intMonth;
	intMonth = dtSelectedDate.getMonth();	
	intMonth = intMonth + incr;
	
	if (intMonth == 0){
		intMonth = 12;
		fnChangeYear(-1)
	} else if (intMonth == 13) {
		intMonth = 1;
		fnChangeYear(1);
	}
	
	var dtFindDate = new Date(dtSelectedDate.getYear(), intMonth , dtSelectedDate.getDate());	
	if ( dtFindDate.getMonth() != intMonth )
		dtSelectedDate = new Date(dtSelectedDate.getYear() , intMonth ,1);		
	else
		dtSelectedDate = new Date(dtSelectedDate.getYear(), intMonth , dtSelectedDate.getDate());	
	
}

function fnChangeYear(incr) {
	var intYear;
	intYear = dtSelectedDate.getFullYear();
	intYear = intYear + incr;	
	dtSelectedDate = new Date(intYear, dtSelectedDate.getMonth(), dtSelectedDate.getDate());	
}

function fnDisplayPopup(leftX, topY, content) {
	var tmpStr;
	oPopup = window.createPopup();
	var oPopupBody = oPopup.document.body;	
	
	tmpStr = "<HTML><HEAD></HEAD>" + 
				"<SCRIPT>function fnRefresh(content) {dvContent.innerHTML=content}</SCRIPT>" +
				"<STYLE> .WeekDay {font-size: 11px;color: #333374;font-family: Verdana,Arial,Helvetica,Sans-serif;} " + 
				" .WeekHead{font-size: 11px;color: #ffffff;font-family: Verdana,Arial,Helvetica,Sans-serif;background-color: #333374;} " + 
				" .WeekEnd{font-size: 11px;color: navy;font-family: Verdana,Arial,Helvetica,Sans-serif;background-color: #aec3dc;} " +
				" .HighlightColor{font-size: 11px;color: #000000;font-weight:bold;font-family: Verdana,Arial,Helvetica,Sans-serif;background-color: #c0e3f4;}"  +
				" .linkButton{cursor:hand;color:000080;} </STYLE>" + 
				"<BODY STYLE='border-top:0px;border-left:0px;border-right:0px;border-bottom:0px;' scroll=no topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0><div style='filter:alpha(opacity=50)' ID=dvContent>"
			
	oPopup.document.write(tmpStr + content + "</div></BODY></HTML>");
	oPopup.show(leftX, topY, 203, 158, document.body);
}

function fnBuildContent() 
{
try 
{

	var tmpStr
	
	intDatePickerLength = 0;
	
	var tmpDateStr = fnGetDateList(dtSelectedDate);
	
	if (intDatePickerLength == 6 )
	{
		tmpStr = "<table border=0 width=100% STYLE='border-top:solid 1px gray;border-left:solid 1px gray;border-right:solid 1px gray;border-bottom:solid 1px gray;' cellspacing=0 cellpadding=0><tr class=Weekend><td><table  border=0 cellpadding=3 width=100% class=Weekend><tr><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeMonth(-1);fnRefresh(parent.fnBuildContent());'><img src="+ relativePath +"images/Calendar_Down.gif></a></td> " +
				" <td width=130 ALIGN=CENTER class=Weekend>" + this.CalendarMonths[dtSelectedDate.getMonth()] +"</td><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeMonth(1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Up.gif></a></td>" + 
				" <td ALIGN=CENTER WIDTH=10><a class=linkbutton onClick='javascript:parent.fnChangeYear(-1);fnRefresh(parent.fnBuildContent());'><IMG SRC='" + relativePath + "images/Calendar_down.gif'></a></td> " +
				" <td ALIGN=CENTER class=Weekend width=30>" + dtSelectedDate.getFullYear() +"</td><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeYear(1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Up.gif></a></td>" + 					
				" </tr></table></td></tr><tr><td>"										
	}
	else
	{
		tmpStr = "<table border=0 width=100% STYLE='border-top:solid 1px gray;border-left:solid 1px gray;border-right:solid 1px gray;border-bottom:solid 1px gray;' cellspacing=0 cellpadding=0><tr class=Weekend><td><table  border=0 cellpadding=5 width=100% class=Weekend><tr><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeMonth(-1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Down.gif></a></td> " +
				" <td width=130 ALIGN=CENTER class=Weekend>" + this.CalendarMonths[dtSelectedDate.getMonth()] +"</td><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeMonth(1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Up.gif></a></td>" + 
				" <td ALIGN=CENTER WIDTH=10><a class=linkbutton onClick='javascript:parent.fnChangeYear(-1);fnRefresh(parent.fnBuildContent());'><IMG SRC='" + relativePath + "images/Calendar_down.gif'></a></td> " +
				" <td ALIGN=CENTER class=Weekend width=30>" + dtSelectedDate.getFullYear() +"</td><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeYear(1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Up.gif></a></td>" + 					
				" </tr></table></td></tr><tr><td>"										
	}
	
	if (intDatePickerLength == 6 )
		tmpDateStr = tmpDateStr.replace("~!$",3);
	else
		tmpDateStr = tmpDateStr.replace("~!$",4);
		
	
		
	tmpStr += tmpDateStr;
	tmpStr += "</td></tr></table>";
} catch(ex) {
	alert(ex.message);}	
	return tmpStr;
}

function fnSetValue(dtDate) 
{	
	dtSelectedDate = new Date(dtDate);	
	document.all(ctrlName).value = fnGetDateUK(new Date(dtDate)); 		
	oPopup.hide();
}

function fnGetDateList(dtDate)
{
	var dtCurrDate = new Date(dtDate);
	dtCurrDate.setDate(1);
	
	var strDates;
	var intCount
	strDates = '<table border="0" cellspacing="0" cellpadding="~!$" width="100%">'
	
	// For Table Head
	
	strDates += '<tr><td class="WeekHead">Sun</td>';
	strDates += '<td class="WeekHead">Mon</td>';
	strDates += '<td class="WeekHead">Tue</td>';
	strDates += '<td class="WeekHead">Wed</td>';
	strDates += '<td class="WeekHead">Thu</td>';
	strDates += '<td class="WeekHead">Fri</td>';
	strDates += '<td class="WeekHead">Sat</td></tr>';
	
	
	// For empty space of the month
	for (intCount=1;intCount<=dtCurrDate.getDay();intCount++)
	{
		if ( intCount == 1 )
			strDates += '<tr><td class="WeekEnd">&nbsp;</td>';
		else
			strDates += '<td class="WeekDay">&nbsp;</td>';
	}
	
	var bolContinue = true;
	intCount  = 1;
	var intEndWeekCount = 0
	intDatePickerLength = 0
	
	while (bolContinue)
	{
		var strDate;
		
		// to display only current months date
		if ( intEndWeekCount == 0 )
			strDate = '<a class="LinkButton" onclick="javascript:parent.fnSetValue(' + "'" + fnGetDate(intCount,dtCurrDate) + "'" + ');">' + intCount + '</a>' ; 
		else
			strDate = '';
			
		if ((dtCurrDate.getDate() == dtDate.getDate() ) && (dtCurrDate.getMonth() == dtDate.getMonth())) 
		{
			strDates += '<td class="HighlightColor">' + strDate + '</td>';
			
			if ( intDatePickerLength == 0 )
				intDatePickerLength++;
				
			if ( dtCurrDate.getDay() == 0 )
				intDatePickerLength++;
		}
		else
		{
			switch (dtCurrDate.getDay())
			{
				case 0:
					strDates += '<tr><td class="WeekEnd">' + strDate + '</td>';
					intDatePickerLength++;
					break;
				case 6:
					strDates += '<td class="WeekEnd">' + strDate + '</td></tr>';
					if ( intDatePickerLength == 0 )
						intDatePickerLength++;
					break;
				default:
					strDates += '<td class="WeekDay">' + strDate + '</td>';
					if ( intDatePickerLength == 0 )
						intDatePickerLength++;
			}
		}
			
		intCount++;
		
		// continue until the end of the month and end of the week
		// to be returned
		if ( (intEndWeekCount != 0) && ( dtCurrDate.getDay() == 6 ) )
			bolContinue = false;
		
		// adding date
		dtCurrDate.setDate(dtCurrDate.getDate() + 1);
		
		// checking current month and give month are same
		// if true display the month
		// else we need add white space till the end of the week
		
		if ( dtCurrDate.getMonth() != dtDate.getMonth())
			intEndWeekCount++;
		
	}
	
	strDates += '</table>' 
	
	return strDates;
	
}



function fnGetDate(intDate,dtCurrDate)
{
	var strDate;
	
	// Adding month, month starts from 0 so getMonth return 0 for jan
	// and 11 dec and so on..
	if ( parseInt(dtCurrDate.getMonth(),10) < 9 )
		strDate = '0' + new String(parseInt(dtCurrDate.getMonth(),10) + 1);
	else
		strDate = dtCurrDate.getMonth()+ 1;
	
	strDate+= '/';
	
	// date part
	if ( parseInt(intDate,10) < 10 )
		strDate += '0' + new String(parseInt(intDate,10));
	else
		strDate += intDate
		
	strDate+= '/' + dtCurrDate.getFullYear();
	
	// year part
	return strDate;
		
}

function fnGetDateUK(dtCurrDate)
{
	var strDate;
	
	// date part
	if ( parseInt(dtCurrDate.getDate(),10) < 10 )
		strDate = '0' + new String(parseInt(dtCurrDate.getDate(),10));
	else
		strDate = dtCurrDate.getDate();
	
	strDate += '/';
	
	// Adding month, month starts from 0 so getMonth return 0 for jan
	// and 11 dec and so on..
	if ( parseInt(dtCurrDate.getMonth(),10) < 9 )
		strDate += '0' + new String(parseInt(dtCurrDate.getMonth(),10) + 1);
	else
		strDate += dtCurrDate.getMonth()+ 1;

		
	strDate += '/' + dtCurrDate.getFullYear();
	
	// year part
	return strDate;
		
}

function handleDocumentClick(){
	fnEnablePromptDialog();
}
var dtSelectedDate;
var CalendarMonths;
var intDatePickerLength;
var ctrlName;
var oPopup;
var relativePath;

function fnDisablePromptDialog()
{
}

function InitializeCalendar(relativePath) {
	if (relativePath == undefined)
	{
		this.relativePath = "../";	
	}
	else
	{
		this.relativePath = relativePath;
	}
	
	this.CalendarMonths = new Array("January","February","March","April","May","June","July","August","September","October","November","December");
}

function fnShowCalendar(objControl,ctrlName) {	
    
    var intTop, intLeft;

    if (document.all(ctrlName).disabled == true)  return;
	this.ctrlName = ctrlName;		
    
	var strDate = document.all(ctrlName).value.split("/");		

    if(strDate.length >= 2)
	    dtSelectedDate = new Date(strDate[1] + "/" + strDate[0] + "/" + strDate[2]);
	else
	   dtSelectedDate = new Date();		

	if (dtSelectedDate == "NaN")
		dtSelectedDate = new Date();		

    if ( event.y  <= (document.body.clientHeight - 140) )
	    intTop = window.event.y;
    else
	    intTop = window.event.y - 140 - 20;
		
    if ( window.event.x  <= (document.body.clientWidth - 220) )
	    intLeft = window.event.x;
    else	
	    intLeft = window.event.x - 220 + 10;
    
	fnDisplayPopup(intLeft, intTop, fnBuildContent());	
	
}


function fnChangeMonth(incr) {
	var intMonth;
	intMonth = dtSelectedDate.getMonth();	
	intMonth = intMonth + incr;
	
	if (intMonth == 0){
		intMonth = 12;
		fnChangeYear(-1)
	} else if (intMonth == 13) {
		intMonth = 1;
		fnChangeYear(1);
	}
	
	var dtFindDate = new Date(dtSelectedDate.getYear(), intMonth , dtSelectedDate.getDate());	
	if ( dtFindDate.getMonth() != intMonth )
		dtSelectedDate = new Date(dtSelectedDate.getYear() , intMonth ,1);		
	else
		dtSelectedDate = new Date(dtSelectedDate.getYear(), intMonth , dtSelectedDate.getDate());	
	
}

function fnChangeYear(incr) {
	var intYear;
	intYear = dtSelectedDate.getFullYear();
	intYear = intYear + incr;	
	dtSelectedDate = new Date(intYear, dtSelectedDate.getMonth(), dtSelectedDate.getDate());	
}

function fnDisplayPopup(leftX, topY, content) {
	var tmpStr;
	oPopup = window.createPopup();
	var oPopupBody = oPopup.document.body;	
	
	tmpStr = "<HTML><HEAD></HEAD>" + 
				"<SCRIPT>function fnRefresh(content) {dvContent.innerHTML=content}</SCRIPT>" +
				"<STYLE> .WeekDay {font-size: 11px;color: #333374;font-family: Verdana,Arial,Helvetica,Sans-serif;} " + 
				" .WeekHead{font-size: 11px;color: #ffffff;font-family: Verdana,Arial,Helvetica,Sans-serif;background-color: #333374;} " + 
				" .WeekEnd{font-size: 11px;color: navy;font-family: Verdana,Arial,Helvetica,Sans-serif;background-color: #aec3dc;} " +
				" .HighlightColor{font-size: 11px;color: #000000;font-weight:bold;font-family: Verdana,Arial,Helvetica,Sans-serif;background-color: #c0e3f4;}"  +
				" .linkButton{cursor:hand;color:000080;} </STYLE>" + 
				"<BODY STYLE='border-top:0px;border-left:0px;border-right:0px;border-bottom:0px;' scroll=no topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0><div style='filter:alpha(opacity=50)' ID=dvContent>"
			
	oPopup.document.write(tmpStr + content + "</div></BODY></HTML>");
	oPopup.show(leftX, topY, 203, 158, document.body);
}

function fnBuildContent() 
{
try 
{

	var tmpStr
	
	intDatePickerLength = 0;
	
	var tmpDateStr = fnGetDateList(dtSelectedDate);
	
	if (intDatePickerLength == 6 )
	{
		tmpStr = "<table border=0 width=100% STYLE='border-top:solid 1px gray;border-left:solid 1px gray;border-right:solid 1px gray;border-bottom:solid 1px gray;' cellspacing=0 cellpadding=0><tr class=Weekend><td><table  border=0 cellpadding=3 width=100% class=Weekend><tr><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeMonth(-1);fnRefresh(parent.fnBuildContent());'><img src="+ relativePath +"images/Calendar_Down.gif></a></td> " +
				" <td width=130 ALIGN=CENTER class=Weekend>" + this.CalendarMonths[dtSelectedDate.getMonth()] +"</td><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeMonth(1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Up.gif></a></td>" + 
				" <td ALIGN=CENTER WIDTH=10><a class=linkbutton onClick='javascript:parent.fnChangeYear(-1);fnRefresh(parent.fnBuildContent());'><IMG SRC='" + relativePath + "images/Calendar_down.gif'></a></td> " +
				" <td ALIGN=CENTER class=Weekend width=30>" + dtSelectedDate.getFullYear() +"</td><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeYear(1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Up.gif></a></td>" + 					
				" </tr></table></td></tr><tr><td>"										
	}
	else
	{
		tmpStr = "<table border=0 width=100% STYLE='border-top:solid 1px gray;border-left:solid 1px gray;border-right:solid 1px gray;border-bottom:solid 1px gray;' cellspacing=0 cellpadding=0><tr class=Weekend><td><table  border=0 cellpadding=5 width=100% class=Weekend><tr><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeMonth(-1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Down.gif></a></td> " +
				" <td width=130 ALIGN=CENTER class=Weekend>" + this.CalendarMonths[dtSelectedDate.getMonth()] +"</td><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeMonth(1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Up.gif></a></td>" + 
				" <td ALIGN=CENTER WIDTH=10><a class=linkbutton onClick='javascript:parent.fnChangeYear(-1);fnRefresh(parent.fnBuildContent());'><IMG SRC='" + relativePath + "images/Calendar_down.gif'></a></td> " +
				" <td ALIGN=CENTER class=Weekend width=30>" + dtSelectedDate.getFullYear() +"</td><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeYear(1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Up.gif></a></td>" + 					
				" </tr></table></td></tr><tr><td>"										
	}
	
	if (intDatePickerLength == 6 )
		tmpDateStr = tmpDateStr.replace("~!$",3);
	else
		tmpDateStr = tmpDateStr.replace("~!$",4);
		
	
		
	tmpStr += tmpDateStr;
	tmpStr += "</td></tr></table>";
} catch(ex) {
	alert(ex.message);}	
	return tmpStr;
}

function fnSetValue(dtDate) 
{	
	dtSelectedDate = new Date(dtDate);	
	document.all(ctrlName).value = fnGetDateUK(new Date(dtDate)); 		
	oPopup.hide();
}

function fnGetDateList(dtDate)
{
	var dtCurrDate = new Date(dtDate);
	dtCurrDate.setDate(1);
	
	var strDates;
	var intCount
	strDates = '<table border="0" cellspacing="0" cellpadding="~!$" width="100%">'
	
	// For Table Head
	
	strDates += '<tr><td class="WeekHead">Sun</td>';
	strDates += '<td class="WeekHead">Mon</td>';
	strDates += '<td class="WeekHead">Tue</td>';
	strDates += '<td class="WeekHead">Wed</td>';
	strDates += '<td class="WeekHead">Thu</td>';
	strDates += '<td class="WeekHead">Fri</td>';
	strDates += '<td class="WeekHead">Sat</td></tr>';
	
	
	// For empty space of the month
	for (intCount=1;intCount<=dtCurrDate.getDay();intCount++)
	{
		if ( intCount == 1 )
			strDates += '<tr><td class="WeekEnd">&nbsp;</td>';
		else
			strDates += '<td class="WeekDay">&nbsp;</td>';
	}
	
	var bolContinue = true;
	intCount  = 1;
	var intEndWeekCount = 0
	intDatePickerLength = 0
	
	while (bolContinue)
	{
		var strDate;
		
		// to display only current months date
		if ( intEndWeekCount == 0 )
			strDate = '<a class="LinkButton" onclick="javascript:parent.fnSetValue(' + "'" + fnGetDate(intCount,dtCurrDate) + "'" + ');">' + intCount + '</a>' ; 
		else
			strDate = '';
			
		if ((dtCurrDate.getDate() == dtDate.getDate() ) && (dtCurrDate.getMonth() == dtDate.getMonth())) 
		{
			strDates += '<td class="HighlightColor">' + strDate + '</td>';
			
			if ( intDatePickerLength == 0 )
				intDatePickerLength++;
				
			if ( dtCurrDate.getDay() == 0 )
				intDatePickerLength++;
		}
		else
		{
			switch (dtCurrDate.getDay())
			{
				case 0:
					strDates += '<tr><td class="WeekEnd">' + strDate + '</td>';
					intDatePickerLength++;
					break;
				case 6:
					strDates += '<td class="WeekEnd">' + strDate + '</td></tr>';
					if ( intDatePickerLength == 0 )
						intDatePickerLength++;
					break;
				default:
					strDates += '<td class="WeekDay">' + strDate + '</td>';
					if ( intDatePickerLength == 0 )
						intDatePickerLength++;
			}
		}
			
		intCount++;
		
		// continue until the end of the month and end of the week
		// to be returned
		if ( (intEndWeekCount != 0) && ( dtCurrDate.getDay() == 6 ) )
			bolContinue = false;
		
		// adding date
		dtCurrDate.setDate(dtCurrDate.getDate() + 1);
		
		// checking current month and give month are same
		// if true display the month
		// else we need add white space till the end of the week
		
		if ( dtCurrDate.getMonth() != dtDate.getMonth())
			intEndWeekCount++;
		
	}
	
	strDates += '</table>' 
	
	return strDates;
	
}



function fnGetDate(intDate,dtCurrDate)
{
	var strDate;
	
	// Adding month, month starts from 0 so getMonth return 0 for jan
	// and 11 dec and so on..
	if ( parseInt(dtCurrDate.getMonth(),10) < 9 )
		strDate = '0' + new String(parseInt(dtCurrDate.getMonth(),10) + 1);
	else
		strDate = dtCurrDate.getMonth()+ 1;
	
	strDate+= '/';
	
	// date part
	if ( parseInt(intDate,10) < 10 )
		strDate += '0' + new String(parseInt(intDate,10));
	else
		strDate += intDate
		
	strDate+= '/' + dtCurrDate.getFullYear();
	
	// year part
	return strDate;
		
}

function fnGetDateUK(dtCurrDate)
{
	var strDate;
	
	// date part
	if ( parseInt(dtCurrDate.getDate(),10) < 10 )
		strDate = '0' + new String(parseInt(dtCurrDate.getDate(),10));
	else
		strDate = dtCurrDate.getDate();
	
	strDate += '/';
	
	// Adding month, month starts from 0 so getMonth return 0 for jan
	// and 11 dec and so on..
	if ( parseInt(dtCurrDate.getMonth(),10) < 9 )
		strDate += '0' + new String(parseInt(dtCurrDate.getMonth(),10) + 1);
	else
		strDate += dtCurrDate.getMonth()+ 1;

		
	strDate += '/' + dtCurrDate.getFullYear();
	
	// year part
	return strDate;
		
}

function handleDocumentClick(){
	fnEnablePromptDialog();
}
var dtSelectedDate;
var CalendarMonths;
var intDatePickerLength;
var ctrlName;
var oPopup;
var relativePath;

function fnDisablePromptDialog()
{
}

function InitializeCalendar(relativePath) {
	if (relativePath == undefined)
	{
		this.relativePath = "../";	
	}
	else
	{
		this.relativePath = relativePath;
	}
	
	this.CalendarMonths = new Array("January","February","March","April","May","June","July","August","September","October","November","December");
}

function fnShowCalendar(objControl,ctrlName) {	
    
    var intTop, intLeft;

    if (document.all(ctrlName).disabled == true)  return;
	this.ctrlName = ctrlName;		
    
	var strDate = document.all(ctrlName).value.split("/");		

    if(strDate.length >= 2)
	    dtSelectedDate = new Date(strDate[1] + "/" + strDate[0] + "/" + strDate[2]);
	else
	   dtSelectedDate = new Date();		

	if (dtSelectedDate == "NaN")
		dtSelectedDate = new Date();		

    if ( event.y  <= (document.body.clientHeight - 140) )
	    intTop = window.event.y;
    else
	    intTop = window.event.y - 140 - 20;
		
    if ( window.event.x  <= (document.body.clientWidth - 220) )
	    intLeft = window.event.x;
    else	
	    intLeft = window.event.x - 220 + 10;
    
	fnDisplayPopup(intLeft, intTop, fnBuildContent());	
	
}


function fnChangeMonth(incr) {
	var intMonth;
	intMonth = dtSelectedDate.getMonth();	
	intMonth = intMonth + incr;
	
	if (intMonth == 0){
		intMonth = 12;
		fnChangeYear(-1)
	} else if (intMonth == 13) {
		intMonth = 1;
		fnChangeYear(1);
	}
	
	var dtFindDate = new Date(dtSelectedDate.getYear(), intMonth , dtSelectedDate.getDate());	
	if ( dtFindDate.getMonth() != intMonth )
		dtSelectedDate = new Date(dtSelectedDate.getYear() , intMonth ,1);		
	else
		dtSelectedDate = new Date(dtSelectedDate.getYear(), intMonth , dtSelectedDate.getDate());	
	
}

function fnChangeYear(incr) {
	var intYear;
	intYear = dtSelectedDate.getFullYear();
	intYear = intYear + incr;	
	dtSelectedDate = new Date(intYear, dtSelectedDate.getMonth(), dtSelectedDate.getDate());	
}

function fnDisplayPopup(leftX, topY, content) {
	var tmpStr;
	oPopup = window.createPopup();
	var oPopupBody = oPopup.document.body;	
	
	tmpStr = "<HTML><HEAD></HEAD>" + 
				"<SCRIPT>function fnRefresh(content) {dvContent.innerHTML=content}</SCRIPT>" +
				"<STYLE> .WeekDay {font-size: 11px;color: #333374;font-family: Verdana,Arial,Helvetica,Sans-serif;} " + 
				" .WeekHead{font-size: 11px;color: #ffffff;font-family: Verdana,Arial,Helvetica,Sans-serif;background-color: #333374;} " + 
				" .WeekEnd{font-size: 11px;color: navy;font-family: Verdana,Arial,Helvetica,Sans-serif;background-color: #aec3dc;} " +
				" .HighlightColor{font-size: 11px;color: #000000;font-weight:bold;font-family: Verdana,Arial,Helvetica,Sans-serif;background-color: #c0e3f4;}"  +
				" .linkButton{cursor:hand;color:000080;} </STYLE>" + 
				"<BODY STYLE='border-top:0px;border-left:0px;border-right:0px;border-bottom:0px;' scroll=no topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0><div style='filter:alpha(opacity=50)' ID=dvContent>"
			
	oPopup.document.write(tmpStr + content + "</div></BODY></HTML>");
	oPopup.show(leftX, topY, 203, 158, document.body);
}

function fnBuildContent() 
{
try 
{

	var tmpStr
	
	intDatePickerLength = 0;
	
	var tmpDateStr = fnGetDateList(dtSelectedDate);
	
	if (intDatePickerLength == 6 )
	{
		tmpStr = "<table border=0 width=100% STYLE='border-top:solid 1px gray;border-left:solid 1px gray;border-right:solid 1px gray;border-bottom:solid 1px gray;' cellspacing=0 cellpadding=0><tr class=Weekend><td><table  border=0 cellpadding=3 width=100% class=Weekend><tr><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeMonth(-1);fnRefresh(parent.fnBuildContent());'><img src="+ relativePath +"images/Calendar_Down.gif></a></td> " +
				" <td width=130 ALIGN=CENTER class=Weekend>" + this.CalendarMonths[dtSelectedDate.getMonth()] +"</td><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeMonth(1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Up.gif></a></td>" + 
				" <td ALIGN=CENTER WIDTH=10><a class=linkbutton onClick='javascript:parent.fnChangeYear(-1);fnRefresh(parent.fnBuildContent());'><IMG SRC='" + relativePath + "images/Calendar_down.gif'></a></td> " +
				" <td ALIGN=CENTER class=Weekend width=30>" + dtSelectedDate.getFullYear() +"</td><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeYear(1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Up.gif></a></td>" + 					
				" </tr></table></td></tr><tr><td>"										
	}
	else
	{
		tmpStr = "<table border=0 width=100% STYLE='border-top:solid 1px gray;border-left:solid 1px gray;border-right:solid 1px gray;border-bottom:solid 1px gray;' cellspacing=0 cellpadding=0><tr class=Weekend><td><table  border=0 cellpadding=5 width=100% class=Weekend><tr><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeMonth(-1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Down.gif></a></td> " +
				" <td width=130 ALIGN=CENTER class=Weekend>" + this.CalendarMonths[dtSelectedDate.getMonth()] +"</td><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeMonth(1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Up.gif></a></td>" + 
				" <td ALIGN=CENTER WIDTH=10><a class=linkbutton onClick='javascript:parent.fnChangeYear(-1);fnRefresh(parent.fnBuildContent());'><IMG SRC='" + relativePath + "images/Calendar_down.gif'></a></td> " +
				" <td ALIGN=CENTER class=Weekend width=30>" + dtSelectedDate.getFullYear() +"</td><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeYear(1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Up.gif></a></td>" + 					
				" </tr></table></td></tr><tr><td>"										
	}
	
	if (intDatePickerLength == 6 )
		tmpDateStr = tmpDateStr.replace("~!$",3);
	else
		tmpDateStr = tmpDateStr.replace("~!$",4);
		
	
		
	tmpStr += tmpDateStr;
	tmpStr += "</td></tr></table>";
} catch(ex) {
	alert(ex.message);}	
	return tmpStr;
}

function fnSetValue(dtDate) 
{	
	dtSelectedDate = new Date(dtDate);	
	document.all(ctrlName).value = fnGetDateUK(new Date(dtDate)); 		
	oPopup.hide();
}

function fnGetDateList(dtDate)
{
	var dtCurrDate = new Date(dtDate);
	dtCurrDate.setDate(1);
	
	var strDates;
	var intCount
	strDates = '<table border="0" cellspacing="0" cellpadding="~!$" width="100%">'
	
	// For Table Head
	
	strDates += '<tr><td class="WeekHead">Sun</td>';
	strDates += '<td class="WeekHead">Mon</td>';
	strDates += '<td class="WeekHead">Tue</td>';
	strDates += '<td class="WeekHead">Wed</td>';
	strDates += '<td class="WeekHead">Thu</td>';
	strDates += '<td class="WeekHead">Fri</td>';
	strDates += '<td class="WeekHead">Sat</td></tr>';
	
	
	// For empty space of the month
	for (intCount=1;intCount<=dtCurrDate.getDay();intCount++)
	{
		if ( intCount == 1 )
			strDates += '<tr><td class="WeekEnd">&nbsp;</td>';
		else
			strDates += '<td class="WeekDay">&nbsp;</td>';
	}
	
	var bolContinue = true;
	intCount  = 1;
	var intEndWeekCount = 0
	intDatePickerLength = 0
	
	while (bolContinue)
	{
		var strDate;
		
		// to display only current months date
		if ( intEndWeekCount == 0 )
			strDate = '<a class="LinkButton" onclick="javascript:parent.fnSetValue(' + "'" + fnGetDate(intCount,dtCurrDate) + "'" + ');">' + intCount + '</a>' ; 
		else
			strDate = '';
			
		if ((dtCurrDate.getDate() == dtDate.getDate() ) && (dtCurrDate.getMonth() == dtDate.getMonth())) 
		{
			strDates += '<td class="HighlightColor">' + strDate + '</td>';
			
			if ( intDatePickerLength == 0 )
				intDatePickerLength++;
				
			if ( dtCurrDate.getDay() == 0 )
				intDatePickerLength++;
		}
		else
		{
			switch (dtCurrDate.getDay())
			{
				case 0:
					strDates += '<tr><td class="WeekEnd">' + strDate + '</td>';
					intDatePickerLength++;
					break;
				case 6:
					strDates += '<td class="WeekEnd">' + strDate + '</td></tr>';
					if ( intDatePickerLength == 0 )
						intDatePickerLength++;
					break;
				default:
					strDates += '<td class="WeekDay">' + strDate + '</td>';
					if ( intDatePickerLength == 0 )
						intDatePickerLength++;
			}
		}
			
		intCount++;
		
		// continue until the end of the month and end of the week
		// to be returned
		if ( (intEndWeekCount != 0) && ( dtCurrDate.getDay() == 6 ) )
			bolContinue = false;
		
		// adding date
		dtCurrDate.setDate(dtCurrDate.getDate() + 1);
		
		// checking current month and give month are same
		// if true display the month
		// else we need add white space till the end of the week
		
		if ( dtCurrDate.getMonth() != dtDate.getMonth())
			intEndWeekCount++;
		
	}
	
	strDates += '</table>' 
	
	return strDates;
	
}



function fnGetDate(intDate,dtCurrDate)
{
	var strDate;
	
	// Adding month, month starts from 0 so getMonth return 0 for jan
	// and 11 dec and so on..
	if ( parseInt(dtCurrDate.getMonth(),10) < 9 )
		strDate = '0' + new String(parseInt(dtCurrDate.getMonth(),10) + 1);
	else
		strDate = dtCurrDate.getMonth()+ 1;
	
	strDate+= '/';
	
	// date part
	if ( parseInt(intDate,10) < 10 )
		strDate += '0' + new String(parseInt(intDate,10));
	else
		strDate += intDate
		
	strDate+= '/' + dtCurrDate.getFullYear();
	
	// year part
	return strDate;
		
}

function fnGetDateUK(dtCurrDate)
{
	var strDate;
	
	// date part
	if ( parseInt(dtCurrDate.getDate(),10) < 10 )
		strDate = '0' + new String(parseInt(dtCurrDate.getDate(),10));
	else
		strDate = dtCurrDate.getDate();
	
	strDate += '/';
	
	// Adding month, month starts from 0 so getMonth return 0 for jan
	// and 11 dec and so on..
	if ( parseInt(dtCurrDate.getMonth(),10) < 9 )
		strDate += '0' + new String(parseInt(dtCurrDate.getMonth(),10) + 1);
	else
		strDate += dtCurrDate.getMonth()+ 1;

		
	strDate += '/' + dtCurrDate.getFullYear();
	
	// year part
	return strDate;
		
}

function handleDocumentClick(){
	fnEnablePromptDialog();
}
var dtSelectedDate;
var CalendarMonths;
var intDatePickerLength;
var ctrlName;
var oPopup;
var relativePath;

function fnDisablePromptDialog()
{
}

function InitializeCalendar(relativePath) {
	if (relativePath == undefined)
	{
		this.relativePath = "../";	
	}
	else
	{
		this.relativePath = relativePath;
	}
	
	this.CalendarMonths = new Array("January","February","March","April","May","June","July","August","September","October","November","December");
}

function fnShowCalendar(objControl,ctrlName) {	
    
    var intTop, intLeft;

    if (document.all(ctrlName).disabled == true)  return;
	this.ctrlName = ctrlName;		
    
	var strDate = document.all(ctrlName).value.split("/");		

    if(strDate.length >= 2)
	    dtSelectedDate = new Date(strDate[1] + "/" + strDate[0] + "/" + strDate[2]);
	else
	   dtSelectedDate = new Date();		

	if (dtSelectedDate == "NaN")
		dtSelectedDate = new Date();		

    if ( event.y  <= (document.body.clientHeight - 140) )
	    intTop = window.event.y;
    else
	    intTop = window.event.y - 140 - 20;
		
    if ( window.event.x  <= (document.body.clientWidth - 220) )
	    intLeft = window.event.x;
    else	
	    intLeft = window.event.x - 220 + 10;
    
	fnDisplayPopup(intLeft, intTop, fnBuildContent());	
	
}


function fnChangeMonth(incr) {
	var intMonth;
	intMonth = dtSelectedDate.getMonth();	
	intMonth = intMonth + incr;
	
	if (intMonth == 0){
		intMonth = 12;
		fnChangeYear(-1)
	} else if (intMonth == 13) {
		intMonth = 1;
		fnChangeYear(1);
	}
	
	var dtFindDate = new Date(dtSelectedDate.getYear(), intMonth , dtSelectedDate.getDate());	
	if ( dtFindDate.getMonth() != intMonth )
		dtSelectedDate = new Date(dtSelectedDate.getYear() , intMonth ,1);		
	else
		dtSelectedDate = new Date(dtSelectedDate.getYear(), intMonth , dtSelectedDate.getDate());	
	
}

function fnChangeYear(incr) {
	var intYear;
	intYear = dtSelectedDate.getFullYear();
	intYear = intYear + incr;	
	dtSelectedDate = new Date(intYear, dtSelectedDate.getMonth(), dtSelectedDate.getDate());	
}

function fnDisplayPopup(leftX, topY, content) {
	var tmpStr;
	oPopup = window.createPopup();
	var oPopupBody = oPopup.document.body;	
	
	tmpStr = "<HTML><HEAD></HEAD>" + 
				"<SCRIPT>function fnRefresh(content) {dvContent.innerHTML=content}</SCRIPT>" +
				"<STYLE> .WeekDay {font-size: 11px;color: #333374;font-family: Verdana,Arial,Helvetica,Sans-serif;} " + 
				" .WeekHead{font-size: 11px;color: #ffffff;font-family: Verdana,Arial,Helvetica,Sans-serif;background-color: #333374;} " + 
				" .WeekEnd{font-size: 11px;color: navy;font-family: Verdana,Arial,Helvetica,Sans-serif;background-color: #aec3dc;} " +
				" .HighlightColor{font-size: 11px;color: #000000;font-weight:bold;font-family: Verdana,Arial,Helvetica,Sans-serif;background-color: #c0e3f4;}"  +
				" .linkButton{cursor:hand;color:000080;} </STYLE>" + 
				"<BODY STYLE='border-top:0px;border-left:0px;border-right:0px;border-bottom:0px;' scroll=no topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0><div style='filter:alpha(opacity=50)' ID=dvContent>"
			
	oPopup.document.write(tmpStr + content + "</div></BODY></HTML>");
	oPopup.show(leftX, topY, 203, 158, document.body);
}

function fnBuildContent() 
{
try 
{

	var tmpStr
	
	intDatePickerLength = 0;
	
	var tmpDateStr = fnGetDateList(dtSelectedDate);
	
	if (intDatePickerLength == 6 )
	{
		tmpStr = "<table border=0 width=100% STYLE='border-top:solid 1px gray;border-left:solid 1px gray;border-right:solid 1px gray;border-bottom:solid 1px gray;' cellspacing=0 cellpadding=0><tr class=Weekend><td><table  border=0 cellpadding=3 width=100% class=Weekend><tr><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeMonth(-1);fnRefresh(parent.fnBuildContent());'><img src="+ relativePath +"images/Calendar_Down.gif></a></td> " +
				" <td width=130 ALIGN=CENTER class=Weekend>" + this.CalendarMonths[dtSelectedDate.getMonth()] +"</td><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeMonth(1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Up.gif></a></td>" + 
				" <td ALIGN=CENTER WIDTH=10><a class=linkbutton onClick='javascript:parent.fnChangeYear(-1);fnRefresh(parent.fnBuildContent());'><IMG SRC='" + relativePath + "images/Calendar_down.gif'></a></td> " +
				" <td ALIGN=CENTER class=Weekend width=30>" + dtSelectedDate.getFullYear() +"</td><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeYear(1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Up.gif></a></td>" + 					
				" </tr></table></td></tr><tr><td>"										
	}
	else
	{
		tmpStr = "<table border=0 width=100% STYLE='border-top:solid 1px gray;border-left:solid 1px gray;border-right:solid 1px gray;border-bottom:solid 1px gray;' cellspacing=0 cellpadding=0><tr class=Weekend><td><table  border=0 cellpadding=5 width=100% class=Weekend><tr><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeMonth(-1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Down.gif></a></td> " +
				" <td width=130 ALIGN=CENTER class=Weekend>" + this.CalendarMonths[dtSelectedDate.getMonth()] +"</td><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeMonth(1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Up.gif></a></td>" + 
				" <td ALIGN=CENTER WIDTH=10><a class=linkbutton onClick='javascript:parent.fnChangeYear(-1);fnRefresh(parent.fnBuildContent());'><IMG SRC='" + relativePath + "images/Calendar_down.gif'></a></td> " +
				" <td ALIGN=CENTER class=Weekend width=30>" + dtSelectedDate.getFullYear() +"</td><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeYear(1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Up.gif></a></td>" + 					
				" </tr></table></td></tr><tr><td>"										
	}
	
	if (intDatePickerLength == 6 )
		tmpDateStr = tmpDateStr.replace("~!$",3);
	else
		tmpDateStr = tmpDateStr.replace("~!$",4);
		
	
		
	tmpStr += tmpDateStr;
	tmpStr += "</td></tr></table>";
} catch(ex) {
	alert(ex.message);}	
	return tmpStr;
}

function fnSetValue(dtDate) 
{	
	dtSelectedDate = new Date(dtDate);	
	document.all(ctrlName).value = fnGetDateUK(new Date(dtDate)); 		
	oPopup.hide();
}

function fnGetDateList(dtDate)
{
	var dtCurrDate = new Date(dtDate);
	dtCurrDate.setDate(1);
	
	var strDates;
	var intCount
	strDates = '<table border="0" cellspacing="0" cellpadding="~!$" width="100%">'
	
	// For Table Head
	
	strDates += '<tr><td class="WeekHead">Sun</td>';
	strDates += '<td class="WeekHead">Mon</td>';
	strDates += '<td class="WeekHead">Tue</td>';
	strDates += '<td class="WeekHead">Wed</td>';
	strDates += '<td class="WeekHead">Thu</td>';
	strDates += '<td class="WeekHead">Fri</td>';
	strDates += '<td class="WeekHead">Sat</td></tr>';
	
	
	// For empty space of the month
	for (intCount=1;intCount<=dtCurrDate.getDay();intCount++)
	{
		if ( intCount == 1 )
			strDates += '<tr><td class="WeekEnd">&nbsp;</td>';
		else
			strDates += '<td class="WeekDay">&nbsp;</td>';
	}
	
	var bolContinue = true;
	intCount  = 1;
	var intEndWeekCount = 0
	intDatePickerLength = 0
	
	while (bolContinue)
	{
		var strDate;
		
		// to display only current months date
		if ( intEndWeekCount == 0 )
			strDate = '<a class="LinkButton" onclick="javascript:parent.fnSetValue(' + "'" + fnGetDate(intCount,dtCurrDate) + "'" + ');">' + intCount + '</a>' ; 
		else
			strDate = '';
			
		if ((dtCurrDate.getDate() == dtDate.getDate() ) && (dtCurrDate.getMonth() == dtDate.getMonth())) 
		{
			strDates += '<td class="HighlightColor">' + strDate + '</td>';
			
			if ( intDatePickerLength == 0 )
				intDatePickerLength++;
				
			if ( dtCurrDate.getDay() == 0 )
				intDatePickerLength++;
		}
		else
		{
			switch (dtCurrDate.getDay())
			{
				case 0:
					strDates += '<tr><td class="WeekEnd">' + strDate + '</td>';
					intDatePickerLength++;
					break;
				case 6:
					strDates += '<td class="WeekEnd">' + strDate + '</td></tr>';
					if ( intDatePickerLength == 0 )
						intDatePickerLength++;
					break;
				default:
					strDates += '<td class="WeekDay">' + strDate + '</td>';
					if ( intDatePickerLength == 0 )
						intDatePickerLength++;
			}
		}
			
		intCount++;
		
		// continue until the end of the month and end of the week
		// to be returned
		if ( (intEndWeekCount != 0) && ( dtCurrDate.getDay() == 6 ) )
			bolContinue = false;
		
		// adding date
		dtCurrDate.setDate(dtCurrDate.getDate() + 1);
		
		// checking current month and give month are same
		// if true display the month
		// else we need add white space till the end of the week
		
		if ( dtCurrDate.getMonth() != dtDate.getMonth())
			intEndWeekCount++;
		
	}
	
	strDates += '</table>' 
	
	return strDates;
	
}



function fnGetDate(intDate,dtCurrDate)
{
	var strDate;
	
	// Adding month, month starts from 0 so getMonth return 0 for jan
	// and 11 dec and so on..
	if ( parseInt(dtCurrDate.getMonth(),10) < 9 )
		strDate = '0' + new String(parseInt(dtCurrDate.getMonth(),10) + 1);
	else
		strDate = dtCurrDate.getMonth()+ 1;
	
	strDate+= '/';
	
	// date part
	if ( parseInt(intDate,10) < 10 )
		strDate += '0' + new String(parseInt(intDate,10));
	else
		strDate += intDate
		
	strDate+= '/' + dtCurrDate.getFullYear();
	
	// year part
	return strDate;
		
}

function fnGetDateUK(dtCurrDate)
{
	var strDate;
	
	// date part
	if ( parseInt(dtCurrDate.getDate(),10) < 10 )
		strDate = '0' + new String(parseInt(dtCurrDate.getDate(),10));
	else
		strDate = dtCurrDate.getDate();
	
	strDate += '/';
	
	// Adding month, month starts from 0 so getMonth return 0 for jan
	// and 11 dec and so on..
	if ( parseInt(dtCurrDate.getMonth(),10) < 9 )
		strDate += '0' + new String(parseInt(dtCurrDate.getMonth(),10) + 1);
	else
		strDate += dtCurrDate.getMonth()+ 1;

		
	strDate += '/' + dtCurrDate.getFullYear();
	
	// year part
	return strDate;
		
}

function handleDocumentClick(){
	fnEnablePromptDialog();
}
var dtSelectedDate;
var CalendarMonths;
var intDatePickerLength;
var ctrlName;
var oPopup;
var relativePath;

function fnDisablePromptDialog()
{
}

function InitializeCalendar(relativePath) {
	if (relativePath == undefined)
	{
		this.relativePath = "../";	
	}
	else
	{
		this.relativePath = relativePath;
	}
	
	this.CalendarMonths = new Array("January","February","March","April","May","June","July","August","September","October","November","December");
}

function fnShowCalendar(objControl,ctrlName) {	
    
    var intTop, intLeft;

    if (document.all(ctrlName).disabled == true)  return;
	this.ctrlName = ctrlName;		
    
	var strDate = document.all(ctrlName).value.split("/");		

    if(strDate.length >= 2)
	    dtSelectedDate = new Date(strDate[1] + "/" + strDate[0] + "/" + strDate[2]);
	else
	   dtSelectedDate = new Date();		

	if (dtSelectedDate == "NaN")
		dtSelectedDate = new Date();		

    if ( event.y  <= (document.body.clientHeight - 140) )
	    intTop = window.event.y;
    else
	    intTop = window.event.y - 140 - 20;
		
    if ( window.event.x  <= (document.body.clientWidth - 220) )
	    intLeft = window.event.x;
    else	
	    intLeft = window.event.x - 220 + 10;
    
	fnDisplayPopup(intLeft, intTop, fnBuildContent());	
	
}


function fnChangeMonth(incr) {
	var intMonth;
	intMonth = dtSelectedDate.getMonth();	
	intMonth = intMonth + incr;
	
	if (intMonth == 0){
		intMonth = 12;
		fnChangeYear(-1)
	} else if (intMonth == 13) {
		intMonth = 1;
		fnChangeYear(1);
	}
	
	var dtFindDate = new Date(dtSelectedDate.getYear(), intMonth , dtSelectedDate.getDate());	
	if ( dtFindDate.getMonth() != intMonth )
		dtSelectedDate = new Date(dtSelectedDate.getYear() , intMonth ,1);		
	else
		dtSelectedDate = new Date(dtSelectedDate.getYear(), intMonth , dtSelectedDate.getDate());	
	
}

function fnChangeYear(incr) {
	var intYear;
	intYear = dtSelectedDate.getFullYear();
	intYear = intYear + incr;	
	dtSelectedDate = new Date(intYear, dtSelectedDate.getMonth(), dtSelectedDate.getDate());	
}

function fnDisplayPopup(leftX, topY, content) {
	var tmpStr;
	oPopup = window.createPopup();
	var oPopupBody = oPopup.document.body;	
	
	tmpStr = "<HTML><HEAD></HEAD>" + 
				"<SCRIPT>function fnRefresh(content) {dvContent.innerHTML=content}</SCRIPT>" +
				"<STYLE> .WeekDay {font-size: 11px;color: #333374;font-family: Verdana,Arial,Helvetica,Sans-serif;} " + 
				" .WeekHead{font-size: 11px;color: #ffffff;font-family: Verdana,Arial,Helvetica,Sans-serif;background-color: #333374;} " + 
				" .WeekEnd{font-size: 11px;color: navy;font-family: Verdana,Arial,Helvetica,Sans-serif;background-color: #aec3dc;} " +
				" .HighlightColor{font-size: 11px;color: #000000;font-weight:bold;font-family: Verdana,Arial,Helvetica,Sans-serif;background-color: #c0e3f4;}"  +
				" .linkButton{cursor:hand;color:000080;} </STYLE>" + 
				"<BODY STYLE='border-top:0px;border-left:0px;border-right:0px;border-bottom:0px;' scroll=no topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0><div style='filter:alpha(opacity=50)' ID=dvContent>"
			
	oPopup.document.write(tmpStr + content + "</div></BODY></HTML>");
	oPopup.show(leftX, topY, 203, 158, document.body);
}

function fnBuildContent() 
{
try 
{

	var tmpStr
	
	intDatePickerLength = 0;
	
	var tmpDateStr = fnGetDateList(dtSelectedDate);
	
	if (intDatePickerLength == 6 )
	{
		tmpStr = "<table border=0 width=100% STYLE='border-top:solid 1px gray;border-left:solid 1px gray;border-right:solid 1px gray;border-bottom:solid 1px gray;' cellspacing=0 cellpadding=0><tr class=Weekend><td><table  border=0 cellpadding=3 width=100% class=Weekend><tr><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeMonth(-1);fnRefresh(parent.fnBuildContent());'><img src="+ relativePath +"images/Calendar_Down.gif></a></td> " +
				" <td width=130 ALIGN=CENTER class=Weekend>" + this.CalendarMonths[dtSelectedDate.getMonth()] +"</td><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeMonth(1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Up.gif></a></td>" + 
				" <td ALIGN=CENTER WIDTH=10><a class=linkbutton onClick='javascript:parent.fnChangeYear(-1);fnRefresh(parent.fnBuildContent());'><IMG SRC='" + relativePath + "images/Calendar_down.gif'></a></td> " +
				" <td ALIGN=CENTER class=Weekend width=30>" + dtSelectedDate.getFullYear() +"</td><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeYear(1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Up.gif></a></td>" + 					
				" </tr></table></td></tr><tr><td>"										
	}
	else
	{
		tmpStr = "<table border=0 width=100% STYLE='border-top:solid 1px gray;border-left:solid 1px gray;border-right:solid 1px gray;border-bottom:solid 1px gray;' cellspacing=0 cellpadding=0><tr class=Weekend><td><table  border=0 cellpadding=5 width=100% class=Weekend><tr><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeMonth(-1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Down.gif></a></td> " +
				" <td width=130 ALIGN=CENTER class=Weekend>" + this.CalendarMonths[dtSelectedDate.getMonth()] +"</td><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeMonth(1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Up.gif></a></td>" + 
				" <td ALIGN=CENTER WIDTH=10><a class=linkbutton onClick='javascript:parent.fnChangeYear(-1);fnRefresh(parent.fnBuildContent());'><IMG SRC='" + relativePath + "images/Calendar_down.gif'></a></td> " +
				" <td ALIGN=CENTER class=Weekend width=30>" + dtSelectedDate.getFullYear() +"</td><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeYear(1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Up.gif></a></td>" + 					
				" </tr></table></td></tr><tr><td>"										
	}
	
	if (intDatePickerLength == 6 )
		tmpDateStr = tmpDateStr.replace("~!$",3);
	else
		tmpDateStr = tmpDateStr.replace("~!$",4);
		
	
		
	tmpStr += tmpDateStr;
	tmpStr += "</td></tr></table>";
} catch(ex) {
	alert(ex.message);}	
	return tmpStr;
}

function fnSetValue(dtDate) 
{	
	dtSelectedDate = new Date(dtDate);	
	document.all(ctrlName).value = fnGetDateUK(new Date(dtDate)); 		
	oPopup.hide();
}

function fnGetDateList(dtDate)
{
	var dtCurrDate = new Date(dtDate);
	dtCurrDate.setDate(1);
	
	var strDates;
	var intCount
	strDates = '<table border="0" cellspacing="0" cellpadding="~!$" width="100%">'
	
	// For Table Head
	
	strDates += '<tr><td class="WeekHead">Sun</td>';
	strDates += '<td class="WeekHead">Mon</td>';
	strDates += '<td class="WeekHead">Tue</td>';
	strDates += '<td class="WeekHead">Wed</td>';
	strDates += '<td class="WeekHead">Thu</td>';
	strDates += '<td class="WeekHead">Fri</td>';
	strDates += '<td class="WeekHead">Sat</td></tr>';
	
	
	// For empty space of the month
	for (intCount=1;intCount<=dtCurrDate.getDay();intCount++)
	{
		if ( intCount == 1 )
			strDates += '<tr><td class="WeekEnd">&nbsp;</td>';
		else
			strDates += '<td class="WeekDay">&nbsp;</td>';
	}
	
	var bolContinue = true;
	intCount  = 1;
	var intEndWeekCount = 0
	intDatePickerLength = 0
	
	while (bolContinue)
	{
		var strDate;
		
		// to display only current months date
		if ( intEndWeekCount == 0 )
			strDate = '<a class="LinkButton" onclick="javascript:parent.fnSetValue(' + "'" + fnGetDate(intCount,dtCurrDate) + "'" + ');">' + intCount + '</a>' ; 
		else
			strDate = '';
			
		if ((dtCurrDate.getDate() == dtDate.getDate() ) && (dtCurrDate.getMonth() == dtDate.getMonth())) 
		{
			strDates += '<td class="HighlightColor">' + strDate + '</td>';
			
			if ( intDatePickerLength == 0 )
				intDatePickerLength++;
				
			if ( dtCurrDate.getDay() == 0 )
				intDatePickerLength++;
		}
		else
		{
			switch (dtCurrDate.getDay())
			{
				case 0:
					strDates += '<tr><td class="WeekEnd">' + strDate + '</td>';
					intDatePickerLength++;
					break;
				case 6:
					strDates += '<td class="WeekEnd">' + strDate + '</td></tr>';
					if ( intDatePickerLength == 0 )
						intDatePickerLength++;
					break;
				default:
					strDates += '<td class="WeekDay">' + strDate + '</td>';
					if ( intDatePickerLength == 0 )
						intDatePickerLength++;
			}
		}
			
		intCount++;
		
		// continue until the end of the month and end of the week
		// to be returned
		if ( (intEndWeekCount != 0) && ( dtCurrDate.getDay() == 6 ) )
			bolContinue = false;
		
		// adding date
		dtCurrDate.setDate(dtCurrDate.getDate() + 1);
		
		// checking current month and give month are same
		// if true display the month
		// else we need add white space till the end of the week
		
		if ( dtCurrDate.getMonth() != dtDate.getMonth())
			intEndWeekCount++;
		
	}
	
	strDates += '</table>' 
	
	return strDates;
	
}



function fnGetDate(intDate,dtCurrDate)
{
	var strDate;
	
	// Adding month, month starts from 0 so getMonth return 0 for jan
	// and 11 dec and so on..
	if ( parseInt(dtCurrDate.getMonth(),10) < 9 )
		strDate = '0' + new String(parseInt(dtCurrDate.getMonth(),10) + 1);
	else
		strDate = dtCurrDate.getMonth()+ 1;
	
	strDate+= '/';
	
	// date part
	if ( parseInt(intDate,10) < 10 )
		strDate += '0' + new String(parseInt(intDate,10));
	else
		strDate += intDate
		
	strDate+= '/' + dtCurrDate.getFullYear();
	
	// year part
	return strDate;
		
}

function fnGetDateUK(dtCurrDate)
{
	var strDate;
	
	// date part
	if ( parseInt(dtCurrDate.getDate(),10) < 10 )
		strDate = '0' + new String(parseInt(dtCurrDate.getDate(),10));
	else
		strDate = dtCurrDate.getDate();
	
	strDate += '/';
	
	// Adding month, month starts from 0 so getMonth return 0 for jan
	// and 11 dec and so on..
	if ( parseInt(dtCurrDate.getMonth(),10) < 9 )
		strDate += '0' + new String(parseInt(dtCurrDate.getMonth(),10) + 1);
	else
		strDate += dtCurrDate.getMonth()+ 1;

		
	strDate += '/' + dtCurrDate.getFullYear();
	
	// year part
	return strDate;
		
}

function handleDocumentClick(){
	fnEnablePromptDialog();
}
var dtSelectedDate;
var CalendarMonths;
var intDatePickerLength;
var ctrlName;
var oPopup;
var relativePath;

function fnDisablePromptDialog()
{
}

function InitializeCalendar(relativePath) {
	if (relativePath == undefined)
	{
		this.relativePath = "../";	
	}
	else
	{
		this.relativePath = relativePath;
	}
	
	this.CalendarMonths = new Array("January","February","March","April","May","June","July","August","September","October","November","December");
}

function fnShowCalendar(objControl,ctrlName) {	
    
    var intTop, intLeft;

    if (document.all(ctrlName).disabled == true)  return;
	this.ctrlName = ctrlName;		
    
	var strDate = document.all(ctrlName).value.split("/");		

    if(strDate.length >= 2)
	    dtSelectedDate = new Date(strDate[1] + "/" + strDate[0] + "/" + strDate[2]);
	else
	   dtSelectedDate = new Date();		

	if (dtSelectedDate == "NaN")
		dtSelectedDate = new Date();		

    if ( event.y  <= (document.body.clientHeight - 140) )
	    intTop = window.event.y;
    else
	    intTop = window.event.y - 140 - 20;
		
    if ( window.event.x  <= (document.body.clientWidth - 220) )
	    intLeft = window.event.x;
    else	
	    intLeft = window.event.x - 220 + 10;
    
	fnDisplayPopup(intLeft, intTop, fnBuildContent());	
	
}


function fnChangeMonth(incr) {
	var intMonth;
	intMonth = dtSelectedDate.getMonth();	
	intMonth = intMonth + incr;
	
	if (intMonth == 0){
		intMonth = 12;
		fnChangeYear(-1)
	} else if (intMonth == 13) {
		intMonth = 1;
		fnChangeYear(1);
	}
	
	var dtFindDate = new Date(dtSelectedDate.getYear(), intMonth , dtSelectedDate.getDate());	
	if ( dtFindDate.getMonth() != intMonth )
		dtSelectedDate = new Date(dtSelectedDate.getYear() , intMonth ,1);		
	else
		dtSelectedDate = new Date(dtSelectedDate.getYear(), intMonth , dtSelectedDate.getDate());	
	
}

function fnChangeYear(incr) {
	var intYear;
	intYear = dtSelectedDate.getFullYear();
	intYear = intYear + incr;	
	dtSelectedDate = new Date(intYear, dtSelectedDate.getMonth(), dtSelectedDate.getDate());	
}

function fnDisplayPopup(leftX, topY, content) {
	var tmpStr;
	oPopup = window.createPopup();
	var oPopupBody = oPopup.document.body;	
	
	tmpStr = "<HTML><HEAD></HEAD>" + 
				"<SCRIPT>function fnRefresh(content) {dvContent.innerHTML=content}</SCRIPT>" +
				"<STYLE> .WeekDay {font-size: 11px;color: #333374;font-family: Verdana,Arial,Helvetica,Sans-serif;} " + 
				" .WeekHead{font-size: 11px;color: #ffffff;font-family: Verdana,Arial,Helvetica,Sans-serif;background-color: #333374;} " + 
				" .WeekEnd{font-size: 11px;color: navy;font-family: Verdana,Arial,Helvetica,Sans-serif;background-color: #aec3dc;} " +
				" .HighlightColor{font-size: 11px;color: #000000;font-weight:bold;font-family: Verdana,Arial,Helvetica,Sans-serif;background-color: #c0e3f4;}"  +
				" .linkButton{cursor:hand;color:000080;} </STYLE>" + 
				"<BODY STYLE='border-top:0px;border-left:0px;border-right:0px;border-bottom:0px;' scroll=no topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0><div style='filter:alpha(opacity=50)' ID=dvContent>"
			
	oPopup.document.write(tmpStr + content + "</div></BODY></HTML>");
	oPopup.show(leftX, topY, 203, 158, document.body);
}


function fnBuildContent() 
{
try 
{

	var tmpStr
	
	intDatePickerLength = 0;
	
	var tmpDateStr = fnGetDateList(dtSelectedDate);
	
	if (intDatePickerLength == 6 )
	{
		tmpStr = "<table border=0 width=100% STYLE='border-top:solid 1px gray;border-left:solid 1px gray;border-right:solid 1px gray;border-bottom:solid 1px gray;' cellspacing=0 cellpadding=0><tr class=Weekend><td><table  border=0 cellpadding=3 width=100% class=Weekend><tr><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeMonth(-1);fnRefresh(parent.fnBuildContent());'><img src="+ relativePath +"images/Calendar_Down.gif></a></td> " +
				" <td width=130 ALIGN=CENTER class=Weekend>" + this.CalendarMonths[dtSelectedDate.getMonth()] +"</td><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeMonth(1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Up.gif></a></td>" + 
				" <td ALIGN=CENTER WIDTH=10><a class=linkbutton onClick='javascript:parent.fnChangeYear(-1);fnRefresh(parent.fnBuildContent());'><IMG SRC='" + relativePath + "images/Calendar_down.gif'></a></td> " +
				" <td ALIGN=CENTER class=Weekend width=30>" + dtSelectedDate.getFullYear() +"</td><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeYear(1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Up.gif></a></td>" + 					
				" </tr></table></td></tr><tr><td>"										
	}
	else
	{
		tmpStr = "<table border=0 width=100% STYLE='border-top:solid 1px gray;border-left:solid 1px gray;border-right:solid 1px gray;border-bottom:solid 1px gray;' cellspacing=0 cellpadding=0><tr class=Weekend><td><table  border=0 cellpadding=5 width=100% class=Weekend><tr><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeMonth(-1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Down.gif></a></td> " +
				" <td width=130 ALIGN=CENTER class=Weekend>" + this.CalendarMonths[dtSelectedDate.getMonth()] +"</td><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeMonth(1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Up.gif></a></td>" + 
				" <td ALIGN=CENTER WIDTH=10><a class=linkbutton onClick='javascript:parent.fnChangeYear(-1);fnRefresh(parent.fnBuildContent());'><IMG SRC='" + relativePath + "images/Calendar_down.gif'></a></td> " +
				" <td ALIGN=CENTER class=Weekend width=30>" + dtSelectedDate.getFullYear() +"</td><td WIDTH=10 ALIGN=CENTER><a class=linkbutton onClick='javascript:parent.fnChangeYear(1);fnRefresh(parent.fnBuildContent());'><img src=" + relativePath + "images/Calendar_Up.gif></a></td>" + 					
				" </tr></table></td></tr><tr><td>"										
	}
	
	if (intDatePickerLength == 6 )
		tmpDateStr = tmpDateStr.replace("~!$",3);
	else
		tmpDateStr = tmpDateStr.replace("~!$",4);
		
	
		
	tmpStr += tmpDateStr;
	tmpStr += "</td></tr></table>";
} catch(ex) {
	alert(ex.message);}	
	return tmpStr;
}

function fnSetValue(dtDate) 
{	
	dtSelectedDate = new Date(dtDate);	
	document.all(ctrlName).value = fnGetDateUK(new Date(dtDate)); 		
	oPopup.hide();
}

function fnGetDateList(dtDate)
{
	var dtCurrDate = new Date(dtDate);
	dtCurrDate.setDate(1);
	
	var strDates;
	var intCount
	strDates = '<table border="0" cellspacing="0" cellpadding="~!$" width="100%">'
	
	// For Table Head
	
	strDates += '<tr><td class="WeekHead">Sun</td>';
	strDates += '<td class="WeekHead">Mon</td>';
	strDates += '<td class="WeekHead">Tue</td>';
	strDates += '<td class="WeekHead">Wed</td>';
	strDates += '<td class="WeekHead">Thu</td>';
	strDates += '<td class="WeekHead">Fri</td>';
	strDates += '<td class="WeekHead">Sat</td></tr>';
	
	
	// For empty space of the month
	for (intCount=1;intCount<=dtCurrDate.getDay();intCount++)
	{
		if ( intCount == 1 )
			strDates += '<tr><td class="WeekEnd">&nbsp;</td>';
		else
			strDates += '<td class="WeekDay">&nbsp;</td>';
	}
	
	var bolContinue = true;
	intCount  = 1;
	var intEndWeekCount = 0
	intDatePickerLength = 0
	
	while (bolContinue)
	{
		var strDate;
		
		// to display only current months date
		if ( intEndWeekCount == 0 )
			strDate = '<a class="LinkButton" onclick="javascript:parent.fnSetValue(' + "'" + fnGetDate(intCount,dtCurrDate) + "'" + ');">' + intCount + '</a>' ; 
		else
			strDate = '';
			
		if ((dtCurrDate.getDate() == dtDate.getDate() ) && (dtCurrDate.getMonth() == dtDate.getMonth())) 
		{
			strDates += '<td class="HighlightColor">' + strDate + '</td>';
			
			if ( intDatePickerLength == 0 )
				intDatePickerLength++;
				
			if ( dtCurrDate.getDay() == 0 )
				intDatePickerLength++;
		}
		else
		{
			switch (dtCurrDate.getDay())
			{
				case 0:
					strDates += '<tr><td class="WeekEnd">' + strDate + '</td>';
					intDatePickerLength++;
					break;
				case 6:
					strDates += '<td class="WeekEnd">' + strDate + '</td></tr>';
					if ( intDatePickerLength == 0 )
						intDatePickerLength++;
					break;
				default:
					strDates += '<td class="WeekDay">' + strDate + '</td>';
					if ( intDatePickerLength == 0 )
						intDatePickerLength++;
			}
		}
			
		intCount++;
		
		// continue until the end of the month and end of the week
		// to be returned
		if ( (intEndWeekCount != 0) && ( dtCurrDate.getDay() == 6 ) )
			bolContinue = false;
		
		// adding date
		dtCurrDate.setDate(dtCurrDate.getDate() + 1);
		
		// checking current month and give month are same
		// if true display the month
		// else we need add white space till the end of the week
		
		if ( dtCurrDate.getMonth() != dtDate.getMonth())
			intEndWeekCount++;
		
	}
	
	strDates += '</table>' 
	
	return strDates;
	
}



function fnGetDate(intDate,dtCurrDate)
{
	var strDate;
	
	// Adding month, month starts from 0 so getMonth return 0 for jan
	// and 11 dec and so on..
	if ( parseInt(dtCurrDate.getMonth(),10) < 9 )
		strDate = '0' + new String(parseInt(dtCurrDate.getMonth(),10) + 1);
	else
		strDate = dtCurrDate.getMonth()+ 1;
	
	strDate+= '/';
	
	// date part
	if ( parseInt(intDate,10) < 10 )
		strDate += '0' + new String(parseInt(intDate,10));
	else
		strDate += intDate
		
	strDate+= '/' + dtCurrDate.getFullYear();
	
	// year part
	return strDate;
		
}

function fnGetDateUK(dtCurrDate)
{
	var strDate;
	
	// date part
	if ( parseInt(dtCurrDate.getDate(),10) < 10 )
		strDate = '0' + new String(parseInt(dtCurrDate.getDate(),10));
	else
		strDate = dtCurrDate.getDate();
	
	strDate += '/';
	
	// Adding month, month starts from 0 so getMonth return 0 for jan
	// and 11 dec and so on..
	if ( parseInt(dtCurrDate.getMonth(),10) < 9 )
		strDate += '0' + new String(parseInt(dtCurrDate.getMonth(),10) + 1);
	else
		strDate += dtCurrDate.getMonth()+ 1;

		
	strDate += '/' + dtCurrDate.getFullYear();
	
	// year part
	return strDate;
		
}

function handleDocumentClick(){
	fnEnablePromptDialog();
}