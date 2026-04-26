<%@ page language="C#" autoeventwireup="true" inherits="login, App_Web_login.aspx.cdcab7d2" title="Login Page" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>OHATS Organisational History and Accommplishment Tracking System</title>
    <link rel="stylesheet" type="text/css" href="menu/anylink.css" />
    <link rel="stylesheet" type="text/css" href="CSS/pflaws.css" />

    <script language="javascript" type="text/javascript" src="Javascript/SysScript.js"></script>

    <script language="javascript" type="text/javascript" src="menu/anylink.js">        function IMG1_onclick() {

        }
        
    </script>

    <script language="javascript" type="text/javascript">
        var btnSaveId = '<%= this.Submit.ClientID %>';
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

</head>
<body>
    <form id="form1" runat="server">
    <div align="center">
        <%--<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">--%>
        
       <%--  alert('Please enter valid name');--%>
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td align="center">
                    <table width="94%" cellpadding="0" cellspacing="0" border="0" style="border-bottom: 4px solid green">
                        <tr>
                            <td rowspan="2" valign="bottom" style="padding-top:3px">
                                <img src="Image/OHATS.jpg" alt="Tutor Mentor Connection's Tool" style="float: left;" />
                            </td>
                            <td valign="top" align="right" style="display:none" >
                                <a href="http://www.vattsystems.com/" target="_parent">
                                    <object width="207" height="56">
                                        <param name="movie" value="banner.swf">
                                        <embed src="flash/vattbanner.swf" width="207" height="56"></embed></object></a>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 19px;">
                                <div style="float: right; margin: 0px 20px 0px 0px; display: inline;">
                                    <a href="Home.aspx" class="menu" style="float: left;">
                                        <asp:Label ID="lblHome" runat="server" Text="Home " ToolTip="Home"></asp:Label>
                                    </a><span style="font-size: 12px; padding-left: 5px; float: left;">|</span> <a href="Metrics.aspx"
                                        class="menu" style="padding-left: 5px; float: left;">
                                        <asp:Label ID="Label1" runat="server" ToolTip="Metrics" Text="Metrics"></asp:Label>
                                    </a><span style="font-size: 12px; padding-left: 5px; float: left;">|</span> <a href="AdvancedMetrics.aspx"
                                        class="menu" style="position: relative; margin: 0px 0px 0px -16px; float: left;">
                                        <asp:Label ID="Label2" runat="server" ToolTip="Advanced Metrics" Text="Advanced Metrics">
                                        </asp:Label>
                                    </a><span style="font-size: 12px; padding-left: 5px; float: left;">|</span> <a href="http://www.tutormentorconnections.org"
                                        class="menu" style="padding-left: 5px; float: left;" onclick="return clickreturnvalue()"
                                        onmouseover="dropdownmenu(this, event, 'Div1')">
                                        <asp:Label ID="Label4" runat="server" ToolTip="Help" Text="Help"></asp:Label>
                                    </a><a href="login.aspx" class="menu">
                                        <asp:Label ID="Label5" runat="server" ToolTip="Login" Text="Login"></asp:Label>
                                    </a>
                                </div>
                                <div id="Div1" class="anylinkcss">
                                    <a href="EventHelpcreate.aspx" target="_blank" style="font-size: 10px; font-weight: 500;
                                        color: #0074c4; font-family: Arial, Helvetica, sans-serif;">>&nbsp;&nbsp;Create
                                        Event</a> <a href="UpDateHelp.aspx" target="_blank" style="font-size: 10px; font-weight: 500;
                                            color: #0074c4; font-family: Arial, Helvetica, sans-serif;">>&nbsp;&nbsp;Update
                                            Event</a>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <%--<close two table continue div only>--%>
        <div align="center">
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        <br />
                        <table border="0" cellpadding="0" cellspacing="0" style="padding: 0% 10% 10% 10%">
                            <tr>
                                <td valign="top">
                                    <table border="0" cellpadding="0" cellspacing="0" style="border: 1px solid #BBC7E5;
                                        background: #dee6f0;">
                                        <tr>
                                            <td colspan="2">
                                                <img src="Image/log.jpg" style="float: left; width: 270px;" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="width: 250px; text-align: left; padding: 10px 0px 10px 0px;">
                                                <table border="0" cellpadding="0" cellspacing="0" background="#DEE6F0;" style="margin: 0px 0px 0px 10px;">
                                                    <tr>
                                                        <td valign="top" colspan="2">
                                                            <asp:Label ID="lblError" ForeColor="red" EnableViewState="false" runat="Server" CssClass="valid" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top">
                                                            <asp:Label ID="username" runat="server" Text="USERNAME" CssClass="logintext"></asp:Label>
                                                        </td>
                                                        <td valign="top">
                                                            <asp:TextBox ID="txtUsername" runat="server" CssClass="textfield" Style="margin: 0px 0px 0px 0px;"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ControlToValidate="txtUsername" CssClass="logintext"
                                                                ErrorMessage="Enter  username" runat="server" ValidationGroup="1" ID="RequiredFieldValidator2"
                                                                Style="float: left; clear: left;" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top">
                                                            <asp:Label ID="pswd" runat="server" Text="PASSWORD" CssClass="logintext"></asp:Label>
                                                        </td>
                                                        <td valign="top">
                                                            <asp:TextBox ID="txtPassword" runat="server" CssClass="textfield" TextMode="Password"
                                                                Style="margin: 0px 0px 0px 0px;"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ControlToValidate="txtPassword" CssClass="logintext"
                                                                ErrorMessage="Enter  password" runat="server" ValidationGroup="1" ID="RequiredFieldValidator1"
                                                                Style="float: left; clear: left;" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 200px; padding-left: 60px;" colspan="2">
                                                            <asp:CheckBox ID="chkRemember" CssClass="logintext" Text="Remember Login" runat="Server" style="outline:none;" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 200px; padding-left: 80px;" colspan="2">
                                                            <asp:Label ID="lblCaptcha" runat="server" Width="150px" Font-Bold="True" Font-Size="15"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 200px;padding:2px 20px 2px 10px;" colspan="2" align="center">
                                                            <asp:Label ID="lblCMessage" runat="server" ForeColor="Red" CssClass="valid"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 200px; padding-left: 60px;" colspan="2">
                                                            <asp:TextBox ID="txtCaptcha" runat="server" CssClass="textfieldmid"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left" style="width: 100px; padding-left: 35px; padding-top: 10px;">
                                                            <asp:Button Text="sign-in" runat="server" ID="Button3" ToolTip="sign-in" OnClick="Login"
                                                                ValidationGroup="1" CssClass="finishbutton" />
                                                        </td>
                                                        <td align="left" style="width: 107px; padding-left: 0px; padding-top: 10px;">
                                                            <asp:Button Text="Cancel" runat="server" ID="LoginCancel" ToolTip="Cancel" OnClick="LoginCancel_Click"
                                                                CssClass="finishbutton" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td valign="top" style="width: 2%;">
                                </td>
                                <td valign="top" style="width: 62%;">
                                    <table border="0" cellpadding="0" cellspacing="0" width="50%">
                                        <tr>
                                            <td align="center" valign="top" style="width: 50%;">
                                                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border: 1px solid #BBC7E5;
                                                    background: #dee6f0;">
                                                    <tr>
                                                        <td colspan="4">
                                                            <img src="Image/reg.jpg" style="float: left;" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="" align="center" colspan="2" valign="top">
                                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                                <tr>
                                                                    <td style="" colspan="4" valign="top" align="center">
                                                                        <asp:Label ID="lblerrormsg" ForeColor="red" EnableViewState="false" runat="Server"
                                                                            CssClass="valid" />
                                                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                                            <tr>
                                                                                <td valign="top" colspan="4">
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td colspan="4" align="left" style="padding: 2px 0px 0px 10px; font: 12px arial;
                                                                                    color: #525251">
                                                                                    <asp:Label ID="Label9" runat="server" Text="Personal Information" Font-Bold=" True"
                                                                                        Font-Size="Small"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="" colspan="4" align="left">
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="width: 100px;" align="right">
                                                                                    <asp:Label ID="LBLfname" runat="server" Text="FIRST NAME" CssClass="logintext"></asp:Label>
                                                                                </td>
                                                                                <td align="left" style="padding-top: 10px; padding-left: 5px;">
                                                                                    <asp:TextBox ID="txtfname" runat="server" CssClass="textfield" OnKeydown="javascript:return CheckValidNameFields(event);"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="first" runat="server" ControlToValidate="txtfname"
                                                                                        Font-Size="XX-Small" ErrorMessage="Enter First Name" ValidationGroup="2" Style="float: left;
                                                                                        clear: left;"></asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="fname" runat="server" ControlToValidate="txtfname"
                                                                                        Display="Dynamic" ErrorMessage="Enter a valid firstname" Font-Size="XX-Small"
                                                                                        ValidationExpression="^([0-9a-zA-Z]+([_.-]?[0-9a-zA-Z]+)*[0-9 a-zA-Z]+[0-9,a-z,A-Z,.,-]*(.){0}[a-zA-Z]{0})+$"
                                                                                        ValidationGroup="2" Style="float: left; clear: left;"></asp:RegularExpressionValidator>
                                                                                </td>
                                                                                <td style="width: 100px;" align="right">
                                                                                    <asp:Label ID="Lbllname" runat="server" Text="LAST NAME" CssClass="logintext"></asp:Label>
                                                                                </td>
                                                                                <td align="left" style="padding-top: 10px; padding-left: 5px;">
                                                                                    <asp:TextBox ID="txtlname" runat="server" CssClass="textfield" OnKeydown="javascript:return CheckValidNameFields(event);"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="rlname" runat="server" ValidationGroup="2" ControlToValidate="txtlname"
                                                                                        Font-Size="XX-Small" ErrorMessage="Enter Last Name" Style="float: left; clear: left;"></asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtlname"
                                                                                        Display="Dynamic" ErrorMessage="Enter a valid lastname" Font-Size="XX-Small"
                                                                                        ValidationExpression="^([a-zA-Z]+([_.-]?[a-zA-Z]+)*[ a-zA-Z]+[a-z,A-Z,.,-]*(.){0}[a-zA-Z]{0})+$"
                                                                                        ValidationGroup="2" Style="float: left; clear: left;"></asp:RegularExpressionValidator>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="" colspan="4">
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="width: 100px;" align="right">
                                                                                    <asp:Label ID="Label3" runat="server" Text="USER NAME" CssClass="logintext"></asp:Label>
                                                                                </td>
                                                                                <td align="left" style="padding-top: 10px; padding-left: 5px;">
                                                                                    <asp:TextBox ID="txtuname" runat="server" CssClass="textfield" OnKeydown="javascript:return CheckValidNameFields(event);"> </asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="2"
                                                                                        Font-Size="XX-Small" ControlToValidate="txtuname" ErrorMessage="Enter User Name"
                                                                                        Style="float: left; clear: left;"></asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="runame" runat="server" ControlToValidate="txtuname"
                                                                                        Display="Dynamic" ErrorMessage="Enter a valid username" Font-Size="XX-Small"
                                                                                        ValidationExpression="^([0-9a-zA-Z]+([_.-]?[0-9a-zA-Z]+)*[0-9 a-zA-Z]+[0-9,a-z,A-Z,.,-]*(.){0}[a-zA-Z]{0})+$"
                                                                                        ValidationGroup="2" Style="float: left; clear: left;"></asp:RegularExpressionValidator>
                                                                                </td>
                                                                                <td style="width: 100px;" align="right">
                                                                                    <asp:Label ID="lbldname" runat="server" Text="DISPLAY NAME" CssClass="logintext"></asp:Label>
                                                                                </td>
                                                                                <td align="left" style="padding-top: 0px; padding-left: 5px;">
                                                                                    <asp:TextBox ID="txtdname" runat="server" CssClass="textfield" OnKeydown="javascript:return CheckValidNameFields(event);"></asp:TextBox>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="" colspan="4">
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="width: 100px;" align="right">
                                                                                    <asp:Label ID="lbldpt" runat="server" Text="DEPARTMENT" CssClass="logintext"></asp:Label>
                                                                                </td>
                                                                                <td align="left" style="padding-top: 10px; padding-left: 5px;">
                                                                                    <asp:TextBox ID="txtdpt" runat="server" CssClass="textfield" OnKeydown="javascript:return CheckValidNameFields(event);"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="2"
                                                                                        Font-Size="XX-Small" ControlToValidate="txtdpt" ErrorMessage="Enter Department"
                                                                                        Style="float: left; clear: left;"></asp:RequiredFieldValidator>
                                                                                </td>
                                                                                <td style="width: 100px;" align="right">
                                                                                    <asp:Label ID="lblmail" runat="server" Text="E-MAIL" CssClass="logintext"></asp:Label>
                                                                                </td>
                                                                                <td align="left" style="padding-top: 15px; padding-left: 5px;">
                                                                                    <asp:TextBox ID="txtmail" runat="server" CssClass="textfield"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="remail" runat="server" ErrorMessage="Enter e-mail"
                                                                                        Font-Size="XX-Small" ControlToValidate="txtmail" ValidationGroup="2" Style="float: left;
                                                                                        clear: left;"></asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="mail" ControlToValidate="txtmail" runat="server"
                                                                                        Font-Size="XX-Small" ErrorMessage="Enter a Vaild e-mail Address" ValidationGroup="2"
                                                                                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Style="float: left;
                                                                                        clear: left;"></asp:RegularExpressionValidator>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="" colspan="4">
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="width: 100px;" align="right">
                                                                                    <asp:Label ID="lblcno" runat="server" Text="CONTACT NO" CssClass="logintext"></asp:Label>
                                                                                </td>
                                                                                <td align="left" style="padding-top: 10px; padding-left: 5px;">
                                                                                    <asp:TextBox ID="txtcno" runat="server" CssClass="textfield" MaxLength="10"></asp:TextBox>
                                                                                    <asp:RegularExpressionValidator ID="range" Font-Size="XX-Small" ControlToValidate="txtcno"
                                                                                        Style="float: left; clear: left;" ValidationExpression="\d{10}" ValidationGroup="2"
                                                                                        ErrorMessage="Enter the Correct Number" runat="server"></asp:RegularExpressionValidator>
                                                                                </td>
                                                                                <td style="width: 100px;" align="right" colspan="2">
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="border-bottom: solid 1px #AEB5C4;" colspan="4">
                                                                                    &nbsp;
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="" colspan="4">
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td align="left" colspan="4" style="padding: 2px 0px 0px 10px; font: 12px arial;
                                                                                    color: #525251;">
                                                                                    <asp:Label ID="Label13" runat="server" Font-Bold="True" Font-Size="Small" Text="Contact Information"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="" colspan="4">
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 100px;" align="right">
                                                                        <asp:Label ID="add1" runat="server" Text="ADDRESS1" CssClass="logintext"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 137px; padding-left: 5px;" align="left">
                                                                        <asp:TextBox ID="txtadd1" runat="server" CssClass="textfield"></asp:TextBox>
                                                                    </td>
                                                                    <td style="width: 110px;" align="right">
                                                                        <asp:Label ID="Label10" runat="server" Text="ADDRESS2" CssClass="logintext"></asp:Label>
                                                                    </td>
                                                                    <td align="left" style="padding-left: 5px;" >
                                                                        <asp:TextBox ID="txtadd2" runat="server" CssClass="textfield" ></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="" colspan="4">
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 100px;" align="right">
                                                                        <asp:Label ID="Label11" runat="server" Text="CITY" CssClass="logintext"></asp:Label>
                                                                    </td>
                                                                    <td align="left" style="width: 137px; padding-left: 5px;">
                                                                        <asp:TextBox ID="txtcity" runat="server" CssClass="textfield" OnKeydown="javascript:return CheckValidNameFields(event);"></asp:TextBox>
                                                                    </td>
                                                                    <td style="width: 100px;" align="right">
                                                                        <asp:Label ID="Label12" runat="server" Text="STATE" CssClass="logintext"></asp:Label>
                                                                    </td>
                                                                    <td align="left" style="padding-left: 5px;">
                                                                        <asp:TextBox ID="txtstate" runat="server" CssClass="textfield" OnKeydown="javascript:return CheckValidNameFields(event);"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="border-bottom: solid 1px #AEB5C4;" colspan="4">
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4" style="" align="center">
                                                                        <asp:Label ID="lblRegCaptcha" runat="server" Width="184px" Font-Bold="True" Font-Size="XX-Large"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4" style="" align="center">
                                                                        <asp:Label ID="lblCaptchamsg" runat="server" CssClass="valid"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4" style="" align="center">
                                                                        <asp:TextBox ID="numbertxt" runat="server" CssClass="textfieldmid"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4" style="">
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4" style="padding-top: 10px; padding-bottom: 10px;">
                                                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                                            <tr>
                                                                                <td colspan="2" align="right">
                                                                                    <asp:Button ID="Submit" runat="server" Text="Submit" ToolTip="submit" ValidationGroup="2"
                                                                                        OnClick="Submit_Click" CssClass="finishbutton" />
                                                                                </td>
                                                                                <td width="50px">
                                                                                </td>
                                                                                <td colspan="2" align="left" style="">
                                                                                    <asp:Button ID="Cancel" runat="server" Text="Cancel" ToolTip="cancel" OnClick="Cancel_Click"
                                                                                        CssClass="finishbutton" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4" style="">
                                                                    </td>
                                                                </tr>
                                                            </table>
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
        </div>
    </div>
    </form>
</body>
</html>
<%--</asp:Content>--%>