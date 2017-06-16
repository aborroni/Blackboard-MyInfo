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
                blackboard.platform.persistence.*"
        errorPage="/error.jsp"                
%>

<%@ taglib uri="/bbData" prefix="bbData"%>                
<%@ taglib uri="/bbUI" prefix="bbUI"%>
<bbData:context id="ctx">
<%
/* This building block displays user information to the user */
// create a persistence manager - needed for using loaders and persisters
BbPersistenceManager bbPm = BbServiceManager.getPersistenceService().getDbPersistenceManager();

%>

<bbUI:docTemplate title="My Info">
<bbUI:breadcrumbBar handle="control_panel" isContent="false">
<!--<bbUI:breadcrumb>My Info</bbUI:breadcrumb> -->
</bbUI:breadcrumbBar>

<style type="text/css">
<!--
.style1 {
	color: saddlebrown;
	font-weight: bold;
}
#RoundedDiv {
	border-radius: 60px 60px 25px 25px;
	overflow:hidden;
	 }
-->
 </style>
 
<%
public BbPerson(User user, String role) {
    //standard info
    if(user != null){
        this.id = user.getId().getExternalString();
        this.given_name = user.getGivenName();
        this.family_name = user.getFamilyName();
        this.username = user.getUserName();
        this.email = user.getEmailAddress();
        this.role = role;

        //bb info
        this.department = user.getDepartment();
        this.address = user.getStreet1() + " " + user.getStreet2() + ", " + user.getCity() + ", " + user.getState() + " " + user.getZipCode();
        this.phone = user.getMobilePhone();
        this.uniqueId = user.getStudentId();
    }

}

//OCMR
if(userPortalRoleId.equals(studentPortalRole.getId()))
{
    result.append("<span class=\"fieldtitle\">OCMR: </span>");
    String userMailbox = user.getJobTitle();
    if(userMailbox.startsWith("OCMR"))
        userMailbox = userMailbox.substring(4);
    if(userMailbox.startsWith("-"))
        userMailbox = userMailbox.substring(1);
    if(userMailbox.isEmpty())
        userMailbox = "None listed";
    result.append(userMailbox);
}

%>
	

</bbUI:docTemplate>
 </bbData:context>
 

