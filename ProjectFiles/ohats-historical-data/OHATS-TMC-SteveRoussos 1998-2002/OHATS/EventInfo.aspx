<%@ page language="C#" masterpagefile="Event1.master" autoeventwireup="true" inherits="_EventInfo, App_Web_eventinfo.aspx.cdcab7d2" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register TagPrefix="obout" Namespace="OboutInc.Flyout2" Assembly="obout_Flyout2_NET" %>
<%-- %><%@ Register Src="Controls/DatePicker.ascx" TagName="DatePicker" TagPrefix="uc1" %>--%>
<asp:Content ContentPlaceHolderID="Main" runat="server">

   
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

    function EventOccuredChange(sender,args) {
        var hdnEvent = document.getElementById('<%= this.hdnEventoccur.ClientID%>');
        var selectedDate = new Date(sender._selectedDate);
        hdnEvent.value = selectedDate.format('MM/dd/yyyy');
       
    }
    function DateUnsureChange(sender, args) {
        var hdfunsure = document.getElementById('<%= this.hdnUnsured.ClientID%>');
        var selectedDate = new Date(sender._selectedDate);
        hdfunsure.value = selectedDate.format('MM/dd/yyyy');
    }


   </script>
   
   
   
   

    <div style="margin-top: 25px; text-align: left;">
        <center>
            <span style="font: 22px arial; color: red">Events , Results & Accomplishments: Create
                New Event Form </span>
        </center>
        <table width="76%" cellpadding="0px" cellspacing="0px" align="center" style="margin-top: 20px;">
            <tr>
                <td colspan="5">
                    <asp:Label ID="lblError" runat="server" Visible="False" ForeColor="Red" CssClass="Label"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="width: 100%;">
                    <asp:Wizard ID="wizard" runat="server" Height="45%" Width="100%" BackColor="" CssClass="wizardright"
                        Style="border: 1px solid #8CA1BC; margin: 0px 0px 0px 0px;" BorderColor="Red"
                        ActiveStepIndex="0" OnFinishButtonClick="wizard_FinishButtonClick" OnNextButtonClick="wizard_NextButtonClick"
                        NavigationButtonStyle-BackColor="Black">
                        <SideBarStyle Font-Size="11px" Width="35%" HorizontalAlign="Justify" VerticalAlign="Top"
                            CssClass="wizardleft" />
                        <SideBarButtonStyle ForeColor="Black" Height="10px" />
                        <SideBarTemplate>
                            <asp:DataList ID="SideBarList" runat="server">
                                <SelectedItemStyle Font-Bold="True" />
                                <ItemTemplate>
                                    <table border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td valign="top" style="width: 300px;">
                                                <asp:LinkButton ID="SideBarButton" runat="server"></asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:DataList>
                        </SideBarTemplate>
                        <WizardSteps>
                       
                            <asp:WizardStep ID="templatedwizardstep" runat="server" Title="Step 1:- EVENT INFO"
                                StepType="Start">
                                <table>
                                    <tr>
                                        <td nowrap colspan="2" style="text-align: left; background: #0E4A8F; height: 35px;
                                            color: #ffffff; padding: 0px 0px 0px 20px;">
                                            <asp:Label ID="labelEvent" runat="server" Text="STEP-1: EVENT INFORMATION" Font-Size="14px"
                                                Font-Bold="True" Font-Italic="False" Width="187px"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="30%" style="padding: 0px 0px 0px 10px;">
                                            <table>
                                                <tr>
                                                    <td style="width: 123px;">
                                                        <asp:Label ID="lblprivateitem" runat="server" Text="Private Item" Width="90" CssClass="Label"></asp:Label>
                                                    </td>
                                                    <td style="width: 123px;">
                                                        <asp:CheckBox ID="cbprivateitem" runat="server" Enabled="true" CssClass="Checkbox"
                                                            Font-Size="10px" ToolTip="Tick the box to ensure that it is a private item" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 100px;" nowrap>
                                                        <asp:Label ID="lblrecordername" runat="server" Text="Recorder Name" Width="100" CssClass="Label"></asp:Label>
                                                    </td>
                                                    <td style="width: 123px; padding-top: 10px;">
                                                        <asp:HyperLink ID="lnkRecorderNew" runat="server" Text="Addnew" ForeColor="RoyalBlue"
                                                            Style="float: left; margin: 0px 0px 0px 90px;"></asp:HyperLink>
                                                        <asp:DropDownList ID="ddlrecordername" runat="server" Height="20px" Width="130px"
                                                            Font-Size="8pt" ToolTip="Select a Recorder name" TabIndex="1" DataTextField="RecorderName"
                                                            DataValueField="Userid">
                                                        </asp:DropDownList>
                                                        <asp:RequiredFieldValidator ID="rfvrecordername" runat="server" ControlToValidate="ddlrecordername"
                                                            ErrorMessage="Choose a Recorder Name" InitialValue="Select" Font-Size="X-Small"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 100px;" nowrap>
                                                        <asp:Label ID="lbleventoccureddate" runat="server" Text="Event Occured Date" Width="100"
                                                            CssClass="Label" ToolTip="On which date the Event had occured"></asp:Label>
                                                    </td>
                                                    <td style="width: 150px;">
                                                        <asp:TextBox ID="txtEventOccureddate" runat="server" ReadOnly="true" Width="100px"
                                                            ValidationGroup="10" ToolTip="On which date the Event had occured" Style="float: left;"></asp:TextBox>
                                                        <img id="ImageButtonEvent" runat="server" src="~/Images/clr.jpg" alt="Event Occured Date" style="cursor:pointer" onclick ="javascript:return ImageButtonEventClick();"  />
                                                            
                                                            
                                                                <cc1:CalendarExtender ID="EventoccuredCalendar" runat="server" CssClass="cal_Theme1" TargetControlID="txtEventOccureddate"
                                                                    PopupButtonID="ImageButtonEvent" OnClientDateSelectionChanged="EventOccuredChange">
                                                                </cc1:CalendarExtender>
                                                            
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 100px;">
                                                        <asp:Label ID="lbldateunsurred" runat="server" Text="Date Unsure" Width="100" CssClass="Label"
                                                            ToolTip="Unsured date of the event" Style="float: left; position: relative; margin-top: 10px;"></asp:Label>
                                                    </td>
                                                   <td style="width: 150px; padding-top: 10px;">
                                                        <asp:TextBox ID="txtDateUnsurred" runat="server" ReadOnly="true" Width="100px" ValidationGroup="10"
                                                            ToolTip="Enter the Unsure date of the event" Style="float: left;"></asp:TextBox>
                                                     <img id="ImageButtonUnsurred" runat="server" src="~/Images/clr.jpg" alt="Unsure Date" style="cursor:pointer" onclick ="javascript:return ImageButtonUnsurredClick();"  />
                                                            
                                                          
                                                                <cc1:CalendarExtender ID="DateUnsureCalendar" runat="server"  CssClass="cal_Theme1" TargetControlID="txtDateUnsurred"
                                                                    PopupButtonID="ImageButtonUnsurred" OnClientDateSelectionChanged="DateUnsureChange" >
                                                                </cc1:CalendarExtender>
                                                           
                                                        <asp:Label ID="lbldateError" runat="server"></asp:Label>
                                                        <asp:HiddenField ID="hdnUnsured" runat="server" />
                                                         <asp:HiddenField ID="hdnEventoccur" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 123px;">
                                                        <asp:Label ID="lblthisevent" runat="server" Text="This Event" Width="90" CssClass="Label"
                                                            ToolTip="The event belongs to what type" Style="float: left; margin-top: -10px;
                                                            position: relative;"></asp:Label>
                                                    </td>
                                                    <td style="width: 200px;">
                                                        <asp:RadioButtonList ID="rbleventstatus" runat="server" CssClass="list" Font-Size="10px"
                                                            Style="float: left;">
                                                            <asp:ListItem Selected="True" Text="Occured on only one day" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="Will occur multiple days but has an end date(Please list the future dates,if known in the item description)"
                                                                Value="1"></asp:ListItem>
                                                            <asp:ListItem Text="It is not designed to end" Value="2"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="50%" style="padding: 25px 0px 0px 10px;" valign="top">
                                            <table>
                                                <tr>
                                                    <td style="width: 80px; padding-top: 6px;">
                                                        <asp:Label ID="lblsource" runat="server" Text="Source" CssClass="Label"></asp:Label>
                                                    </td>
                                                    <td style="padding-top: 8px;">
                                                        <asp:RadioButtonList ID="rblsource" runat="server" Font-Size="8pt" CssClass="list"
                                                            RepeatDirection="Horizontal">
                                                            <asp:ListItem Text="External" Value="0"></asp:ListItem>
                                                            <asp:ListItem Selected="True" Text="Internal" Value="1"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 80px; padding-top: 6px;" nowrap>
                                                        <asp:Label ID="lblpeopleattend" runat="server" Text="People Attended" CssClass="Label"></asp:Label>
                                                    </td>
                                                    <td style="width: 15px; padding: 10px 0px 0px 0px;">
                                                        <asp:TextBox ID="txtpeopleattended" runat="server" MaxLength="5" ToolTip="Enter no of peoples attend the event"
                                                            Font-Size="8"></asp:TextBox><%--<asp:CustomValidator
                                                                ID="validPeopleAttended" runat="server" ControlToValidate="txtpeopleattended"
                                                                ClientValidationFunction="isValidNumeric" ErrorMessage="No of people Must be in Numeric"
                                                                Height="5px" Width="240px" Font-Size="XX-Small"></asp:CustomValidator>--%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 80px; padding-top: 10px;">
                                                        <asp:Label ID="lblstate" runat="server" Text="State" CssClass="Label"></asp:Label>
                                                    </td>
                                                    <td style="width: 123px; padding-top: 6px;">
                                                        <asp:DropDownList ID="ddlstate" runat="server" Width="100px" DataTextField="State"
                                                            Font-Size="8">
                                                        </asp:DropDownList>
                                                        <%--<asp:RequiredFieldValidator ID="rfvddlstate" runat="server" ControlToValidate="ddlstate"
                                                                ErrorMessage="Choose a State" InitialValue="Select" Font-Size="X-Small"></asp:RequiredFieldValidator>--%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 80px;">
                                                        <asp:Label ID="country" runat="server" Text="Country" CssClass="Label"></asp:Label>
                                                    </td>
                                                    <td style="width: 123px; padding-top: 12px;">
                                                        <asp:TextBox ID="txtcountry" runat="server" Width="90" ToolTip="Enter the country"
                                                            Font-Size="8"></asp:TextBox>
                                                        <asp:CustomValidator ID="customcountry" runat="server" ControlToValidate="txtcountry"
                                                            ClientValidationFunction="isAlphanumeric" ErrorMessage="Enter a valid country name"
                                                            Style="clear: left; float: left" Font-Size="XX-Small"></asp:CustomValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 80px;">
                                                        <asp:Label ID="lblitemnovelity" runat="server" Text="Item Novelity" CssClass="Label"
                                                            ToolTip="Drop any one of the following"></asp:Label>
                                                    </td>
                                                    <td style="width: 123px; padding-top: 0px;">
                                                        <asp:DropDownList ID="ddlitemnovelity" runat="server" Width="184px" Font-Size="8">
                                                            <asp:ListItem Text="Select"></asp:ListItem>
                                                            <asp:ListItem Text="Modified from Earlier work"></asp:ListItem>
                                                            <asp:ListItem Text="New - Not done before"></asp:ListItem>
                                                            <asp:ListItem Text="Pre Existing"></asp:ListItem>
                                                            <asp:ListItem Text="Other"></asp:ListItem>
                                                        </asp:DropDownList>
                                                        <%--<asp:RequiredFieldValidator ID="rfvddlItemNovelity" runat="server" ControlToValidate="ddlitemnovelity"
                                                                ValidationGroup="1" ErrorMessage="Choose an Item Novelity" InitialValue="Select"
                                                                Font-Size="X-Small"></asp:RequiredFieldValidator>--%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 80px;">
                                                        <asp:Label ID="lblitemtype" runat="server" Text="Item Type" CssClass="Label" ToolTip="Drop any one of the following"></asp:Label>
                                                    </td>
                                                    <td style="width: 123px; padding-top: 6px; font: 8px tahoma;">
                                                        <asp:DropDownList ID="ddlitemtype" runat="server" Width="184px" ValidationGroup="1"
                                                            Font-Size="8">
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
                                                        <%--<asp:RequiredFieldValidator ID="rfvddlItemType" runat="server" ControlToValidate="ddlitemtype"
                                                                ErrorMessage="Choose an Item type" InitialValue="Select" Font-Size="X-Small"></asp:RequiredFieldValidator>--%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 80px;">
                                                        <asp:Label ID="lblrecuring" runat="server" Text="Recurring" CssClass="Label" Visible="false"
                                                            ToolTip="Drop any one of the following"></asp:Label>
                                                    </td>
                                                    <td style="width: 123px; padding-top: 8px;">
                                                        <asp:DropDownList ID="ddlRecuring" runat="server" Width="90" Font-Size="8" Visible="false">
                                                            <asp:ListItem Text="Select"></asp:ListItem>
                                                            <asp:ListItem Text="Yes"></asp:ListItem>
                                                            <asp:ListItem Text="No"></asp:ListItem>
                                                        </asp:DropDownList>
                                                        <%--<asp:RequiredFieldValidator ID="rfvddlRecuring" runat="server" ControlToValidate="ddlRecuring"
                                                                ValidationGroup="1" ErrorMessage="Choose a recuring method" InitialValue="Select"
                                                                Font-Size="X-Small"></asp:RequiredFieldValidator>--%>
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
                                                    <asp:TextBox ID="txtRecorderFName" runat="server" Style="float: left;"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ValidationGroup="3" ID="RequiredFieldValidator4" runat="server"
                                                        ErrorMessage="Enter First Name" ControlToValidate="txtRecorderFName" Style="float: left;
                                                        clear: left; width: 80px;"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 16px;" class="label" align="left">
                                                    Last Name
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtRecorderLName" runat="server" Style="float: left;"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ValidationGroup="3" Style="float: left; clear: left;
                                                        width: 80px;" ID="RequiredFieldValidator5" runat="server" ErrorMessage="Enter Last Name"
                                                        ControlToValidate="txtRecorderLName"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 16px;" class="label" align="left">
                                                    Organization
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtRecorderOrganization" runat="server" Style="float: left;"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ValidationGroup="3" Style="float: left; clear: left;
                                                        width: 120px;" ID="RequiredFieldValidator6" runat="server" ErrorMessage="Enter Organization"
                                                        ControlToValidate="txtRecorderOrganization"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 16px;" class="label" align="left">
                                                    Phone No
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtRecorderPhoneno" MaxLength="10" runat="server" Style="float: left;"></asp:TextBox>
                                                    <asp:RegularExpressionValidator Style="float: left; clear: left; width: 120px;" ID="RegularExpressionValidator3"
                                                        runat="server" ControlToValidate="txtRecorderPhoneno" ValidationGroup="3" ValidationExpression="\d{10}"></asp:RegularExpressionValidator><asp:CustomValidator
                                                            ID="CustomValidator1" runat="server" Style="float: left; clear: left; width: 120px;"
                                                            ValidationGroup="3" ControlToValidate="txtRecorderPhoneno" ClientValidationFunction="isValidNumeric"
                                                            Width="113px" ErrorMessage=" Please Give a Valid Input"></asp:CustomValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 16px;" class="label" align="left">
                                                    Email
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtRecorderEmail" runat="server" Style="float: left;"></asp:TextBox><asp:RegularExpressionValidator
                                                        ID="RegularExpressionValidator4" Style="float: left; clear: left; width: 120px;"
                                                        runat="server" ValidationExpression="^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*\.(\w{2}|(com|net|org|edu|gov|biz|info))$"
                                                        ErrorMessage="give a valid e-mail address" ControlToValidate="txtRecorderEmail"
                                                        Display="Dynamic" ValidationGroup="3" SetFocusOnError="True"></asp:RegularExpressionValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center" colspan="4" valign="middle">
                                                    <asp:Button ID="butRecorderSave" runat="server" Text="Save" ValidationGroup="3" OnClick="butRecorderSave_Click">
                                                    </asp:Button>
                                                    <asp:Button ID="butRecorderCancel" runat="server" Text="Cancel" OnClick="butRecorderCancel_Click"
                                                        CausesValidation="false"></asp:Button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </obout:Flyout>
                            </asp:WizardStep>
                            <asp:TemplatedWizardStep ID="templatedwizardstepitem" runat="server" Title="Step 2:- ITEM DETAILS"
                                StepType="Step">
                                <ContentTemplate>
                                    <table width="100%">
                                        <tr>
                                            <td nowrap colspan="2" style="text-align: left; background: #0E4A8F; width: 100%;
                                                height: 35px; color: #ffffff; padding: 0px 0px 0px 20px;">
                                                <asp:Label ID="label2" runat="server" Text="STEP-2: ITEM DETAILS" Font-Size="14px"
                                                    Font-Bold="true" Font-Italic="FALSE" Width="187px"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 123px; padding-bottom: 8px; padding-left: 20px;">
                                                <asp:Label ID="lblitemdescription" runat="server" Text="Item Description:-" CssClass="Heading"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 123px; padding-bottom: 4px; padding-left: 40px;">
                                                <asp:TextBox ID="txtitemdescription" runat="server" TextMode="MultiLine" Height="80px"
                                                    Width="380px" CssClass="MultiLineTextbox"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table>
                                                    <tr>
                                                        <td style="width: 123px; padding-bottom: 4px; padding-left: 20px;">
                                                            <asp:Label ID="lblitemmeaning" runat="server" Text="Item Meaning:-" CssClass="Heading"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 123px; padding-bottom: 4px; padding-left: 40px;">
                                                            <asp:TextBox ID="txtitemmeaning" runat="server" TextMode="MultiLine" CssClass="MultiLineTextbox"
                                                                Height="80px" Width="380px"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table>
                                                    <tr>
                                                        <td style="width: 123px; padding-bottom: 4px; padding-left: 20px;">
                                                            <asp:Label ID="lblitemresult" runat="server" Text="Item Result:-" CssClass="Heading"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 123px; padding-bottom: 4px; padding-left: 40px;">
                                                            <asp:TextBox ID="txtitemresult" runat="server" TextMode="MultiLine" Height="80px"
                                                                Width="380px" CssClass="MultiLineTextbox"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                    <obout:Flyout runat="server" ID="Flyout21" AttachTo="lblitemdescription" Align="MIDDLE"
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
                                    <obout:Flyout runat="server" ID="Flyout24" AttachTo="lblitemmeaning" Align="MIDDLE"
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
                                    <obout:Flyout runat="server" ID="Flyout25" AttachTo="lblitemresult" Align="MIDDLE"
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
                                </ContentTemplate>
                            </asp:TemplatedWizardStep>
                            <asp:WizardStep ID="tempwizactorname" runat="server" Title="Step 3:- KEY ACTORS &amp; ORGANISATION"
                                StepType="Step">
                                <table width="100%">
                                    <tr>
                                        <td nowrap colspan="2" style="text-align: left; background: #0E4A8F; width: 100%;
                                            height: 35px; color: #ffffff; padding: 0px 0px 0px 20px;">
                                            <asp:Label ID="label1" runat="server" Text="STEP-3: KEY ACTOR'S & ORGANISATION" Font-Size="14px"
                                                Font-Bold="true" Width="187px"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 183px; padding-bottom: 4px; padding-left: 20px; padding-top: 10px;">
                                            <asp:Label ID="lblkeyactors" runat="server" Text="Key Actors Name:-" CssClass="Heading"></asp:Label>
                                            <asp:HyperLink ID="lnkAddNew" runat="server" Text="Addnew" ForeColor="RoyalBlue"></asp:HyperLink>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table>
                                                <tr>
                                                    <td style="width: 50px; padding-bottom: 4px; padding-left: 40px;">
                                                        <asp:ListBox ID="ltbkeyactorsname" runat="server" Height="110px" Width="190px" DataTextField="ActorName"
                                                            CssClass="MultiLineTextbox" DataValueField="Userid"></asp:ListBox>
                                                    </td>
                                                    <td style="width: 11px; padding-bottom: 4px">
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:LinkButton ID="linkbutton1" runat="server" Text=">" Style="padding: 0px 0px 0px 5px;"
                                                                        Font-Size="Large" ToolTip="Click here to move the selected actor" OnClick="passselectedactor_Click"></asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:LinkButton ID="linkbutton2" runat="server" Text=">>" Font-Size="Large" ToolTip="Click here to move all the actor"
                                                                        OnClick="passallactor_Click"></asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:LinkButton ID="linkbutton3" runat="server" Text="<" Style="padding: 0px 0px 0px 5px;"
                                                                        Font-Size="Large" ToolTip="Click here to remove the selected actor" OnClick="deleteselectedactor_Click"></asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:LinkButton ID="linkbutton4" runat="server" Text="<<" Font-Size="Large" ToolTip="Click here to remove all"
                                                                        OnClick="deleteallactor_Click"></asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td>
                                                        <table style="position: relative; margin: -25px 0px 0px 0px;">
                                                            <tr>
                                                                <td style="width: 123px;">
                                                                    <asp:Label ID="lblselectedactors" runat="server" Text="Selected Actors:-" CssClass="Heading"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width: 123px; padding-bottom: 4px; padding-top: 20px;">
                                                                    <asp:ListBox ID="txtselectedactors" runat="server" Height="116px" Width="190px" DataTextField="ACTORNAME"
                                                                        CssClass="MultiLineTextBox" DataValueField="Userid"></asp:ListBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 151px; padding-bottom: 4px; padding-left: 20px;" colspan="2">
                                                        <asp:Label ID="lblkeyorganisation" runat="server" Text="Key Organisation:-" CssClass="Heading"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 151px; padding-bottom: 4px; padding-left: 40px;" colspan="2">
                                                        <asp:ListBox ID="txtkeyorganisastion" runat="server" Height="110px" Width="190px"
                                                            CssClass="MultiLineTextbox" DataTextField="organization" DataValueField="Userid">
                                                        </asp:ListBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblkeyactorsdetails" runat="server" Text="New Actor Details" Visible="false"
                                                            CssClass="Label"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <obout:Flyout ID="flyKeyActors" runat="server" AttachTo="lnkAddNew" CloseEvent="ONFOCUSOUT"
                                    zIndex="107">
                                    <table style="border-top-style: double; border-right-style: double; border-left-style: double;
                                        border-bottom-style: double" bgcolor="Gainsboro" height="200px" width="275px">
                                        <tbody>
                                            <tr>
                                                <td style="padding-left: 16px; margin-top: 7px;" class="label" align="left">
                                                    First Name
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtKeyActorsFirstName" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                                                        ValidationGroup="2" ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter First Name"
                                                        ControlToValidate="txtKeyActorsFirstName"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 16px;" class="label" align="left">
                                                    Last Name
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtKeyActorsLastName" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ValidationGroup="2" ID="RequiredFieldValidator2" runat="server"
                                                        ErrorMessage="Enter Last Name" ControlToValidate="txtKeyActorsLastName"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 16px;" class="label" align="left">
                                                    Organization
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtKeyActorsOrganization" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ValidationGroup="2" ID="RequiredFieldValidator3" runat="server"
                                                        ErrorMessage="Enter Organization" ControlToValidate="txtKeyActorsOrganization"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 16px;" class="label" align="left">
                                                    Phone No
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtKeyActorsPhoneNo" MaxLength="10" runat="server"></asp:TextBox>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtKeyActorsPhoneNo"
                                                        ValidationGroup="2" ValidationExpression="\d{10}"></asp:RegularExpressionValidator><asp:CustomValidator
                                                            ID="CustomValidator2" runat="server" ValidationGroup="2" ControlToValidate="txtKeyActorsPhoneNo"
                                                            ClientValidationFunction="isValidNumeric" Width="113px" ErrorMessage=" Please Give a Valid Input"></asp:CustomValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-left: 16px;" class="label" align="left">
                                                    Email
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtKeyActorsEmail" runat="server"></asp:TextBox><asp:RegularExpressionValidator
                                                        ID="RegularExpressionValidator2" runat="server" ValidationExpression="^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*\.(\w{2}|(com|net|org|edu|gov|biz|info))$"
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
                            </asp:WizardStep>
                            <asp:TemplatedWizardStep ID="tempwizeventgoal" runat="server" Title="Step 4:- EVENT GOALS"
                                StepType="Step">
                                <ContentTemplate>
                                    <table width="100%">
                                        <tr>
                                            <td nowrap colspan="2" style="text-align: left; background: #0E4A8F; width: 100%;
                                                height: 35px; color: #ffffff; padding: 0px 0px 0px 20px;">
                                                <asp:Label ID="label3" runat="server" Text="STEP-4: EVENT GOALS" Font-Size="14px"
                                                    Font-Bold="true" Font-Italic="FALSE" Width="187px"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top" style="padding-left: 20px; padding-top: 10px;">
                                                <asp:Label ID="lblEvent" runat="server" Text="Event Goals" Font-Bold="true"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-top: 20px;">
                                                <table style="margin-left: 40px;">
                                                    <tr>
                                                        <td valign="top">
                                                            <asp:CheckBox ID="cbpublicawareness" runat="server" Text="Public Awareness" CssClass="CheckBox"
                                                                Font-Size="10px" Style="float: left;" />
                                                            <asp:CheckBox ID="cbtechnology" runat="server" Text="Technology" CssClass="CheckBox"
                                                                Font-Size="10px" Style="float: left; margin: 0px 80px 0px 20px;" />
                                                            <asp:CheckBox ID="cbresearch" runat="server" Text="Research" CssClass="CheckBox"
                                                                Font-Size="10px" Style="float: left;" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top">
                                                            <asp:CheckBox ID="cbtraining" runat="server" Text="Training" CssClass="CheckBox"
                                                                Font-Size="10px" Style="float: left;" />
                                                            <asp:CheckBox ID="cbresourcedevelopment" runat="server" Text="Resource Development"
                                                                Font-Size="10px" Style="float: left; margin: 0px 20px 0px 72px;" CssClass="CheckBox" />
                                                            <asp:CheckBox ID="cbstrategicevents" runat="server" Text="Strategic Events" CssClass="CheckBox"
                                                                Font-Size="10px" Style="float: left;" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 189px; padding-left: 20px; padding-top: 40px;">
                                                <asp:Label ID="eventgoalsothers" runat="server" Width="11px" Text="OTHERS" CssClass="Label"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-left: 40px; padding-bottom: 30px;">
                                                <asp:TextBox ID="txteventgoalsothers" runat="server" TextMode="MultiLine" Height="100px"
                                                    Width="360px" CssClass="MultiLineTextbox"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                    <obout:Flyout runat="server" ID="Flyout3" AttachTo="cbpublicawareness" Align="MIDDLE"
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
                                    <obout:Flyout runat="server" ID="Flyout4" AttachTo="cbtechnology" Align="MIDDLE"
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
                                    <obout:Flyout runat="server" ID="Flyout5" AttachTo="cbresearch" Align="MIDDLE" CloseEvent="ONMOUSEOUT"
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
                                    <obout:Flyout runat="server" ID="Flyout6" AttachTo="cbtraining" Align="MIDDLE" CloseEvent="ONMOUSEOUT"
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
                                    <obout:Flyout runat="server" ID="Flyout7" AttachTo="cbresourcedevelopment" Align="MIDDLE"
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
                                    <obout:Flyout runat="server" ID="Flyout8" AttachTo="cbstrategicevents" Align="MIDDLE"
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
                                    <obout:Flyout runat="server" ID="Flyout20" AttachTo="eventgoalsothers" Align="MIDDLE"
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
                                </ContentTemplate>
                            </asp:TemplatedWizardStep>
                            <asp:TemplatedWizardStep ID="TemplatedWizardStep1" runat="server" Title="Step 5:- EVENT TYPE"
                                StepType="Step">
                                <ContentTemplate>
                                    <table width="100%">
                                        <tr>
                                            <td colspan="2" nowrap style="text-align: left; background: #0E4A8F; width: 100%;
                                                height: 35px; color: #ffffff; padding: 0px 0px 0px 20px;">
                                                <asp:Label ID="label4" runat="server" Text="STEP-5: EVENT Type" Font-Size="14px"
                                                    Font-Bold="true" Font-Italic="FALSE" Width="187px"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-left: 20px; padding-top: 10px;">
                                                <asp:Label ID="label3" runat="server" Text="Event Type" Font-Bold="true" Font-Italic="FALSE"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table style="margin-left: 40px;">
                                                    <tr>
                                                        <td valign="top" style="padding-top: 20px;">
                                                            <asp:CheckBox ID="cbcommunity" runat="server" Text="Community System Change" Font-Size="10px"
                                                                CssClass="CheckBox" Style="float: left;" />
                                                            <asp:CheckBox ID="cbmedia" runat="server" Text="Media" CssClass="CheckBox" Font-Size="10px"
                                                                Style="float: left; margin: 0px 23px 0px 5px;" />
                                                            <asp:CheckBox ID="cbcommunityaction" runat="server" Text="Community Action" CssClass="CheckBox"
                                                                Font-Size="10px" Style="float: left;" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top">
                                                            <asp:CheckBox ID="cbresources" runat="server" Text="Resources" CssClass="CheckBox"
                                                                Font-Size="10px" Style="float: left;" />
                                                            <asp:CheckBox ID="cbservices" runat="server" Text="Services" CssClass="CheckBox"
                                                                Font-Size="10px" Style="float: left; margin: 0px 8px 0px 85px;" />
                                                            <asp:CheckBox ID="cbplaning" runat="server" Text="Planning and Development" Font-Size="10px"
                                                                CssClass="CheckBox" Style="float: left;" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top">
                                                            <asp:CheckBox ID="cbcriticalevent" runat="server" Text="Critical Event" CssClass="CheckBox"
                                                                Font-Size="10px" Style="float: left;" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-left: 20px; padding-top: 20px;">
                                                <asp:Label ID="eventtypeothers" runat="server" Width="11px" Text="OTHERS" CssClass="Label"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-left: 40px; padding-top: 10px; padding-bottom: 25px;">
                                                <asp:TextBox ID="txteventtypeothers" runat="server" TextMode="MultiLine" Height="100px"
                                                    Width="380px" CssClass="MultiLineTextbox"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                    <obout:Flyout runat="server" ID="Flyout16" AttachTo="eventtypeothers" Align="MIDDLE"
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
                                    <obout:Flyout runat="server" ID="Flyout9" AttachTo="cbcommunity" Align="MIDDLE" CloseEvent="ONMOUSEOUT"
                                        CloseTime="20" DelayTime="20" FadingEffect="True" FlyingEffect="NONE" NoneEffect="False"
                                        OnClientClose="" OnClientInit="" OnClientOpen="" Opacity="100" OpenEvent="ONMOUSEOVER"
                                        OpenTime="250" Position="MIDDLE_RIGHT" RelativeLeft="0" RelativeTop="0" Resolution="10"
                                        SlidingEffect="NONE" SlidingRange="10" zIndex="0">
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
                                    <obout:Flyout runat="server" ID="Flyout10" AttachTo="cbmedia" Align="MIDDLE" CloseEvent="ONMOUSEOUT"
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
                                    <obout:Flyout runat="server" ID="Flyout11" AttachTo="cbcommunityaction" Align="MIDDLE"
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
                                    <obout:Flyout runat="server" ID="Flyout12" AttachTo="cbresources" Align="MIDDLE"
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
                                    <obout:Flyout runat="server" ID="Flyout13" AttachTo="cbservices" Align="MIDDLE" CloseEvent="ONMOUSEOUT"
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
                                    <obout:Flyout runat="server" ID="Flyout14" AttachTo="cbplaning" Align="MIDDLE" CloseEvent="ONMOUSEOUT"
                                        CloseTime="20" DelayTime="20" FadingEffect="True" FlyingEffect="NONE" NoneEffect="False"
                                        OnClientClose="" OnClientInit="" OnClientOpen="" Opacity="100" OpenEvent="ONMOUSEOVER"
                                        OpenTime="250" Position="MIDDLE_RIGHT" RelativeLeft="0" RelativeTop="0" Resolution="10"
                                        SlidingEffect="NONE" SlidingRange="10" zIndex="0">
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
                                    <obout:Flyout runat="server" ID="Flyout15" AttachTo="cbcriticalevent" Align="MIDDLE"
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
                                </ContentTemplate>
                            </asp:TemplatedWizardStep>
                            <asp:TemplatedWizardStep ID="TemplatedWizardStep2" runat="server" Title="Step 6:- EVENT COMMUNICATION"
                                StepType="Finish">
                                <ContentTemplate>
                                    <table width="100%">
                                        <tr>
                                            <td nowrap colspan="2" style="text-align: left; background: #0E4A8F; width: 100%;
                                                height: 35px; color: #ffffff; padding: 0px 0px 0px 20px;">
                                                <asp:Label ID="label4" runat="server" Text="STEP-6: EVENT COMMUNICATION" Font-Size="14px"
                                                    Font-Bold="true" Font-Italic="FALSE" Width="187px"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-left: 20px; padding-top: 10px;">
                                                <asp:Label ID="label3" runat="server" Text="Event Communication" Font-Bold="true"
                                                    Font-Italic="FALSE"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-top: 20px;">
                                                <table style="margin-left: 40px;">
                                                    <tr>
                                                        <td valign="top">
                                                            <asp:CheckBox ID="cbreport" runat="server" Text="Report" CssClass="CheckBox" Font-Size="7pt"
                                                                Style="float: left;" />
                                                            <asp:CheckBox ID="cbnews" runat="server" Text="News" CssClass="CheckBox" Font-Size="7pt"
                                                                Style="float: left; margin: 0px 30px 0px 80px;" />
                                                            <asp:CheckBox ID="cbspecial" runat="server" Text="Special" CssClass="CheckBox" Font-Size="7pt"
                                                                Style="float: left;" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:CheckBox ID="cbbestpractice" runat="server" Text="Best Practice" CssClass="CheckBox"
                                                                Font-Size="7pt" Style="float: left; margin-right: 52px;" />
                                                            <asp:CheckBox ID="cbemail" runat="server" Text="Email" CssClass="CheckBox" Font-Size="7pt"
                                                                Style="float: left;" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table>
                                                    <tr>
                                                        <td style="padding: 10px 0px 0px 20px;">
                                                            <asp:Label ID="lblemaillist" runat="server" Text="EMAIL LIST" CssClass="Label"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="padding: 10px 0px 0px 40px;">
                                                            <asp:TextBox ID="txtemaillist" runat="server" TextMode="MultiLine" Width="250px"
                                                                CssClass="MultiLineTextbox">
                                                            </asp:TextBox>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ErrorMessage="Enter the correct Email Id"
                                                                ControlToValidate="txtemaillist" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 185px; padding-left: 20px; padding-top: 10px;">
                                                <asp:Label ID="eventcommunicationothers" runat="server" Text="OTHERS" CssClass="Label"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 185px; padding-left: 40px; padding-top: 10px; padding-bottom: 20px;">
                                                <asp:TextBox ID="txteventcommunicationothers" runat="server" TextMode="MultiLine"
                                                    Height="100px" Width="380px" CssClass="MultiLineTextbox"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                    <obout:Flyout runat="server" ID="Flyout1" AttachTo="eventcommunicationothers" Align="MIDDLE"
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
                                    <obout:Flyout runat="server" ID="Flyout19" AttachTo="cbemail" Align="MIDDLE" CloseEvent="ONMOUSEOUT"
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
                                    <obout:Flyout runat="server" ID="Flyout17" AttachTo="cbreport" Align="MIDDLE" CloseEvent="ONMOUSEOUT"
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
                                    <obout:Flyout runat="server" ID="Flyout18" AttachTo="cbnews" Align="MIDDLE" CloseEvent="ONMOUSEOUT"
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
                                    <obout:Flyout runat="server" ID="Flyout22" AttachTo="cbspecial" Align="MIDDLE" CloseEvent="ONMOUSEOUT"
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
                                    <obout:Flyout runat="server" ID="Flyout23" AttachTo="cbbestpractice" Align="MIDDLE"
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
                                </ContentTemplate>
                            </asp:TemplatedWizardStep>
                            <asp:WizardStep ID="wizardcomplete" runat="server" Title="     " StepType="Complete">
                                <div style="margin: 20px 0px 0px 20px; text-align: center;">
                                    <asp:Label ID="label" runat="server" Font-Size="22px"></asp:Label>
                                </div>
                            </asp:WizardStep>
                        </WizardSteps>
                        <StepStyle BackColor="Transparent" />
                        <FinishCompleteButtonStyle CssClass="finishbutton" />
                        <HeaderStyle CssClass="finishbutton" />
                        <StartNextButtonStyle CssClass="finishbutton" />
                        <StepPreviousButtonStyle CssClass="finishbutton" />
                        <StepNextButtonStyle CssClass="finishbutton" />
                        <FinishPreviousButtonStyle CssClass="finishbutton" />
                        <NavigationButtonStyle CssClass="finishbutton" />
                    </asp:Wizard>
                </td>
            </tr>
        </table>
        <%--
        <script type="text/javascript" language="javascript">
            InitializeCalendar('');
        </script>--%>
    </div>
</asp:Content>
