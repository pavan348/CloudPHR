<%@page import="java.text.SimpleDateFormat"%>
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
					<li class="nav-item active"><a href="patients.jsp" class="nav-link"><span>My Patients</span></a></li>
					<li class="nav-item"><a href="records.jsp" class="nav-link"><span>Health Records</span></a></li>
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
		id="about-section" style='min-height: 800px;'>
		<div class="container">
			<div class="row d-flex">
				<div class="col-md-12">
				<hr/>
				
				<br/>
				
					<div class="py-md-5">
						<div class="row justify-content-start pb-3">
							<div class="col-md-12 heading-section ftco-animate p-4 p-lg-5">
								<h2 class="mb-4">
									<span>My Patients</span> 
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
								
							<a href='#' data-toggle="modal" data-target="#addpatient"><span class="icon-plus"></span> Add</a> 
							<hr/>	
							<!-- Modal -->
							<div style='margin-top:150px; padding-bottom:200px;' class="modal" id="addpatient" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
							  <div class="modal-dialog shadow-lg p-3 mb-5 bg-white rounded" role="document">
							    <div class="modal-content" style='background-color: #207dff; color: white;'>    
							      <div class="modal-header">
							        <h5 class="modal-title" id="exampleModalLabel" style='color: white;'>Add Patient</h5>
							        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
							          <span aria-hidden="true">&times;</span>
							        </button>
							      </div>
										<form action='patient' method=post>
									      <div class="modal-body">
													<input type=hidden name='reqtype' value='write' />
													<label>Patient First Name</label>
													<input type=text name='fname' placeholder="First Name" class='form-control' required="required"/>
													<br/>
													<label>Patient Last Name</label>
													<input type=text name='lname' placeholder="Last Name" class='form-control' required="required"/>
													<br/>
													<label>Date of Birth</label>
													<input type=date required="required" name='dob' class='form-control'/>
													<br/>
													<label>Gender</label>
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
													<input type=radio name='gender' value='Male'> Male &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
													<input type=radio name='gender' value='Female'> Female
													<br/>
													<label>Patient Email ID</label>
													<input type=text name='email' placeholder="Email ID" class='form-control' required="required"/>
													<br/>
													<label>Patient Mobile</label>
													<input type=text name='mobile' placeholder="Mobile" class='form-control' required="required" pattern="[0-9]{10}"/>
													<br/>
									      </div>
									      <div class="modal-footer">
									        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
									        <button type="submit" class="btn btn-success"><span class="icon-plus"></span> Add Patient</button>
									      </div>
										</form>
							    </div>
							  </div>
							</div>
							
							<%
															PatientDAO pDao = new PatientDAO();
																				List<Patient> patients = pDao.getAll(u1.getEmail());
																				if (patients != null && patients.size() == 0)
																				{
														%>
										<h4>No Patients Added yet</h4>
									<%
								}
								else
								{
									%>
									<div class='row'>
									<%
									int i=0;
									for (Patient p : patients)
									{
										i++;
										SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
										String birthyear = sdf.format(p.getDob());
										int age = 2020 - (Integer.parseInt(birthyear));
										%>
										<div class='col-md-3' style='margin: 30px;'>
										<div class="card" style="width: 18rem;">
										  <img src="patient.png" class="card-img-top" alt="...">
										  <div class="card-body">
										    <h5 class="card-title"><%=p.getFname() %> <%=p.getLname() %></h5>
										    <hr/>
										    <div class="card-text">
										    	<%=age %> years/ <%=p.getGender() %>
										    	<hr/>
										    	<%=p.getEmail() %>
										    	<hr/>
										    	<%=p.getMobile() %>
										    	<hr/>
										    </div>
										    <a href="#" data-toggle="modal" data-target="#edit<%=i %>" style='width: 100px; float: left;' class="btn btn-primary">Edit</a>
										    <a href="#" data-toggle="modal" data-target="#delete<%=i %>" style='float: right; width: 100px;' class="btn btn-danger">Delete</a>
										    
												<!-- Modal -->
												<div style='margin-top:150px; padding-bottom:200px;' class="modal" id="edit<%=i %>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
												  <div class="modal-dialog shadow-lg p-3 mb-5 bg-white rounded" role="document">
												    <div class="modal-content" style='background-color: #207dff; color: white;'>    
												      <div class="modal-header">
												        <h5 class="modal-title" id="exampleModalLabel" style='color: white;'>Add Patient</h5>
												        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
												          <span aria-hidden="true">&times;</span>
												        </button>
												      </div>
															<form action='patient' method=post>
														      <div class="modal-body">
																		<input type=hidden name='reqtype' value='update' />
																		<label>Patient First Name</label>
																		<input value='<%=p.getFname() %>' type=text name='fname' placeholder="First Name" class='form-control' required="required"/>
																		<br/>
																		<label>Patient Last Name</label>
																		<input value='<%=p.getLname() %>' type=text name='lname' placeholder="Last Name" class='form-control' required="required"/>
																		<br/>
																		<label>Date of Birth</label>
																		<input value='<%=p.getDob() %>' type=date required="required" name='dob' class='form-control'/>
																		<br/>
																		<label>Gender</label>
																		<%
																			if(p.getGender().equals("Male"))
																			{
																				%>
																					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
																					<input checked="checked" type=radio name='gender' value='Male'> Male &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
																					<input type=radio name='gender' value='Female'> Female																				
																				<%
																			}
																			else
																			{
																				%>
																					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
																					<input type=radio name='gender' value='Male'> Male &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
																					<input checked="checked" type=radio name='gender' value='Female'> Female																				
																				<%	
																			}
																		%>
																		
																		<br/>
																		<label>Patient Email ID</label>
																		<input value='<%=p.getEmail() %>' type=text name='email' placeholder="Email ID" class='form-control' required="required"/>
																		<br/>
																		<label>Patient Mobile</label>
																		<input value='<%=p.getMobile() %>' type=text name='mobile' placeholder="Mobile" class='form-control' required="required"/>
																		<br/>
														      </div>
														      <div class="modal-footer">
														        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
														        <button type="submit" class="btn btn-success"><span class="icon-plus"></span> Add Patient</button>
														      </div>
															</form>
												    </div>
												  </div>
												</div>

												<!-- Modal -->
												<div style='margin-top:150px; padding-bottom:200px;' class="modal" id="delete<%=i %>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
												  <div class="modal-dialog shadow-lg p-3 mb-5 bg-white rounded" role="document">
												    <div class="modal-content" style='background-color: #207dff; color: white;'>    
												      <div class="modal-header">
												        <h5 class="modal-title" id="exampleModalLabel" style='color: white;'>Delete <%=p.getFname() %> <%=p.getLname() %></h5>
												        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
												          <span aria-hidden="true">&times;</span>
												        </button>
												      </div>
															<form action='patient' method=post>
														      <div class="modal-body">
																		<input type=hidden name='reqtype' value='delete' />
																		<input type=hidden name='patientid' value='<%=p.getPatientId() %>' />
																		<label>Are you sure to delete?</label>
														      </div>
														      <div class="modal-footer">
														        <button type="button" class="btn btn-success" data-dismiss="modal">No</button>
														        <button type="submit" class="btn btn-secondary"><span class="icon-remove"></span> Yes</button>
														      </div>
															</form>
												    </div>
												  </div>
												</div>
										    
										    
										  </div>
										</div>
										</div>
										<%
									}
								}
							%>
							
								
								</div>

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

</body>
</html>
<% } %>