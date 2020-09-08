<%@page import="com.phr.crypto.Elgamal"%>
<%@page import="com.phr.util.Util"%>
<%@page import="com.phr.model.Discussion"%>
<%@page import="com.phr.dao.DiscussionsDAO"%>
<%@page import="com.phr.dao.DiscussionsDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.phr.model.Record"%>
<%@page import="com.phr.model.Patient"%>
<%@page import="java.util.List"%>
<%@page import="com.phr.dao.PatientDAO"%>
<%@page import="com.phr.model.User"%>
<%
	User u1 = (User) session.getAttribute("user");
   if (u1 == null)
   {
      response.sendRedirect("login.jsp?msg=Session expired. Login again");
   }
   else
   {
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>SePHR</title>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link
	href="https://fonts.googleapis.com/css?family=Poppins:100,200,300,400,500,600,700,800,900"
	rel="stylesheet">

<link rel="stylesheet" href="css/open-iconic-bootstrap.min.css">
<link rel="stylesheet" href="css/animate.css">

<link rel="stylesheet" href="css/owl.carousel.min.css">
<link rel="stylesheet" href="css/owl.theme.default.min.css">
<link rel="stylesheet" href="css/magnific-popup.css">

<link rel="stylesheet" href="css/aos.css">

<link rel="stylesheet" href="css/ionicons.min.css">

<link rel="stylesheet" href="css/flaticon.css">
<link rel="stylesheet" href="css/icomoon.css">
<link rel="stylesheet" href="css/style.css">
</head>
<body data-spy="scroll" data-target=".site-navbar-target"
	data-offset="300">
	<div class="py-1 bg-black top">
		<div class="container">
			<div
				class="row no-gutters d-flex align-items-start align-items-center px-md-0">
				<div class="col-lg-12 d-block">
					<div class="row d-flex">
						<div class="col-md pr-4 d-flex topper align-items-center">
							<div
								class="icon mr-2 d-flex justify-content-center align-items-center">
								<span class="icon-heart"></span>
							</div>
							<span class="text">Secured Patients Health Records</span>
						</div>
						<div class="col-md pr-4 d-flex topper align-items-center">
							<div
								class="icon mr-2 d-flex justify-content-center align-items-center">
								<span class="icon-paper-plane"></span>
							</div>
							<span class="text">XON Labs</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<nav
		class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light site-navbar-target"
		id="ftco-navbar">
		<div class="container">
			<a class="navbar-brand" href="welcome.jsp">SePHR</a>
			<button class="navbar-toggler js-fh5co-nav-toggle fh5co-nav-toggle"
				type="button" data-toggle="collapse" data-target="#ftco-nav"
				aria-controls="ftco-nav" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="oi oi-menu"></span> Menu
			</button>

			<div class="collapse navbar-collapse" id="ftco-nav">
				<ul class="navbar-nav nav ml-auto">
					<li class="nav-item "><a href="welcome.jsp" class="nav-link"><span>Welcome</span></a></li>
					<li class="nav-item"><a href="patients.jsp" class="nav-link"><span>My Patients</span></a></li>
					<li class="nav-item active"><a href="records.jsp" class="nav-link"><span>Health Records</span></a></li>
					  <li class="nav-item dropdown">
					    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false"><%=u1.getFname()%> <%=u1.getLname()%></a>
					    <div class="dropdown-menu">
					      <a class="dropdown-item" href="updateprofile.jsp">Update Profile</a>
					      <a class="dropdown-item" href="changepassword.jsp">Change Password</a>
					      <a class="dropdown-item" href="account?request_type=deleteprofile">Delete Profile</a>
					      <a class="dropdown-item" href="account?request_type=logout">Logout</a>
					    </div>
					  </li>

<!-- 					<li class="nav-item cta mr-md-2"><a href="appointment.html" -->
<!-- 						class="nav-link">Appointment</a></li> -->
				</ul>
			</div>
		</div>
	</nav>

	<section class="ftco-counter img ftco-section ftco-no-pt ftco-no-pb"
		id="about-section">
		<div class="container">
			<div class="row d-flex">
				<div class="col-md-12">
				<hr/>
				
				<br/>
				
					<div class="py-md-5">
						<div class="row justify-content-start pb-3">
							<div class="col-md-12 heading-section ftco-animate p-4 p-lg-5">
								<h2 class="mb-4">
									<span>Health Records</span> 
								</h2>
								<p><%=u1.getFname()%> <%=u1.getLname()%></p>

								<br/>
								<%
									String msg = request.getParameter("msg");
								%>
								<%
									if (msg != null) {
								%>
								<div class="alert alert-success alert-dismissable">
									<a href="#" class="close" data-dismiss="alert"
										aria-label="close">&times;</a> <strong>Message!</strong>
									<%=msg%>.
								</div>
								<%
									}
								%>
								
								<%
																	PatientDAO pDao = new PatientDAO();
																																					List<Patient> patients = pDao.getAll(u1.getEmail());
																																					DiscussionsDAO dDao = new DiscussionsDAO();
																																					SimpleDateFormat sdf = new SimpleDateFormat("dd/MMM/yyyy - kk:mm");									
																																					if (patients == null || patients.size() == 0 )
																																					{
																%>
											<h4>No Patients Added Yet</h4>
										<%
									}
									else
									{
										%>
											<form action='record'>
												<input type=hidden name='reqtype' value='read' />
												<label>Select Patient</label>
												<select name='patientid' class='form-control'>
													<%
														for (Patient p : patients)
														{
															%>
																<option value='<%=p.getPatientId()%>'><%=p.getFname() %> <%=p.getLname() %> (<%=p.getPatientId() %>)</option>
															<%
														}
													%>
												</select>
												<br/>
												<input type=submit value='Fetch Records' class='btn btn-primary' />
											</form>
											<br/>
											<hr/>
											<%
												List<Record> records = (List<Record>) request.getAttribute("records");
												String patientid = (String) request.getAttribute("patientid");
												if (records != null)
												{
													Patient patient = pDao.get(patientid);																										
													%>
														<h4 style='background-color: #207dff; padding: 10px; color: white;'><%=patient.getFname() %> <%=patient.getLname() %> (<%=patient.getPatientId() %>) </h4>
														<hr/>
														
														<a href='#' data-toggle="modal" data-target="#add<%=patientid%>" ><span class="icon-plus"></span> Add New Health Record</a>
														<br/>
														<br/>
															<!-- Modal -->
															<div style='margin-top:150px; padding-bottom:200px;' class="modal" id="add<%=patientid %>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
															  <div class="modal-dialog shadow-lg p-3 mb-5 bg-white rounded" role="document">
															    <div class="modal-content" style='background-color: #207dff; color: white;'>    
															      <div class="modal-header">
															        <h5 class="modal-title" id="exampleModalLabel" style='color: white;'>Add New Health Record for <%=patient.getFname() %> <%=patient.getLname() %> (<%=patient.getPatientId() %>) </h5>
															        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
															          <span aria-hidden="true">&times;</span>
															        </button>
															      </div>
																		<form action='record' method=post>
																	      <div class="modal-body">
																				<input type=hidden name='reqtype' value='write' />
																				<input type=hidden name='patientid' value='<%=patientid%>' />
																				<textarea rows=10 placeholder="Health Record" class='form-control' name='data' style='height: 800px;' required="required"></textarea>
																	      </div>
																	      <div class="modal-footer">
																	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
																	        <button type="submit" class="btn btn-success"><span class="icon-plus"></span> Add</button>
																	      </div>
																		</form>
															    </div>
															  </div>
															</div>
														
													<%
													if (records.size() == 0)
													{
														%>
															<h6>No Health Records Found</h6>
														<%
													}
													else
													{
														%>
															<h6>Health Records for <%=patient.getFname() %> <%=patient.getLname() %> (<%=patient.getPatientId() %>)</h6>
															
															<br/>
															
															<div class="accordion" id="accordionExample">
															<%
													        	String key = Util.getSecret(u1.getEmail().substring(0, u1.getEmail().indexOf("@")));
																int i=0;
																for (Record r: records)
																{
																	i++;
																	%>
																	  <div class="card">
																	    <div class="card-header" id="headingThree<%=r.getRecordID()%>">
																	      <h2 class="mb-0">
																	        <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseThree<%=r.getRecordID()%>" aria-expanded="false" aria-controls="collapseThree<%=r.getRecordID()%>">
																	          <%=sdf.format(r.getEntry_time()) %>
																	        </button>
																	      </h2>
																	    </div>
																	    <div id="collapseThree<%=r.getRecordID()%>" class="collapse" aria-labelledby="headingThree<%=r.getRecordID()%>" data-parent="#accordionExample">
																	      <div class="card-body">
																	      	<button id='<%=patientid %>-<%=i %>-btn' onclick="decr('<%=patientid %>-<%=i %>');" style='float: right;' class='btn btn-default btn-xs'>Decrypt</button>
																	        <textarea id='<%=patientid %>-<%=i %>-enc' rows="10" class='form-control' readonly="readonly"><%=r.getData() %></textarea>
																	        <%
																	        	String arr[] = r.getData().split("\n");
																	        	String decData = "";
																	        	for (String a: arr)
																	        	{
																	        		decData += Elgamal.decrypt(a, key);
																	        		decData += "\n";
																	        	}
																	        %>
																	        <textarea style='display: none; ' id='<%=patientid %>-<%=i %>-dec' rows="10" class='form-control' readonly="readonly"><%=decData %></textarea>
																	      </div>
																	    </div>
																	  </div>
																	<%																	
																}
															%>
															</div>
														<%
													}
													
													%>
															<br/>
															<hr/>
															<h4>Discussions</h4>
															<br/>
															<%
																List<Discussion> discussions = dDao.getAll(patientid);
																if (discussions == null || discussions.size() == 0)
																{
																	%>
																		<h6>No Discussions yet</h6>
																	<%
																}
																else
																{
																	%>
																	
																	<%
																		for (Discussion d: discussions)
																		{
																			String data = d.getData().replaceAll("\n", "<br/>");
																			%>
																				<div class="card" style="width: 100%;">
																				  <div class="card-body">
																				    <h5 class="card-title"><%=d.getAuthor() %> <span style='float: right;'><%= sdf.format(d.getEntry_time())%></span></h5>
																				    <hr/>
																				    <div class="card-text">
																						<%=data %>
																				    	<hr/>
																				    </div>
																				  </div>
																			  	</div>
																			  <br/>
																			
																			<%
																		}
																	%>
																	
																		
																	<%
																}
															%>
															<br/>
															<form action='record' method=post>
																<input type=hidden name='reqtype' value='dwrite' /> 
																<input type=hidden name='patientid' value='<%=patientid%>' /> 
																<textarea rows="3" name='data' class='form-control' placeholder="Write your comment here"></textarea>
																<br/>
																<input type=submit value='Add Comment' class='btn btn-primary'/>
															</form>
													<%
													
												}
											%>
											
										<%
									}
								%>


							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>






	<!-- loader -->
	<div id="ftco-loader" class="show fullscreen">
		<svg class="circular" width="48px" height="48px">
			<circle class="path-bg" cx="24" cy="24" r="22" fill="none"
				stroke-width="4" stroke="#eeeeee" />
			<circle class="path" cx="24" cy="24" r="22" fill="none"
				stroke-width="4" stroke-miterlimit="10" stroke="#F96D00" /></svg>
	</div>


	<script src="js/jquery.min.js"></script>
	<script src="js/jquery-migrate-3.0.1.min.js"></script>
	<script src="js/popper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.easing.1.3.js"></script>
	<script src="js/jquery.waypoints.min.js"></script>
	<script src="js/jquery.stellar.min.js"></script>
	<script src="js/owl.carousel.min.js"></script>
	<script src="js/jquery.magnific-popup.min.js"></script>
	<script src="js/aos.js"></script>
	<script src="js/jquery.animateNumber.min.js"></script>
	<script src="js/scrollax.min.js"></script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
	<script src="js/google-map.js"></script>

	<script src="js/main.js"></script>
	
	<script>
		function decr(id)
		{
			var ele = id+"-enc";
			var ele2 = id+"-dec";
			var btn = id+"-btn";
			$('#'+ele).hide();
			$('#'+btn).hide();
			$('#'+ele2).show();
		}
	</script>

</body>
</html>
<% } %>