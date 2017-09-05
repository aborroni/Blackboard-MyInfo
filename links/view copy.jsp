<%@page import="java.util.*,
				java.lang.Integer,
				blackboard.base.*,
				blackboard.data.*,
                blackboard.data.user.*,
				blackboard.data.course.*,
                blackboard.persist.*,
                blackboard.persist.user.*,
				blackboard.persist.course.*,
                blackboard.platform.*,
                blackboard.platform.persistence.*,
				blackboard.portal.external.*"
        errorPage="/error.jsp"             
%>
<SCRIPT LANGUAGE="JavaScript">
function imageError(theImage)
{
theImage.src="http://octet1.csr.oberlin.edu/octet/Bb/Faculty/img/noimage.jpg";
theImage.onerror = null;
}
</script>
<%@ taglib uri="/bbData" prefix="bbData"%>                
<%@ taglib uri="/bbUI" prefix="bbUI"%>
<bbData:context id="ctx">
<%
/* Displays user photo and provides an entry point for users to change their photos
 */
 
//get the current user
User thisUser = ctx.getUser();
//get their username and system role
String strUsername = thisUser.getUserName();
String userRole = thisUser.getPortalRoleId().toExternalString();
%>
<table width="506" border="0">
  <tr>
    <td width="160"><div align="center"><img src="http://octet1.csr.oberlin.edu/octet/Bb/Photos/expo/<%=strUsername%>/profileImage" alt="" align="middle" onError="imageError(this)"></div></td>
    <td width="336"><div align="justify">
	<% if(userRole.equals("_2_1") || userRole.equals("_145_1")){ //user is faculty or teaching staff
	%>This photo is provided here so that you may change it if you wish.
	It is important to remember that this photo will be available in the Faculty Directory as well as in your personal profile.
	Anyone who navigates to Oberlin Oncampus will be able to see the Faculty Directory.
	If you would like to provide an updated photo of yourself, 
	please click the pencil icon in the upper right corner of this module.	
	<%}else{ //user is a student (this bblock idsplays only for faculty, students and teaching staff)
	%>This photo is provided here so that you may change it if you wish. 
		It is important to remember that this photo is available only to professors 
		in whose courses you are enrolled during a semester, 
		and is only meant to help them identify you in class. 
		Only you and your professors can see it. 
		If you would like to provide an updated photo of yourself, 
		please click the pencil icon in the upper right corner of this module.<%}%></div></td>
  </tr>
</table>
</bbData:context>
