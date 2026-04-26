<%@ page language="C#" masterpagefile="Event1.master" enableeventvalidation="false" autoeventwireup="true" inherits="_Contactinfo, App_Web_contactinfo.aspx.cdcab7d2" %>

<asp:Content ID="cp1" ContentPlaceHolderID="Main" runat="server">

 <%--   <script language="javascript" type="text/javascript" src="Javascript/SysScript.js"></script>--%>
<script language="javascript" type="text/javascript">
    var btnSaveId = '<%= this.BtCreateNewContact.ClientID %>';
    function CheckValidNameFields(evt) {

        if ((evt.which && evt.which == 13) || (evt.keyCode && evt.keyCode == 13)) {
            ClickButton(btnSaveId);
            return (false);
        }
        else {
            if (evt.keyCode != 16) {
                var charCode = (evt.which) ? evt.which : event.keyCode;
                if (charCode == 39 || charCode == 45 || charCode == 46 || charCode == 222 || charCode == 189 || charCode == 190) {
                    return (true);
                }
                else {
                    if ((charCode < 65 || charCode > 90) && (charCode < 97 || charCode > 122) && charCode != Sys.UI.Key.backspace && charCode != Sys.UI.Key.tab && charCode != Sys.UI.Key.space && charCode != 16 && charCode != 17 && charCode != 18 && charCode != 20 && charCode != Sys.UI.Key.down && charCode != Sys.UI.Key.up && charCode != Sys.UI.Key.right && charCode != Sys.UI.Key.left) {

                        return (false);
                    }
                    else {
                        return (true);
                    }
                }
            }
        }
    }</script>


<script language="javascript" type="text/javascript">
    var btnSaveId = '<%= this.BtCreateNewContact.ClientID %>';
    function checkvalidtextandnumbers(evt) {

        if ((evt.which && evt.which == 13) || (evt.keyCode && evt.keyCode == 13)) {
            ClickButton(btnSaveId);
            return (false);
        }
        else {
            if (evt.keyCode != 16) {
                var charCode = (evt.which) ? evt.which : event.keyCode;
                if (charCode == 39 || charCode == 45 || charCode == 46 || charCode == 222 || charCode == 189 || charCode == 190) {
                    return (true);
                }
                else {
                    if ((charCode < 65 || charCode > 90) && (charCode < 97 || charCode > 122) && charCode != Sys.UI.Key.backspace && charCode != Sys.UI.Key.tab && charCode != Sys.UI.Key.space && charCode != 16 && charCode != 17 && charCode != 18 && charCode != 20 && charCode != Sys.UI.Key.down && charCode != Sys.UI.Key.up && charCode != Sys.UI.Key.right && charCode != Sys.UI.Key.left) {

                        return (false);
                    }
                    else {
                        return (true);
                    }
                }
            }
        }
    }</script>
    

    <%-- this is for only text with numbers--%>

    

    <asp:Panel ID="pnlMessage" runat="server" Visible="false">
        <div style="margin: 20px 0px 0px 20px; text-align: center;">
            <asp:Label ID="lblMainMessage" runat="server" Font-Size="22px"></asp:Label>
        </div>
    </asp:Panel>
    <asp:Panel ID="mainPannel" runat="server">
        <!--alert('Please enter valid name');-->

        <script src="Javascript/Validation.js" type="text/javascript"></script>

        <div style="text-align: left; margin-top: 25px;">
            <center>
                <span style="font: 22px arial; color: red">CONTACT INFORMATION </span>
            </center>
            <table border="0" align="center" style="font: 11px tahoma; padding-left: 20px; margin-top: 10px;"
                width="90%" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="3">
                        <asp:Label ID="lblError" runat="server" CssClass="Label" Visible="False" ForeColor="Red"
                            Height="29px"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <div style="float: left; border: 1px solid #B0BEC7; background: #EDF2F5; width: 28%;
                            padding: 10px;height:40%;">
                            <table>
                                <tr>
                                    <td align="left">
                                        <p style="float: left; background-image: url(Images/bg.png); color: #18397C; font: bold 14px arial;
                                            padding: 0px 2px 3p 0pxs">
                                            User Information
                                        </p>
                                    </td>
                                </tr>
                            </table>
                            <table>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="lblTitle" runat="server" Text="Title" CssClass="Label" Width="60px"
                                            meta:resourcekey="lblTitleResource1"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlTitle" runat="server" meta:resourcekey="ddlTitleResource1"
                                            Width="60px" Style="font: 11px tahoma; outline: none;">
                                            <asp:ListItem meta:resourcekey="ListItemResource1" Value="0" Text="-Select-"></asp:ListItem>
                                            <asp:ListItem meta:resourcekey="ListItemResource2" Text="Mr."></asp:ListItem>
                                            <asp:ListItem meta:resourcekey="ListItemResource3" Text="Miss."></asp:ListItem>
                                            <asp:ListItem meta:resourcekey="ListItemResource4" Text="Mrs."></asp:ListItem>
                                            <asp:ListItem meta:resourcekey="ListItemResource5" Text="Dr."></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td align="left">
                                        <asp:RequiredFieldValidator ID="rfvTitle" runat="server" ValidationGroup="1" ControlToValidate="ddlTitle"
                                            ErrorMessage="Select the title" InitialValue="--Select--" Font-Size="XX-Small"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="lblFirstName" runat="server" Text="First Name" CssClass="Label" meta:resourcekey="lblFirstNameResource1"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtFirstName" runat="server" meta:resourcekey="txtFirstNameResource1"
                                            Width="90px" Style="margin: 0px 0px 0px 0px; outline: none;" OnKeydown="javascript:return CheckValidNameFields(event);"></asp:TextBox>
                                    </td>
                                    <td align="left">
                                        <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ControlToValidate="txtFirstName"
                                            Style="float: left; clear: left" ErrorMessage="Enter the firstname" ValidationGroup="1"
                                            Font-Size="xx-Small" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <%-- <asp:RegularExpressionValidator ID="revFirstName" runat="server" ControlToValidate="txtFirstName"
                                        Display="Dynamic" ErrorMessage="Enter Valid name" Font-Size="XX-Small" Style="float: left;
                                        clear: left" ValidationExpression="^([0-9a-zA-Z]+([_.-]?[0-9a-zA-Z]+)*[0-9 a-zA-Z]+[0-9,a-z,A-Z,.,-]*(.){0}[a-zA-Z]{0})+$"
                                        ValidationGroup="1"></asp:RegularExpressionValidator>--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="lblMiddleName" runat="server" Text="Middle Name" CssClass="Label"
                                            meta:resourcekey="lblMiddleNameResource1"></asp:Label>
                                    </td>
                                    <td align="left" colspan="2">
                                        <asp:TextBox ID="txtMiddleName" runat="server" meta:resourcekey="txtMiddleNameResource1"
                                            Width="30px" Style="outline: none" MaxLength="10" OnKeydown="javascript:return CheckValidNameFields(event);"></asp:TextBox>
                                        <%--<asp:RegularExpressionValidator ID="revMiddleName" runat="server" ControlToValidate="txtMiddleName"
                                        Display="Dynamic" ErrorMessage="Enter Valid Name" Font-Size="XX-Small" ValidationExpression="^[a-zA-Z0-9-_\.]+"
                                        ValidationGroup="1"></asp:RegularExpressionValidator>--%>
                                    </td>
                                </tr>
                            </table>
                            <!--this is convert sapn to table completes -->
                            <table>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="lblLastName" runat="server" Text="Last Name" Width="60px" CssClass="Label"
                                            meta:resourcekey="lblLastNameResource1"></asp:Label>
                                    </td>
                                    <td align="left" class="td">
                                        <asp:TextBox ID="txtLastName" runat="server" Width="90px" meta:resourcekey="txtLastNameResource1"
                                            Style="outline: none" OnKeydown="javascript:return CheckValidNameFields(event);"></asp:TextBox>
                                    </td>
                                    <td align="left">
                                        <asp:RequiredFieldValidator ID="rfvLastName" runat="server" ControlToValidate="txtLastName"
                                            ErrorMessage="Enter the Last name" Style="float: left; clear: left" ValidationGroup="1"
                                            Font-Size="xx-Small" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <%--   <asp:RegularExpressionValidator ID="revLastName" runat="server" ControlToValidate="txtLastName"
                                        Display="Dynamic" Font-Size="XX-Small" ValidationExpression="^([0-9a-zA-Z]+([_.-]?[0-9a-zA-Z]+)*[0-9 a-zA-Z]+[0-9,a-z,A-Z,.,-]*(.){0}[a-zA-Z]{0})+$"
                                        ValidationGroup="1"></asp:RegularExpressionValidator>--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="lblJobTitle" runat="server" Width="60px" Text="Job Title" CssClass="Label"
                                            meta:resourcekey="lblJobTitleResource1"></asp:Label>
                                    </td>
                                    <td align="left" class="td">
                                        <asp:TextBox ID="txtJobTitle" runat="server" Width="90px" meta:resourcekey="txtJobTitleResource1"
                                            Style="outline: none"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" colspan="2">
                                        <asp:CustomValidator ID="cvJobTitle" runat="server" ControlToValidate="txtJobTitle"
                                            ErrorMessage="Enter the valid Job title" ClientValidationFunction="isAlphanumeric"
                                            Display="Dynamic" ValidationGroup="1" Font-Size="xx-Small"></asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="lblCompany" runat="server" Text="Company" Width="60px" CssClass="Label"
                                            meta:resourcekey="lblCompanyResource1"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtCompany" runat="server" Width="90px" meta:resourcekey="txtCompanyResource1"
                                            Style="outline: none"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" colspan="2">
                                        <asp:RequiredFieldValidator ID="rvCompany" runat="server" ControlToValidate="txtCompany"
                                            ErrorMessage="Enter the Company Name" Style="float: left; clear: left" ValidationGroup="1"
                                            Font-Size="xx-Small" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="revCompany" runat="server" ControlToValidate="txtCompany"
                                            Display="Dynamic" ErrorMessage="Enter Valid Company Name" Style="float: left;
                                            clear: left" Font-Size="XX-Small" ValidationExpression="^([0-9a-zA-Z]+([_.-]?[0-9a-zA-Z/]+)*[0-9 a-zA-Z]+[0-9,a-z,A-Z,.,-]*(.){0}[a-zA-Z]{0})+$"
                                            ValidationGroup="1"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                            </table>
                            <table>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="lblWebsite" runat="server" Width="60px" Text="Website" CssClass="Label"
                                            meta:resourcekey="lblWebsiteResource1"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtWebsite" runat="server" Width="150px" meta:resourcekey="txtWebsiteResource1"
                                            Style="outline: none"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" colspan="2">
                                        <asp:RegularExpressionValidator ID="revWebsite" runat="server" ControlToValidate="txtWebsite"
                                            Display="Dynamic" ErrorMessage="Enter the valid website" Font-Size="XX-Small"
                                            ValidationExpression="([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)?" ValidationGroup="1"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                            </table>
                            <table>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="lblMobile" runat="server" Text="Mobile" Width="60px" CssClass="Label"
                                            meta:resourcekey="lblMobileResource1"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtMobile" runat="server" MaxLength="10" Width="80px" meta:resourcekey="txtMobileResource1"
                                            Style="outline: none"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" colspan="2">
                                        <asp:RegularExpressionValidator ID="revMobile" runat="server" ControlToValidate="txtMobile"
                                            Display="Dynamic" ErrorMessage="Enter Ten Digit Phone Number" Style="float: left;
                                            clear: left" Font-Size="XX-Small" ValidationExpression="\d{10}" ValidationGroup="1"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="lblFax" runat="server" Text="Fax" Width="60px" CssClass="Label" meta:resourcekey="lblFaxResource1"></asp:Label>
                                    </td>
                                    <td align="left" class="td">
                                        <asp:TextBox ID="txtFax" runat="server" Width="80px" meta:resourcekey="txtFaxResource1"
                                            Style="outline: none" MaxLength="10"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" colspan="2">
                                        <asp:RegularExpressionValidator ID="revFax" runat="server" Font-Size="XXSmall" ErrorMessage="Enter Ten Digit Phone Number"
                                            ControlToValidate="txtFax" Display="Dynamic" ValidationExpression="\d{10}" ValidationGroup="1"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="lblOrganization" runat="server" Width="60px" Text="Organization" CssClass="Label"
                                            meta:resourcekey="lblOrganizationResource1"></asp:Label>
                                    </td>
                                    <td align="left" class="td">
                                        <asp:TextBox ID="txtOrganization" Width="120px" runat="server" meta:resourcekey="txtOrganizationResource1"
                                            Style="outline: none"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" colspan="2">
<%--                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" Style="float: left;
                                            clear: left" runat="server" ControlToValidate="txtOrganization" Display="Dynamic"
                                            ErrorMessage="Enter Valid Organization" Font-Size="XX-Small" ValidationExpression="^([0-9a-zA-Z]+([_.-]?[0-9a-zA-Z/]+)*[0-9 a-zA-Z]+[0-9,a-z,A-Z,.,-]*(.){0}[a-zA-Z]{0})+$"
                                            ValidationGroup="1"></asp:RegularExpressionValidator>--%>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div style="float: left; border: 1px solid #B0BEC7; background: #EDF2F5; width: 28%;
                            padding: 10px 10px 50px 10px; margin: 0px 10px 0px 10px;height:275px;">
                            <table>
                                <tr>
                                    <td>
                                        <p style="float: left; background-image: url(Images/bg.png); color: #18397C; font: bold 14px arial;">
                                            Official Address
                                        </p>
                                    </td>
                                </tr>
                            </table>
                            <table>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="lblStreet" runat="server" Width="90" Text="Street" CssClass="Label"
                                            meta:resourcekey="lblStreetResource1"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtStreet" runat="server" meta:resourcekey="txtStreetResource1"
                                            Width="90px" Style="outline: none;"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:CustomValidator ID="cvStreet" runat="server" ClientValidationFunction="alphanumeric"
                                            ControlToValidate="txtStreet" Display="Dynamic" ErrorMessage="Enter the valid street name"
                                            Font-Size="XX-Small" Style="float: left; clear: left" ValidationGroup="1"></asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblCity" runat="server" CssClass="Label" meta:resourcekey="lblCityResource1"
                                            Width="90" Text="City"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtCity" runat="server" meta:resourcekey="txtCityResource1" Width="90px"
                                            Style="outline: none;"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:CustomValidator ID="cvCity" runat="server" ClientValidationFunction="isAlphanumeric"
                                            ControlToValidate="txtCity" Display="Dynamic" ErrorMessage="Enter a valid city name"
                                            Font-Size="xx-Small" Style="float: left; clear: left" ValidationGroup="1"></asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="lblState" runat="server" CssClass="Label" meta:resourcekey="lblStateResource1"
                                            Width="90" Style="float: left;" Text="State"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlState" runat="server" DataTextField="State" meta:resourcekey="ddlStateResource1"
                                            Style="font: 11px tahoma; float: left; outline: none;" Width="110px">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:RequiredFieldValidator ID="rfvState" runat="server" ControlToValidate="ddlState"
                                            Display="dynamic" ErrorMessage="Select the state" Font-Size="XX-Small" InitialValue="--Select--"
                                            Style="float: left; clear: left" ValidationGroup="1" Width="124px"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="lblCountry" runat="server" CssClass="Label" meta:resourcekey="lblCountryResource1"
                                            Width="90" Text="Country"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtCountry" runat="server" meta:resourcekey="txtCountryResource1"
                                            Width="90px" Style="outline: none;"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:CustomValidator ID="cvCountry" runat="server" ClientValidationFunction="isAlphanumeric"
                                            ControlToValidate="txtCountry" Display="Dynamic" ErrorMessage="Enter a valid country name"
                                            Font-Size="xx-Small" Style="float: left; clear: left" ValidationGroup="1"></asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="lblZip" runat="server" CssClass="Label" meta:resourcekey="lblZipResource1"
                                            Width="90" Text="Zip"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtZip" runat="server" meta:resourcekey="txtZipResource1" Width="30px"
                                            Style="outline: none;"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:CompareValidator ID="cvZip" runat="server" ControlToValidate="txtZip" Display="Dynamic"
                                            ErrorMessage="Enter a valid zipcode" Font-Size="xx-Small" Operator="DataTypeCheck"
                                            Style="float: left; clear: left" Type="integer" ValidationGroup="1"></asp:CompareValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="lblOfficialEmail" runat="server" CssClass="Label" meta:resourcekey="lblOfficialEmailResource1"
                                            Width="90" Text="Official Email"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtOfficialEmail" runat="server" meta:resourcekey="txtOfficialEmailResource1"
                                            Width="120px" Style="outline: none;"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" colspan="2">
                                        <asp:RegularExpressionValidator ID="revOfficialEmail" runat="server" ControlToValidate="txtOfficialEmail"
                                            Display="Dynamic" ErrorMessage="Enter valid e-mail address" Font-Size="xx-Small"
                                            SetFocusOnError="True" ValidationExpression="^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*\.(\w{2}|(com|net|org|edu|gov|biz|info))$"
                                            ValidationGroup="1"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="lblOfficePhone" runat="server" CssClass="Label" meta:resourcekey="lblOfficePhoneResource1"
                                            Style="float: left;" Text="Office Phone" Width="90"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtOfficePhone" runat="server" MaxLength="10" meta:resourcekey="txtOfficePhoneResource1"
                                            Style="float: left; padding: 2px 0px 2px 0px; outline: none" Width="80px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" colspan="2">
                                        <asp:RegularExpressionValidator ID="revOfficePhone" runat="server" ControlToValidate="txtOfficePhone"
                                            ErrorMessage="Enter Ten Digit Phone Number" Font-Size="XXSmall" Style="float: left;
                                            clear: left" ValidationExpression="\d{10}" ValidationGroup="1" Width="129px"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div style="float: left; border: 1px solid #B0BEC7; background: #EDF2F5; width: 28%;
                            padding: 10px 10px 50px 10px;height:275px;">
                            <table>
                                <tr>
                                    <td>
                                        <p style="float: left; background-image: url(Images/bg.png); color: #18397C; font: bold 14px arial;">
                                            Personal Address
                                        </p>
                                    </td>
                                </tr>
                            </table>
                            <table>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="lblStreet1" runat="server" Text="Street" CssClass="Label" meta:resourcekey="lblStreetResource1"
                                            Width="90px"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtStreet1" runat="server" meta:resourcekey="txtStreetResource1"
                                            Width="90px" Style="outline: none;"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" colspan="2">
                                        <asp:CustomValidator ID="cvStreet1" runat="server" ControlToValidate="txtStreet1"
                                            ErrorMessage="Enter the valid street name" ClientValidationFunction="alphanumeric"
                                            Display="Dynamic" ValidationGroup="1" Font-Size="XX-Small"></asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="lblCity1" runat="server" Text="City" CssClass="Label" meta:resourcekey="lblCityResource1"
                                            Width="90px"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtCity1" runat="server" meta:resourcekey="txtCityResource1" Width="90px"
                                            Style="outline: none;"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="left">
                                        <asp:CustomValidator ID="cvCity1" runat="server" ControlToValidate="txtCity1" ErrorMessage="Enter a valid city name"
                                            ClientValidationFunction="isAlphanumeric" Display="Dynamic" ValidationGroup="1"
                                            Font-Size="xx-Small"></asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="lblState1" runat="server" Text="State" CssClass="Label" Style="float: left;
                                            margin: 4px 0px 0px 3px;" meta:resourcekey="lblStateResource1" Width="90px"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlState1" runat="server" meta:resourcekey="ddlStateResource1"
                                            Style="font: 11px tahoma; float: left;" Width="110px" DataTextField="State">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="left">
                                        <asp:RequiredFieldValidator ID="rfvState1" runat="server" Style="float: left;" ValidationGroup="1"
                                            ControlToValidate="ddlState1" ErrorMessage="Select the state" InitialValue="--Select--"
                                            Display="dynamic" Font-Size="XX-Small"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="lblCountry1" runat="server" Text="Country" CssClass="Label" meta:resourcekey="lblCountryResource1"
                                            Width="90px"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtCountry1" runat="server" meta:resourcekey="txtCountryResource1"
                                            Width="90px" Style="outline: none;"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="left">
                                        <asp:CustomValidator ID="cvCountry1" runat="server" ControlToValidate="txtCountry1"
                                            ErrorMessage="Enter a valid country name" ClientValidationFunction="isAlphanumeric"
                                            Display="Dynamic" ValidationGroup="1" Font-Size="xx-Small"></asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="lblZip1" runat="server" Text="Zip" CssClass="Label" meta:resourcekey="lblZipResource1"
                                            Width="90px"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtZip1" runat="server" meta:resourcekey="txtZipResource1" Width="30px"
                                            Style="outline: none;"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="left">
                                        <asp:CompareValidator ID="cvZip1" runat="server" ControlToValidate="txtZip1" ErrorMessage="Enter a valid zipcode"
                                            Operator="DataTypeCheck" Type="integer" ValidationGroup="1" Font-Size="xx-Small"
                                            Display="Dynamic"></asp:CompareValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="lblPersonalEmail" runat="server" Text="Personal Email" CssClass="Label"
                                            Width="90px" meta:resourcekey="lblPresonalEmailResource1"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtPersonalEmail" runat="server" meta:resourcekey="txtPersonalEmailResource1"
                                            Width="120px" Style="outline: none;"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" colspan="2">
                                        <asp:RegularExpressionValidator ID="revPersonalEmail" runat="server" ControlToValidate="txtPersonalEmail"
                                            ErrorMessage="give a valid e-mail address" ValidationExpression="^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*\.(\w{2}|(com|net|org|edu|gov|biz|info))$"
                                            ValidationGroup="1" Display="Dynamic" SetFocusOnError="True" Font-Size="xx-Small"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="lblHomePhone" runat="server" Text="Home Phone" CssClass="Label" Style="float: left;
                                            margin: 0px 0px 0px 0px;" Width="90px" meta:resourcekey="lblHomePhoneResource1"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtHomePhone" runat="server" MaxLength="10" Width="80px" Style="float: left;
                                            margin: 0px 0px 0px 0px; outline: none;" meta:resourcekey="txtHomePhoneResource1"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" colspan="2">
                                        <asp:RegularExpressionValidator ID="revHomePhone" runat="server" Font-Size="XXSmall"
                                            Style="float: left;" ErrorMessage="Enter Ten Digit Phone Number" ControlToValidate="txtHomePhone"
                                            ValidationExpression="\d{10}" ValidationGroup="1"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td valign="top" style="padding: 10px 0px 0px 0px;">
                        <div style="float: left; border: 1px solid #B0BEC7; background: #EDF2F5; width: 350px;
                            padding: 0px 10px 40px 0px; height: auto; margin: 0px 0px 0px 10px;">
                            <table width="100%">
                                <tr>
                                    <td colspan="2" colspan="2" style="padding: 10px 10px 10px 20px; background-image: url(Images/bg.png);
                                        color: #18397C; font: bold 14px arial;">
                                        Volunteer Roles
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="width: 100%; padding: 10px 10px 10px 90px;">
                                        <asp:CheckBox ID="cbEnable" runat="server" CssClass="Label" meta:resourcekey="cbSponsorResource1"
                                            Style="float: left; width: auto; outline: none;" Text="Enable" Visible="false" />
                                        <asp:CheckBox ID="cbPending" runat="server" CssClass="Label" meta:resourcekey="cbSponsorResource1"
                                            Style="float: left; width: auto; outline: none;" Text="Pending" Visible="false" />
                                        <asp:CheckBox ID="cbActor" runat="server" CssClass="Label" meta:resourcekey="cbActorResource1"
                                            Style="float: left; width: auto; outline: none;" Text="Actor" />
                                        <asp:CheckBox ID="cbSponsor" runat="server" CssClass="Label" meta:resourcekey="cbSponsorResource1"
                                            Style="float: left; width: auto;" Text="Sponsor" />
                                        <asp:CheckBox ID="cbRecorder" runat="server" CssClass="Label" meta:resourcekey="cbRecorderResource1"
                                            Style="float: left; width: auto; outline: none" Text="Recorder" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: auto; padding: 10px 0px 10px 20px;">
                                        <asp:Label ID="lblRoles" runat="server" CssClass="Label" meta:resourcekey="lblOrganizationResource1"
                                            Text="EventTracker Roles"></asp:Label>
                                    </td>
                                    <td align="left" style="width: auto; padding-right: 110px;">
                                        <asp:DropDownList ID="ddlRoles" runat="server" DataTextField="RoleName" DataValueField="RoleID"
                                            Width="80px">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div style="float: left; border: 1px solid #B0BEC7; background: #EDF2F5; width: 350px;
                            padding: 10px; margin: 0px 0px 0px 10px; height: 135px;">
                            <table>
                                <tr>
                                    <td align="left" style="float: left; background-image: url(Images/bg.png); color: #18397C;
                                        font: bold 14px arial;">
                                        Login Information
                                    </td>
                                </tr>
                            </table>
                            <table>
                                <tr>
                                    <td align="left" colspan="2">
                                        <asp:CheckBox ID="changepwd" Text="Set/Change User Name and Password" AutoPostBack="true"
                                            runat="server" OnCheckedChanged="changepwd_CheckedChanged" />
                                        <asp:CheckBox ID="conformpwd" Visible="false" Text="Conform Password" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="lblUserName" runat="server" Text="User Name" CssClass="Label" meta:resourcekey="lblUserNameResource1"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtUserName" runat="server" meta:resourcekey="txtUserNasmeResource1"
                                            Style="outline: none;" Width="149px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="left">
                                        <asp:RegularExpressionValidator ID="revUserName" runat="server" ControlToValidate="txtUserName"
                                            Display="Dynamic" ErrorMessage="Enter Valid User Name" Font-Size="XX-Small" ValidationExpression="^([0-9a-zA-Z]+([_.-]?[0-9a-zA-Z]+)*[0-9 a-zA-Z]+[0-9,a-z,A-Z,.,-]*(.){0}[a-zA-Z]{0})+$"
                                            ValidationGroup="1"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="lblPassword" runat="server" Text="Password" CssClass="Label" meta:resourcekey="lblPasswordResource1"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" meta:resourcekey="txtPasswordResource1"
                                            Width="149px" Style="outline: none;"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="lblConfirm" runat="server" Text="Comfirm Pwd" CssClass="Label" meta:resourcekey="lblPasswordResource1"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtConfirm" runat="server" TextMode="Password" meta:resourcekey="txtPasswordResource1"
                                            Width="149px" Style="outline: none;"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" colspan="2">
                                        <asp:CompareValidator ID="valComparePassword" runat="server" ErrorMessage="Please Give Correct Password"
                                            Display="dynamic" ControlToCompare="txtPassword" ControlToValidate="txtConfirm"></asp:CompareValidator>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td valign="top" colspan="3" style="padding-bottom: 10px;">
                        <p style="float: left; margin: 10px 0px 0px 290px; display: inline;">
                            <asp:Button ID="BtCreateNewContact" runat="server" Text="Create" ValidationGroup="1"
                                CssClass="finishbutton" OnClick="BtCreateNewContact_Click" meta:resourcekey="Button1Resource1" />
                            <asp:Button ID="BtUpdate" runat="server" Text="Update" ValidationGroup="1" CssClass="finishbutton"
                                OnClick="BtUpdate_Click" meta:resourcekey="Button2Resource1" />
                            <asp:Button ID="BtCancel" runat="server" Text="Cancel" CssClass="finishbutton" meta:resourcekey="Button3Resource1"
                                OnClick="BtCancel_Click" />
                        </p>
                    </td>
                </tr>
            </table>
        </div>
    </asp:Panel>
</asp:Content>
