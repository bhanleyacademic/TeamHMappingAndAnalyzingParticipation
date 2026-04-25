<%@ page language="C#" autoeventwireup="true" inherits="EMDemo_EventHelpcreate, App_Web_eventhelpcreate.aspx.cdcab7d2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Create Event Help</title>
    <link href="Stylesheet/StyleSheets.css" rel="stylesheet" type="text/css" />
    
<script language="javascript" type="text/javascript">
// <!CDATA[

function IMG1_onclick() {

}

// ]]>
</script>
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin:auto;">
            
       
            <table border="0" cellpadding="0" cellspacing="0" width="93.8%" align="center" style="border-bottom:4px solid green;">
                <tr>
                    <td valign="top">
                        <a href="Home.aspx"><img src="Image/OHATS.jpg" style="float: left;border:0px;" /></a>
                    </td>
                    <td valign="top" align="right">
                        <a href="http://www.vattsystems.com/" target="_parent">
                           <img src="Image/logo.png" 
                             
                             style="border-style: none; border-color :inherit; border-width: 0px; float: left; position:relative; margin-top:-15px; top: 0px; left: 0px;" />
                        </a>
                    </td>
                </tr>
            </table>
            
            <table border="0" cellpadding="0" cellspacing="0" width="850" align="center" style="margin-top:10px;font:12px arial;">
                  
                <tr>
                    <td valign="top" width="140" style="background:#E0E0DF;padding:20px 0px 0px 0px;">
                        <div style="float:left;width:150px;">
                            <span style="float:left;border-bottom:1px solid green;width:150px;">HELP CONTENT</span>
                            <span style="float:left;clear:left;width:150px;font:bold 11px tahoma;margin:10px 0px 0px 10px;">
                                .&nbsp;<asp:LinkButton Text="Event Create" runat="server" ID="lnkCreate" OnClick="lnkCreate_OnClick"></asp:LinkButton><br /><br />
                                .&nbsp;<asp:LinkButton Text="Event Goal" runat="server" ID="lnkGoal" OnClick="lnkGoal_OnClick"></asp:LinkButton><br /><br />
                                .&nbsp;<asp:LinkButton Text="Event Type" runat="server" ID="LinkButton1" OnClick="lnkType_OnClick"></asp:LinkButton><br /><br />
                                .&nbsp;<asp:LinkButton Text="Event Communication" runat="server" ID="lnkCommunication" OnClick="lnkCommunication_OnClick"></asp:LinkButton>
                            </span>
                            
                        </div>
                    </td>
                    <td valign="top" width="780" style="padding:0px 0px 0px 10px;text-align:justify;">
                        <asp:Panel runat="server" ID="pnlCreate" Visible="false" >
                            <center>
                                <span style="font:22px arial;color:red">
                                     Event Create Help
                                </span>
                            </center>
                            Event creators can record a new accomplishment, contact or event using this create event Menu. In the events, Results & Accomplishments: New Information Form page
                            users can describe their event details and based on the details provided event reports are generated.<br /><br />
                            <span style="margin: 0px 0px 0px 20px;text-align:justify;">*For purposes of this explanation “EVENT” is a term used to describe any action, contact, accomplishment or event that a recorder  documents in T/MC OHATS.</span>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                                <span style="float:left;width:250px;"><img src="Image/recorder.bmp" style="float:left;" /></span>
                                <span style="float:left;width:500px;text-align:justify;"><asp:Label ID="lblRecorder" runat="server">Recorder name can be chosen from the list of existing names or  a new recorder can be added through the “Add New” link</asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                                <span style="float:left;width:250px;"><img src="Image/private.JPG" style="float:left;" /></span>
                                <span style="float:left;width:500px;text-align:justify;"><asp:Label ID="lblPrivateItem" runat="server">If you check this box, events will not be listed to public.  It is available for the logged users only</asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                                <span style="float:left;width:250px;"><img src="Image/date.JPG" style="float:left;" /></span>
                                <span style="float:left;width:500px;text-align:justify;"><asp:Label ID="lblEventOccuredDate" runat="server">Specify the Date on which the event took place, or began </asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                                <span style="float:left;width:250px;"><img src="Image/dateunsure.JPG" style="float:left;" /></span>
                                <span style="float:left;width:500px;text-align:justify;"> <asp:Label ID="lblDateUnsure" runat="server">If you are not sure when the event happened then choose  an approximate date for when the event took place </asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                                <span style="float:left;width:250px;"><img src="Image/source.JPG" style="float:left;" /></span>
                                <span style="float:left;width:500px;text-align:justify;"><asp:Label ID="lblSource" runat="server">Specify the source of the Event. By default the event source will be set as “Internal” All internal and external events will be listed separately in the Main page.</asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;"> 
                                <span style="float:left;width:250px;"><img src="Image/state.JPG" style="float:left;" /></span>
                                <span style="float:left;width:500px;text-align:justify;"><asp:Label ID="lblState" runat="server">Choose a state in which an event or action took place, or where the primary contact is located. E.G. if you had a meeting with someone from New York City, choose New York, from the list of states </asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                                <span style="float:left;width:250px;"><img src="Image/country.JPG" style="float:left;" /></span>
                                <span style="float:left;width:500px;text-align:justify;"><asp:Label ID="lblCountry" runat="server">Specify the country where the event is scheduled to occur.</asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                                <span style="float:left;width:250px;"><img src="Image/peopleattend.JPG" style="float:left;" /></span>
                                <span style="float:left;width:500px;text-align:justify;"><asp:Label ID="lblNoOfPeoples" runat="server">State the total number of  people attended the meeting, or event  </asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                                <span style="float:left;width:250px;"><img src="Image/thisevent.JPG" style="float:left;" /></span>
                                <span style="float:left;width:500px;text-align:justify;"><asp:Label ID="lblThisEvent" runat="server">Options for capturing event period <br />
                                     1.	“Occurred on only one day” if the events occurs on only one day.<br />
                                     2.	Choose “Multiple days but has an end date” option if the event is scheduled to occur on more than one day but has a scheduled end date.<br />
                                     3.	Choose “It is not designed to end” if the event is a never ending event.<br />

                                </asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                                <span style="float:left;width:300px;"><img src="Image/item novelty.JPG" style="float:left;" /></span>
                                <span style="float:left;width:450px;text-align:justify;"><asp:Label ID="lblNovelty" runat="server">Item Novelty tells about the item innovation.The item can be a new item or an existing one or may be a modified from the earlier work.Choose one of the options to specify about the nature of your Item.</asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                                <span style="float:left;width:300px;"><img src="Image/itemtype.JPG" style="float:left;" /></span>
                                <span style="float:left;width:450px;text-align:justify;"><asp:Label ID="lblItemType" runat="server">This section describes contacts,which may or may not lead to accomplishments or events in the future.You do not need to document every contact,but if you have a purpose for contacting someone,you can show the nature of that contact here.</asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;"> 
                                <span style="float:left;width:430px;"><img src="Image/iten%20desc.JPG" style="float:left;" /></span>
                                <span style="float:left;width:320px;text-align:justify;"><asp:Label ID="lblItemDescription" runat="server">Briefly outline what happened so that people outside your organization can understand the nature of  your accomplishment,contact or event. </asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                               <span style="float:left;width:430px;"> <img src="Image/Item%20meaning.JPG" style="float:left;" /></span>
                               <span style="float:left;width:320px;text-align:justify;"> <asp:Label ID="lblItemMeaning" runat="server">Describe why and how this event is important to the mission,objectives or work of the organization.Look at the choices in the EVENT GOALS section.All actions should related to one or more event goals,or a new goal should be stated.</asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                                <span style="float:left;width:430px;"><img src="Image/Item result.JPG" style="float:left;" /></span>
                                <span style="float:left;width:320px;text-align:justify;"><asp:Label ID="Label4" runat="server">State the outcome or predict future results or consequences as a result of the recorded event. </asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;"> 
                                <span style="float:left;width:450px;"><img src="Image/keyactors.JPG" style="float:left;" /></span>
                                <span style="float:left;width:300px;text-align:justify;"><asp:Label ID="lblKeyActors" runat="server">List the key person(s) involved in the event you are describing.If you have listed a person previously,the name will be in the “Key Actors Name” list.You can choose an actor of your choice or add an actor through the “Add New” link.</asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px; margin: 10px 0px 0px 0px;padding:5px;">
                                <span style="float:left; width:225px;"><img src="Image/keyorganization.JPG" style="float:left;" /></span>
                                
                                <span style="float:left; width:520px; text-align:justify;"><asp:Label ID="lblKeyOrganization" runat="server">In this section you are listing the organizations involved in the event you are describing.By default when an actor is chosen the actor’s organization will be loaded.If you have worked with this actor or organization previously,you will be able to pull it from the list of organizations already on-line.</asp:Label></span>
                                
                              
                            </p>
                        </asp:Panel>
                        <asp:Panel runat="server" ID="pnlGoal" Visible="false" 
                            style="margin-right: 0px;text-align:justify;">
                            <center>
                                <span style="font:22px arial;color:red">
                                     Event Goals
                                </span>
                            </center>
                            The OHATS T/MC is intended to document actions that lead to a desired long-term outcome. The major categories within the Tutor/Mentor Connection mission and action plan are the event goals listed below.  As you describe an event, think of the impact of your action on one or more of these goals.   An Event Recorder can choose any of these goals or state their own goals other than the listed goals. More than one goal can be chosen for an event.
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                                <span style="float:left;width:170px;"><img src="Image/Goals%20public.JPG" /></span>
                                <span style="float:left;width:580px;"><asp:Label ID="lblPublicAwarness" runat="server">Check this check box if the item relates to public awareness i.e. related to media(TV, Radio, print, cable, web)</asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                                <span style="float:left;width:145px; padding-left:25px;"><img src="Image/Goals%20technology.JPG" /></span>
                                <span style="float:left;text-align:justify;width:580px;"><asp:Label ID="lblTechnology" runat="server">Check this check box if the event goal is related to the organization’s use of technology to achieve goals</asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                                <span style="float:left;width:145px; padding-left:25px;"><img src="Image/research.JPG" /></span>
                                <span style="float:left;text-align:justify;width:580px;"><asp:Label ID="lblResearch" runat="server">Check this check box if the event goal is related to research, best practices, program locator search,  and/ or evaluation</asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                                <span style="float:left;width:145px; padding-left:25px;"><img src="Image/Training.JPG" /></span>
                                <span style="float:left;text-align:justify;width:580px;"><asp:Label ID="lblTraining" runat="server">Check this check box if the event goal is related to training, education, and/or helping people understand and use the information T/MC collects and shares</asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                                <span style="float:left;width:145px; padding-left:25px;"><img src="Image/resource.JPG" /></span>
                                <span style="float:left;text-align:justify;width:580px;"><asp:Label ID="lblResourcedevelopment" runat="server">Check this check box if the event goal is related to Resource Development and Capacity Building, eg.   namely bringing in/developing  people and organization helping tutor/mentor programs throughout Chicago get volunteers, dollars, training, and other resources needed to mentor kids to careers.</asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                                <span style="float:left;width:145px; padding-left:25px;"><img src="Image/strategic.JPG" /></span>
                                <span style="float:left;text-align:justify;width:580px;"><asp:Label ID="lblstrategicevent" runat="server">Check this check box if the event goal is related to one or more of the events, services or products the T/MC has created, such as conferences, recruitment fairs, etc.</asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                                <span style="float:left;width:300px;"><img src="Image/others.JPG" /></span>
                                <span style="float:left;text-align:justify;width:450px;"><asp:Label ID="lblOthersEventGoal" runat="server">If the event goal is other than the specified list of goals stated the event goals in the above, describe  your goal in the "other" text box area</asp:Label></span>
                            </p>
                        </asp:Panel>
                        <asp:Panel  runat="server"  ID="pnlType" Visible="false"  >
                            <center>
                                <span style="font:22px arial;color:red">
                                     EVENT TYPE – MEASURE OF COMMUNITY CHANGE
                                </span>
                            </center>
                            A Community Change is an observable change in the environment that indicates a new or modified program, policy or practice of an organization or system. A reported item is counted as a community change if it is facilitated by the organization under study (Tutor/Mentor Connection), is important to the mission of that organization, and influences or engages people or organizations outside of that organization<br />
                            <br />Once you describe what part of the T/MC mission your event affects, select the box of one or more of the following categories that best describes this event.  You can check more categories 
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                                <span style="float:left;width:190px;"><img src="Image/Eventtype.JPG" /></span>
                                <span style="float:left;width:560px; text-align:justify;"><asp:Label ID="lblEventtype" runat="server">Check this check box if the event resulted in a creation or modification of any community or system.</asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                                <span style="float:left;width:165px; padding-left:25px;"><img src="Image/media.JPG" /></span>
                                <span style="float:left;width:560px; text-align:justify;"><asp:Label ID="lblMedia" runat="server">Check this check box if the event resulted in media related to your organization.</asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                                <span style="float:left;width:165px; padding-left:25px;"><img src="Image/community.JPG" /></span>
                                <span style="float:left;width:560px; text-align:justify;"><asp:Label ID="lblCommunityAction" runat="server">Check this check box if the event resulted in Community action or change</asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                                <span style="float:left;width:165px; padding-left:25px;"><img src="Image/resource.JPG" /></span>
                                <span style="float:left;width:560px; text-align:justify;"><asp:Label ID="lblResources" runat="server">Check this check box if the event resulted in funding, materials and services to your organization.</asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                                <span style="float:left;width:165px; padding-left:25px;"><img src="Image/services.JPG" /></span>
                                <span style="float:left;width:560px; text-align:justify;"><asp:Label ID="lblServices" runat="server">Check this check box if the event  resulted in offering or providing a service by your organization to a person, client, or group </asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                               <span style="float:left;width:165px; padding-left:25px;"><img src="Image/planning.JPG" /></span>
                                <span style="float:left;width:560px; text-align:justify;"><asp:Label ID="lblPD" runat="server">Check this check box if the event result was an event or action to plan or develop your organization or its related work </asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                                <span style="float:left;width:165px; padding-left:25px;"><img src="Image/critical.JPG" /></span>
                                <span style="float:left;width:560px; text-align:justify;"><asp:Label ID="lblCriticalEvent" runat="server">Check this check box if the event result was an event or action that positively or negatively influenced your organization or its work.</asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                                <span style="float:left;width:300px;"><img src="Image/others.JPG" /></span>
                                <span style="float:left;width:450px; text-align:justify;"><asp:Label ID="lblOtherGoal" runat="server">If your event type is other than the specified event types specify it in the “Other” text box area. </asp:Label></span>
                            </p>
                        </asp:Panel>
                        <asp:Panel runat="server" ID="pnlCommn" Visible="false">
                            <center>
                                <span style="font:22px arial;color:red">
                                     Event Communications
                                </span>
                            </center>
                            In this section you can help organize the information you document for future reports and analysis. You can choose a communication type from the list or specify your own communication type. You can choose more than one communication type.
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                                <span style="float:left;width:100px;"><img src="Image/Report.JPG" style="float:left;" /></span>
                                <span style="float:left;width:650px; text-align:justify;"><asp:Label ID="lblReport" runat="server">Check this check box if the event has to be included in organizational reports or related document.</asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                                <span style="float:left;width:100px;"><img src="Image/special.JPG" /></span>
                                <span style="float:left;width:650px; text-align:justify;"><asp:Label ID="lblSpecial" runat="server">Check this check box if the event is a special event.</asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                                <span style="float:left;width:100px;"><img src="Image/best.JPG" /></span>
                                <span style="float:left;width:650px; text-align:justify;"><asp:Label ID="lblBestPractice" runat="server">Check this check box if it is a best practice.</asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                                <span style="float:left;width:100px;"><img src="Image/email.JPG" /></span>
                                <span style="float:left;width:650px; text-align:justify;"><asp:Label ID="lblEmail" runat="server">Check this check box if the you want to share this event through mail.</asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                                <span style="float:left;width:100px;"><img src="Image/news.JPG" /></span>
                                <span style="float:left;width:650px; text-align:justify;"><asp:Label ID="lblNews" runat="server">Check this check box if the event  can be shared through news or through media</asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                                <span style="float:left;width:185px;"><img src="Image/emaillist.JPG" /></span>
                                <span style="float:left;width:565px; text-align:justify;"><asp:Label ID="lblEmailList" runat="server">You can specify the list of e-mails separated by comma with whom you want to share.</asp:Label></span>
                            </p>
                            <p style="float:left;clear:left;border:1px solid green;width:750px;margin:10px 0px 0px 0px;padding:5px;">
                                <span style="float:left; width:300px"><img src="Image/others.JPG" /></span>
                                <span style="float:left;width:450px; text-align:justify;"><asp:Label ID="lblComment" runat="server">Other comments related to event communication can be given here.</asp:Label></span>
                            </p>
                        </asp:Panel>
                    </td>
                </tr>
                
                    
                
            </table>
            
            
            
            
           
      
        </div>
    </form>
</body>
</html>
