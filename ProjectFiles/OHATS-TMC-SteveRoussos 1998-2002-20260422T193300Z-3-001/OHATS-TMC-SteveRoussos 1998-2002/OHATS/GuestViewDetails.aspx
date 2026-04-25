<%@ page language="C#" masterpagefile="Event1.master" enableeventvalidation="false" autoeventwireup="true" inherits="GuestViewDetails, App_Web_guestviewdetails.aspx.cdcab7d2" %>

<asp:Content ID="cp1" ContentPlaceHolderID="Main" runat="server">
    <div style="margin-top: 25px; text-align: left;">
        <center>
            <span style="font: 22px arial; color: red">Events , Results & Accomplishments: View
                Event Form </span>
        </center>
        <table width="70%" cellpadding="0px" cellspacing="0px" align="center" style="margin-top: 20px;">
            <%-- <tr>
                <td style="width: 271px; padding-bottom: 10px;">
                    <asp:Label ID="label4" runat="server" Text="EVENT INFORMATION:-" ForeColor="Black"
                        Font-Underline="true" Font-Bold="true" Font-Italic="FALSE"></asp:Label></td>
            </tr>--%>
            <tr>
                <td>
                    <table border="0" cellpadding="0" cellspacing="0" width="700px" align="center">
                        <tr>
                            <td width="150" valign="top" style="border: 1px solid #B0BEC7; background: #EDF2F5;
                                padding: 8px;">
                                <table>
                                    <tr>
                                        <td nowrap style="padding-bottom: 8px;">
                                            <asp:Label ID="lblEventId" runat="server" Text="Event ID" CssClass="Label"></asp:Label></td>
                                        <td nowrap style="padding-bottom: 8px;">
                                            <asp:Label ID="txtEventId" runat="server" CssClass="MultiLineTextbox">
                                            </asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td nowrap style="padding-bottom: 8px;">
                                            <asp:Label ID="lblrecordername" runat="server" Text="Recorder Name" CssClass="Label"></asp:Label></td>
                                        <td nowrap style="padding-bottom: 8px;">
                                            <asp:Label ID="ddlrecordername" runat="server" Font-Size="10pt">
                                            </asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td nowrap style="padding-bottom: 8px;">
                                            <asp:Label ID="lbleventoccureddate" runat="server" Text="Event occured Date" CssClass="Label"
                                                ToolTip="On which date the Event had occured"></asp:Label></td>
                                        <td nowrap style="padding-bottom: 8px;">
                                            <asp:Label ID="txteventoccureddate" runat="server" ToolTip="On which date the Event had occured"
                                                CssClass="MultiLineTextbox"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td nowrap style="padding-bottom: 8px;">
                                            <asp:Label ID="lbldateunsurred" runat="server" Text="Date Unsure" CssClass="Label"></asp:Label></td>
                                        <td nowrap style="padding-bottom: 8px;">
                                            <asp:Label ID="txtdateunsurred" runat="server" ToolTip="Unsure date of the event"
                                                CssClass="MultiLineTextbox"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td valign="top" width="20">
                                &nbsp;</td>
                            <td valign="top" width="150" style="border: 1px solid #B0BEC7; background: #EDF2F5;
                                padding: 8px;">
                                <table>
                                    <tr>
                                        <td style="padding-bottom: 8px;">
                                            <asp:Label ID="lblprivateitem" runat="server" Text="Private Item" CssClass="Label"></asp:Label>
                                        </td>
                                        <td style="padding-bottom: 8px;">
                                            <asp:Label ID="cbprivateitem" runat="server" Enabled="true" CssClass="MultiLineTextbox"
                                                ToolTip="Tick the box to ensure that it is a private item" /></td>
                                    </tr>
                                    <tr>
                                        <td style="padding-bottom: 8px;">
                                            <asp:Label ID="lblsource" runat="server" Text="Source" CssClass="Label"></asp:Label></td>
                                        <td style="padding-bottom: 8px;">
                                            <asp:Label ID="rblsource" runat="server" CssClass="MultiLineTextbox">
                                            </asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td style="padding-bottom: 8px;">
                                            <asp:Label ID="lblstate" runat="server" Text="State" CssClass="Label"></asp:Label></td>
                                        <td style="padding-bottom: 8px;">
                                            <asp:Label ID="ddlstate" runat="server" CssClass="MultiLineTextbox">
                                            </asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td style="padding-bottom: 8px;">
                                            <asp:Label ID="country" runat="server" Text="Country" CssClass="Label"></asp:Label></td>
                                        <td style="padding-bottom: 8px;">
                                            <asp:Label ID="txtcountry" runat="server" CssClass="MultiLineTextbox"></asp:Label></td>
                                    </tr>
                                </table>
                            </td>
                            <td valign="top" width="20">
                                &nbsp;</td>
                            <td valign="top" width="150" style="border: 1px solid #B0BEC7; background: #EDF2F5;
                                padding: 8px;">
                                <table>
                                    <tr>
                                        <td nowrap style="padding-bottom: 8px;">
                                            <asp:Label ID="lblitemnovelity" runat="server" Text="Item Novelity" CssClass="Label"
                                                ToolTip="Drop any one of the following"></asp:Label></td>
                                        <td nowrap style="padding-bottom: 8px;">
                                            <asp:Label ID="ddlitemnovelity" runat="server" CssClass="">
                                            </asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td nowrap style="padding-bottom: 8px;">
                                            <asp:Label ID="lblitemtype" runat="server" Text="Item Type" CssClass="Label" ToolTip="Drop any one of the following"></asp:Label></td>
                                        <td nowrap style="padding-bottom: 8px;">
                                            <asp:Label ID="ddlitemtype" runat="server" CssClass="">
                                            </asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td nowrap style="padding-bottom: 8px;">
                                            <asp:Label ID="lblrecuring" runat="server" Text="Recuring" CssClass="Label" ToolTip="Drop any one of the following"></asp:Label></td>
                                        <td nowrap style="padding-bottom: 8px;">
                                            <asp:Label ID="ddlRecuring" runat="server" CssClass="MultiLineTextbox">
                                            </asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td nowrap style="padding-bottom: 8px;">
                                            <asp:Label ID="lblpeopleattend" runat="server" Text="People Attended" CssClass="Label"></asp:Label></td>
                                        <td nowrap style="padding-bottom: 8px;">
                                            <asp:Label ID="txtpeopleattended" runat="server" CssClass="MultiLineTextbox"></asp:Label></td>
                                    </tr>
                                </table>
                            </td>
                            <td valign="top" width="20">
                                &nbsp;</td>
                            <td valign="top" width="200" style="border: 1px solid #B0BEC7; background: #EDF2F5;
                                padding: 8px;">
                                <table>
                                    <tr>
                                        <td valign="top" style="padding-bottom: 8px;">
                                            <asp:Label ID="lblthisevent" runat="server" Text="This Event" CssClass="Label" ToolTip="The event belongs to what type"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td style="padding-bottom: 8px;">
                                            <asp:Label ID="rbleventstatus" runat="server" CssClass="MultiLineTextbox">
                                            </asp:Label></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" colspan="7" style="padding: 10px 0px 10px 0px;">
                                <table>
                                    <tr>
                                        <td valign="top" style="border: 1px solid #B0BEC7; background: #EDF2F5; width: 300px;
                                            padding: 8px;">
                                            <table>
                                                <tr>
                                                    <td valign="top" style="width: 123px; padding-bottom: 8px;">
                                                        <asp:Label ID="lblitemdescription" runat="server" Text="Item Description" CssClass="Heading"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td valign="top" style="padding-bottom: 8px;">
                                                        <asp:Label ID="txtitemdescription" runat="server" CssClass="MultiLineTextbox"></asp:Label></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td valign="top" style="border: 1px solid #B0BEC7; background: #EDF2F5; width: 300px;
                                            padding: 8px;">
                                            <table>
                                                <tr>
                                                    <td valign="top" style="width: 123px; padding-bottom: 8px;">
                                                        <asp:Label ID="lblitemmeaning" runat="server" Text="Item Meaning" CssClass="Heading"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td valign="top" style="padding-bottom: 8px;">
                                                        <asp:Label ID="txtitemmeaning" runat="server" CssClass="MultiLineTextbox"></asp:Label></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td valign="top" style="border: 1px solid #B0BEC7; background: #EDF2F5; width: 300px;
                                            padding: 8px;">
                                            <table>
                                                <tr>
                                                    <td valign="top" style="width: 123px; padding-bottom: 8px;">
                                                        <asp:Label ID="lblitemresult" runat="server" Text="Item Result" CssClass="Heading"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td valign="top" style="padding-bottom: 8px;">
                                                        <asp:Label ID="txtitemresult" runat="server" CssClass="MultiLineTextbox"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" width="150" style="border: 1px solid #B0BEC7; background: #EDF2F5;
                                padding: 8px;">
                                <table>
                                    <tr>
                                        <td style="background: #EDF2F5;" valign="top">
                                            <table>
                                                <tr>
                                                    <td valign="top" nowrap>
                                                        <asp:Label ID="lblselectedactors" runat="server" Text="Selected Actors" CssClass="Heading"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td id="txtselectedactors" runat="server" valign="top" >
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="background: #EDF2F5;" valign="top">
                                            <table>
                                                <tr>
                                                    <td valign="top" nowrap>
                                                        <asp:Label ID="lblkeyorganisation" runat="server" Text="Key Organisation" CssClass="Heading"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td id="txtkeyorganisastion" runat="server" valign="top">
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td valign="top" width="20">
                                &nbsp;</td>
                            <td valign="top" width="150" style="border: 1px solid #B0BEC7; background: #EDF2F5;
                                padding: 8px;">
                                <table style="background: #EDF2F5; margin: -left:5px;">
                                    <tr>
                                        <td style="width: 123px; padding-bottom: 8px;">
                                            <asp:Label ID="lblEventGoals" runat="server" Text="Event Goals" CssClass="Heading" /></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="cbpublicawareness" runat="server" Text="Public Awareness" CssClass="MultiLineTextbox" /></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="cbtechnology" runat="server" Text="Technology" CssClass="MultiLineTextbox" /></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="cbresearch" runat="server" Text="Research" CssClass="MultiLineTextbox" /></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="cbtraining" runat="server" Text="Training" CssClass="MultiLineTextbox" /></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="cbresourcedevelopment" runat="server" Text="Resource Development"
                                                CssClass="MultiLineTextbox" /></td>
                                    </tr>
                                    <tr>
                                        <td style="padding-bottom: 8px;">
                                            <asp:Label ID="cbstrategicevents" runat="server" Text="Strategic Events" CssClass="MultiLineTextbox" /></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 123px; padding-bottom: 8px;">
                                            <asp:Label ID="Label1" runat="server" Text="OTHERS" CssClass="Heading"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 220px">
                                            <asp:Label ID="txteventgoalsothers" runat="server" CssClass="MultiLineTextbox"></asp:Label></td>
                                    </tr>
                                </table>
                            </td>
                            <td valign="top" width="20">
                                &nbsp;</td>
                            <td valign="top" width="150" style="border: 1px solid #B0BEC7; background: #EDF2F5;
                                padding: 8px;">
                                <table style="background: #EDF2F5; margin-left: 5px;">
                                    <tr>
                                        <td style="width: 150px; padding-bottom: 8px;">
                                            <asp:Label ID="lblEventType" runat="server" Text="Event Type" CssClass="Heading" /></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 230px">
                                            <asp:Label ID="cbcommunity" runat="server" Text="Community System Change" Width="200"
                                                CssClass="MultiLineTextbox" /></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 185px">
                                            <asp:Label ID="cbmedia" runat="server" Text="Media" CssClass="MultiLineTextbox" /></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 185px">
                                            <asp:Label ID="cbcommunityaction" runat="server" Text="Community Action" CssClass="MultiLineTextbox" /></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 185px">
                                            <asp:Label ID="cbresources" runat="server" Text="Resources" CssClass="MultiLineTextbox" /></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 185px">
                                            <asp:Label ID="cbservices" runat="server" Text="Services" CssClass="MultiLineTextbox" /></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 220px">
                                            <asp:Label ID="cbplaning" runat="server" Text="Planning and Development" Width="180"
                                                CssClass="MultiLineTextbox" /></td>
                                    </tr>
                                    <tr>
                                        <td style="padding-bottom: 8px;">
                                            <asp:Label ID="cbcriticalevent" runat="server" Text="Critical Event" CssClass="MultiLineTextbox" /></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 123px; padding-bottom: 8px;">
                                            <asp:Label ID="eventgoalsothers" runat="server" Text="OTHERS" CssClass="Heading"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 185px">
                                            <asp:Label ID="txteventcommunicationothers" runat="server" CssClass="MultiLineTextbox"></asp:Label></td>
                                    </tr>
                                </table>
                            </td>
                            <td valign="top" width="20">
                                &nbsp;</td>
                            <td valign="top" width="200" style="border: 1px solid #B0BEC7; background: #EDF2F5;
                                padding: 8px;">
                                <table style="background: #EDF2F5;">
                                    <tr>
                                        <td style="width: 123px; padding-bottom: 8px;">
                                            <asp:Label ID="lblEventCommunication" runat="server" Text="Event Communication" CssClass="Heading" /></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 185px">
                                            <asp:Label ID="cbreport" runat="server" Text="Report" CssClass="MultiLineTextbox"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 185px">
                                            <asp:Label ID="cbnews" runat="server" Text="News" CssClass="MultiLineTextbox"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 185px">
                                            <asp:Label ID="cbspecial" runat="server" Text="Special" CssClass="MultiLineTextbox" /></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 185px">
                                            <asp:Label ID="cbbestpractice" runat="server" Text="Best Practice" CssClass="MultiLineTextbox" /></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 185px; padding-bottom: 8px;">
                                            <asp:Label ID="cbemail" runat="server" Text="Email" CssClass="MultiLineTextbox"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 185px; padding-bottom: 8px;">
                                            <asp:Label ID="cbemaillist" runat="server" Text="Email List" CssClass="Label" /></td>
                                    </tr>
                                    <tr>
                                        <td style="padding-bottom: 8px;">
                                            <asp:Label ID="emaillist" runat="server" CssClass="MultiLineTextbox" Width="60px" /></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 123px; padding-bottom: 8px;">
                                            <asp:Label ID="lbleventtypeothers" runat="server" Text="OTHERS" CssClass="Heading"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 220px">
                                            <asp:Label ID="txteventtypeothers" runat="server" CssClass="MultiLineTextbox"></asp:Label></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="7" style="padding: 10px 10px 0px 0px;">
                    <asp:Button ID="butGuestViewBack" runat="Server" Text="Back" CssClass="finishbutton"
                        Style="float: right;" OnClick="butGuestViewBack_Click" /></td>
            </tr>
        </table>
    </div>
</asp:Content>
