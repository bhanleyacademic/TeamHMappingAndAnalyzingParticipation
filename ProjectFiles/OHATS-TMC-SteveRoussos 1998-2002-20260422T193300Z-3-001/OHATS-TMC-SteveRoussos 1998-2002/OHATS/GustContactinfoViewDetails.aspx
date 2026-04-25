<%@ page language="C#" masterpagefile="Event1.master" autoeventwireup="true" inherits="GustContactinfoViewDetails, App_Web_gustcontactinfoviewdetails.aspx.cdcab7d2" %>

<asp:Content ID="cp1" ContentPlaceHolderID="Main" runat="server">

    <script src="Javascript/Validation.js" type="text/javascript"></script>

    <div style="padding-top: 15px; text-align: left;">
        <center>
            <span style="font: 22px arial; color: Red;">Contact Information</span>
        </center>
        <table align="center" style="font: 11px tahoma; padding-left: 20px; margin-top: 10px;"
            width="500" cellpadding="0" cellspacing="0">
            <tr>
                <td valign="top" style=" width: 450px;" >
                    <table style=" border: 1px solid #B0BEC7; background: #EDF2F5;">
                        <tr>
                            <td colspan="2" height="18px" style="background-image: url(Images/bg.png); color: #18397C;
                                font: bold 14px arial;">
                                <center>
                                    User Details</center>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" width="180" style=" padding:10px 0px 10px 10px;">
                                <asp:Label ID="lblTitle" runat="server" Text="Title" CssClass="Label" meta:resourcekey="lblTitleResource1"></asp:Label></td>
                            <td valign="top" width="180" style=" padding:10px 0px 10px 10px;">
                                <asp:Label ID="ddlTitle" runat="server" meta:resourcekey="ddlTitleResource1">
                                    
                                </asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" style="width: 171px;padding:0px 0px 0px 10px;">
                                <asp:Label ID="lblFirstName" runat="server" Text="First Name" CssClass="Label" meta:resourcekey="lblFirstNameResource1"></asp:Label></td>
                            <td valign="top"  style="padding:0px 0px 0px 10px;">
                                <asp:Label ID="txtFirstName" runat="server" meta:resourcekey="txtFirstNameResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 171px;padding:10px 0px 10px 10px;">
                                <asp:Label ID="lblMiddleName" runat="server" Text="Middle Name" CssClass="Label"
                                    meta:resourcekey="lblMiddleNameResource1"></asp:Label>
                            </td>
                            <td  style=" padding:10px 0px 10px 10px;">
                                <asp:Label ID="txtMiddleName" runat="server" meta:resourcekey="txtMiddleNameResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" style="width: 171px;padding:0px 0px 0px 10px;">
                                <asp:Label ID="lblLastName" runat="server" Text="Last Name" CssClass="Label" meta:resourcekey="lblLastNameResource1"></asp:Label></td>
                            <td valign="top"  style="padding:0px 0px 0px 10px;">
                                <asp:Label ID="txtLastName" runat="server" meta:resourcekey="txtLastNameResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" style="width: 171px;padding:10px 0px 10px 10px;">
                                <asp:Label ID="lblJobTitle" runat="server" Text="Job Title" CssClass="Label" meta:resourcekey="lblJobTitleResource1"></asp:Label></td>
                            <td valign="top"  style=" padding:10px 0px 10px 10px;">
                                <asp:Label ID="txtJobTitle" runat="server" meta:resourcekey="txtJobTitleResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" style="width: 171px;padding:0px 0px 0px 10px;">
                                <asp:Label ID="lblCompany" runat="server" Text="Company" CssClass="Label" meta:resourcekey="lblCompanyResource1"></asp:Label></td>
                            <td valign="top"  style="padding:0px 0px 0px 10px;">
                                <asp:Label ID="txtCompany" runat="server" meta:resourcekey="txtCompanyResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" style="width: 171px; padding:10px 0px 10px 10px;">
                                <asp:Label ID="lblWebsite" runat="server" Text="Website" CssClass="Label" meta:resourcekey="lblWebsiteResource1"></asp:Label></td>
                            <td  valign="top" style=" padding:10px 0px 10px 10px;">
                                <asp:Label ID="txtWebsite" runat="server" meta:resourcekey="txtWebsiteResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" style="width: 171px;padding:0px 0px 0px 10px;">
                                <asp:Label ID="lblOfficePhone" runat="server" Text="Office Phone" CssClass="Label"
                                    meta:resourcekey="lblOfficePhoneResource1"></asp:Label></td>
                            <td valign="top"  style="padding:0px 0px 0px 10px;">
                                <asp:Label ID="txtOfficePhone" runat="server" MaxLength="10" meta:resourcekey="txtOfficePhoneResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" style="width: 171px; padding:10px 0px 10px 10px;">
                                <asp:Label ID="lblHomePhone" runat="server" Text="Home Phone" CssClass="Label" meta:resourcekey="lblHomePhoneResource1"></asp:Label></td>
                            <td valign="top"  style=" padding:10px 0px 10px 10px;">
                                <asp:Label ID="txtHomePhone" runat="server" MaxLength="10" meta:resourcekey="txtHomePhoneResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" style="width: 171px;padding:0px 0px 0px 10px;">
                                <asp:Label ID="lblMobile" runat="server" Text="Mobile" CssClass="Label" meta:resourcekey="lblMobileResource1"></asp:Label></td>
                            <td valign="top" style="padding:0px 0px 0px 10px;">
                                <asp:Label ID="txtMobile" runat="server" MaxLength="10" meta:resourcekey="txtMobileResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" style="width: 171px;  padding:10px 0px 10px 10px;">
                                <asp:Label ID="lblFax" runat="server" Text="Fax" CssClass="Label" meta:resourcekey="lblFaxResource1"></asp:Label></td>
                            <td valign="top"  style=" padding:10px 0px 10px 10px;">
                                <asp:Label ID="txtFax" runat="server" MaxLength="10" meta:resourcekey="txtFaxResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" style="width: 171px;padding:0px 0px 0px 10px;">
                                <asp:Label ID="lblOfficialEmail" runat="server" Text="Official Email" CssClass="Label"
                                    meta:resourcekey="lblOfficialEmailResource1"></asp:Label></td>
                            <td valign="top" style="padding:0px 0px 0px 10px;">
                                <asp:Label ID="txtOfficialEmail" runat="server" meta:resourcekey="txtOfficialEmailResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" style="width: 171px; padding:10px 0px 10px 10px;">
                                <asp:Label ID="lblPersonalEmail" runat="server" Text="Personal Email" CssClass="Label"
                                    meta:resourcekey="lblPresonalEmailResource1"></asp:Label></td>
                            <td valign="top"  style=" padding:10px 0px 10px 10px;">
                                <asp:Label ID="txtPersonalEmail" runat="server" meta:resourcekey="txtPersonalEmailResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" style="width: 171px;padding:0px 0px 10px 10px;">
                                <asp:Label ID="lblOrganization" runat="server" Text="Organization" CssClass="Label"
                                    meta:resourcekey="lblOrganizationResource1"></asp:Label></td>
                            <td valign="top" style="padding:0px 0px 10px 10px;">
                                <asp:Label ID="txtOrganization" runat="server" meta:resourcekey="txtOrganizationResource1"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
                <td valign="top" style="width: 450px;">
                    <table border="0" cellpadding="0" cellspacing="0" style="margin-left: 10px;">
                        <tr>
                            <td valign="top">
                                <table style="border: 1px solid #B0BEC7; background: #EDF2F5;">
                                    <tr>
                                        <td colspan="2" height="18px" style="background-image: url(Images/bg.png); color: #18397C;
                                            font: bold 14px arial;">
                                            <center>
                                                Volunteer Roles</center>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td valign="top" style="width: 175px; padding-bottom: 10px; padding-left: 10px;">
                                            <asp:Label ID="cbActor" runat="server" Text="Actor" CssClass="Label" meta:resourcekey="cbActorResource1" /></td>
                                        <td valign="top" style="width: 175px; padding-left: 10px;">
                                            <img id="imgActor" runat="server" src="Images/checkmark.gif" /><img id="imgActor1"
                                                runat="server" src="Images/icon-delete.gif" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td valign="top" style="width: 175px; padding-bottom: 10px; padding-left: 10px;">
                                            <asp:Label ID="cbSponsor" runat="server" Text="Sponsor" CssClass="Label" meta:resourcekey="cbSponsorResource1" /></td>
                                        <td valign="top" style="width: 175px; padding-left: 10px;">
                                            <img id="imgSponsor" runat="server" src="Images/checkmark.gif" /><img id="imgSponsor1"
                                                runat="server" src="Images/icon-delete.gif" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 175px; padding-bottom: 10px; padding-left: 10px;">
                                            <asp:Label ID="cbRecorder" runat="server" Text="Recorder" CssClass="Label" meta:resourcekey="cbRecorderResource1" /></td>
                                        <td valign="top" style="width: 175px; padding-left: 10px;">
                                            <img id="imgRecorder" runat="server" src="Images/checkmark.gif" /><img id="imgRecorder1"
                                                runat="server" src="Images/icon-delete.gif" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top">
                                <table style="border: 1px solid #B0BEC7; background: #EDF2F5; margin: 10px 0px 0px 0px;">
                                    <tr>
                                        <td colspan="2" height="18px" style="background-image: url(Images/bg.png); color: #18397C;
                                            font: bold 14px arial;">
                                            <center>
                                                Official Address</center>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 175px; padding-bottom: 10px; padding-left: 10px;">
                                            <asp:Label ID="lblStreet" runat="server" Text="Street" CssClass="Label" meta:resourcekey="lblStreetResource1"></asp:Label></td>
                                        <td valign="top" style="width: 175px; padding-left: 10px;">
                                            <asp:Label ID="txtStreet" runat="server" meta:resourcekey="txtStreetResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 175px; padding-bottom: 10px; padding-left: 10px;">
                                            <asp:Label ID="lblCity" runat="server" Text="City" CssClass="Label" meta:resourcekey="lblCityResource1"></asp:Label></td>
                                        <td style="padding-left: 10px;">
                                            <asp:Label ID="txtCity" runat="server" meta:resourcekey="txtCityResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 175px; padding-bottom: 10px; padding-left: 10px;">
                                            <asp:Label ID="lblState" runat="server" Text="State" CssClass="Label" meta:resourcekey="lblStateResource1"></asp:Label></td>
                                        <td valign="top" style="padding-left: 10px;">
                                            <asp:Label ID="ddlState" runat="server" DataTextField="State" meta:resourcekey="ddlStateResource1">
                                            </asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 175px; padding-bottom: 10px; padding-left: 10px;">
                                            <asp:Label ID="lblCountry" runat="server" Text="Country" CssClass="Label" meta:resourcekey="lblCountryResource1"></asp:Label></td>
                                        <td style="padding-left: 10px;">
                                            <asp:Label ID="txtCountry" runat="server" meta:resourcekey="txtCountryResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 175px; padding-bottom: 10px; padding-left: 10px;">
                                            <asp:Label ID="lblZip" runat="server" Text="Zip" CssClass="Label" meta:resourcekey="lblZipResource1"></asp:Label></td>
                                        <td valign="top" style="padding-left: 10px;">
                                            <asp:Label ID="txtZip" runat="server" meta:resourcekey="txtZipResource1"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" style="height: 223px">
                                <table style="border: 1px solid #B0BEC7; margin: 10px 0px 0px 0px; background: #EDF2F5;">
                                    <tr style="padding: 4px 0px 4px 40px;">
                                        <td colspan="2" height="18px" style="background-image: url(Images/bg.png); color: #18397C;
                                            font: bold 14px arial;">
                                            <center>
                                                Personal Address</center>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 175px; padding-bottom: 10px; padding-left: 10px;">
                                            <asp:Label ID="lblStreet1" runat="server" Text="Street" CssClass="Label" meta:resourcekey="lblStreetResource1"></asp:Label></td>
                                        <td style="width: 175px; padding-left: 10px;">
                                            <asp:Label ID="txtStreet1" runat="server" meta:resourcekey="txtStreetResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 175px; padding-bottom: 10px; padding-left: 10px;">
                                            <asp:Label ID="lblCity1" runat="server" Text="City" CssClass="Label" meta:resourcekey="lblCityResource1"></asp:Label></td>
                                        <td valign="top" style="padding-left: 10px;">
                                            <asp:Label ID="txtCity1" runat="server" meta:resourcekey="txtCityResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 175px; padding-bottom: 10px; padding-left: 10px;">
                                            <asp:Label ID="lblState1" runat="server" Text="State" CssClass="Label" meta:resourcekey="lblStateResource1"></asp:Label></td>
                                        <td style="padding-left: 10px;">
                                            <asp:Label ID="ddlState1" runat="server" meta:resourcekey="ddlStateResource1" DataTextField="State">
                                            </asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 175px; padding-bottom: 10px; padding-left: 10px;">
                                            <asp:Label ID="lblCountry1" runat="server" Text="Country" CssClass="Label" meta:resourcekey="lblCountryResource1"></asp:Label></td>
                                        <td valign="top" style="padding-left: 10px;">
                                            <asp:Label ID="txtCountry1" runat="server" meta:resourcekey="txtCountryResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 175px; padding-bottom: 10px; padding-left: 10px;">
                                            <asp:Label ID="lblZip1" runat="server" Text="Zip" CssClass="Label" meta:resourcekey="lblZipResource1"></asp:Label></td>
                                        <td style="padding-left: 10px;">
                                            <asp:Label ID="txtZip1" runat="server" meta:resourcekey="txtZipResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 175px; padding-bottom: 10px; padding-left: 10px;">
                                            <asp:Label ID="lblRoles" runat="server" Visible="false" Text="Event Tracker User Role"
                                                CssClass="Label" meta:resourcekey="lblOrganizationResource1"></asp:Label></td>
                                        <td valign="top" style="padding-left: 10px;">
                                            <asp:Label ID="ddlRoles" runat="server" Visible="false" DataTextField="RoleName"
                                                DataValueField="RoleID">
                                            </asp:Label></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        
                    </table>
                </td>
            </tr>
            <tr>
                            <td  colspan="2">
                                <asp:Button ID="btnBack"  style ="float:right;" CssClass="finishbutton" runat="server" Text="Back" OnClick="btnBack_Click" /></td>
                        </tr>
        </table>
    </div>
</asp:Content>
