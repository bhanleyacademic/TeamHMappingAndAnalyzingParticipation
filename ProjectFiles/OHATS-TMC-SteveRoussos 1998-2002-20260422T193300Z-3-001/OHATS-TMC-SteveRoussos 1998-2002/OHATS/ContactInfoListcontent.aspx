<%@ page language="C#" autoeventwireup="true" masterpagefile="Event1.master" inherits="ContactInfo_Listuc, App_Web_contactinfolistcontent.aspx.cdcab7d2" title="Address Book" enableeventvalidation="false" %>

<%@ Register TagPrefix="obout" Namespace="OboutInc.Flyout2" Assembly="obout_Flyout2_NET" %>
<%@ Register Assembly="Web.YUI" Namespace="Web.YUI" TagPrefix="yui" %>
<asp:Content ID="List" runat="server" ContentPlaceHolderID="Main">

    <script language="javascript" type="text/javascript">
        function checkDelete() {
            var hdnDeleteValue = '<%= this.hdnDelete.ClientID %>';
            if (confirm('Are you sure you want to delete this item ?')) {
                //document.getElementById(hdnDelete).value='1';
                document.getElementById(hdnDeleteValue).value = '1';
                return true;
            }
            else {
                return false;
            }
        }
    </script>

    <div style="margin-top: 25px; text-align: left;">
        <center>
            <span style="font: 22px arial; color: red">ADDRESS BOOK </span>
        </center>
        <table border="0" cellpadding="0" cellspacing="0" style="margin: 0px 0px 0px 60px;"
            align="center" width="850">
            <tr>
                <td valign="top">
                    <div>
                        <table>
                            <tr>
                                <asp:HiddenField ID="hdnDelete" runat="server" />
                                <td valign="top" width="170">
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
                                                                <td valign="top" style="background: #f2f2f2; padding-left: 10px; width: 150px;">
                                                                    <asp:Label ID="lbltxt1" runat="server" Text="You have Selected" CssClass="desc" Font-Bold="True"
                                                                        Font-Size="13px" Style="float: left;"></asp:Label>
                                                                    <p style="float: left; margin: 5px 0px 0px 0px; clear: left; width: 125px;">
                                                                        <asp:Label ID="lblstate1" runat="server" Text="State:" Font-Bold="true" CssClass="ee"
                                                                            Font-Size="10" Style="float: left; clear: left;"></asp:Label>
                                                                        <asp:Label ID="lblstatename" runat="server" Font-Size="10pt" Text="" Style="float: left;
                                                                            margin-left: 10px;" CssClass="desc"></asp:Label>
                                                                    </p>
                                                                    <asp:LinkButton ID="lblremovestate" runat="server" Text="Remove" CssClass="desc"
                                                                        Style="float: right; margin: 5px 0px 0px 10px;" ToolTip="Remove" Font-Underline="true"
                                                                        ForeColor="Red" OnClick="lblremovestate_Click"></asp:LinkButton>
                                                                    <p style="clear: left; float: left;">
                                                                        <asp:Label ID="lblcity1" runat="server" Text="City:" Font-Bold="true" CssClass="ee"
                                                                            Style="float: left; clear: left;" Font-Size="10"></asp:Label>
                                                                        <asp:Label ID="lblcityname" CssClass="desc" runat="server" Font-Size="10pt" Style="float: left;
                                                                            margin-left: 10px;" Width="94px"></asp:Label>
                                                                    </p>
                                                                </td>
                                                            </tr>
                                                            <tr align="left" class="background">
                                                                <td colspan="2">
                                                                    <asp:LinkButton ID="lblremovecity" runat="server" Text="Remove" CssClass="desc" ToolTip="Remove"
                                                                        Font-Underline="true" ForeColor="Red" OnClick="lblremovecity_Click"></asp:LinkButton>
                                                                </td>
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
                                                    <td style="background: #f2f2f2; padding: 5px; width: 150px;">
                                                        <asp:Label ID="Label1" runat="server" Text="State" Style="color: Black" CssClass="Label"
                                                            Font-Bold="True" BackColor="" Font-Size="12px" Font-Italic="True"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr class="background">
                                                    <td id="td_State" runat="server">
                                                        <asp:Label ID="lblbindstate" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr class="background">
                                                    <td style="background: #f2f2f2; padding: 5px; width: 150px;">
                                                        <asp:Label ID="Label2" runat="server" Text="City" CssClass="Label" Font-Bold="true"
                                                            Font-Italic="true"></asp:Label>
                                                    </td>
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
                </td>
                <td valign="top" width="650">
                    <table border="0" cellpadding="0" cellspacing="0" width="650" style="margin: 0px 0px 0px 70px;">
                        <tr>
                            <!--amala remove this CssClass="button3" it is not working -->
                            <td valign="top">
                                <asp:Button ID="btnaddnew" runat="server" Text="Add New Contact" OnClick="btnaddnew_Click"
                                    Style="float: right; margin-right: 34px; cursor: pointer;" Width="145px" />
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" style="padding: 10px 0px 0px 0px;">
                                <span style="font: bold 12px tahome; color: green;">Find By Alphabet:</span> <a href="ContactInfoListcontent.aspx?BLet=0">
                                    All</a><span style="margin: 0px 1px 0px 1px;">|</span> <a href="ContactInfoListcontent.aspx?BLet=A">
                                        A</a><span style="margin: 0px 1px 0px 1px;">|</span> <a href="ContactInfoListcontent.aspx?BLet=B">
                                            B</a><span style="margin: 0px 1px 0px 1px;">|</span> <a href="ContactInfoListcontent.aspx?BLet=C">
                                                C</a><span style="margin: 0px 1px 0px 1px;">|</span> <a href="ContactInfoListcontent.aspx?BLet=D">
                                                    D</a><span style="margin: 0px 1px 0px 1px;">|</span> <a href="ContactInfoListcontent.aspx?BLet=E">
                                                        E</a><span style="margin: 0px 1px 0px 1px;">|</span> <a href="ContactInfoListcontent.aspx?BLet=F">
                                                            F</a><span style="margin: 0px 1px 0px 1px;">|</span>
                                <a href="ContactInfoListcontent.aspx?BLet=G">G</a><span style="margin: 0px 1px 0px 1px;">|</span>
                                <a href="ContactInfoListcontent.aspx?BLet=H">H</a><span style="margin: 0px 1px 0px 1px;">|</span>
                                <a href="ContactInfoListcontent.aspx?BLet=I">I</a><span style="margin: 0px 1px 0px 1px;">|</span>
                                <a href="ContactInfoListcontent.aspx?BLet=J">J</a><span style="margin: 0px 1px 0px 1px;">|</span>
                                <a href="ContactInfoListcontent.aspx?BLet=K">K</a><span style="margin: 0px 1px 0px 1px;">|</span>
                                <a href="ContactInfoListcontent.aspx?BLet=L">L</a><span style="margin: 0px 1px 0px 1px;">|</span>
                                <a href="ContactInfoListcontent.aspx?BLet=M">M</a><span style="margin: 0px 1px 0px 1px;">|</span>
                                <a href="ContactInfoListcontent.aspx?BLet=N">N</a><span style="margin: 0px 1px 0px 1px;">|</span>
                                <a href="ContactInfoListcontent.aspx?BLet=O">O</a><span style="margin: 0px 1px 0px 1px;">|</span>
                                <a href="ContactInfoListcontent.aspx?BLet=P">P</a><span style="margin: 0px 1px 0px 1px;">|</span>
                                <a href="ContactInfoListcontent.aspx?BLet=Q">Q</a><span style="margin: 0px 1px 0px 1px;">|</span>
                                <a href="ContactInfoListcontent.aspx?BLet=R">R</a><span style="margin: 0px 1px 0px 1px;">|</span>
                                <a href="ContactInfoListcontent.aspx?BLet=S">S</a><span style="margin: 0px 1px 0px 1px;">|</span>
                                <a href="ContactInfoListcontent.aspx?BLet=T">T</a><span style="margin: 0px 1px 0px 1px;">|</span>
                                <a href="ContactInfoListcontent.aspx?BLet=U">U</a><span style="margin: 0px 1px 0px 1px;">|</span>
                                <a href="ContactInfoListcontent.aspx?BLet=V">V</a><span style="margin: 0px 1px 0px 1px;">|</span>
                                <a href="ContactInfoListcontent.aspx?BLet=W">W</a><span style="margin: 0px 1px 0px 1px;">|</span>
                                <a href="ContactInfoListcontent.aspx?BLet=X">X</a><span style="margin: 0px 1px 0px 1px;">|</span>
                                <a href="ContactInfoListcontent.aspx?BLet=Y">Y</a><span style="margin: 0px 1px 0px 1px;">|</span>
                                <a href="ContactInfoListcontent.aspx?BLet=Z">Z</a>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" style="padding: 10px 0px 0px 0px">
                                <span style="font: bold 12px tahome; color: green;">Find By Contact Status:</span>
                                <a href="ContactInfoListcontent.aspx?show=showall">Show All |</a> <a href="ContactInfoListcontent.aspx?show=Activeuser">
                                    Active User |</a> <a href="ContactInfoListcontent.aspx?show=Inactiveuser">Inactive User|</a>
                                <a href="ContactInfoListcontent.aspx?show=Pending">Pending</a>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" width="650" style="padding-top: 5px">
                                <table width="100%">
                                    <tr>
                                        <td>
                                            <p style="float: left; padding: 5px 0px 5px 0px">
                                                <asp:Label ID="records" runat="server" Text="Number of records:" Width="110px" Style="float: left;
                                                    font: bold 12px tahome; color: green;"></asp:Label>
                                                <asp:Label ID="recordnumber" runat="server" Style="float: left; margin: 1px 0px 0px 3px;"></asp:Label>
                                            </p>
                                        </td>
                                        <td>
                                            <p style="float: right; padding: 5px 34px 0px 0px;">
                                                <asp:Label ID="select" runat="server" Text="Select Page Size:" Width="110px" Style="float: left;
                                                    font: bold 12px tahome; color: green;"></asp:Label>
                                                <asp:DropDownList ID="ddlContacts" runat="server" CssClass="Label" AutoPostBack="True"
                                                    Style="float: left; outline: none;" OnSelectedIndexChanged="ddlContacts_SelectedIndexChanged">
                                                    <asp:ListItem Value="2">10</asp:ListItem>
                                                    <asp:ListItem Value="3">25</asp:ListItem>
                                                    <asp:ListItem Value="4">50</asp:ListItem>
                                                    <asp:ListItem Value="5">100</asp:ListItem>
                                                    <asp:ListItem Value="6">200</asp:ListItem>
                                                    <asp:ListItem Value="7">500</asp:ListItem>
                                                    <asp:ListItem Value="8">1000</asp:ListItem>
                                                </asp:DropDownList>
                                            </p>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <%-- this is my source--%>
                        <tr>
                            <td align="center" style="padding-top: 10px;">
                                <asp:Label ID="lblDgVisible" Style="float: left;" Visible="false" Width="615px" BorderColor="black"
                                    BorderWidth="1px" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" style="padding: 10px 0px 0px 0px;">
                                <asp:DataGrid ID="dgrdAddressList" runat="server" OnPageIndexChanged="dgrdAddressList_PageIndexChanged"
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
                                                <a href="Contactinfo.aspx?UserId=<%# DataBinder.Eval(Container.DataItem, "UserID") %>">
                                                    <asp:Image ImageUrl="images/icon-pencil.gif" runat="server" ID="Image1" ToolTip="Edit"
                                                        Height="15px" ImageAlign="Top" Style="float: none"></asp:Image></a> <a href="ContactInfoListcontent.aspx?UserId=<%# DataBinder.Eval(Container.DataItem, "UserID") %>">
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="View" Visible="false">
                                            <HeaderStyle HorizontalAlign="Left" Width="6%" BackColor="DarkGray" VerticalAlign="Middle">
                                            </HeaderStyle>
                                            <ItemStyle HorizontalAlign="Center" Height="18px"></ItemStyle>
                                            <ItemTemplate>
                                                <a href="GustContactinfoViewDetails.aspx?UserId=<%# DataBinder.Eval(Container.DataItem, "UserID") %>">
                                                    <asp:Image ImageUrl="images/icon-pencil.gif" runat="server" ID="Image2" ToolTip="View"
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
                    </table>
                </td>
            </tr>
        </table>
        <table border="0" cellpadding="0" cellspacing="0" style="margin-top: 20px;">
            <tr>
                <td>
                    <%--<div style="left: 280px; top: 270px; position: absolute; float: left;">
                        <table cellspacing="0" cellpadding="0" border="0" style="left: 0px; top: 0px; position: absolute">
                            <tbody valign="top">
                                <tr>
                                    <td valign="top" style="width: 811px; text-align: left;" colspan="2">
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>--%>
                    <yui:YahooScriptManager ID="manager" runat="server" />
                    <div>
                        <table border="0" id="table1" runat="server">
                            <tr class="background">
                                <td colspan="2" valign="middle">
                                    <table align="left">
                                        <tr>
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
