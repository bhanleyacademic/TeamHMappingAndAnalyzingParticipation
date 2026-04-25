<%@ page language="C#" masterpagefile="Event1.master" enableeventvalidation="false" autoeventwireup="true" inherits="Update, App_Web_update.aspx.cdcab7d2" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Flyout2" Assembly="obout_Flyout2_NET" %>
<%@ Register Src="Controls/DatePicker.ascx" TagName="DatePicker" TagPrefix="uc1" %>
<asp:Content ID="cp1" ContentPlaceHolderID="Main" runat="server">

<script language="javascript" type="text/javascript">

    var EventoccuredCalendar = '<%= this.EventoccuredCalendar.ClientID%>';
    var DateUnsureCalendar = '<%= this.DateUnsureCalendar.ClientID%>';
    function ImageButtonEventClick() {
        $find("<%=DateUnsureCalendar.ClientID%>").hide();
        return false;
    }

    function ImageButtonUnsurredClick() {
        $find("<%=EventoccuredCalendar.ClientID%>").hide();
        return false;
 }

   </script>





    <div style="text-align: left; margin-top: 25px;">
        <center>
            <span style="font: 22px arial; color: red;">Events,Results & Accomplishments: Event
                Update Form </span>
        </center>
        <asp:Panel ID="pnlMessage" runat="server" Visible="false">
            <div style="margin: 20px 0px 0px 20px; text-align: center;">
                <asp:Label ID="label" runat="server" Font-Size="22px"></asp:Label>
            </div>
        </asp:Panel>
        <asp:Panel ID="pnlupdate" runat="server">
            <table bgcolor="#e7f1fe" style="border: 1px solid blue; margin: 10px 25px 0px 32px;"
                cellpadding="0" cellspacing="0" align="center" width="80%">
                <tr>
                    <td>
                        <table style="margin-left: 10px; margin-right: 10px;">
                            <tr>
                                <td colspan="3">
                                    <asp:Label ID="lblError" runat="server" Visible="False" ForeColor="Red" Height="29px"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" width="80%">
                                    <table border="0" cellpadding="0" cellspacing="0" style="border-bottom: 1px dotted black;"
                                        width="80%">
                                        <tr>
                                            <td valign="top" style="border-right: 1px dotted black; padding: 5px 5px 0px 0px;
                                                width: 280px">
                                                <table style="margin-right: 0px" width="280px">
                                                    <tr>
                                                        <td valign="top" style="padding-bottom: 5px;">
                                                            <asp:Label ID="lblEventId" runat="server" Text="Event ID" CssClass="Label"></asp:Label>
                                                        </td>
                                                        <td valign="top" style="padding: 0px 50px 0px 0px">
                                                            <asp:Label ID="txteventid" runat="server" Font-Size="10pt"> </asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top" nowrap style="padding-bottom: 5px;">
                                                            <asp:Label ID="lblCreatedDate" runat="server" Text="Event Created On" CssClass="Label"></asp:Label>
                                                        </td>
                                                        <td valign="top" nowrap>
                                                            <asp:Label ID="txtCreatedDate" runat="server" Font-Size="10pt"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top" nowrap style="padding-bottom: 12px;">
                                                            <asp:Label ID="lblRecorderName" runat="server" Text="Recorder Name" CssClass="Label"></asp:Label>
                                                        </td>
                                                        <td valign="top">
                                                            <asp:HyperLink ID="lnkRecorderNew" runat="server" Text="Addnew" ForeColor="RoyalBlue"
                                                                Style="float: left; position: relative; margin: -15px 0px 0px 90px;"></asp:HyperLink>
                                                            <asp:DropDownList ID="ddlRecorderName" CssClass="dropdown" runat="server" DataTextField="RecorderName"
                                                                DataValueField="Userid" Width="150px">
                                                            </asp:DropDownList>
                                                            <br />
                                                            <asp:RequiredFieldValidator Style="float: left; clear: left;" ID="rvalRecorder" runat="server"
                                                                ControlToValidate="ddlRecorderName" ErrorMessage="Choose Recorder Name" InitialValue="Select"
                                                                ValidationGroup="1" Font-Size="X-Small"></asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top" nowrap>
                                                            <asp:Label ID="lblEventOccuredDate" runat="server" Text="Event Occured Date" CssClass="Label"
                                                                ToolTip="On which date the Event had occured"></asp:Label>
                                                        </td>
                                                        <td valign="top" nowrap>
                                                            <asp:TextBox ID="txtEventOccuredDate" runat="server" Width="80px" Height="14px" Style="float: left;
                                                                outline: none;" ToolTip="On which date the Event had occured"></asp:TextBox>
                                                           <img id="ImageButtonEvent" runat="server" src="~/Images/clr.jpg" alt="Event Occured Date" style="cursor:pointer" onclick ="javascript:return ImageButtonEventClick();"  />
                                                              
                                                               
                                                                    <cc1:CalendarExtender ID="EventoccuredCalendar" runat="server" CssClass="cal_Theme1" TargetControlID="txtEventOccuredDate"
                                                                        PopupButtonID="ImageButtonEvent">
                                                                    </cc1:CalendarExtender>
                                                               
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top" nowrap style="padding-top: 5px; padding-bottom: 5px;">
                                                            <asp:Label ID="lblDateUnsurred" runat="server" Text="Date Unsure" CssClass="Label"
                                                                ToolTip="Unsured date of the event"></asp:Label>
                                                        </td>
                                                        <td valign="top" nowrap>
                                                            <asp:TextBox ID="txtDateUnsurred" Width="80px" runat="server" Height="14px" Style="float: left;
                                                                outline: none;" ToolTip="Unsure date of the event"></asp:TextBox>
                                                             <img id="ImageButtonUnsurred" runat="server" src="~/Images/clr.jpg" alt="Unsure Date" style="cursor:pointer" onclick ="javascript:return ImageButtonUnsurredClick();"  />
                                                                
                                                                
                                                                    <cc1:CalendarExtender ID="DateUnsureCalendar" CssClass="cal_Theme1" runat="server" TargetControlID="txtDateUnsurred"
                                                                        PopupButtonID="ImageButtonUnsurred">
                                                                    </cc1:CalendarExtender>
                                                                
                                                            <asp:Label ID="lbldateError" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td valign="top" style="padding: 0px 5px 0px 5px; border-right: 1px dotted black;
                                                width: 250px">
                                                <table width="250px">
                                                    <tr>
                                                        <td valign="top" nowrap style="padding-bottom: 5px;">
                                                            <asp:Label ID="lblPrivateitem" runat="server" Width="50px" Text="Private Item" CssClass="Label"></asp:Label>
                                                        </td>
                                                        <td valign="top" nowrap style="">
                                                            <asp:CheckBox ID="cbPrivateItem" runat="server" Style="float: left; margin: -5px 0px 0px 3px;
                                                                position: relative;"></asp:CheckBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top" nowrap>
                                                            <asp:Label ID="lblSource" runat="server" Text="Source" Width="50px" CssClass="Label"> </asp:Label>
                                                        </td>
                                                        <td valign="top" nowrap>
                                                            <asp:RadioButtonList ID="rblsource" Style="float: left; position: relative; margin-top: -7px;"
                                                                runat="server" Font-Size="10px" RepeatDirection="Horizontal">
                                                                <asp:ListItem Text="External" Value="0"></asp:ListItem>
                                                                <asp:ListItem Text="Internal" Value="1"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top">
                                                            <asp:Label ID="lblThisEvent" runat="server" Text="This Event" Width="50px" CssClass="Label"
                                                                ToolTip="The event belongs to what type"></asp:Label>
                                                        </td>
                                                        <td valign="top">
                                                            <asp:RadioButtonList ID="rblEventStatus" Style="float: left; position: relative;
                                                                margin-top: -7px;" runat="server" CssClass="" Font-Size="10px">
                                                                <asp:ListItem Text="Occured on only one day" Value="0"></asp:ListItem>
                                                                <asp:ListItem Text="Will occur multiple days but has an end date(Please list the future dates,if known in the item description)"
                                                                    Value="1"></asp:ListItem>
                                                                <asp:ListItem Text="It is not designed to end" Value="2"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td valign="top" nowrap width="30%" style="padding-left: 5px; width: 200px">
                                                <table width="200px">
                                                    <tr>
                                                        <td valign="top" nowrap>
                                                            <asp:Label ID="lblState" runat="server" Text="State" CssClass="Label"></asp:Label>
                                                        </td>
                                                        <td valign="top" nowrap>
                                                            <asp:DropDownList ID="ddlstate" runat="server" CssClass="dropdown" DataTextField="State">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top" nowrap>
                                                            <asp:Label ID="lblCountry" runat="server" Text="Country" CssClass="Label"></asp:Label>
                                                        </td>
                                                        <td valign="top" nowrap style="padding-bottom: 3px;">
                                                            <asp:TextBox ID="txtCountry" runat="server" ToolTip="Enter the country" Style="outline: none;"></asp:TextBox>
                                                            <asp:CustomValidator ID="customcountry" runat="server" ValidationGroup="1" ControlToValidate="txtCountry"
                                                                ClientValidationFunction="isAlphanumeric" ErrorMessage="Enter a valid country name"
                                                                Font-Size="XX-Small" Style="clear: left;"></asp:CustomValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top" nowrap>
                                                            <asp:Label ID="lblPeopleAttend" runat="server" Text="People Attended" CssClass="Label"></asp:Label>
                                                        </td>
                                                        <td valign="top" nowrap style="padding-bottom: 3px;">
                                                            <asp:TextBox ID="txtPeopleAttended" runat="server" MaxLength="5" Style="outline: none;"
                                                                ToolTip="Enter no of peoples attend the event"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top" nowrap>
                                                            <asp:Label ID="lblItemNovelity" runat="server" Text="Item Novelity" CssClass="Label"
                                                                ToolTip="Drop any one of the following"></asp:Label>
                                                        </td>
                                                        <td valign="top" nowrap style="padding-bottom: 3px;">
                                                            <asp:DropDownList ID="ddlItemNovelity" runat="server" CssClass="dropdown">
                                                                <asp:ListItem Text="Select"></asp:ListItem>
                                                                <asp:ListItem Text="Modified from Earlier work"></asp:ListItem>
                                                                <asp:ListItem Text="New - Not done before"></asp:ListItem>
                                                                <asp:ListItem Text="Pre Existing"></asp:ListItem>
                                                                <asp:ListItem Text="Other"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top" nowrap>
                                                            <asp:Label ID="lblItemType" runat="server" Text="Item Type" CssClass="Label" ToolTip="Drop any one of the following"></asp:Label>
                                                        </td>
                                                        <td valign="top" style="padding-bottom: 5px;">
                                                            <asp:DropDownList ID="ddlItemType" runat="server" CssClass="dropdown">
                                                                <asp:ListItem Text="Select"></asp:ListItem>
                                                                <asp:ListItem Text="Blog"></asp:ListItem>
                                                                <asp:ListItem Text="Discussion Group (or) List Communication"></asp:ListItem>
                                                                <asp:ListItem Text="Email communication"></asp:ListItem>
                                                                <asp:ListItem Text="Event after the meeting"></asp:ListItem>
                                                                <asp:ListItem Text="Meeting by phone"></asp:ListItem>
                                                                <asp:ListItem Text="Meeting in person"></asp:ListItem>
                                                                <asp:ListItem Text="Personal Reflection"></asp:ListItem>
                                                                <asp:ListItem Text="Other"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top" nowrap>
                                                            <asp:Label ID="lblRecuring" runat="server" Text="Recuring" Width="90" CssClass="Label"
                                                                Visible="false" ToolTip="Drop any one of the following"></asp:Label>
                                                        </td>
                                                        <td valign="top" nowrap style="padding-bottom: 5px;">
                                                            <asp:DropDownList ID="ddlRecuring" CssClass="dropdown" runat="server" Width="120px"
                                                                Visible="false">
                                                                <asp:ListItem Text="Select"></asp:ListItem>
                                                                <asp:ListItem Text="Yes"></asp:ListItem>
                                                                <asp:ListItem Text="No"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">
                                    <table border="0" style="border-bottom: 1px dotted black; width: 900px;">
                                        <tr>
                                            <td valign="top" style="width: 690px">
                                                <table>
                                                    <tr>
                                                        <td valign="top" style="width: 207px">
                                                            <table>
                                                                <tr>
                                                                    <td style="width: 192px">
                                                                        <asp:Label ID="lblItemDescription" runat="server" Text="Item Description" CssClass="Heading"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 192px">
                                                                        <asp:TextBox ID="txtItemDescription" runat="server" Height="85px" Width="275px" CssClass="MultiLineTextbox"
                                                                            TextMode="MultiLine"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td style="width: 196px">
                                                            <table>
                                                                <tr>
                                                                    <td style="width: 204px; height: 16px;">
                                                                        <asp:Label ID="lblItemMeaning" runat="server" Text="Item Meaning" CssClass="Heading"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 204px">
                                                                        <asp:TextBox ID="txtItemMeaning" runat="server" Height="85px" Width="275px" CssClass="MultiLineTextbox"
                                                                            TextMode="MultiLine"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td style="width: 271px">
                                                            <table>
                                                                <tr>
                                                                    <td style="width: 253px">
                                                                        <asp:Label ID="lblItemResult" runat="server" Text="Item Result" CssClass="Heading"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 253px">
                                                                        <asp:TextBox ID="txtItemResult" runat="server" Height="85px" Width="275px" TextMode="MultiLine"
                                                                            CssClass="MultiLineTextbox"></asp:TextBox>
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
                            <tr>
                                <td colspan="3">
                                    <table border="0" style="border-bottom: 1px dotted black; margin-left: 4px; width: 900px;">
                                        <tr>
                                            <td style="width: 30px">
                                            </td>
                                            <td style="width: 185px">
                                                <table>
                                                    <tr>
                                                        <td style="width: 183px">
                                                            <asp:Label ID="lblkeyactors" runat="server" Text="Key Actors Name" CssClass="Heading"></asp:Label><asp:HyperLink
                                                                ID="linkAddNew" runat="server" Text="Addnew" ForeColor="RoyalBlue"></asp:HyperLink>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 183px">
                                                            <asp:ListBox ID="ltbKeyActorsName" runat="server" Height="110px" Width="190px" DataTextField="ActorName"
                                                                DataValueField="Userid" Style="outline: none;"></asp:ListBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td style="width: 21px">
                                                <table>
                                                    <tr>
                                                        <td style="width: 19px">
                                                            <asp:LinkButton ID="linkbutton1" runat="server" Text=">" ToolTip="Click here to move the selected actor"
                                                                OnClick="passselectedactor_Click"></asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 19px; height: 21px">
                                                            <asp:LinkButton ID="linkbutton2" runat="server" Text=">>" ToolTip="Click here to move all the actor"
                                                                OnClick="passallactor_Click"></asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 19px">
                                                            <asp:LinkButton ID="linkbutton3" runat="server" Text="<" ToolTip="Click here to remove the selected actor"
                                                                OnClick="deleteselectedactor_Click"></asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 19px">
                                                            <asp:LinkButton ID="linkbutton4" runat="server" Text="<<" ToolTip="Click here to remove all"
                                                                OnClick="deleteallactor_Click"></asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td style="width: 188px">
                                                <table>
                                                    <tr>
                                                        <td style="width: 183px">
                                                            <asp:Label ID="lblSelectedActors" runat="server" Text="Selected Actors" CssClass="Heading"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 183px">
                                                            <asp:ListBox ID="ltbSelectedActors" runat="server" Height="110px" Width="190px" DataTextField="AddedByname"
                                                                DataValueField="userid" Style="outline: none;"></asp:ListBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td style="width: 232px;">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblKeyOrganisation" runat="server" Text="Key Organisation" CssClass="Heading"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:ListBox ID="ltbKeyOrganization" runat="server" Height="110px" Width="190px"
                                                                DataTextField="Organization" DataValueField="userid" Style="outline: none;">
                                                            </asp:ListBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="140px">
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <table border="0" <%--style="border-bottom:1px dotted black;margin-left:4px;"--%>>
                                        <tr>
                                            <td style="width: 30px">
                                            </td>
                                            <td style="width: 220px; height: 225px; border-right: 1px dotted black">
                                                <table cellpadding="3px" cellspacing="3px">
                                                    <tr>
                                                        <td style="height: 21px; padding-left: 2px;">
                                                            <asp:Label ID="lblEventGoals" runat="server" Text="Event Goals" CssClass="Heading"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:CheckBox ID="cbPublicAwareness" runat="server" Text="Public Awareness" CssClass="Label" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:CheckBox ID="cbTechnology" runat="server" Text="Technology" CssClass="Label" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:CheckBox ID="cbResearch" runat="server" Text="Research" CssClass="Label" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:CheckBox ID="cbTraining" runat="server" Text="Training" CssClass="Label" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:CheckBox ID="cbResourceDevelopment" runat="server" Text="Resource Development"
                                                                CssClass="Label" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:CheckBox ID="cbStrategicEvents" runat="server" Text="Strategic Events" CssClass="Label" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="padding-top: 12px;">
                                                            <asp:Label ID="lblEventGoalsOthers" runat="server" Text="OTHERS" CssClass="Heading"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox ID="txtEventGoalsOthers" runat="server" Height="50px" Width="180px"
                                                                TextMode="MultiLine" CssClass="MultiLineTextbox"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td style="width: 230px; height: 225px; border-right: 1px dotted black; padding-left: 2px;
                                                padding: 0px 10px 0px 10px;">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lbleventCommunication" runat="server" Text="Event Type" CssClass="Heading"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 230px">
                                                            <asp:CheckBox ID="cbCommunitySystemChange" runat="server" Text="Community System Change"
                                                                Width="200" CssClass="Label" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 185px">
                                                            <asp:CheckBox ID="cbMedia" runat="server" Text="Media" CssClass="Label" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 185px">
                                                            <asp:CheckBox ID="cbCommunityAction" runat="server" Text="Community Action" CssClass="Label" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 185px">
                                                            <asp:CheckBox ID="cbResources" runat="server" Text="Resources" CssClass="Label" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 185px">
                                                            <asp:CheckBox ID="cbServices" runat="server" Text="Services" CssClass="Label" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 220px">
                                                            <asp:CheckBox ID="cbPlaningAndDevelopment" runat="server" Text="Planning and Development"
                                                                Width="180" CssClass="Label" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 185px">
                                                            <asp:CheckBox ID="cbCriticalEvent" runat="server" Text="Critical Event" CssClass="Label" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 224px; padding-top: 6px;">
                                                            <asp:Label ID="lblEventTypeOthers" runat="server" Text="OTHERS" CssClass="Heading"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 224px">
                                                            <asp:TextBox ID="txtEventTypeOthers" runat="server" Height="50px" Width="180px" TextMode="MultiLine"
                                                                CssClass="MultiLineTextbox"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td style="width: 220px; height: 225px; padding-left: 2px; padding-left: 10px;">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblEventType" runat="server" Text="Event Communication" CssClass="Heading"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 185px">
                                                            <asp:CheckBox ID="cbReport" runat="server" Text="Report" CssClass="Label"></asp:CheckBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 185px">
                                                            <asp:CheckBox ID="cbNews" runat="server" Text="News" CssClass="Label"></asp:CheckBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 185px">
                                                            <asp:CheckBox ID="cbSpecial" runat="server" Text="Special" CssClass="Label" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 185px">
                                                            <asp:CheckBox ID="cbBestPractice" runat="server" Text="Best Practice" CssClass="Label" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 185px">
                                                            <asp:CheckBox ID="cbEmail" runat="server" Text="Email" CssClass="Label"></asp:CheckBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 185px">
                                                            <asp:Label ID="lblEmaillist" runat="server" Text="Email List" CssClass="Label" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 185px">
                                                            <asp:TextBox ID="txtEmaillist" runat="server" TextMode="MultiLine" CssClass="MultiLineTextbox" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 185px; padding-top: 6px;">
                                                            <asp:Label ID="lblEventCommunicationOthers" runat="server" Text="OTHERS" CssClass="Heading"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 185px">
                                                            <asp:TextBox ID="txtEventCommunicationOthers" runat="server" TextMode="MultiLine"
                                                                Height="50px" Width="180px" CssClass="MultiLineTextbox"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="100">
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr align="right">
                                <td colspan="4">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:Button ID="btnUpdate" runat="server" CssClass="finishbutton" Text="Update" ValidationGroup="1"
                                                    OnClick="btnUpdate_Click" TabIndex="44" />
                                                <asp:Button ID="btnCancel" CssClass="finishbutton" runat="server" Text="Cancel" OnClick="btnCancel_Click"
                                                    TabIndex="46" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <obout:Flyout ID="Flyout2" runat="server" AttachTo="lnkRecorderNew" CloseEvent="NONE"
                zIndex="107">
                <table style="border-top-style: double; border-right-style: double; border-left-style: double;
                    border-bottom-style: double" bgcolor="Gainsboro" height="200px" width="275px">
                    <tbody>
                        <tr>
                            <td style="padding-left: 16px; margin-top: 7px;" class="label" align="left">
                                First Name
                            </td>
                            <td>
                                <asp:TextBox ID="txtRecorderFName" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                                    ValidationGroup="3" ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter First Name"
                                    ControlToValidate="txtRecorderFName"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 16px;" class="label" align="left">
                                Last Name
                            </td>
                            <td>
                                <asp:TextBox ID="txtRecorderLName" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ValidationGroup="3" ID="RequiredFieldValidator5" runat="server"
                                    ErrorMessage="Enter Last Name" ControlToValidate="txtRecorderLName"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 16px;" class="label" align="left">
                                Organization
                            </td>
                            <td>
                                <asp:TextBox ID="txtRecorderOrganization" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ValidationGroup="3" ID="RequiredFieldValidator6" runat="server"
                                    ErrorMessage="Enter Organization" ControlToValidate="txtRecorderOrganization"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 16px;" class="label" align="left">
                                Phone No
                            </td>
                            <td>
                                <asp:TextBox ID="txtRecorderPhoneno" MaxLength="10" runat="server"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtRecorderPhoneno"
                                    ValidationGroup="3" ValidationExpression="\d{10}"></asp:RegularExpressionValidator><asp:CustomValidator
                                        ID="CustomValidator2" runat="server" ValidationGroup="3" ControlToValidate="txtRecorderPhoneno"
                                        ClientValidationFunction="isValidNumeric" Width="113px" ErrorMessage=" Please Give a Valid Input"></asp:CustomValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 16px;" class="label" align="left">
                                Email
                            </td>
                            <td>
                                <asp:TextBox ID="txtRecorderEmail" runat="server"></asp:TextBox><asp:RegularExpressionValidator
                                    ID="RegularExpressionValidator4" runat="server" ValidationExpression="^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*\.(\w{2}|(com|net|org|edu|gov|biz|info))$"
                                    ErrorMessage="give a valid e-mail address" ControlToValidate="txtRecorderEmail"
                                    Display="Dynamic" ValidationGroup="3" SetFocusOnError="True"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center" colspan="4" valign="middle">
                                <asp:Button ID="butRecorderSave" runat="server" Text="Save" ValidationGroup="3" OnClick="butRecorderSave_Click">
                                </asp:Button>
                                <asp:Button ID="butRecorderCancel" runat="server" Text="Cancel" OnClick="butRecorderCancel_Click">
                                </asp:Button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </obout:Flyout>
            <obout:Flyout ID="flyKeyActors" runat="server" AttachTo="linkAddNew" CloseEvent="ONFOCUSOUT"
                zIndex="107">
                <table style="border-top-style: double; border-right-style: double; border-left-style: double;
                    border-bottom-style: double" bgcolor="Gainsboro" height="200px" width="275px">
                    <tbody>
                        <tr>
                            <td style="padding-left: 16px; margin-top: 7px;" class="label" align="left">
                                First Name
                            </td>
                            <td>
                                <asp:TextBox ID="txtKeyActorsFirstame" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                                    ValidationGroup="2" ID="rfvKeyActorsFirstame" runat="server" ErrorMessage="Enter First Name"
                                    ControlToValidate="txtKeyActorsFirstame"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 16px;" class="label" align="left">
                                Last Name
                            </td>
                            <td>
                                <asp:TextBox ID="txtKeyActorsLastName" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ValidationGroup="2" ID="rfvKeyActorsLastName" runat="server"
                                    ErrorMessage="Enter Last Name" ControlToValidate="txtKeyActorsLastName"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 16px;" class="label" align="left">
                                Organization
                            </td>
                            <td>
                                <asp:TextBox ID="txtKeyActorsOrganization" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ValidationGroup="2" ID="rfvKeyActorsOrganization" runat="server"
                                    ErrorMessage="Enter Organization" ControlToValidate="txtKeyActorsOrganization"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 16px;" class="label" align="left">
                                Phone No
                            </td>
                            <td>
                                <asp:TextBox ID="txtKeyActorsPhoneNo" MaxLength="10" runat="server"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="rfvKeyActorsPhoneNo" runat="server" ControlToValidate="txtKeyActorsPhoneNo"
                                    ValidationGroup="2" ValidationExpression="\d{10}"></asp:RegularExpressionValidator><asp:CustomValidator
                                        ID="CustomValidator1" runat="server" ValidationGroup="2" ControlToValidate="txtKeyActorsPhoneNo"
                                        ClientValidationFunction="isValidNumeric" Width="113px" ErrorMessage=" Please Give a Valid Input"></asp:CustomValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 16px;" class="label" align="left">
                                Email
                            </td>
                            <td>
                                <asp:TextBox ID="txtKeyActorsEmail" runat="server"></asp:TextBox><asp:RegularExpressionValidator
                                    ID="rfvKeyActorsEmail" runat="server" ValidationExpression="^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*\.(\w{2}|(com|net|org|edu|gov|biz|info))$"
                                    ErrorMessage="give a valid e-mail address" ControlToValidate="txtKeyActorsEmail"
                                    Display="Dynamic" ValidationGroup="2" SetFocusOnError="True"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center" colspan="4" valign="middle">
                                <asp:Button ID="butKeyActorsSave" runat="server" Text="Save" ValidationGroup="2"
                                    OnClick="butKeyActorsSave_Click"></asp:Button>
                                <asp:Button ID="butKeyActorsCancel" runat="server" Text="Cancel" OnClick="butKeyActorsCancel_Click">
                                </asp:Button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </obout:Flyout>
            <obout:Flyout runat="server" ID="Flyout3" AttachTo="cbPublicAwareness" Align="MIDDLE"
                CloseEvent="ONMOUSEOUT" CloseTime="20" DelayTime="20" FadingEffect="True" FlyingEffect="NONE"
                NoneEffect="False" OnClientClose="" OnClientInit="" OnClientOpen="" Opacity="100"
                OpenEvent="ONMOUSEOVER" OpenTime="250" Position="MIDDLE_RIGHT" RelativeLeft="0"
                RelativeTop="0" Resolution="10" SlidingEffect="NONE" SlidingRange="10" zIndex="0">
                <table>
                    <tr>
                        <td style="background-image: url(Images/aaa.jpg)">
                            <fieldset style="width: 200px; font-size: small">
                                Related to media (radio,TV,Print,cable,web)
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </obout:Flyout>
            <obout:Flyout runat="server" ID="Flyout4" AttachTo="cbTechnology" Align="MIDDLE"
                CloseEvent="ONMOUSEOUT" CloseTime="20" DelayTime="20" FadingEffect="True" FlyingEffect="NONE"
                NoneEffect="False" OnClientClose="" OnClientInit="" OnClientOpen="" Opacity="100"
                OpenEvent="ONMOUSEOVER" OpenTime="250" Position="MIDDLE_RIGHT" RelativeLeft="0"
                RelativeTop="0" Resolution="10" SlidingEffect="NONE" SlidingRange="10" zIndex="0">
                <table>
                    <tr>
                        <td style="background-image: url(Images/aaa.jpg)">
                            <fieldset style="width: 250px; font-size: small">
                                Related to T/MC Internet resources(web,lists,blogs),GIS,group systems, animation,autocad,video,conferencing
                                and other technologies
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </obout:Flyout>
            <obout:Flyout runat="server" ID="Flyout21" AttachTo="lblItemDescription" Align="MIDDLE"
                CloseEvent="ONMOUSEOUT" CloseTime="20" DelayTime="20" FadingEffect="True" FlyingEffect="NONE"
                NoneEffect="False" OnClientClose="" OnClientInit="" OnClientOpen="" Opacity="100"
                OpenEvent="ONMOUSEOVER" OpenTime="250" Position="MIDDLE_RIGHT" RelativeLeft="60"
                RelativeTop="10" Resolution="10" SlidingEffect="NONE" SlidingRange="60" zIndex="10">
                <table>
                    <tr>
                        <td style="background-image: url(Images/aaa.jpg)">
                            <fieldset>
                                <legend>Item Description</legend>
                                <asp:Label ID="lblWhathappened" runat="server" Text="What happened? (describe briefly so those outside)your organization can understand"
                                    BackColor="FloralWhite" Font-Names="Verdana" Font-Size="Smaller" Height="64px"
                                    Width="130px"></asp:Label></fieldset>
                        </td>
                    </tr>
                </table>
            </obout:Flyout>
            <obout:Flyout runat="server" ID="Flyout24" AttachTo="lblItemMeaning" Align="MIDDLE"
                CloseEvent="ONMOUSEOUT" CloseTime="20" DelayTime="20" FadingEffect="True" FlyingEffect="NONE"
                NoneEffect="False" OnClientClose="" OnClientInit="" OnClientOpen="" Opacity="100"
                OpenEvent="ONMOUSEOVER" OpenTime="250" Position="MIDDLE_RIGHT" RelativeLeft="60"
                RelativeTop="10" Resolution="10" SlidingEffect="NONE" SlidingRange="60" zIndex="10">
                <table>
                    <tr>
                        <td>
                            <fieldset>
                                <legend>Item Meaning</legend>
                                <asp:Label ID="Label15" runat="server" Text="Why or how is this item important to the mission,objectives or work you are recording for? "
                                    BackColor="FloralWhite" Font-Names="Verdana" Font-Size="Smaller" Height="84px"
                                    Width="130px"></asp:Label></fieldset>
                        </td>
                    </tr>
                </table>
            </obout:Flyout>
            <obout:Flyout runat="server" ID="Flyout25" AttachTo="lblItemResult" Align="MIDDLE"
                CloseEvent="ONMOUSEOUT" CloseTime="20" DelayTime="20" FadingEffect="True" FlyingEffect="NONE"
                NoneEffect="False" OnClientClose="" OnClientInit="" OnClientOpen="" Opacity="100"
                OpenEvent="ONMOUSEOVER" OpenTime="250" Position="MIDDLE_RIGHT" RelativeLeft="60"
                RelativeTop="10" Resolution="10" SlidingEffect="NONE" SlidingRange="60" zIndex="10">
                <table>
                    <tr>
                        <td>
                            <fieldset>
                                <legend>Item Result Or Lesson</legend>
                                <asp:Label ID="lblHelpItemResult" runat="server" Text="What is at least one real or potential result, outcome consequence, or lesson related to this recorded item?"
                                    BackColor="FloralWhite" Font-Names="Verdana" Font-Size="Smaller" Height="89px"
                                    Width="133px"></asp:Label></fieldset>
                        </td>
                    </tr>
                </table>
            </obout:Flyout>
            <obout:Flyout runat="server" ID="Flyout5" AttachTo="cbResearch" Align="MIDDLE" CloseEvent="ONMOUSEOUT"
                CloseTime="20" DelayTime="20" FadingEffect="True" FlyingEffect="NONE" NoneEffect="False"
                OnClientClose="" OnClientInit="" OnClientOpen="" Opacity="100" OpenEvent="ONMOUSEOVER"
                OpenTime="250" Position="MIDDLE_RIGHT" RelativeLeft="0" RelativeTop="0" Resolution="10"
                SlidingEffect="NONE" SlidingRange="10" zIndex="0">
                <table>
                    <tr>
                        <td style="background-image: url(Images/aaa.jpg)">
                            <fieldset style="width: 250px; font-size: small">
                                Related to research,survey development,GIS,mapping,best practices search and evaluation
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </obout:Flyout>
            <obout:Flyout runat="server" ID="Flyout6" AttachTo="cbTraining" Align="MIDDLE" CloseEvent="ONMOUSEOUT"
                CloseTime="20" DelayTime="20" FadingEffect="True" FlyingEffect="NONE" NoneEffect="False"
                OnClientClose="" OnClientInit="" OnClientOpen="" Opacity="100" OpenEvent="ONMOUSEOVER"
                OpenTime="250" Position="MIDDLE_RIGHT" RelativeLeft="0" RelativeTop="0" Resolution="10"
                SlidingEffect="NONE" SlidingRange="10" zIndex="0">
                <table>
                    <tr>
                        <td style="background-image: url(Images/aaa.jpg)">
                            <fieldset style="width: 290px; font-size: small">
                                Related to training and education (e.g T/M Learning,Network,conferences,advising
                                and consulting T/M training Institute,web courses)
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </obout:Flyout>
            <obout:Flyout runat="server" ID="Flyout7" AttachTo="cbResourceDevelopment" Align="MIDDLE"
                CloseEvent="ONMOUSEOUT" CloseTime="20" DelayTime="20" FadingEffect="True" FlyingEffect="NONE"
                NoneEffect="False" OnClientClose="" OnClientInit="" OnClientOpen="" Opacity="100"
                OpenEvent="ONMOUSEOVER" OpenTime="250" Position="MIDDLE_RIGHT" RelativeLeft="0"
                RelativeTop="0" Resolution="10" SlidingEffect="NONE" SlidingRange="10" zIndex="0">
                <table>
                    <tr>
                        <td style="background-image: url(Images/aaa.jpg)">
                            <fieldset style="width: 250px; font-size: small">
                                Related to bringing in /developing people /organizations to support and lead ;generating
                                volunteers,media,dollars,technology,new ideas,business partners,space ,others
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </obout:Flyout>
            <obout:Flyout runat="server" ID="Flyout8" AttachTo="cbStrategicEvents" Align="MIDDLE"
                CloseEvent="ONMOUSEOUT" CloseTime="20" DelayTime="20" FadingEffect="True" FlyingEffect="NONE"
                NoneEffect="False" OnClientClose="" OnClientInit="" OnClientOpen="" Opacity="100"
                OpenEvent="ONMOUSEOVER" OpenTime="250" Position="MIDDLE_RIGHT" RelativeLeft="0"
                RelativeTop="0" Resolution="10" SlidingEffect="NONE" SlidingRange="10" zIndex="0">
                <table>
                    <tr>
                        <td style="background-image: url(Images/aaa.jpg)">
                            <fieldset style="width: 250px; font-size: small">
                                Related to strategic or special events or products (e.g . Recruitment Campaign,
                                ,T/M week, Key dinners and benefits,festivals,awarness and fund generating events,
                                key reports and information)
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </obout:Flyout>
            <obout:Flyout runat="server" ID="Flyout9" AttachTo="cbCommunitySystemChange" Align="MIDDLE"
                CloseEvent="ONMOUSEOUT" CloseTime="20" DelayTime="20" FadingEffect="True" FlyingEffect="NONE"
                NoneEffect="False" OnClientClose="" OnClientInit="" OnClientOpen="" Opacity="100"
                OpenEvent="ONMOUSEOVER" OpenTime="250" Position="MIDDLE_RIGHT" RelativeLeft="0"
                RelativeTop="0" Resolution="10" SlidingEffect="NONE" SlidingRange="10" zIndex="0">
                <table>
                    <tr>
                        <td style="background-image: url(Images/aaa.jpg)">
                            <fieldset style="width: 250px; font-size: small">
                                Resulted in a new OR modified program, policy, or practice related to your mission.
                                This includes the start of new collaborations and changes in a way of "doing business."
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </obout:Flyout>
            <obout:Flyout runat="server" ID="Flyout10" AttachTo="cbMedia" Align="MIDDLE" CloseEvent="ONMOUSEOUT"
                CloseTime="20" DelayTime="20" FadingEffect="True" FlyingEffect="NONE" NoneEffect="False"
                OnClientClose="" OnClientInit="" OnClientOpen="" Opacity="100" OpenEvent="ONMOUSEOVER"
                OpenTime="250" Position="MIDDLE_RIGHT" RelativeLeft="0" RelativeTop="0" Resolution="10"
                SlidingEffect="NONE" SlidingRange="10" zIndex="0">
                <table>
                    <tr>
                        <td style="background-image: url(Images/aaa.jpg)">
                            <fieldset style="width: 290px; font-size: small">
                                Resulted in media (print, radio, TV, web, or other) related to your organization,
                                mission, or objectives.
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </obout:Flyout>
            <obout:Flyout runat="server" ID="Flyout11" AttachTo="cbCommunityAction" Align="MIDDLE"
                CloseEvent="ONMOUSEOUT" CloseTime="20" DelayTime="20" FadingEffect="True" FlyingEffect="NONE"
                NoneEffect="False" OnClientClose="" OnClientInit="" OnClientOpen="" Opacity="100"
                OpenEvent="ONMOUSEOVER" OpenTime="250" Position="MIDDLE_RIGHT" RelativeLeft="0"
                RelativeTop="0" Resolution="10" SlidingEffect="NONE" SlidingRange="10" zIndex="0">
                <table>
                    <tr class="pop">
                        <td style="background-image: url(Images/aaa.jpg)">
                            <fieldset style="width: 290px; font-size: small">
                                The result was an event, meeting, action or similar item where your organization
                                worked with others with the aim of creating a community, systems, or environmental
                                change (it may not have occurred yet, such as a group meeting to work toward a change).
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </obout:Flyout>
            <obout:Flyout runat="server" ID="Flyout12" AttachTo="cbResources" Align="MIDDLE"
                CloseEvent="ONMOUSEOUT" CloseTime="20" DelayTime="20" FadingEffect="True" FlyingEffect="NONE"
                NoneEffect="False" OnClientClose="" OnClientInit="" OnClientOpen="" Opacity="100"
                OpenEvent="ONMOUSEOVER" OpenTime="250" Position="MIDDLE_RIGHT" RelativeLeft="0"
                RelativeTop="0" Resolution="10" SlidingEffect="NONE" SlidingRange="10" zIndex="0">
                <table>
                    <tr class="pop">
                        <td style="background-image: url(Images/aaa.jpg)">
                            <fieldset style="width: 290px; font-size: small">
                                Resulted in direct or donated materials, services, or funding to your organization
                                or cause. Please make sure you report this amount in the Event Description.
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </obout:Flyout>
            <obout:Flyout runat="server" ID="Flyout13" AttachTo="cbServices" Align="MIDDLE" CloseEvent="ONMOUSEOUT"
                CloseTime="20" DelayTime="20" FadingEffect="True" FlyingEffect="NONE" NoneEffect="False"
                OnClientClose="" OnClientInit="" OnClientOpen="" Opacity="100" OpenEvent="ONMOUSEOVER"
                OpenTime="250" Position="MIDDLE_RIGHT" RelativeLeft="0" RelativeTop="0" Resolution="10"
                SlidingEffect="NONE" SlidingRange="10" zIndex="0">
                <table>
                    <tr class="pop">
                        <td style="background-image: url(Images/aaa.jpg)">
                            <fieldset style="width: 290px; font-size: small">
                                Resulted in offering or providing a service by your organization to a person, client,
                                or group (e.g., some type of information, support, or other type of service).
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </obout:Flyout>
            <obout:Flyout runat="server" ID="Flyout14" AttachTo="cbPlaningAndDevelopment" Align="MIDDLE"
                CloseEvent="ONMOUSEOUT" CloseTime="20" DelayTime="20" FadingEffect="True" FlyingEffect="NONE"
                NoneEffect="False" OnClientClose="" OnClientInit="" OnClientOpen="" Opacity="100"
                OpenEvent="ONMOUSEOVER" OpenTime="250" Position="MIDDLE_RIGHT" RelativeLeft="0"
                RelativeTop="0" Resolution="10" SlidingEffect="NONE" SlidingRange="10" zIndex="0">
                <table>
                    <tr>
                        <td style="background-image: url(Images/aaa.jpg)">
                            <fieldset style="width: 290px; font-size: small">
                                The result was an event or action to plan or develop your organization or its related
                                work. This includes hiring new staff.
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </obout:Flyout>
            <obout:Flyout runat="server" ID="Flyout15" AttachTo="cbCriticalEvent" Align="MIDDLE"
                CloseEvent="ONMOUSEOUT" CloseTime="20" DelayTime="20" FadingEffect="True" FlyingEffect="NONE"
                NoneEffect="False" OnClientClose="" OnClientInit="" OnClientOpen="" Opacity="100"
                OpenEvent="ONMOUSEOVER" OpenTime="250" Position="MIDDLE_RIGHT" RelativeLeft="0"
                RelativeTop="0" Resolution="10" SlidingEffect="NONE" SlidingRange="10" zIndex="0">
                <table>
                    <tr>
                        <td style="background-image: url(Images/aaa.jpg)">
                            <fieldset style="width: 290px; font-size: small">
                                The result was an event or action that positively OR negatively influenced your
                                organization or its work.
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </obout:Flyout>
            <obout:Flyout runat="server" ID="Flyout16" AttachTo="lblEventTypeOthers" Align="MIDDLE"
                CloseEvent="ONMOUSEOUT" CloseTime="20" DelayTime="20" FadingEffect="True" FlyingEffect="NONE"
                NoneEffect="False" OnClientClose="" OnClientInit="" OnClientOpen="" Opacity="100"
                OpenEvent="ONMOUSEOVER" OpenTime="250" Position="MIDDLE_RIGHT" RelativeLeft="0"
                RelativeTop="0" Resolution="10" SlidingEffect="NONE" SlidingRange="10" zIndex="0">
                <table>
                    <tr>
                        <td style="background-image: url(Images/aaa.jpg)">
                            <fieldset style="width: 290px; font-size: small">
                                The results was an event, action or consequence not captured in the given categories.
                                Please describe details in the Event Description.
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </obout:Flyout>
            <obout:Flyout runat="server" ID="Flyout20" AttachTo="lblEventGoalsOthers" Align="MIDDLE"
                CloseEvent="ONMOUSEOUT" CloseTime="20" DelayTime="20" FadingEffect="True" FlyingEffect="NONE"
                NoneEffect="False" OnClientClose="" OnClientInit="" OnClientOpen="" Opacity="100"
                OpenEvent="ONMOUSEOVER" OpenTime="250" Position="MIDDLE_RIGHT" RelativeLeft="0"
                RelativeTop="0" Resolution="10" SlidingEffect="NONE" SlidingRange="10" zIndex="0">
                <table>
                    <tr>
                        <td style="background-image: url(Images/aaa.jpg)">
                            <fieldset style="width: 200px; font-size: small">
                                Please provide any other comments that are important for this item.
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </obout:Flyout>
            <obout:Flyout runat="server" ID="Flyout1" AttachTo="lblEventCommunicationOthers"
                Align="MIDDLE" CloseEvent="ONMOUSEOUT" CloseTime="20" DelayTime="20" FadingEffect="True"
                FlyingEffect="NONE" NoneEffect="False" OnClientClose="" OnClientInit="" OnClientOpen=""
                Opacity="100" OpenEvent="ONMOUSEOVER" OpenTime="250" Position="MIDDLE_RIGHT"
                RelativeLeft="0" RelativeTop="0" Resolution="10" SlidingEffect="NONE" SlidingRange="10"
                zIndex="0">
                <table>
                    <tr>
                        <td style="background-image: url(Images/aaa.jpg)">
                            <fieldset style="width: 200px; font-size: small">
                                Please provide any other comments that are important for this item.
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </obout:Flyout>
            <obout:Flyout runat="server" ID="Flyout19" AttachTo="cbEmail" Align="MIDDLE" CloseEvent="ONMOUSEOUT"
                CloseTime="20" DelayTime="20" FadingEffect="True" FlyingEffect="NONE" NoneEffect="False"
                OnClientClose="" OnClientInit="" OnClientOpen="" Opacity="100" OpenEvent="ONMOUSEOVER"
                OpenTime="250" Position="MIDDLE_RIGHT" RelativeLeft="0" RelativeTop="0" Resolution="10"
                SlidingEffect="NONE" SlidingRange="10" zIndex="0">
                <table>
                    <tr>
                        <td style="background-image: url(Images/aaa.jpg)">
                            <fieldset style="width: 200px; font-size: small">
                                Share this item with someone by email
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </obout:Flyout>
            <obout:Flyout runat="server" ID="Flyout17" AttachTo="cbReport" Align="MIDDLE" CloseEvent="ONMOUSEOUT"
                CloseTime="20" DelayTime="20" FadingEffect="True" FlyingEffect="NONE" NoneEffect="False"
                OnClientClose="" OnClientInit="" OnClientOpen="" Opacity="100" OpenEvent="ONMOUSEOVER"
                OpenTime="250" Position="MIDDLE_RIGHT" RelativeLeft="0" RelativeTop="0" Resolution="10"
                SlidingEffect="NONE" SlidingRange="10" zIndex="0">
                <table>
                    <tr>
                        <td style="background-image: url(Images/aaa.jpg)">
                            <fieldset style="width: 200px; font-size: small">
                                Include this event or action in a future organizational report or related document.
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </obout:Flyout>
            <obout:Flyout runat="server" ID="Flyout18" AttachTo="cbNews" Align="MIDDLE" CloseEvent="ONMOUSEOUT"
                CloseTime="20" DelayTime="20" FadingEffect="True" FlyingEffect="NONE" NoneEffect="False"
                OnClientClose="" OnClientInit="" OnClientOpen="" Opacity="100" OpenEvent="ONMOUSEOVER"
                OpenTime="250" Position="MIDDLE_RIGHT" RelativeLeft="0" RelativeTop="0" Resolution="10"
                SlidingEffect="NONE" SlidingRange="10" zIndex="0">
                <table>
                    <tr>
                        <td style="background-image: url(Images/aaa.jpg)">
                            <fieldset style="width: 200px; font-size: small">
                                Share this item in the news or related media.
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </obout:Flyout>
            <obout:Flyout runat="server" ID="Flyout22" AttachTo="cbSpecial" Align="MIDDLE" CloseEvent="ONMOUSEOUT"
                CloseTime="20" DelayTime="20" FadingEffect="True" FlyingEffect="NONE" NoneEffect="False"
                OnClientClose="" OnClientInit="" OnClientOpen="" Opacity="100" OpenEvent="ONMOUSEOVER"
                OpenTime="250" Position="MIDDLE_RIGHT" RelativeLeft="0" RelativeTop="0" Resolution="10"
                SlidingEffect="NONE" SlidingRange="10" zIndex="0">
                <table>
                    <tr>
                        <td style="background-image: url(Images/aaa.jpg)">
                            <fieldset style="width: 200px; font-size: small">
                                Mark as "special" for some other purpose.
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </obout:Flyout>
            <obout:Flyout runat="server" ID="Flyout23" AttachTo="cbBestPractice" Align="MIDDLE"
                CloseEvent="ONMOUSEOUT" CloseTime="20" DelayTime="20" FadingEffect="True" FlyingEffect="NONE"
                NoneEffect="False" OnClientClose="" OnClientInit="" OnClientOpen="" Opacity="100"
                OpenEvent="ONMOUSEOVER" OpenTime="250" Position="MIDDLE_RIGHT" RelativeLeft="0"
                RelativeTop="0" Resolution="10" SlidingEffect="NONE" SlidingRange="10" zIndex="0">
                <table>
                    <tr>
                        <td style="background-image: url(Images/aaa.jpg)">
                            <fieldset style="width: 200px; font-size: small">
                                Mark this as a "best practice"
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </obout:Flyout>
        </asp:Panel>
    </div>
    <%-- <script language="javascript" type="text/javascript">
        InitializeCalendar('');
    </script>--%>
</asp:Content>
