<%@ page language="C#" masterpagefile="Event1.master" autoeventwireup="true" inherits="CredentialMetrics, App_Web_credentialmetrics.aspx.cdcab7d2" title="Credential Metrics" %>

<%@ Register TagPrefix="Graph1" TagName="CardGraph" Src="Controls/Metrics/Line.ascx" %>
<%@ Register TagPrefix="Graph2" TagName="CardBarGraph" Src="Controls/Metrics/Bar.ascx" %>
<%@ Register TagPrefix="Graph3" TagName="CardPieGraph" Src="Controls/Metrics/Pie.ascx" %>
<%@ Register TagPrefix="Graph4" TagName="Horizontalbar" Src="Controls/Metrics/Horizontalbar.ascx" %>
<%@ Register TagPrefix="Graph5" TagName="ItemNovelty" Src="Controls/Metrics/ItemNovelty.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Main" Runat="Server">
    <%--<div style="DISPLAY: inline; Z-INDEX: 103; LEFT: 20px; FLOAT: left; WIDTH: 162px; POSITION: absolute; TOP: 100px; HEIGHT: 180px; text-align: center;">
      <Graph1:CardGraph id="CardGraph1" runat="server"></Graph1:CardGraph> 
    </div>--%>
    
     <table border="0" cellpadding="1" cellspacing="1" width="900" align="center" style="margin-top: 10px;">
        <tr>
            <td valign="top" style="padding: 10px 0px 10px 0px;">
                <Graph4:Horizontalbar ID="Horizontalbar" runat="server" />
            </td>
            <td valign="top" style="font-family: Arial; font-size: 12px; line-height: 15px; padding-left: 5px;text-align:justify;padding-top:9px">
                <span><b><u><font size="2">Strategic Actions of Tutor/Mentor Connection: </font></u>
                </b>
                    <br />
                    <br />
                    Five interconnected strategies guide actions and events employed by T/MC: Public
                    Awareness, research, resource building, technology, training, and networking events.
                    Each of these strategies, and thus the events and actions that they represent, are
                    interconnected and simultaneous. For instance, T/MC research on tutor/mentor programs
                    characteristics and needs is not only a fact-finding activity, but also a process
                    of building awareness of what programs exist and building a connection between programs.
                    Every new contact documented in OHATS represents a new piece of knowledge in this
                    research. The T/MC contact database that began with 400 people in 1993 now has over
                    14,000 contacts is one sign of this growth of knowledge. Another example of the
                    interconnection across strategies is how technology (as a strategy) is also a resource,
                    but is so important to the T/MC mission that it is documented separately. All events
                    that T/MC leads are strategically designed to generate public awareness, resources,
                    and training. To read more and discuss this information
                    <br />
                    <br />
                    <a style="color:Blue;text-decoration:underline;" href="http://tutormentorconnection.ning.com/group/ohatsmetrics/forum/topics/tmc-ohats-goals-that-are">
                        click this link.</a> </span>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <Graph2:CardBarGraph ID="CardBarGraph" runat="server">
                </Graph2:CardBarGraph>
            </td>
            <td valign="top" style="font-family: Arial; font-size: 12px; line-height: 15px; padding-left: 5px;text-align:justify;">
                <span><b><u><font size="2">Measures of Community Change</font></u></b>
                    <br />
                    <br />
                    Of all the types of events and actions categorized in OHATS, community change is
                    of particular importance. Community change is measured as new or modified programs,
                    practices or policies related to the mission of T/MC. These are changes in the environment
                    that alter the conditions that shape individual and organizational behaviors. Studies
                    of comprehensive community initiatives indicate the rate of community change may
                    be related to the rate of population-level health and development outcomes. Therefore,
                    community change is tracked as an intermediate marker of broader, more distal population
                    outcomes. To read more about the actions that are documented, and the meaning of
                    this information:<br />
                    <br />
                    <a style="color:Blue;text-decoration:underline;" href="http://tutormentorconnection.ning.com/group/ohatsmetrics/forum/topics/metrics-tutormentor-events-1">
                        click this link</a></span>
            </td>
        </tr>
        <tr>
            <td valign="top" style="padding-top:9px">
                <Graph3:CardPieGraph ID="CardPieGraph1" runat="server" />
            </td>
            <td valign="top" style="font-family: Arial; font-size: 12px; line-height: 15px; padding-left: 5px;text-align:justify;padding-top:9px">
                <span><b><u><font size="2">Event Duration<br />
                    <br />
                </font></u></b>Though a given event or action may be powerful enough to produce behavior
                    or organizational outcomes after a single exposure, experience suggests that this
                    is not the norm. The longevity of any given event can determine the opportunity
                    for exposure to that event or change. And, exposure to an event is a prerequisite
                    for producing an outcome.The vast majority (82%) of changes facilitated by T/MC
                    from 2000 through April 2008 were intended to be ongoing. Some examples are the
                    citywide volunteer recruitment fair held every August/September since 1995 and the
                    training and networking conference held every May and November since 1994. The building
                    of OHATS is an example of an ongoing event that will be enhanced and engage new
                    partners over the years. Another on-going event is the Chicago Tutor/Mentor Program
                    locator, which demonstrates the T/MC’s fundamental commitment to help tutor/mentor
                    programs in every part of the Chicago region get volunteers and donors. To read
                    more and discuss this information
                    <br />
                    <br />
                    <a style="color:Blue;text-decoration:underline;" href="http://tutormentorconnection.ning.com/group/ohatsmetrics/forum/topics/metrics-tutormentor-events-1 ">
                        click this link</a></span>
            </td>
        </tr>
        <tr>
            <td valign="top" style="padding: 10px 0px 10px 0px;">
                <Graph5:ItemNovelty ID="ItemNovelty" runat="server" />
            </td>
            <td valign="top" style="font-family: Arial; font-size: 12px; line-height: 15px; padding-left: 5px;text-align:justify;padding-top:9px">
                <span><b><u><font size="2">Event Innovation</font></u></b><br />
                    <br />
                    Equally important to the abilities to create actions that endure time and to sustain
                    events over multiple years are the abilities to adapt to changing conditions and
                    to innovate. Reporters were prompted to categorize an event into one of the four
                    groups: “new” (not existing in the prior history of T/MC work), “modified” (having
                    occurred before, but modified in some important way), “existing,” or “other” (for
                    uncertain or events with no clear category). The vast majority of events were either
                    new or modified. Examples of new events include the creation of OHATS and the start
                    of new working relationships and collaborations to conduct the GIS mapping work,
                    the volunteer recruitment campaign, and the training and networking conferences.
                    Modified events included enhancements to the major T/MC events and actions that
                    grow and reach more people each year, such as the Program Locator database, the
                    T/MC web site and social networking portals, the T/MC leadership and networking
                    conferences and the Lend-A-Hand Program. To read more and discuss this information
                    <br />
                    <br />
                    <a style="color:Blue;text-decoration:underline;" href="http://tutormentorconnection.ning.com/group/ohatsmetrics/forum/topics/tmc-ohats-event-innovation-1">
                        click this link.</a></span>
            </td>
        </tr>
        <tr>
            <td valign="top" style="height: 320px">
                <Graph1:CardGraph ID="CardGraph1" runat="server">
                </Graph1:CardGraph>
            </td>
            <td valign="top" style="font-family: Arial; font-size: 12px; line-height: 15px; padding-left: 5px; text-align:justify;">
                <span><b><u><font size="2">Community System Change Events</font></u></b><br />
                    <br />
                    This chart shows that T/MC was actively using the OHATS when it was new, but that
                    between 2003 and 2007 OHATS was used less frequently. This was because the system
                    did not update automatically, and was creating a growing list of actions (over 900
                    by 2007) which no observer would scroll through to read and understand the T/MC
                    accomplishments, or actions that led to those accomplishments. While T/MC recognized
                    the problems with OHATS, it was unable to find a donor to help fund the needed work,
                    or a volunteer who would do this work on a pro bono basis. With the changes provided
                    by this new version (launched in early 2008, is also a growth in the use of OHATS.
                    There is still work to be done which requires donor or sponsor support. To read
                    more and discuss this information:
                    <br />
                    <br />
                    <a style="color:Blue;text-decoration:underline;" href=" http://tutormentorconnection.ning.com/group/ohatsmetrics/forum/topics/tmc-ohats-log-in-to-review">
                        click this link.</a>
                        
                        </span>
            </td>
        </tr>
        <tr>
            <td valign="top" style="font-family: Arial; font-size: 12px; line-height: 15px; padding-left: 5px;text-align:justify;"
                colspan="2">
                <br />
                <span><b><u><font size="2">Results of actions documented in T/MC OHATS</font></u></b><br />
                    <br />
                    Below are four links to web pages that illustrate the results of actions documented
                    in OHATS by the T/MC since 2000. These are on-going projects, which are intended
                    to help people understand where and why tutor/mentor programs are needed, while
                    helping parents, volunteers and donors connect with specific programs already operating
                    in the Chicago region.
                    <br />
                    <br />
                    Interactive Program Locator Map <a style="color:Blue;text-decoration:underline;" href=" http://www.tutormentorprogramlocator.net//InteractiveMap.aspx">
                        - use this to find contact information for tutoring and/or mentoring programs, or
                        to build strategies that support programs in different areas </a></span>
            </td>
        </tr>
        <tr>
             <td valign="top"  style="font-family: Arial;padding-left:5px; text-align:left; font-size: 12px; line-height: 15px; "
                colspan="2">
                
                   <br />
                   <br />
                    Program Locator <a style="color:Blue;text-decoration:underline;" href=" http://www.tutormentorprogramlocator.net">- you can search
                        for a tutor/mentor program by type of program, age group served, and zip code</a>
                
            </td>
        </tr>
        <tr>
            <td valign="top" style="font-family: Arial; text-align:left; font-size: 12px; line-height: 15px; padding-left: 5px"
                colspan="2">
                    <br />
                    <br />
                    T/MC links library <a style="color:Blue;text-decoration:underline;" href="http://cmapspublic.ihmc.us/servlet/SBReadResourceServlet?rid=1238727620203_1951466067_30266&partName=htmltext">
                        - more than 1500 links, organized by categories. Useful to leaders, donors, volunteers,
                        students, researchers, etc. </a>
            </td>
        </tr>
        <tr>
            <td valign="top" style="font-family: Arial; text-align:left; font-size: 12px; line-height: 15px; padding-left: 5px"
                colspan="2">
                
                    <br />
                    <br />
                    T/MC Leadership and Networking Conference <a style="color:Blue;text-decoration:underline;" href="http://www.tutormentorconference.org">
                        http://www.tutormentorconference.org </a>
            </td>
        </tr>
        <tr>
            <td valign="top" style="font-family: Arial; font-size: 12px; line-height: 15px; padding-left: 5px;text-align:justify;"
                colspan="2">
                <span style="font-family: Verdana; font-size: 12px"><b><u><font size="2"></font></u>
                </b>
                    <br />
                    <br />
                    Volunteer time and talent with the Tutor/Mentor Connection. If you would like to
                    help with OHATS or in other ways view this  <a style="color:Blue;text-decoration:underline;"  href="http://www.tutormentorconnection.org/GetInvolved/VolunteerforTMC/tabid/644/Default.aspx">
                        list of volunteer roles </a></span>. Call 312-492-9614 or email tutormentor2@earthlink.net
                to discuss your involvement.
            </td>
        </tr>
    </table>

</asp:Content>
   

