<%@ page language="C#" autoeventwireup="true" inherits="EMDemo_EventListHelp, App_Web_eventlisthelp.aspx.cdcab7d2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>EventList Help Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
            <!--------------------------------Content Panel-------------------------------------->
            <table style="margin: 10px 0px 10px 0px; width: 80%;" align="center">
                <tr>
                    <td style="font-family: Tahoma; font-size: 14pt;color:MediumBlue;" align="center">
                        <span style="text-decoration: underline">
                       <strong>Eventlist Help</strong> </span>
                    </td>
                </tr>
                <tr>
                    <td style="font-size: 11pt; ;color:#7E452A ;font-family: Tahoma;">
                        <strong>
                    Internal List</strong>
                    </td>
                </tr>
                <tr>
                    <td style="font-family: Tahoma;
                        font-size: 10pt;text-indent:40px;">
                       
                            All Internal events are listed in the “Internal list” page. You can filter internal events based on “Event Type”.
                           
                       
                     
                    </td>
                </tr>
                <tr>
                    <td>
                        <table border="1">
                            <tr>
                                <td style="width: 415px"
                                    >
                                    <asp:Image ID="imginternal" runat="server" ImageUrl="~/Images/internal.jpg"
                                        />
                                </td>
                                <td style="text-align: left; font-family: Tahoma; font-size: 10pt;
                                    ">
                                    <asp:Label ID="lblInternal_desc" runat="server" Width="400px">All upcoming internal events are displayed in the data grid. By default the grid will display the internal events for all event type. By clicking the edit icon you can view the “Internal Event Details”.
                                    </asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left;  font-family: Tahoma; font-size: 10pt;
                                    width: 415px;">
                                    &nbsp;<img src="Images/searchrecords.JPG" /></td>
                                <td style="text-align: left; font-family: Tahoma; font-size: 10pt;
                                    width: 450px;">
                                    <asp:Label ID="lblInternalfilter_desc" runat="server" Width="400px">Choose an event type and events corresponding to the chosen event type are displayed.
                                    </asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="font-size: 11pt;color:#7E452A ;margin-top:20px; font-family: Tahoma;
                                    text-align: left">
                                    <strong>
                                    External List</strong></td>
                            </tr>
                            <tr>
                                <td colspan="2" style="font-size: 10pt;  font-family: Tahoma;
                                    text-align: left;text-indent:40px;">
                                    All external events are listed in the “External list” page. You can filter external events based on “Event Type”.
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left; font-family: Tahoma; font-size: 10pt;
                                    width: 415px; height: 107px;">
                                    <asp:Image ID="imgexternal" runat="server" ImageUrl="~/Images/eventlist.jpg" />
                                </td>
                                <td style="text-align: left;  font-family: Tahoma; font-size: 10pt;
                                    width: 450px; height: 107px;">
                                    <asp:Label ID="lblDateUnsure" runat="server" Width="400px">All upcoming external events are displayed in the data grid By default the grid will display the internal events for all event type. By clicking the edit icon you can view the “External Event Details”.</asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left;  font-family: Tahoma; font-size: 10pt;
                                    width: 415px; height: 37px;">
                                    &nbsp;<img src="Images/searchrecords.JPG" /></td>
                                <td style="text-align: left; font-family: Tahoma; font-size: 10pt;
                                    width: 450px; height: 37px;">
                                    <asp:Label ID="lblState" runat="server" Width="400px">Choose an event type and events corresponding to the chosen event type are displayed.
                                    </asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="font-size: 11pt;color:#7E452A ; font-family: Tahoma;
                                    text-align: left;">
                                    <strong>
                                    Key Location</strong></td>
                            </tr>
                            <tr>
                                <td colspan="2" style="font-size: 10pt;  font-family: Tahoma;
                                    text-align: left;text-indent:40px;">Events are listed based on the Location where event is scheduled to happen. We can search events based on Location.
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left; font-family: Tahoma; font-size: 10pt;
                                    width: 415px;">
                                    <asp:Image ID="imgkeylocation" runat="server" ImageUrl="~/Images/eventlist.jpg" />
                                </td>
                                <td style="text-align: left; font-family: Tahoma; font-size: 10pt;
                                    width: 450px;">
                                    <asp:Label ID="lblCountry" runat="server" Width="400px">All upcoming events are displayed in the data grid. By clicking the edit icon you can view the “Event Details”.</asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left;  font-family: Tahoma; font-size: 10pt;
                                    width: 415px;">
                                    &nbsp;<img src="Images/country.jpg" /></td>
                                <td style="text-align: left; font-family: Tahoma; font-size: 10pt;
                                    width: 450px;">
                                    <asp:Label ID="lblThisEvent" runat="server" >Choose a location and event for that location is displayed.</asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="font-size: 11pt;color:#7E452A ;  font-family: Tahoma;
                                    text-align: left">
                                    <strong>
                                    Archived Events</strong></td>
                            </tr>
                            <tr>
                                <td colspan="2" style="font-size: 10pt; font-family: Tahoma;
                                    text-align: left;text-indent:40px;">
All archived events are listed in the “archived events” page. You can filter archived events based on “Event Type”.
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left; font-family: Tahoma; font-size: 10pt;
                                    width: 415px;">
                                    <asp:Image ID="imgarchives" runat="server" ImageUrl="~/Images/archive.jpg"
                                         />
                                </td>
                                <td style="text-align: left; font-family: Tahoma; font-size: 10pt;
                                    width: 450px;">
                                    <asp:Label ID="lblNovelty" runat="server" Width="400px" >All completed events are displayed in the data grid By default the grid will display the “Archived Events” for all event type. By clicking the edit icon you can view the “Event Details”.</asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left; font-family: Tahoma; font-size: 10pt;
                                    width: 415px;">
                                    &nbsp;<img src="Images/searchrecords.JPG" /></td>
                                <td style="text-align: left;font-family: Tahoma; font-size: 10pt;
                                    ">
                                    <asp:Label ID="lblItemDescription" runat="server" Width="400px" >Choose an event type and events corresponding to the chosen event type are displayed.

                                    </asp:Label>
                                </td>
                            </tr>
                        
                              
                         
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    
    
    
    </form>
   
</body>
</html>
