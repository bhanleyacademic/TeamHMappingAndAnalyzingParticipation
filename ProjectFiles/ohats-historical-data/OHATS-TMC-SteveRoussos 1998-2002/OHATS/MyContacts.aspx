<%@ page language="C#" masterpagefile="Event1.master" autoeventwireup="true" inherits="MyContacts, App_Web_mycontacts.aspx.cdcab7d2" title="Untitled Page" %>

<%@ Register TagPrefix="obout" Namespace="OboutInc.Flyout2" Assembly="obout_Flyout2_NET" %>
<%@ Register Assembly="Web.YUI" Namespace="Web.YUI" TagPrefix="yui" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div>
        <table height="200px">
            <tr>
                <td  height="200px">
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td>
                    <div style="left: 400px; top: 100px; width: 200px; ">
                        <span style="float: left; font: 18px tahoma; color: #3131CE;"><strong>ADDRESS BOOK</strong></span>
                    </div>
                    <asp:Label ID="records" runat="server" Text="Number of records:" Width="137px" Style="left: 250px;
                        top: 160px; position: absolute"></asp:Label>
                    <asp:Label ID="recordnumber" runat="server" Style="left: 380px; top: 160px; position: absolute"></asp:Label>
                    <div style="left: 250px; top: 130px; width: 400px; position: absolute">
                        <table cellspacing="0" cellpadding="0" border="0" class="searchLabel">
                            <tr class="background" align="center">
                                <td style="height: 12px">
                                    <a href="ContactInfoListcontent.aspx?BLet=0">All</a>|</td>
                                <td style="height: 12px">
                                    <a href="ContactInfoListcontent.aspx?BLet=A">A</a>|</td>
                                <td style="height: 12px">
                                    <a href="ContactInfoListcontent.aspx?BLet=B">B</a>|</td>
                                <td style="height: 12px">
                                    <a href="ContactInfoListcontent.aspx?BLet=C">C</a>|</td>
                                <td style="height: 12px">
                                    <a href="ContactInfoListcontent.aspx?BLet=D">D</a>|</td>
                                <td style="height: 12px">
                                    <a href="ContactInfoListcontent.aspx?BLet=E">E</a>|</td>
                                <td style="height: 12px">
                                    <a href="ContactInfoListcontent.aspx?BLet=F">F</a>|</td>
                                <td style="height: 12px">
                                    <a href="ContactInfoListcontent.aspx?BLet=G">G</a>|</td>
                                <td style="height: 12px">
                                    <a href="ContactInfoListcontent.aspx?BLet=H">H</a>|</td>
                                <td style="height: 12px">
                                    <a href="ContactInfoListcontent.aspx?BLet=I">I</a>|</td>
                                <td style="height: 12px">
                                    <a href="ContactInfoListcontent.aspx?BLet=J">J</a>|</td>
                                <td style="height: 12px">
                                    <a href="ContactInfoListcontent.aspx?BLet=K">K</a>|</td>
                                <td style="width: 12px; height: 12px;">
                                    <a href="ContactInfoListcontent.aspx?BLet=L">L</a>|</td>
                                <td style="height: 12px">
                                    <a href="ContactInfoListcontent.aspx?BLet=M">M</a>|</td>
                                <td style="height: 12px">
                                    <a href="ContactInfoListcontent.aspx?BLet=N">N</a>|</td>
                                <td style="height: 12px">
                                    <a href="ContactInfoListcontent.aspx?BLet=O">O</a>|</td>
                                <td style="height: 12px">
                                    <a href="ContactInfoListcontent.aspx?BLet=P">P</a>|</td>
                                <td style="height: 12px">
                                    <a href="ContactInfoListcontent.aspx?BLet=Q">Q</a>|</td>
                                <td style="height: 12px">
                                    <a href="ContactInfoListcontent.aspx?BLet=R">R</a>|</td>
                                <td style="height: 12px">
                                    <a href="ContactInfoListcontent.aspx?BLet=S">S</a>|</td>
                                <td style="height: 12px">
                                    <a href="ContactInfoListcontent.aspx?BLet=T">T</a>|</td>
                                <td style="height: 12px">
                                    <a href="ContactInfoListcontent.aspx?BLet=U">U</a>|</td>
                                <td style="height: 12px">
                                    <a href="ContactInfoListcontent.aspx?BLet=V">V</a>|</td>
                                <td style="height: 12px">
                                    <a href="ContactInfoListcontent.aspx?BLet=W">W</a>|</td>
                                <td style="height: 12px">
                                    <a href="ContactInfoListcontent.aspx?BLet=X">X</a>|</td>
                                <td style="height: 12px">
                                    <a href="ContactInfoListcontent.aspx?BLet=Y">Y</a>|</td>
                                <td style="height: 12px">
                                    <a href="ContactInfoListcontent.aspx?BLet=Z">Z</a>&nbsp;&nbsp;&nbsp;&nbsp;
                                </td>
                                <td style="height: 12px">
                                    <a href="ContactInfoListcontent.aspx?BLet=Z"></a>&nbsp;&nbsp;&nbsp;&nbsp;
                                </td>
                                <td style="height: 12px">
                                    <a href="ContactInfoListcontent.aspx?BLet=Z"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </td>
                                <td style="left: 400px; position: absolute; width: 206px; height: 12px;">
                                    <asp:Button ID="btnaddnew" runat="server" Text="Add New Contact" OnClick="btnaddnew_Click"
                                        CssClass="button3" />
                                </td>
                                <td style="left: 400px; position: absolute; width: 206px; height: 75px;">
                                    <a href="ContactInfoListcontent.aspx?show=showall">Show All |</a><a href="ContactInfoListcontent.aspx?show=Activeuser">
                                        Active User |</a><a href="MyContacts.aspx?show=Inactiveuser"> Inactive User</a>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div style="left: 15px; top: 100px; position: absolute">
                        <table>
                            <tr>
                                <td valign="top">
                                    <yui:FloatPanel ID="FloatPanel1" runat="server" Style="float: left" Resizable="true"
                                        Closable="false" Width="170px" Draggable="false" ToolTip="Search Panel">
                                        <HeaderTemplate>
                                            Contact List By</HeaderTemplate>
                                        <BodyTemplate>
                                            <table style="text-align: left;" align="left">
                                                <tr class="background" align="left">
                                                    <td>
                                                        <table id="select_table" runat="server">
                                                            <tr>
                                                                <td colspan="2">
                                                                    <asp:Label ID="lbltxt1" runat="server" Text="You have Selected" CssClass="desc" Font-Bold="True"
                                                                        BackColor="Azure" Font-Italic="True" Width="135px"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr class="background">
                                                                <td>
                                                                    <asp:Label ID="lblstate1" runat="server" Text="State" Font-Bold="true" CssClass="ee"
                                                                        Font-Size="10"></asp:Label></td>
                                                                <td>
                                                                    <asp:Label ID="lblstatename" runat="server" Text="" align="right" CssClass="desc"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr align="left" class="background">
                                                                <td colspan="2">
                                                                    <asp:LinkButton ID="lblremovestate" runat="server" Text="Remove" CssClass="desc"
                                                                        ToolTip="Remove" Font-Underline="true" ForeColor="Red" OnClick="lblremovestate_Click"></asp:LinkButton></td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblcity1" runat="server" Text="City" Font-Bold="true" CssClass="ee"
                                                                        Font-Size="10"></asp:Label></td>
                                                                <td>
                                                                    <asp:Label ID="lblcityname" CssClass="desc" runat="server" align="right" Font-Size="10pt"
                                                                        Font-Bold="True" Width="94px"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr align="left" class="background">
                                                                <td colspan="2">
                                                                    <asp:LinkButton ID="lblremovecity" runat="server" Text="Remove" CssClass="desc" ToolTip="Remove"
                                                                        Font-Underline="true" ForeColor="Red" OnClick="lblremovecity_Click"></asp:LinkButton></td>
                                                            </tr>
                                                            <%--<tr class="background">
                                            <td align="left" colspan="2">
                                                <asp:LinkButton ID="lblremoveall" runat="server" Text="RemoveAll" Font-Bold="true"
                                                    Font-Size="8" Font-Underline="true" ToolTip="Remove All  " ForeColor="Red"></asp:LinkButton></td>
                                        </tr>--%>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr class="background">
                                                    <td>
                                                        <asp:Label ID="Label1" runat="server" Text="State" CssClass="Label" Font-Bold="True"
                                                            BackColor="Azure" Font-Italic="True"></asp:Label></td>
                                                </tr>
                                                <tr class="background">
                                                    <td id="td_State" runat="server">
                                                        <asp:Label ID="lblbindstate" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr class="background">
                                                    <td>
                                                        <asp:Label ID="Label2" runat="server" Text="City" CssClass="Label" Font-Bold="true"
                                                            BackColor="Azure" Font-Italic="true"></asp:Label></td>
                                                </tr>
                                                <tr class="background">
                                                    <td id="td_city" runat="server">
                                                        <asp:Label ID="lblbindcity" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </BodyTemplate>
                                    </yui:FloatPanel>
                                </td>
                                <td valign="top" width="100%">
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div style="left: 50px; top: 180px; position: absolute; max-width: 600px">
                        <table cellspacing="0" cellpadding="0" border="0" style="left: 190px; top: 0px; position: absolute">
                            <tbody valign="top">
                                <tr class="background">
                                    <td valign="top" style="width: 811px; text-align: left;">
                                        <asp:DataGrid Style="float: right" ID="dgrdAddressList" runat="server" OnPageIndexChanged="dgrdAddressList_PageIndexChanged"
                                            OnSortCommand="dgrdAddressList_SortCommand" BorderColor="DarkGray" AutoGenerateColumns="False"
                                            Width="615px" DataKeyField="UserID" PageSize="10" AllowPaging="True" AllowSorting="True"
                                            CellPadding="7" ShowFooter="false" FooterStyle-HorizontalAlign="center" PagerStyle-PrevPageText="<<"
                                            PagerStyle-NextPageText=">>" PagerStyle-HorizontalAlign="Center" OnDeleteCommand="dgrdAddressList_DeleteCommand"
                                            OnItemCreated="dgrdAddressList_ItemCreated" OnItemDataBound="dgrdAddressList_ItemDataBound"
                                            OnSelectedIndexChanged="dgrdAddressList_SelectedIndexChanged">
                                            <FooterStyle HorizontalAlign="Center" />
                                            <PagerStyle HorizontalAlign="Left" NextPageText="&gt;&gt;" PrevPageText="&lt;&lt;"
                                                Mode="NumericPages" />
                                            <HeaderStyle VerticalAlign="Middle" Height="20px" HorizontalAlign="Center" BackColor="DarkGray"
                                                Font-Bold="True" Wrap="True"></HeaderStyle>
                                            <Columns>
                                                <asp:TemplateColumn HeaderText="S.No">
                                                    <HeaderStyle HorizontalAlign="Left" Width="5%" BackColor="DarkGray" VerticalAlign="Middle">
                                                    </HeaderStyle>
                                                    <ItemStyle HorizontalAlign="Left" Height="18px" />
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblRowCount" runat="server">
                                                        </asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Name" SortExpression="FullName">
                                                    <HeaderStyle HorizontalAlign="Left" Width="22%" BackColor="DarkGray" VerticalAlign="Middle">
                                                    </HeaderStyle>
                                                    <ItemStyle HorizontalAlign="Left" Height="18px"></ItemStyle>
                                                    <ItemTemplate>
                                                        <%# DataBinder.Eval(Container.DataItem, "FullName")%>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:BoundColumn HeaderText="Office Email" DataField="OfficialEmail" SortExpression="OfficialEmail">
                                                    <HeaderStyle HorizontalAlign="Left" Width="20%" BackColor="DarkGray" VerticalAlign="Middle">
                                                    </HeaderStyle>
                                                    <ItemStyle HorizontalAlign="Left" Height="18px"></ItemStyle>
                                                </asp:BoundColumn>
                                                <asp:BoundColumn HeaderText="Office Phone" DataField="OfficePhone">
                                                    <HeaderStyle HorizontalAlign="Left" Width="15%" BackColor="DarkGray" VerticalAlign="Middle">
                                                    </HeaderStyle>
                                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                </asp:BoundColumn>
                                                <asp:TemplateColumn HeaderText="Edit">
                                                    <HeaderStyle HorizontalAlign="Left" Width="6%" BackColor="DarkGray" VerticalAlign="Middle">
                                                    </HeaderStyle>
                                                    <ItemStyle HorizontalAlign="Center" Height="18px"></ItemStyle>
                                                    <ItemTemplate>
                                                        <a href="ContactInfoEntrycontent.aspx?UserId=<%# DataBinder.Eval(Container.DataItem, "UserID") %>">
                                                            <asp:Image ImageUrl="images/icon-pencil.gif" runat="server" ID="Image1" ToolTip="Edit"
                                                                Height="15px" ImageAlign="Top" Style="float: none"></asp:Image></a> <a href="ContactInfoListcontent.aspx?UserId=<%# DataBinder.Eval(Container.DataItem, "UserID") %>">
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Delete">
                                                    <HeaderStyle HorizontalAlign="Left" Width="6%" BackColor="DarkGray"></HeaderStyle>
                                                    <ItemStyle HorizontalAlign="Center" Height="18px"></ItemStyle>
                                                    <ItemTemplate>
                                                        <asp:ImageButton runat="server" ImageUrl="images/icon-delete.gif" ToolTip="Delete"
                                                            CommandName="Delete" CausesValidation="False" ID="imgDeleteButton" Height="15px"
                                                            ImageAlign="middle"></asp:ImageButton>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                            </Columns>
                                        </asp:DataGrid>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblDgVisible" Style="float: right" Visible="false" Width="615px" BorderColor="black"
                                            BorderWidth="1px" runat="server"></asp:Label></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <yui:YahooScriptManager ID="manager" runat="server" />
                    <div style="left: 150px; top: 80px; position: absolute; max-width: 800px">
                        <table border="0" id="table1" runat="server" style="left: 0px; position: absolute">
                            <tr class="background">
                                <td colspan="2" valign="middle">
                                    <table align="left">
                                        <tr>
                                            <td style="width: 400px">
                                            </td>
                                            <td align="right" class="" style="height: 15px; width: 300px; text-align: center;">
                                            </td>
                                            <td align="right">
                                                <span>
                                                    <asp:Label ID="lblUpdate" runat="server" ForeColor="Green" Text="Contact Information Saved"
                                                        Font-Bold="True" Width="197px"></asp:Label>
                                                </span>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td width="5px">
                                </td>
                                <td align="right">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="8" style="height: 12px" align="center">
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 13px">
                                </td>
                                <td style="height: 13px">
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
