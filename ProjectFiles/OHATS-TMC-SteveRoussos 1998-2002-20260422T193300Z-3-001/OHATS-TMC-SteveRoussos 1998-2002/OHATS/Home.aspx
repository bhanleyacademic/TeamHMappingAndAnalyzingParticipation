<%@ page language="C#" masterpagefile="Event.master" autoeventwireup="true" inherits="Home, App_Web_home.aspx.cdcab7d2" title="About OHATS" enablesessionstate="False" enableviewstate="false" %>

<%@ Register Src="Controls/Pie/Pie.ascx" TagName="Pie" TagPrefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">
    <div align="center">
        <!--Header panel-->
        <!--Header Panel endz here-->
        <!-- Content Panel -->
        <table cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td align="center" class="table">
                    <div>
                        <table cellpadding="0" cellspacing="0" border="0" style="border: 1px #cccccc solid;">
                            <tr>
                                <td valign="top" align="left" style="height: 90px; width: 135px;">
                                    <object width="122px" height="90px">
                                        <param name="movie" value="banner.swf" alt="Mentor in Action" />
                                        <embed src="flash/imageflash.swf" width="134" height="90px" alt="Mentor in Action"
                                            style="float: left;"></embed>
                                    </object>
                                </td>
                                <td valign="top" align="right" style="height: 90px;">
                                    <img src="Image/bannernew.jpg" alt="" style="width: 100%" id="IMG1" onclick="return IMG1_onclick()">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" valign="top">
                                    <center>
                                        <!--amala code start-->
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%" style="padding-right: -5px;">
                                            <tr>
                                                <!--common 3coloumn-->
                                                <!--common 1coloumn-->
                                                <td valign="top" align="left" style="width: 36%;">
                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin: 10px 0px 0px 0px;">
                                                        <tr>
                                                            <td colspan="2" valign="top">
                                                                <img src="Image/wel.jpg" style="float: left; margin: 2px -1.5px 2px 10px;" />
                                                                <div align="center" style="float: left; margin-top: 20px;text-align:justify;">
                                                                    <img src="Image/picture-left.jpg" alt="" style="float: left; margin: 15px 10px 85px 0px;" />
                                                                    <p style="width: 280px; font: 12px/18px arial;color: #000000; margin: 15px 0px 0px 0px;
                                                                        display: inline;">
                                                                        Since September 2000, the Tutor/Mentor Connection (T/MC) has been using OHATS to document actions focused on helping inner-city youth have access to constantly improving volunteer-based tutor/mentor programs. See <a href="http://www.tutormentorconnection.org/AboutTMC/Mission/tabid/482/language/en-US/Default.aspx"
                                                                            target="blank">MISSION </a>.<br />
                                                                        <br />
                                                                        OHATS(Organizational History and
                                                                        Accomplishments Tracking System) is an Internet-based system for organizations involved in a collective effort to easily record and report
                                                                        important events, actions and lessons that take place during the day-to-day work.
                                                                        This <a href="http://www.tutormentorexchange.net/images/PDF/tmc_ohats_report_sep-00_thru_mar-02.pdf"
                                                                            target="blank">OHATS 2002 PDF REPORT </a>
                                                                        such information could be summarized.<br /><br><br>
                                                                        
                                                                    </p>
                                                                    <div style="border: 1px solid #AACCEE; padding: 10px 0px 20px 0px;">
                                                                        <table border="0" style="height:80px">
                                                                            <tr >
                                                                                <td class="linkSpace">
                                                                                    <a href="http://www.tutormentorexchange.net/ohats" target="_blank" class="sidelink">
                                                                                        About OHATS </a>
                                                                                </td>
                                                                                <td class="linkSpace" >
                                                                                    <a href="http://www.tutormentorconnection.org/LinksLearningNetwork/AboutTMLearningNetwork/tabid/487/Default.aspx"
                                                                                        target="_blank" class="sidelink">Learning</a>
                                                                                </td>
                                                                                <td class="linkSpace">
                                                                                    <a href="http://www.tutormentorprogramlocator.net" target="_blank" class="sidelink">
                                                                                        Find A Program </a>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td class="linkSpace">
                                                                                    <a href="http://tutormentorconnection.ning.com/groups"
                                                                                        target="_blank" class="sidelink">Collaboration </a>
                                                                                </td>
                                                                                <td class="linkSpace">
                                                                                    <a href="http://cmapspublic.ihmc.us/servlet/SBReadResourceServlet?rid=1238727620203_1951466067_30266&partName=htmltext"
                                                                                        target="_blank" class="sidelink">Library</a>
                                                                                </td>
                                                                                <td class="linkSpace">
                                                                                    <a href="http://www.facebook.com/TutorMentorInstitute" target="_blank"
                                                                                        class="sidelink">Facebook Page </a>
                                                                                </td >
                                                                            </tr>
                                                                            <tr>
                                                                                <td class="linkSpace">
                                                                                    <a href="http://www.tutormentorconnection.org/GetInvolved/VolunteerforTMC/tabid/644/language/en-US/Default.aspx" target="_blank"
                                                                                        class="sidelink">Volunteers </a>
                                                                                </td>
                                                                                <td class="linkSpace">
                                                                                    <a href="http://www.tutormentorconnection.org/GetInvolved/Events/tabid/486/Default.aspx"
                                                                                        target="_blank" class="sidelink">Events</a>
                                                                                </td>
                                                                                <td class="linkSpace">
                                                                                    <a href="http://www.tutormentorexchange.net/donations" target="_blank" class="sidelink">
                                                                                        Support this Work </a>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td class="linkSpace">
                                                                                    <a href="http://michaelcnt.blogspot.com/" target="_blank" class="sidelink">
                                                                                        Interns</a>
                                                                                </td>
                                                                                <td class="linkSpace">
                                                                                    <a href="http://www.tutormentorconference.org/" target="_blank" class="sidelink">Conference</a>
                                                                                </td>
                                                                            
                                                                                <td class="linkSpace">
                                                                                    <a href="http://www.tutormentorconnection.org/FindaProgram/ChicagoAreaProgramLinks/tabid/561/Default.aspx"
                                                                                        target="_blank" class="sidelink">Chicago Programs</a>
                                                                                </td>
                                                                            </tr>
                                                                        </table>

                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <!--common 2coloumn-->
                                                <!--common 3coloumn-->
                                                <td valign="top" align="left" style="width: 36%; padding-bottom: 15px;">
                                                    <table cellpadding="0" cellspacing="0" width="100%" style="margin: 10px 0px 0px 0px;">
                                                        <tr>
                                                            <td valign="bottom" style="height: 31px ;" align="justify">
                                                                <img src="Image/tmc.jpg" style="margin: 2px -15px 2px -5.5px; clear: left;" />
                                                                <p style="float: left; clear: left; margin: 10px 0px 0px 10px;">
                                                                    <uc3:Pie ID="mainPie" runat="server" />
                                                                </p>
                                                                <p style="float: left; clear: left; width: 380px; font: 12px/18px arial; color: #000000;
                                                                    margin: 0px 0px 0px 10px; text-align: justify;">
                                                                    This pie chart represents the type of events facilitated by T/MC. An event may be
                                                                    grouped in more than one category.The percentage representation of different event
                                                                    types with respect to the total events are marked. To see what actions are documented
                                                                    and discuss meaning: <a href="http://tutormentorconnection.ning.com/group/ohatsmetrics/forum/topics/tutormentor-connection">
                                                                        click this link</a> and join the discussion on the Tutor/Mentor Connection online
                                                                    forum.</p>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <!--common 3coloumn-->
                                                <td valign="top" nowrap>
                                                    <table>
                                                        <tr>
                                                            <td align="center" nowrap>
                                                                <p style="font: 10px tahoma; font: bold 13px Arial; color: #009bcb; margin: 15px 15px 2px 15px;">
                                                                   Sponsor and Naming Rights Available. <br><br>Become a partner and help co-develop this resource. <br><br>
                                                                </p>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="padding-left: 13px; padding-right: 7px; padding-top: 20px;">
                                                                
																
																<p style="display: inline;">
																	<a href="http://www.tutormentorexchange.net/donations" target="_blank">
																	<img src="image/sponsor/learn-how-you-can-sponsor.jpg" border="0" alt="Sponsor/Naming Rights Available!" />
																	</a>
																</p>
																
																<!--<object>
                                                                    <p style="display: inline;">
                                                                        <param name="movie" value="banner.swf" alt="Mentor in Action" />
                                                                        <embed src="flash/newadbanner.swf" width="80px" height="70px" alt="Mentor in Action"></embed>
                                                                    </p>
                                                                </object>-->
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <%--<p style="float: left; font: 10px tahoma; width: 100px;font:bold 13px Arial;
                                                        color: #009bcb;margin-top:15px;margin-left:-20px;">
                                                        T/MC Donor List &nbsp;
                                                    </p>
                                                   
                                                    <object width="99px">
                                                    <p style="float: left;display: inline;">
                                                        <param name="movie" value="banner.swf" alt="Mentor in Action" />
                                                        <embed src="flash/newadbanner.swf" width="85px" height="80px" alt="Mentor in Action"
                                                            style="float: left;margin-top: 25px;margin-left:-2px; "></embed>
                                                             </p>
                                                        </object>--%>
                                                </td>
                                            </tr>
                                        </table>
                                    </center>
                                    <!--amala code complete-->
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <!-- content Panel endz here-->
        <!--Footer Panel-->
        <%--<table border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td valign="top" style="height: 19px">
                    </td>
                </tr>
            </table>--%>
        <!--Footer Panel endz here -->
    </div>
</asp:Content>
