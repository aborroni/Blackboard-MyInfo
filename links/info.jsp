<%@page import="blackboard.data.*,
                blackboard.data.user.*,
                blackboard.persist.*,
                blackboard.persist.user.*,
                blackboard.platform.*,
                blackboard.platform.persistence.*,
				octet.*"
        errorPage="/error.jsp"                
%>
<%@ taglib uri="/bbData" prefix="bbData"%>                
<%@ taglib uri="/bbUI" prefix="bbUI"%>
<body onLoad="document.form.submit()">
<bbData:context id="ctx">
<%
/*
 * This page is intended to show up in a separate tab where the current user in blackboard can click to change their profile.
 * It is not intended to be used actively once mosto f the faculty members have set up their profiles.
 * It is intended to be an initial entry point to profiles before the faculty directory is made available
 * The code in this page closely mirros the code in viewProfile.
*/
try{
//get the current user
User thisUser = ctx.getUser();
//get his user name
String strUsername = thisUser.getUserName();
String department = "";
String phone = "";
String email = "";
String office = "";
String title = "";
String fname = "";
String lname = "";

	// create a persistence manager - needed for using loaders and persisters
	BbPersistenceManager bbPm = BbServiceManager.getPersistenceService().getDbPersistenceManager();
	
	// create a database loader for users
    UserDbLoader loader = (UserDbLoader) bbPm.getLoader( UserDbLoader.TYPE );
	
	// load the full user object for the current user
    blackboard.data.user.User userBb = loader.loadByUserName(strUsername);
	
	//get different attributes of the current user
	department = userBb.getDepartment();
	phone = userBb.getBusinessPhone1();
	email = userBb.getEmailAddress();
	office = userBb.getCompany();
	title = userBb.getJobTitle();
	fname = userBb.getGivenName();
	lname = userBb.getFamilyName();
	
	// show a link to the user's courses if he is not a staff member
	int showCourses = 1;
	if(userBb.getPortalRoleId().toExternalString().equals("_3_1")){//staff
		showCourses = 0;
	}
	// create a form and pass all of the gathered information aboutthe current user to the php page
%>
<!--	<form action="http://octet1.csr.oberlin.edu/octet/Bb/Faculty/viewProfile.php" method="post" name="form" target="_self">
-->
	<input name="uid" type="text" value="<%=strUsername%>">
	<input name="showCourses" type="text" value="<%=showCourses%>">
	<input name="dept" type="text" value="<%=department%>">
	<input name="title" type="text" value="<%=title%>">
	<input name="phone" type="text" value="<%=phone%>">
	<input name="office" type="text" value="<%=office%>">
	<input name="email" type="text" value="<%=email%>">
	<input name="firstname" type="text" value="<%=fname%>">
	<input name="lastname" type="text" value="<%=lname%>">
	<input name="currentuser" type="text" value="<%=thisUser.getUserName()%>">
	<% if(strUsername.equals(thisUser.getUserName()))
	{%>
	<input name="editbutton" type="text" value="1">
	<%}%>
<!--	</form> -->
	<%	}
	catch(KeyNotFoundException e)
	{
	// key not found exception occurs when the user accout is disabled.
	//note that a disabled account is different from an unavailable account
	out.print("This faculty member is no longer with Oberlin college");
	}%>
</bbData:context>
