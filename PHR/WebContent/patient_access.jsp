<%@page import="java.util.ArrayList"%>
<%@page import="com.phr.dao.RecordsDAO"%>
<%@page import="com.phr.dao.RecordsDAO"%>
<%@page import="com.phr.util.Util"%>
<%@page import="com.phr.crypto.Elgamal"%>
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
							<span class="text">XON LABS</span>
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
			<a class="navbar-brand" href="patient_access.jsp">SePHR</a>
			<button class="navbar-toggler js-fh5co-nav-toggle fh5co-nav-toggle"
				type="button" data-toggle="collapse" data-target="#ftco-nav"
				aria-controls="ftco-nav" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="oi oi-menu"></span> Menu
			</button>

			
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
									<span>Patient Access (Read Only Records)</span> 
								</h2>
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
																	String patientid = (String) session.getAttribute("pid");
																																																			PatientDAO pDao = new PatientDAO();
																																																			RecordsDAO rDao = new RecordsDAO();
																																																			SimpleDateFormat sdf = new SimpleDateFormat("dd/MMM/yyyy - kk:mm");									
																																																			if (patientid != null)
																																																			{
																																																				
																																																				List<Record> records = (List<Record>) request.getAttribute("records");
																																																				
																																																				if (records == null)
																																																				{
																																																					   records = rDao.getAll(patientid);
																																																					   if (records != null && records.size() > 0)
																																																					   {
																																																			               List<Record> records2 = new ArrayList<Record>();
																																																			               for (Record r : records)
																																																			               {
																																																			                  Record r2 = new Record();
																																																			                  r2.setDoctor(r.getDoctor());
																																																			                  r2.setEntry_time(r.getEntry_time());
																																																			                  r2.setPatientID(r.getPatientID());
																																																			                  r2.setRecordID(r.getRecordID());
																																																			                  r2.setUpdate_time(r.getUpdate_time());
																																													
																																																			                  String data = r.getData();
																																																			                  String key = Util.getSecret(r.getDoctor().substring(0, r.getDoctor().indexOf("@")));
																																																			                  String arr[] = data.split("\n");
																																																			                  String decData = "";
																																																			                  for (String a: arr)
																																																			                  {
																																																			                     decData += Elgamal.decrypt(a, key);
																																																			                     decData += "\n";
																																																			                  }
																																																			                  
																																																			                  String key2 = Util.getSecret(patientid);
																																																			                  String arr2[] = decData.split("\n");
																																																			                  String encData = "";
																																																			                  for (String a: arr2)
																																																			                  {
																																																			                     encData += Elgamal.encrypt(a, key2);
																																																			                     encData += "\n";
																																																			                  }
																																																			                    
																																													
																																																			                  r2.setData(encData);
																																																			                  records2.add(r2);
																																																			               }
																																													
																																																			               records = records2;		
																																																					   }
																																																				}
																																																				
																																																				
																																																				if (records != null && records.size() > 0)
																																																				{
																																																					Patient patient = pDao.get(patientid);
																%>
												<h4 style='background-color: #207dff; padding: 10px; color: white;'><%=patient.getFname()%> <%=patient.getLname()%> (<%=patient.getPatientId()%>) </h4>
												<hr/>
												<a style='float: right;' href='readonly?req_type=logout'>Logout</a>
												
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
													<h6>Health Records for <%=patient.getFname()%> <%=patient.getLname()%> (<%=patient.getPatientId()%>)</h6>
													
													<br/>
													
													<div class="accordion" id="accordionExample">
													<%
														String key = Util.getSecret(patientid);													
																									int i =0;
																									for (Record r: records)
																									{
																										i++;
													%>
															  <div class="card">
															    <div class="card-header" id="headingThree<%=r.getRecordID()%>">
															      <h2 class="mb-0">
															        <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseThree<%=r.getRecordID()%>" aria-expanded="false" aria-controls="collapseThree<%=r.getRecordID()%>">
															          <%=sdf.format(r.getEntry_time())%>
															        </button>
															      </h2>
															    </div>
															    <div id="collapseThree<%=r.getRecordID()%>" class="collapse" aria-labelledby="headingThree<%=r.getRecordID()%>" data-parent="#accordionExample">
															      <div class="card-body">
																	      	<button id='<%=patientid%>-<%=i%>-btn' onclick="decr('<%=patientid%>-<%=i%>');" style='float: right;' class='btn btn-default btn-xs'>Decrypt</button>
																	        <textarea id='<%=patientid%>-<%=i%>-enc' rows="10" class='form-control' readonly="readonly"><%=r.getData()%></textarea>
																	        <%
																	        	String arr[] = r.getData().split("\n");
																	        															        	String decData = "";
																	        															        	for (String a: arr)
																	        															        	{
																	        															        		decData += Elgamal.decrypt(a, key);
																	        															        		decData += "\n";
																	        															        	}
																	        %>
																	        <textarea style='display: none; ' id='<%=patientid%>-<%=i%>-dec' rows="10" class='form-control' readonly="readonly"><%=decData%></textarea>
															      </div>
															    </div>
															  </div>
															<%
																}
															%>
													</div>
													
																	
													
													
												<%
																																																																					}
																																																																												}
																																																																				%>
											
															<br/>
															<hr/>
															<h4>Discussions</h4>
															<br/>
															<%
																DiscussionsDAO dDao = new DiscussionsDAO();
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
															<form action='readonly' method=post>
																<input type=hidden name='req_type' value='dwrite' /> 
																<input type=hidden name='patientid' value='<%=patientid%>' /> 
																<textarea rows="3" name='data' class='form-control' placeholder="Write your comment here"></textarea>
																<br/>
																<input type=submit value='Add Comment' class='btn btn-primary'/>
															</form>
											
											
										<%
									}
									else
									{
										%>
											<form action='readonly' method=post>
												<input type=hidden name='req_type' value='verify' />
												<label>Patient ID</label>
												<input type=text name='pid' class='form-control' required="required" placeholder="Patient ID" />
												<br/>
												<label>PIN</label>
												<input type=text name='pin' class='form-control' required="required" placeholder="PIN" />
												<br/>
												<input type=submit value='Access My Records' class='btn btn-primary' />
 											</form>
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