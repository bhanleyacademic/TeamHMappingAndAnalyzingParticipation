<%@ control language="C#" autoeventwireup="true" inherits="UserContols_DatePicker, App_Web_datepicker.ascx.cc671b29" %>
<script src="../Javascript/DatePicker.js" language="javascript" type="text/javascript"></script>

<table border="0" runat="server" id="tblDate" cellpadding="0" cellspacing="0" width="180px">
    <tr>
        <td>
            <asp:TextBox ID="txtDate" Width="110" MaxLength="16" runat="server" CssClass="FlatText" ></asp:TextBox>
        </td>
        <td>
            <a id="lnkDatePicker" runat="server" class="linkbutton">
                <img id="imgDate" rkeat="server" alt="Select a Date" src="../Images/calendar.gif" border="0"
                    name="imgDate" title="Select a Date" /></a></td>
                  
    </tr>
</table>

<script language="javascript">
    InitializeCalendar('');
</script>