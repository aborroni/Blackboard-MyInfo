<%@page import="import="java.util.*,
		blackboard.data.*,
                blackboard.data.user.*,
                blackboard.persist.*,
                blackboard.persist.user.*,
                blackboard.platform.*,
                blackboard.platform.persistence.*,
				
        errorPage="/error.jsp"                
%>
<%@ taglib uri="/bbData" prefix="bbData"%>    
<%@ taglib uri="/bbNG" prefix="bbNG" %>

<bbNG:cssBlock> 
   <style type="text/css"> 
	p {
	font-weight: 800;
	}
.Name {
	color: cadetblue; 
	}
img {
    	float: left;
	margin-top: 0;
	margin-right: 10px;
	margin-left: 10px;
	margin-bottom: 10px;
	}
	</style> 
</bbNG:cssBlock>
<bbData:context id="ctx">
<%
/*
 * This page is intended to show up in a separate tab where the current user in blackboard can click to change their profile.
 * It is not intended to be used actively once mosto f the faculty members have set up their profiles.
 * It is intended to be an initial entry point to profiles before the faculty directory is made available
 * The code in this page closely mirrors the code in viewProfile.
*/
try{
//get the current user
User thisUser = ctx.getUser();
//get his user name
String strUsername = thisUser.getUserName();
String StudentId = "";
String Suffix ="";
String Title1 ="";
String Tnumb ="";
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
	Title1= userBb.getTitle();
	Suffix = userBb.getSuffix();
	StudentId = userBb.getStudentId();
	Tnumb = userBb.getBatchUid();
	department = userBb.getDepartment();
	phone = userBb.getBusinessPhone1();
	email = userBb.getEmailAddress();
	office = userBb.getCompany();
	title = userBb.getJobTitle();
	fname = userBb.getGivenName();
	lname = userBb.getFamilyName();

%>
<p class="Name">NAME: 	<b> <%=fname%> &nbsp; <%=lname%><br/>
		<i><%=strUsername%></i></p>
	
	<img src="https://resdev.oberlin.edu/feed/photo/blank/<%=StudentId%>" width="121" alt="your image taken from IdCard system"/>
	Student ID : <%=StudentId%><br/>
	T number : <%=Tnumb%><br/>
	Personal Pronouns : <%=Title1%><br/>
	Suffix : <%=Suffix%><br/>
	Department: <%=department%><br/>
	title : <%=title%><br/>
	Phone : <%=phone%><br/>
	Office : <%=office%><br/>
	Email : <%=email%><br/>
<%	}
	catch(KeyNotFoundException e)
	{
	// key not found exception occurs when the user accout is disabled.
	//note that a disabled account is different from an unavailable account
	out.print("This faculty member is no longer with Oberlin college");
	}%>
</bbData:context>
