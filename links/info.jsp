<%@page import="java.util.*,
		blackboard.data.*,
                blackboard.data.user.*,
                blackboard.persist.*,
                blackboard.persist.user.*,
                blackboard.platform.*,
                blackboard.platform.persistence.*"
				
        errorPage="/error.jsp"                
%>
<%@ taglib uri="/bbData" prefix="bbData"%>   
<%@ taglib uri="/bbUI" prefix="bbUI"%>

<bbUI:docTemplateHead> 
<style type="text/css"> 
dt {
	font-weight: 600;
	}
dd {
	font-weight:300;
	padding-left: 5px;
	}
.Name {
	color: cadetblue; 
	font-family: "Lucida Grande", "Lucida Sans Unicode", "Lucida Sans", "DejaVu Sans", Verdana, sans-serif;
	font-weight: 800;
	font-size:larger;
	text-indent:5px;
	   }
.left img {
	position:relative;
	margin-top: 10;
	margin-right: 20px;
	margin-left: 0px;
	margin-bottom: 8px;
	border-radius: 10px;
	}
.left {
  	float: left;
        width: 125px;
}
.right {
  	
    float:left;
	padding-left:25;
	width:220px;
	
}

#text {
	position: absolute;
	color: white;
	font-size: 13px;
	font-weight: bold;
	left: 16px;
	top: 175px;
	text-shadow: 2px 1px darkseagreen;
}
 .group:after {
        content:"";
        display: table;
        clear: both;
    }
 @media screen and (max-width: 380px) {
        .left, .right {
            float: none;
            width: auto;
	    position:inherit;  
        }
    }
</style>

</bbUI:docTemplateHead>
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
String Tnumb = "";
String Suffix ="";
String Title1 ="";
String username ="";
String department = "";
String phone = "";
String email = "";
String position = "";
String location = "";
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
	Tnumb = userBb.getStudentId();
	username = userBb.getBatchUid();
	department = userBb.getDepartment();
	phone = userBb.getBusinessPhone1();
	email = userBb.getEmailAddress();
	position = userBb.getCompany();
	location = userBb.getJobTitle();
	fname = userBb.getGivenName();
	lname = userBb.getFamilyName();

%>
	
<div class="group">
<div>
<p  class="Name"><%=fname%> &nbsp; <%=lname%></p>

</div>

	<div class="left">
<a href="https://idcard.oberlin.edu/form/photo/" title="Change your photo in the ResEd IdCard system" target="_blank">
<img src="https://resdev.oberlin.edu/feed/photo/blank/<%=Tnumb%>" width="121" alt="your image taken from IdCard system"/>
 <p id="text">
UPDATE PHOTO </p>
</a>

</div>	
											    
<div class="right">
	<dl>	
		<dt>Personal Pronouns : </dt><dd><%=Title1%></dd>
		<dt>T# : </dt><dd><%=Tnumb%></dd>
		<dt>ObieID : </dt><dd><%=username%></dd>
		<dt>Suffix : </dt><dd><%=Suffix%></dd>
		<dt>Department:</dt><dd> <%=department%></dd>
		<dt>Location : </dt><dd><%=location%></dd>
		<dt>Phone : </dt><dd><%=phone%></dd>
		<dt>Position :</dt><dd> <%=position%></dd>
		<dt>Email : </dt><dd><%=email%></dd>
</div>

<%	}
	catch(KeyNotFoundException e)
	{
	// key not found exception occurs when the user accout is disabled.
	//note that a disabled account is different from an unavailable account
	out.print("This faculty member is no longer with Oberlin college");
	}%>
</div>
</bbData:context>
