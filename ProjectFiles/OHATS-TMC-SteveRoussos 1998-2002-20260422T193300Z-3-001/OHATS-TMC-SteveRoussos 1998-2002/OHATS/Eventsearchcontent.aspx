<%@ page language="C#" autoeventwireup="true" masterpagefile="Event1.master" inherits="Eventsearch, App_Web_eventsearchcontent.aspx.cdcab7d2" enablesessionstate="True" title="Advanced Search" enableeventvalidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" EnableViewState="true" ContentPlaceHolderID="Main" runat="Server">

    <script language="javascript" type="text/javascript">
        var txtFromDate = '<%= this.txtFromdate.ClientID%>';
        var txtToDate = '<%= this.txtTodate.ClientID%>';
        var Calendar1='<%= this.Calendar1.ClientID%>';
        var calDate = '<%= this.calDate.ClientID%>';
        function ChangeToDate(sender, args) {
            
            var txtCal = document.getElementById(txtFromDate);
            var txtCalTo = document.getElementById(txtToDate);
            var selectedDate = new Date(sender._selectedDate);
            var hdnToDate = document.getElementById('<%= this.hdnToDate.ClientID%>');
            hdnToDate.value = selectedDate.format('MM/dd/yyyy');
            if (txtCal.value != "") {
                var checkDate = new Date(txtCal.value);
                if (selectedDate < checkDate) {
                    txtCalTo.value = '';
                    alert("To date should be greater than From date");
                    return false;
                }

            }

            else {
                txtCalTo.value = '';
                alert("Choose From date");
                return false;
            }

        }
        function ChangeFromDate(sender, args) {
           
            var txtCal = document.getElementById(txtFromDate);
            var txtCalTo = document.getElementById(txtToDate);
            var selectedDate = new Date(sender._selectedDate);
            var hdnFromDate = document.getElementById('<%= this.hdnFromDate.ClientID%>');
            hdnFromDate.value = selectedDate.format('MM/dd/yyyy');
            if (txtCalTo.value != "") {
                var checkDate = new Date(txtCalTo.value);
                if (selectedDate > checkDate) {
                    txtCal.value = '';
                    alert("From date should be smaller than To date");
                    return false;
                }
            }

        }

        function imgFromClick(sender, args) {

            $find("<%=Calendar1.ClientID%>").hide();
            return false;

    }
    function imgToClick(sender, args) {

        $find("<%=calDate.ClientID%>").hide();
        return false;
        
    }
              
    </script>

    <table width="800px">
        <tr>
            <td align="center" style="font-size: x-large; font-family: Arial; font-weight: bold;
                color: Red;">
                <asp:Label ID="lblheader" Text="Event Search" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <div style="background: #e2ebf4; width: 800px; height: 130px; padding-top: 5px; padding-left: -50px;
        padding-right: -50px;" align="center">
        <center>
            <table width="800px" align="center">
                <tr>
                    <td colspan="6" style="text-align: left;">
                        <asp:Label ID="lblalert" runat="server" Visible="False" Text="*" ForeColor="Red"></asp:Label>
                    </td>
                </tr>
                <!-- this is first row-->
            </table>
            <table style="padding-right: 20px">
                <tr>
                    <td nowrap align="left" style="font-family: Tahoma; height: 24px; padding-left: 5px;
                        padding-right: 5px">
                        <asp:Label ID="lblItemType" runat="server" Text="Item Type"></asp:Label>
                    </td>
                    <td colspan="5" align="left" style="padding-left: 2px; outline: none;">
                        <asp:DropDownList ID="ddlItemType" Visible="true" CssClass="evntdrop" Style="border-color: #76A7EF;
                            border-width: 1px;" runat="server" Width="230px" DataTextField="Eventname" Font-Names="Arial">
                            <asp:ListItem Value="0">All Records</asp:ListItem>
                            <asp:ListItem>Blog</asp:ListItem>
                            <asp:ListItem>Discussion Group or List Communication</asp:ListItem>
                            <asp:ListItem>Email Communication</asp:ListItem>
                            <asp:ListItem>Event other than Meeting</asp:ListItem>
                            <asp:ListItem>Meeting by Phone</asp:ListItem>
                            <asp:ListItem>Meeting in Person</asp:ListItem>
                            <asp:ListItem>Personal Reflection</asp:ListItem>
                            <asp:ListItem>Other</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td nowrap align="left" style="padding-left: 13px; padding-right: 5px">
                        <asp:Label ID="lblEventType" runat="server" Text="Event Type"></asp:Label>
                    </td>
                    <td align="left" style="width: 5%; padding-left: 3px">
                        <asp:DropDownList ID="ddlEventtype" Style="border-color: #76A7EF; border-width: 1px;"
                            Visible="true" runat="server" Width="150px" CssClass="evntdrop">
                            <asp:ListItem Selected="True" Value="0">All Records</asp:ListItem>
                            <asp:ListItem Value="1">CommunitySystemchange</asp:ListItem>
                            <asp:ListItem Value="2">Media</asp:ListItem>
                            <asp:ListItem Value="3">CommunityAction</asp:ListItem>
                            <asp:ListItem Value="4">Resources</asp:ListItem>
                            <asp:ListItem Value="5">Services</asp:ListItem>
                            <asp:ListItem Value="6">PlanningAndDevelopment</asp:ListItem>
                            <asp:ListItem Value="7">CriticalEvent</asp:ListItem>
                            <asp:ListItem Value="8">Other</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td nowrap align="left" style="padding-left: 10px">
                        <asp:Label ID="lblEventGoals" runat="server" Text="Event Goals"></asp:Label>
                    </td>
                    <td align="left" style="padding-left: 15px;">
                        <asp:DropDownList ID="ddlEventGoals" Visible="true" runat="server" Width="150px"
                            CssClass="evntdrop" Style="border-color: #76A7EF; border-width: 1px;">
                            <asp:ListItem Value="0">All Records</asp:ListItem>
                            <asp:ListItem>PublicAwareness</asp:ListItem>
                            <asp:ListItem>Technology</asp:ListItem>
                            <asp:ListItem>Research</asp:ListItem>
                            <asp:ListItem>Training</asp:ListItem>
                            <asp:ListItem>ResourceDevelopment</asp:ListItem>
                            <asp:ListItem>StratergicEvents</asp:ListItem>
                            <asp:ListItem>Others</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <!-- six td-->
                <tr>
                    <%-- from and to calender--%>
                    <td align="left" style="padding-left: 5px; padding-top: 1%;">
                        <asp:Label ID="lblRecorder" runat="server" Text="Recorder"></asp:Label>
                    </td>
                    <td colspan="5" style="width: 70px; padding-top: 6px; padding-left: 1.5px">
                        <asp:DropDownList ID="ddlRecorder" Style="border-color: #76A7EF; border-width: 1px;"
                            CssClass="evntdrop" runat="server" Width="230px" DataTextField="FullName" DataValueField="UserId"
                            Font-Names="Arial">
                        </asp:DropDownList>
                    </td>
                    <%-- from and to calender--%>
                    <td align="left" style="width: 2.5%; padding-left: 13px; padding-top: 1%;">
                        <asp:Label ID="lblState" runat="server" Text="State"></asp:Label>
                    </td>
                    <td align="left" style="padding-left: 3px; padding-top: 1%;">
                        <asp:DropDownList ID="ddlState" CssClass="evntdrop" Style="border-color: #76A7EF;
                            border-width: 1px; height: 19px;" runat="server" Width="150px" DataTextField="State">
                        </asp:DropDownList>
                    </td>
                    <%-- recorder--%>
                    <td align="left" style="padding-left: 10px; padding-top: 1%;">
                        <asp:Label ID="lblCountry" runat="server" Text="Country"></asp:Label>
                    </td>
                    <td align="left" style="padding-left: 15px; width: 8%; padding-top: 1%;">
                        <asp:DropDownList ID="ddlCountry" runat="server" CssClass="evntdrop" Width="150px"
                            DataTextField="Country" Style="border-color: #76A7EF; border-width: 1px;">
                        </asp:DropDownList>
                    </td>
                    <%-- recorder--%>
                </tr>
                <tr>
                    <%--   country--%>
                    <td align="left" style="padding-left: 5px; padding-top: 1%;">
                        <asp:Label ID="lblFrom" runat="server" Text="From"></asp:Label>
                    </td>
                    <td align="left" style="padding-left: 1.5px; padding-top: 6px; width: 70px;">
                        <asp:TextBox ID="txtFromdate" runat="server" CssClass="evntdrop" Width="70px" ValidationGroup="1"
                            ReadOnly="true" Style="background: lightyellow;"></asp:TextBox>
                    </td>
                    <td style="padding-top: 1%; padding-right: 2px;">
                       
                           
                           <img id="imgFrom" runat="server" src="~/Images/clr.jpg"   alt="Select Date" style="cursor:pointer" onclick ="javascript:return imgFromClick();"  />
                                <cc1:CalendarExtender ID="calDate" runat="server"  CssClass="cal_Theme1" TargetControlID="txtFromdate" PopupButtonID="imgFrom" OnClientDateSelectionChanged="ChangeFromDate">
                                </cc1:CalendarExtender>
                           
                    </td>
                    <td align="left" style="padding-left: 1%; padding-right: 10px; padding-top: 1%;">
                        <asp:Label ID="LblTo1" runat="server" Text="To"></asp:Label>
                    </td>
                    <td align="left" style="padding-left: 2px; padding-top: 5px; width: 70px; height: 21px;">
                        <asp:TextBox ID="txtTodate" runat="server" Width="70px" CssClass="evntdrop" ValidationGroup="1"
                            ReadOnly="true" Style="background: lightyellow"></asp:TextBox>
                    </td>
                    <td style="padding-top: 1%;">
                         <img id="imgTo" runat="server" src="~/Images/clr.jpg" alt="Select Date" style="cursor:pointer" onclick ="javascript:return imgToClick();"  />
                            
                          
                                <cc1:CalendarExtender ID="Calendar1"   runat="server" CssClass="cal_Theme1" TargetControlID="txtTodate" PopupButtonID="imgTo"
                                    OnClientDateSelectionChanged="ChangeToDate">
                                </cc1:CalendarExtender>
                                
                                
                                 <asp:HiddenField ID="hdnFromDate" runat="server" />
                                                         <asp:HiddenField ID="hdnToDate" runat="server" />
                            
                    </td>
                    <%--   country--%>
                </tr>
                <tr>
                    <td colspan="10" class="td1" style="padding-bottom: 10px">
                        <asp:Button ID="btnSearch" runat="server" Text="Search" Style="cursor: pointer;"
                            OnClick="btnSearch_Click" ValidationGroup="1" CssClass="finishbutton"></asp:Button>
                        <asp:Button ID="btnReset" runat="server" Text="Reset" Style="cursor: pointer;" OnClick="btnReset_Click"
                            CssClass="finishbuttonleft"></asp:Button>
                    </td>
                </tr>
                <tr>
                    <td colspan="10" style="padding: 0px 0px 0px 0px">
                        <asp:Label ID="lbl_ErrMsg" runat="server" Text="Label" Visible="False"></asp:Label>
                        <asp:Label ID="lblErrMsg" runat="server" Text="Label" Visible="False"></asp:Label>
                    </td>
                </tr>
            </table>
    </div>
    </center>
    <div>
        <table border="0" cellpadding="0" cellspacing="0" width="800" align="center">
            <tr>
                <td colspan="5" style="height: 20px; display: inline; text-align: center">
                    <span style="font: 16px arial; color: red; float: left; vertical-align: middle; margin-top: 10px;">
                        Search Result:</span>
                </td>
            </tr>
            <tr>
                <td style="padding-bottom: -5px; padding-top: 3px;">
                    <span style="float: left;">
                        <asp:Label ID="LblNumRecords" runat="server" Text="Number of records :" Style="float: left;"
                            Font-Bold="True" Visible="False"></asp:Label>
                        <asp:Label ID="LblTotal" runat="server" Visible="False" Style="padding-left: 10px"></asp:Label>
                    </span><span style="margin: 0px 0px 0px 450px; float: left;">
                        <asp:Label CssClass="noofrec" ID="lblExport" runat="server" Text="Export To"></asp:Label>&nbsp;
                        <asp:ImageButton ID="imgExcel" runat="server" ToolTip="Open in Excel 2007 only" ImageUrl="~/Images/Excel2007.png"
                            OnClick="imgExcel_Click" Style="position: relative; margin-bottom: -3px;" />
                        <asp:ImageButton ID="imgWord" Visible="false" runat="server" ToolTip="Export to Word"
                            ImageUrl="Images/doc.gif" OnClick="imgWord_Click" Style="position: relative;
                            margin-bottom: -3px;" />
                    </span>
                </td>
            </tr>
            <tr>
                <!-- class="GridPager"-->
                <td align="center" width="100%" bordercolor="black">
                    <table height="14" cellspacing="1" cellpadding="1" border="0" bordercolor="black">
                        <tr>
                            <td valign="middle">
                                <asp:LinkButton ID="lnkPrev" runat="server" Visible="False">&lt;&lt;Prev&nbsp;&nbsp;</asp:LinkButton>
                            </td>
                            <td valign="top" height="11" style="font: 14px arial; color: red; letter-spacing: 1.5px;">
                                <asp:DataList ID="ddlPage" Visible="true" OnItemCommand="ddlPage_ItemCommand" OnItemDataBound="ddlPage_ItemDataBound"
                                    runat="server" Style="" CssClass="bodylinksb" DataKeyField="Key" RepeatDirection="Horizontal">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lbtnPage" runat="server" ForeColor="black" CommandName='<%# DataBinder.Eval(Container.DataItem, "Key") %>'
                                            Text='<%# DataBinder.Eval(Container.DataItem, "Value") %>'>	<%# DataBinder.Eval(Container.DataItem, "Value") %>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:DataList>
                            </td>
                            <td valign="middle">
                                <asp:LinkButton ID="lnkNext" runat="server" Visible="False">&nbsp;&nbsp;Next&gt;&gt;</asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="text-align: Left; height: 220px; width: 850px;" colspan="6" valign="top">
                    <asp:GridView ID="dtgEventsearch" runat="server" BorderColor="DarkGray" Width="100%"
                        CellPadding="7" PageSize="10" EmptyDataText="No data available." Style="z-index: 113;"
                        OnRowCreated="GridViewList_RowCreated" AutoGenerateColumns="False" AllowPaging="true"
                        AllowSorting="True" OnPageIndexChanging="gridEventList_PageIndexChanging" OnSorting="gridEventList_Sorting"
                        OnSorted="gridEventList_Sorted" OnRowDataBound="dtgEventsearch_RowDataBound">
                        <HeaderStyle VerticalAlign="Middle" HorizontalAlign="Center" BackColor="lightblue"
                            Font-Bold="True" Wrap="True" Height="20px"></HeaderStyle>
                        <Columns>
                            <asp:TemplateField HeaderText="Action" Visible="false">
                                <ItemStyle HorizontalAlign="center" Width="20px"></ItemStyle>
                                <ItemTemplate>
                                    <a href="GuestViewDetails.aspx?Eventid=<%# DataBinder.Eval(Container.DataItem, "EventId") %>">
                                        <asp:Image ID="Image1" ImageUrl="Images/icon-pencil.gif" runat="server" ToolTip="View Event Information"
                                            Style="text-align: center; margin-left: 20px;" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Action">
                                <ItemStyle HorizontalAlign="Center" Width="20px"></ItemStyle>
                                <ItemTemplate>
                                    <a href="Update.aspx?Eventid=<%# DataBinder.Eval(Container.DataItem, "EventId") %>">
                                        <asp:Image ID="Image1" ImageUrl="Images/icon-pencil.gif" runat="server" ToolTip="Edit Event Information"
                                            Style="text-align: center; margin-left: 20px;" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Date" SortExpression="EventOccuredDate" HeaderText="Date">
                                <ItemStyle Width="100px" HorizontalAlign="Center" Height="20px" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ItemDescription" HeaderText="Item Description" ItemStyle-CssClass="search">
                                <ItemStyle Width="350px" HorizontalAlign="Left" VerticalAlign="Top" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ItemMeaning" HeaderText="Item Meaning" ItemStyle-CssClass="search">
                                <ItemStyle Width="250px" HorizontalAlign="Left" VerticalAlign="Top" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ItemResult" HeaderText="Item Result" ItemStyle-CssClass="search">
                                <ItemStyle Width="250px" HorizontalAlign="Left" VerticalAlign="Top" />
                            </asp:BoundField>
                        </Columns>
                        <EmptyDataRowStyle HorizontalAlign="Center" Wrap="False" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="SortInformationLabel" ForeColor="Navy" runat="server" />
                    <asp:HiddenField ID="h1" runat="server" />
                    <asp:HiddenField ID="h2" runat="server" />
                    <asp:HiddenField ID="h3" runat="server" />
                    <asp:HiddenField ID="h4" runat="server" />
                    <asp:HiddenField ID="h5" runat="server" />
                    <asp:HiddenField ID="hdfContent" runat="server" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
