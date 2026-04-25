<%@ page language="C#" masterpagefile="Event1.master" autoeventwireup="true" inherits="CredentialsAdvancedMetrics, App_Web_credentialsadvancedmetrics.aspx.cdcab7d2" title="Credential Advanced Metrics" %>
<%@ Register Src="Controls/PieEvents/Pie.ascx" TagName="Pie" TagPrefix="uc1" %>

<%@ Register TagPrefix="Graph7" TagName="CardBarGraph" Src="Controls/Barall.ascx" %>
<%@ Register TagPrefix="Graph8" TagName="Horizontalbar" Src="Controls/Horizontal/Horizontalbar.ascx" %>
<%@ Register TagPrefix="Graph6" TagName="CardGraph" Src="Controls/publicAwareness.ascx" %>
<%@ Register TagPrefix="Graph1" TagName="CardGraph" Src="Controls/Line.ascx" %>
<%@ Register TagPrefix="Graph2" TagName="CardBarGraph" Src="Controls/Bar.ascx" %>
<%@ Register TagPrefix="Graph3" TagName="CardPieGraph" Src="Controls/Pie.ascx" %>
<%@ Register TagPrefix="Graph4" TagName="Horizontalbar" Src="Controls/Horizontalbar.ascx" %>
<%@ Register TagPrefix="Graph5" TagName="ItemNovelty" Src="Controls/ItemNovelty.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Main" Runat="Server">

    <script language="javascript" type="text/javascript">
<!--

function TABLE1_onclick() {

}

// -->
    </script>

    <script language="javascript" type="text/javascript">function check_uncheck(Val)
{
  var ValChecked = Val.checked;
  var ValId = Val.id;
  var frm = document.forms[0];
  // Loop through all elements
  for (i = 0; i < frm.length; i++)
  {
    // Look for Header Template's Checkbox
    //As we have not other control other than checkbox we just check following statement
    if (this != null)
    {
      if (ValId.indexOf('selectyear') !=  - 1)
      {
        // Check if main checkbox is checked,
        // then select or deselect datagrid checkboxes
        if (ValChecked)
          frm.elements[i].checked = true;
        else
          frm.elements[i].checked = false;
      }
      else if (ValId.indexOf('lbYear') !=  - 1)
      {
        // Check if any of the checkboxes are not checked, and then uncheck top select all checkbox
        if (frm.elements[i].checked == true)
          frm.elements[1].checked = false;
//           selectyear.checked=false;
      }
    } // if
  } // for
} // function</script>

    <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td align="center" style="padding-left: 0px;">
                <table width="90%" cellpadding="0" cellspacing="0" border="0" align="center">
                    <tr>
                        <td valign="top" align="center" style="font: 22px geogia,arial; color: red; padding: 10px 0px 10px 0px;">
                            METRICS FILTER
                        </td>
                        <td valign="top" align="center" style="font: 22px geogia,arial; color: red; padding: 10px 0px 10px 0px;">
                            METRICS GRAPH
                        </td>
                    </tr>
               
                    <tr>
                        <td valign="top" style="padding-right: 20px;">
                            <table border="0" cellpadding="0" cellspacing="0" width="90%">
                                <tr>
                                    <td valign="top" style="padding-bottom:20px;padding-top:0px;">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border: 1px solid #BBC7E5;
                                            background: #DEE6F0;" id="TABLE1" onclick="return TABLE1_onclick()">
                                            <tr>
                                                <td nowrap style="padding: 20px 0px 0px 19px; width: 125px;" valign="top">
                                                    <asp:Label ID="lblgraph" Text="Choose Graph Type" runat="server" Style="float: left;
                                                        font: bold 12px arial; color: #525251" CssClass="Label"></asp:Label>
                                                </td>
                                                <td style="padding: 15px 0px 0px 0px;" valign="top">
                                                    <span style="float: left;">
                                                        <asp:DropDownList   ID="drop" CssClass="credentialmetricsdrop" runat="server" Height="25px" Style="float: left;"
                                                            AutoPostBack="true" OnSelectedIndexChanged="dropgraphtype_SelectedIndexChanged">
                                                            <asp:ListItem Value="1">Event Duration</asp:ListItem>
                                                            <asp:ListItem Value="2">Event Innovation</asp:ListItem>
                                                            <asp:ListItem Value="3">Event Summary by Type</asp:ListItem>
                                                            <asp:ListItem Value="4">Event Goal Type</asp:ListItem>
                                                            <asp:ListItem Value="5">Event Type</asp:ListItem>
                                                            <asp:ListItem Value="6">Event Goal</asp:ListItem>
                                                        </asp:DropDownList></span> <span style="float: right;">
                                                            <asp:RequiredFieldValidator ID="graphtype" runat="server" Width="160px" Height="14px"
                                                                Style="float: left; margin-left: 12px;" ControlToValidate="drop" CssClass="valid"
                                                                ErrorMessage=" Select Graph Type" InitialValue="---Select---" ValidationGroup="1"></asp:RequiredFieldValidator></span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 125px; padding: 5px 0px 0px 10px;" valign="top">
                                                    <asp:Label ID="lbleventtype" Text="Choose Event Type" runat="server" Style="float: left; margin-left: 12px;;
                                                        font: bold 12px arial; color: #525251" Visible="false">
                                                    </asp:Label>
                                                </td>
                                                <td style="" valign="top">
                                                    <span style="float: left;padding:5px 0px 15px 0px;">
                                                        <asp:DropDownList ID="dropeventtype"  CssClass="credentialmetricsdrop" runat="server" Height="25px"  Width="170px" Style="float: left;
                                                           " Visible="false" OnSelectedIndexChanged="dropeventtype_SelectedIndexChanged"
                                                            AutoPostBack="true">
                                                            <asp:ListItem Value="0"></asp:ListItem>
                                                        </asp:DropDownList></span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td valign="top" colspan="2">
                                                    <asp:Label ID="lblmsg" runat="server" ForeColor="red" Visible="true" CssClass="valid" />
                                                </td>
                                            </tr>
                                            
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top" align="center" style="font: 22px geogia,arial; color: red; padding: 0px 0px 13px 0px;">
                                        T/MC Event Year
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top" style="padding-bottom:5px;padding-top:5px;">
                                        <table border="0" cellpadding="0" cellspacing="0" width="400px" style="border: 1px solid #BBC7E5;margin:0px 0px 0px 0px;height:140px;
                                            background: #DEE6F0;" id="TABLE2" onclick="return TABLE1_onclick()">
                                
                                           
                                            <tr>
                                                <td colspan="2" align="left" valign="top" style="padding-top: 10px; font: 11px arial;
                                                    padding-left: 10px;">
                                                    <asp:CheckBoxList ID="lbYear" runat="server" DataTextField="EventOccuredDate" RepeatDirection="Horizontal"
                                                        RepeatColumns="5" Width="400" OnClick="return check_uncheck (this );">
                                                    </asp:CheckBoxList>
                                                    <%--   OnSelectedIndexChanged="lbYear_SelectedIndexChanged"--%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="height: 20px; float: right; font: 11px arial; float: left;
                                                    padding-left: 12px;">
                                                    <%--  <asp:CheckBox ID="selectyear" runat="server" Text="Choose All" AutoPostBack="true" OnCheckedChanged="selectyear_CheckedChanged" style="float:right;margin:5px 8px 0px 0px;"  />--%>
                                                    <asp:CheckBox ID="selectyear" Text="Choose All" OnClick="return check_uncheck (this );"
                                                        runat="server" Style="float: left; margin: -1px 8px 0px 0px;" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="280" colspan="2" valign="bottom" align="center" style="height: 24px; padding-bottom: 10px;padding:0px 10px 5px 180px;">
                                                    <asp:Button ID="submit" Text="Submit" runat="server" OnClick="submit_Click1" ValidationGroup="1"
                                                        CssClass="finishbutton"/>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                 </tr>
                              </table>
                        </td>
                        <td valign="top" style="width: 40%; padding: 0px 8px 0px 23px;">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <%-- <tr>
                                    <td valign="top" colspan="2" style="font:22px geogia,arial;color:red;padding:10px 0px 20px 0px;">
                                        OHATS METRICS
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td>
                                        <Graph3:CardPieGraph ID="CardPieGraph1" runat="server" />
                                        <Graph8:Horizontalbar ID="Horizontalbar2" runat="server" />
                                        <Graph6:CardGraph ID="CardGraph2" runat="server" />
                                        <Graph7:CardBarGraph ID="CardBarGraph2" runat="server" />
                                        <%-- <uc1:Innovation ID="Innovation1" runat="server"></uc1:Innovation>--%>
                                        <Graph5:ItemNovelty ID="ItemNovelty1" runat="server" />
                                        <Graph2:CardBarGraph ID="CardBarGraph1" runat="server"></Graph2:CardBarGraph>
                                        <Graph1:CardGraph ID="CardGraph1" runat="server"></Graph1:CardGraph>
                                        <Graph4:Horizontalbar ID="Horizontalbar1" runat="server" />
                                    </td>
                                </tr>
                            </table>
                            <uc1:Pie ID="Pie1" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" colspan="2"  >
                            <table border="0" cellpadding="1"  cellspacing="0" 
                                style="float:left; width: 50%;
                                 clear: left;position: relative;margin:-84px 0px 0px 6px;display: inline; left:-5px; top: 0px;">
                                <tr>
                                    <td valign="top" align="center"  style="font: 22px geogia,arial; width: 400px; color: red; padding: 7px 0px 19px 5px;">
                                       
                                        METRICS DESCRIPTION
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top" style="width:400px">
                                        <asp:Panel ID="pietxt" runat="server" Visible="false" Style="float: left; clear: left;
                                            width: 400px;">
                                            <div style="float: left; clear: left; width: 400px; text-align: justify; font: 12px arial;
                                                border: 1px solid #BBC7E5; background: #DEE6F0; padding: 10px 5px 10px 5px;"
                                                id="DIV2" align="left" onclick="return DIV1_onclick()">
                                                <span><b><u>Intended Duration of Events Facilitated by TMC</u></b><br />
                                                    <br />
                                                    Intended Duration of Events graph represents the Event Period<br />
                                                    <br />
                                                    1. Events that occur only once are represented by the region “onetime”.<br />
                                                    <br />
                                                    2. Events that occur more than once but have a definite end date are represented
                                                    by the region “More than once”.
                                                    <br />
                                                    <br />
                                                    3. Events that are ongoing and do not have an end date are represented by the region
                                                    “Ongoing” </span>
                                            </div>
                                        </asp:Panel>
                                        <table  style=" float:left;width:50%;clear:left;position:relative;margin:-2px 0px 0px 0px;display: inline; top:0px" >
                            
                            <tr><td>
                                        <asp:Panel ID="innovation" runat="server" Visible="false">
                                            <div style="float: left; clear: left; width: 400px; text-align: justify; font: 12px arial;
                                                border: 1px solid #BBC7E5; background: #DEE6F0; padding: 10px 5px 10px 5px;"
                                                id="DIV1" align="left" onclick="return DIV1_onclick()">
                                                <span><b><u>Innovation among Events facilitated by T/MC Graph represents the Item Innovation</u></b><br />
                                                    <br />
                                                    1.Events that are new are represented as "New"
                                                    <br />
                                                    <br />
                                                    2. Events that are Existing are represented as "Existing"
                                                    <br />
                                                    <br />
                                                    3. Events that are Modified from the earlier work are represented as "Modified"
                                                    <br />
                                                    <br />
                                                    4.All other events are represented as "Other" </span>
                                            </div>
                                        </asp:Panel>
                                          </td></tr></table>
                                             <table  style=" float:left;width:104%; clear:left;position:relative;margin:-1px 0px 0px 0px;display: inline; top:0px; left: 0px;" >
                            
                            <tr><td>
                                        <asp:Panel ID="bargraph" runat="server" Visible="false">
                                            <div style="float: left; clear: left; width: 400px;text-align: justify; font: 12px arial;
                                                border: 1px solid #BBC7E5; background: #DEE6F0; padding: 1px 5px 10px 5px;"
                                                id="DIV3" align="left" onclick="return DIV1_onclick()">
                                                <span><b><u>Tutor Mentor Events</u></b><br />
                                                    <br />
                                                    Different Event Types are shown against the total number of events that happened
                                                    <br />
                                                    <br />
                                                    <br />
                                                </span>
                                            </div>
                                        </asp:Panel></td>
                                        </tr>
                                        </table>
                                           <table  style=" float:left;width:50%;clear:left;position:relative;margin:-2px 0px 0px 0px;display: inline; top:0px" >
                            
                            <tr><td>
                                        <asp:Panel ID="Events" runat="server" Visible="false">
                                            <div style="float: left; clear: left; width: 400px; text-align: justify; font: 12px arial;
                                                border: 1px solid #BBC7E5; background: #DEE6F0; padding: 10px 5px 10px 5px;"
                                                id="DIV4" align="left" onclick="return DIV1_onclick()">
                                                <span><b><u>Innovation among Events Facilitated by T/MC graph represents the Item Innovation</u></b><br />
                                                    <br />
                                                    1. Events that are new are represented as “New”<br />
                                                    <br />
                                                    2. Events that are Existing are represented as “existing”<br />
                                                    <br />
                                                    3. Events that are modified from the earlier work are represented as “Modified”<br />
                                                    <br />
                                                    4. All other events are represented as “Other” </span>
                                            </div>
                                        </asp:Panel></td>
                                        </tr>
                                        </table>
                                           <table  style=" float:left;width:50%;clear:left;position:relative;margin:-10px 0px 17px 0px;display: inline; top:0px" >
                            
                            <tr><td>
                                        <asp:Panel ID="horizontal" runat="server" Visible="false">
                                            <div style="float: left; clear: left; width: 400px; text-align: justify; font: 12px arial;
                                                border: 1px solid #BBC7E5; background: #DEE6F0; padding: 0px 5px 10px 5px;"
                                                id="DIV5" align="left" onclick="return DIV1_onclick()">
                                                <span><b><u>Event Goal Types</u> </b>
                                                    <br />
                                                    <br />
                                                    Different event goals are shown against the total event goals. </span>
                                            </div>
                                        </asp:Panel></td>
                                        </tr>
                                        </table>
                                           <table  style=" float:left;width:50%;clear:left;position:relative;margin:-30px 0px 0px 0px;display: inline; top:0px" >
                            
                            <tr><td>
                                        <asp:Panel ID="line" runat="server" Visible="false">
                                            <div style="float: left; clear: left; width: 400px; text-align: justify; font: 12px arial;
                                                border: 1px solid #BBC7E5; background: #DEE6F0; padding: 10px 5px 10px 5px;"
                                                id="DIV6" align="left" onclick="return DIV1_onclick()">
                                                <span><b><u>Event Goal Types </u></b>
                                                    <br />
                                                    <br />
                                                    Different event goals are shown against the total event goals.></span>
                                                <%--The total Community  System change events are represented over a period of year. --%>
                                            </div>
                                        </asp:Panel></td>
                                        </tr>
                                        </table>
                                           <table  style=" float:left;width:50%;clear:left;position:relative;margin:-20px 0px 0px 0px;display: inline; top:0px" >
                            
                            <tr><td>
                                        <asp:Panel ID="linetype" runat="server" Visible="false">
                                            <div style="font: 12px arial; float: left; clear: left; width: 400px; text-align: justify;border: 1px solid #BBC7E5; background: #DEE6F0;padding: 10px 5px 10px 5px;"
                                                id="DIV7" align="left" onclick="return DIV1_onclick()">
                                                <span><b><u>Event Summary </u></b>
                                                    <br />
                                                    <br />
                                                    The total community system change events are represented over a period of year.
                                                </span>
                                            </div>
                                        </asp:Panel></td>
                                        </tr>
                                        </table>
                                           <table  style=" float:left;width:50%;clear:left;position:relative;margin:-20px 0px 0px 0px;display: inline;top:0px" >
                            
                            <tr><td>
                                        <asp:Panel ID="mediatxt" runat="server" Visible="false">
                                            <div style="float: left; clear: left; width: 400px; text-align: justify; font: 12px arial;
                                                border: 1px solid #BBC7E5; background: #DEE6F0; padding: 10px 5px 10px 5px;"
                                                id="DIV9" align="left">
                                                <span><b><u>Event Goal </u></b>
                                                    <br />
                                                    <br />
                                                    The total media events are represented over a period of year. </span>
                                            </div>
                                        </asp:Panel></td>
                                        </tr>
                                        </table>
                                           <table  style=" float:left;width:50%;clear:left;position:relative;margin:-20px 0px 0px 0px;display: inline; top:0px" >
                            
                            <tr><td>
                                        <asp:Panel ID="caction" runat="server" Visible="false">
                                            <div style="float: left; clear: left; width: 400px; text-align: justify; font: 12px arial;
                                                border: 1px solid #BBC7E5; background: #DEE6F0; padding: 10px 5px 10px 5px;"
                                                id="DIV10" align="left" onclick="return DIV10_onclick()">
                                                <span><b><u>Event Summary </u></b>
                                                    <br />
                                                    <br />
                                                    The total community action events are represented over a period of year. </span>
                                            </div>
                                        </asp:Panel></td>
                                        </tr>
                                        </table>
                                           <table  style=" float:left;width:50%;clear:left;position:relative;margin:-20px 0px 0px 0px;display: inline; top:0px" >
                            
                            <tr><td>
                                        <asp:Panel ID="Resourcetxt" runat="server" Visible="false">
                                            <div style="float: left; clear: left; width: 400px; text-align: justify; font: 12px arial;
                                                border: 1px solid #BBC7E5; background: #DEE6F0; padding: 10px 5px 10px 5px;"
                                                id="DIV11" align="left" onclick="return DIV1_onclick()">
                                                <span><b><u>Event Summary </u></b>
                                                    <br />
                                                    <br />
                                                    The total resource events are represented over a period of year. </span>
                                            </div>
                                        </asp:Panel></td>
                                        </tr>
                                        </table>
                                           <table  style=" float:left;width:50%;clear:left;position:relative;margin:-20px 0px 0px 0px;display: inline; top:0px" >
                            
                            <tr><td>
                                        <asp:Panel ID="planning" runat="server" Visible="false">
                                            <div style="float: left; clear: left; width: 400px; text-align: justify; font: 12px arial;
                                                border: 1px solid #BBC7E5; background: #DEE6F0; padding: 10px 5px 10px 5px;"
                                                id="DIV12" align="left" onclick="return DIV1_onclick()">
                                                <span><b><u>Event Summary </u></b>
                                                    <br />
                                                    <br />
                                                    The total planning development events are represented over a period of year. </span>
                                            </div>
                                        </asp:Panel></td>
                                        </tr>
                                        </table>
                                           <table  style=" float:left;width:50%;clear:left;position:relative;margin:-20px 0px 0px 0px;display: inline; top:0px" >
                            
                            <tr><td>
                                        <asp:Panel ID="critical" runat="server" Visible="false">
                                            <div style="float: left; clear: left; width: 400px; text-align: justify; font: 12px arial;
                                                border: 1px solid #BBC7E5; background: #DEE6F0; padding: 10px 5px 10px 5px;"
                                                id="DIV13" align="left" onclick="return DIV1_onclick()">
                                                <span><b><u>Event Summary </u></b>
                                                    <br />
                                                    <br />
                                                    The total critical events are represented over a period of year. </span>
                                            </div>
                                        </asp:Panel></td>
                                        </tr>
                                        </table>
                                           <table  style=" float:left;width:50%;clear:left;position:relative;margin:-20px 0px 0px 0px;display: inline; top:0px" >
                            
                            <tr><td>
                                        <asp:Panel ID="others" runat="server" Visible="false">
                                            <div style="float: left; clear: left; width: 400px; text-align: justify; font: 12px arial;
                                                border: 1px solid #BBC7E5; background: #DEE6F0; padding: 10px 5px 10px 5px;"
                                                id="DIV14" align="left" onclick="return DIV1_onclick()">
                                                <span><b><u>Event Summary </u></b>
                                                    <br />
                                                    <br />
                                                    The total other events are represented over a period of year. </span>
                                            </div>
                                        </asp:Panel></td>
                                        </tr>
                                        </table>
                                           <table  style=" float:left;width:50%;clear:left;position:relative;margin:-20px 0px 0px 0px;display: inline; top:0px" >
                            
                            <tr><td>
                                        <asp:Panel ID="Service" runat="server" Visible="false">
                                            <div style="float: left; clear: left; width: 400px; text-align: justify; font: 12px arial;
                                                border: 1px solid #BBC7E5; background: #DEE6F0; padding: 10px 5px 10px 5px;"
                                                id="DIV15" align="left" onclick="return DIV1_onclick()">
                                                <span><b><u>Event Summary </u></b>
                                                    <br />
                                                    <br />
                                                    The total service events are represented over a period of year. </span>
                                            </div>
                                        </asp:Panel></td>
                                        </tr>
                                        </table>
                                           <table  style=" float:left;width:50%;clear:left;position:relative;margin:-20px 0px 0px 0px;display: inline; top:0px" >
                            
                            <tr><td>
                                        <asp:Panel ID="pawarenesstxt" runat="server" Visible="false">
                                            <div style="float: left; clear: left; width: 400px; text-align: justify; font: 12px arial;
                                                border: 1px solid #BBC7E5; background: #DEE6F0; padding: 10px 5px 10px 5px;"
                                                id="DIV16" align="left" onclick="return DIV1_onclick()">
                                                <span><b><u>Event Goal </u></b>
                                                    <br />
                                                    <br />
                                                    The total public awareness goals are represented over a period of year. </span>
                                            </div>
                                        </asp:Panel></td>
                                        </tr>
                                        </table>
                                           <table  style=" float:left;width:50%;clear:left;position:relative;margin:-25px 0px 0px 0px;display: inline; top:0px" >
                            
                            <tr><td>
                                        <asp:Panel ID="Researchtxt" runat="server" Visible="false">
                                            <div style="font: 12px arial; float: left; width: 400px; clear: left; text-align: justify;
                                                border: 1px solid #BBC7E5; background: #DEE6F0; padding: 10px 5px 10px 5px;"
                                                id="DIV17" align="left" onclick="return DIV1_onclick()">
                                                <span><b><u>Event Goal </u></b>
                                                    <br />
                                                    <br />
                                                    The total research goals are represented over a period of year. </span>
                                            </div>
                                        </asp:Panel></td>
                                        </tr>
                                        </table>
                                           <table  style=" float:left;width:50%;clear:left;position:relative;margin:-25px 0px 0px 0px;display: inline; top:0px" >
                            
                            <tr><td>
                                        <asp:Panel ID="Technologytxt" runat="server" Visible="false">
                                            <div style="float: left; clear: left; width: 400px; text-align: justify; font: 12px arial;
                                                border: 1px solid #BBC7E5; background: #DEE6F0; padding: 10px 5px 10px 5px;"
                                                id="DIV18" align="left" onclick="return DIV1_onclick()">
                                                <span><b><u>Event Goal </u></b>
                                                    <br />
                                                    <br />
                                                    The total technology goals are represented over a period of year. </span>
                                            </div>
                                        </asp:Panel></td>
                                        </tr>
                                        </table>
                                           <table  style=" float:left;width:50%;clear:left;position:relative;margin:-6px 0px 0px 0px;display: inline; top:0px" >
                            
                            <tr><td>
                                        <asp:Panel ID="Rbuildingtxt" runat="server" Visible="false">
                                            <div style="float: left; clear: left; width: 400px; text-align: justify; font: 12px arial;
                                                border: 1px solid #BBC7E5; background: #DEE6F0; padding: 10px 5px 10px 5px;"
                                                id="DIV19" align="left" onclick="return DIV1_onclick()">
                                                <span><b><u>Event Goal </u></b>
                                                    <br />
                                                    <br />
                                                    The total resource building goals are represented over a period of year. </span>
                                            </div>
                                        </asp:Panel></td>
                                        </tr>
                                        </table>
                                           <table  style=" float:left;width:50%;clear:left;position:relative;margin:-25px 0px 0px 0px;display: inline; top:0px" >
                            
                            <tr><td>
                                        <asp:Panel ID="Eventstxt" runat="server" Visible="false">
                                            <div style="float: left; clear: left; width: 400px; text-align: justify; font: 12px arial;
                                                border: 1px solid #BBC7E5; background: #DEE6F0; padding: 10px 5px 10px 5px;"
                                                id="DIV20" align="left" onclick="return DIV1_onclick()">
                                                <span><b><u>Event Goal </u></b>
                                                    <br />
                                                    <br />
                                                    The total event goals are represented over a period of year. </span>
                                            </div>
                                        </asp:Panel></td>
                                        </tr>
                                        </table>
                                           <table  style=" float:left;width:50%;clear:left;position:relative;margin:-25px 0px 0px 0px;display: inline; top:0px" >
                            
                            <tr><td>
                                        <asp:Panel ID="Trainingtxt" runat="server" Visible="false">
                                            <div style="float: left; clear: left; width: 400px; text-align: justify; font: 12px arial;
                                                border: 1px solid #BBC7E5; background: #DEE6F0; padding: 10px 5px 10px 5px;"
                                                id="DIV21" align="left" onclick="return DIV1_onclick()">
                                                <span><b><u>Event Goal </u></b>
                                                    <br />
                                                    <br />
                                                    The total training goals are represented over a period of year. </span>
                                            </div>
                                        </asp:Panel>
                                        </td>
                                        </tr>
                                        </table>
                                           <table  style=" float:left;width:50%;clear:left;position:relative;margin:-25px 0px 0px 0px;display: inline; top:0px" >
                            
                            <tr><td>
                                        <asp:Panel ID="othergoaltxt" runat="server" Visible="false">
                                            <div style="float: left; clear: left; width: 400px; text-align: justify; font: 12px arial;
                                                border: 1px solid #BBC7E5; background: #DEE6F0; padding: 10px 5px 10px 5px;"
                                                id="DIV22" align="left" onclick="return DIV1_onclick()">
                                                <span><b><u>Event Goal </u></b>
                                                    <br />
                                                    <br />
                                                    The total other goals are represented over a period of year. </span>
                                            </div>
                                        </asp:Panel>
                                        </td>
                                        </tr>
                                        </table>
                                           <table  style=" float:left;width:50%;clear:left;position:relative;margin:-29px 0px 0px 0px;display: inline; top:0px" >
                            
                            <tr><td>
                                        <asp:Panel ID="bargraphall" runat="server" Visible="false">
                                            <div style="float: left; clear: left; width: 395px; text-align: justify; font: 12px arial;
                                                border: 1px solid #BBC7E5; background: #DEE6F0; padding: 0px 5px 10px 5px;"
                                                id="DIV8" align="left" onclick="return DIV1_onclick()">
                                                <span><b><u>Tutor Mentor Events </u></b>
                                                    <br />
                                                    <br />
                                                    Different Event Types are shown against the total number of events that happened.
                                                </span>
                                            </div>
                                        </asp:Panel>
                                        </td>
                                        </tr>
                                        </table>
                                           <table  style=" float:left;width:50%;clear:left;position:relative;margin:-30px 0px 20px 0px;display: inline; top:0px" >
                            
                            <tr><td>
                                        <asp:Panel ID="horizontalall" runat="server" Visible="false">
                                            <div style="float: left; clear: left; width: 390px; text-align: justify; font: 12px arial;
                                                border: 1px solid #BBC7E5; background: #DEE6F0; padding: 10px 5px 10px 5px;"
                                                id="DIV23" align="left" onclick="return DIV1_onclick()">
                                                <span><b><u>Event Goal Types </u></b>
                                                    <br />
                                                    <br />
                                                    Different event goals are shown against the total event goals. </span>
                                            </div>
                                        </asp:Panel>
                                        </td>
                                        </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>

