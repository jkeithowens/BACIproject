<!-- Author: J. Keith Owens
File Name: lab2.php
Created Date: 9/14/2018
Purpose: A sample registration page using PHP Post method (lab2 of n242)
File also sends a registration email and activation code
This file contains the user interface
Revision History:
JKO 9/4/2018 Original Build
JKO 9/14/2018 Made password field a password type (from text type)
              added functions file as a dependency
-->


<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8"/>
		<title>My Template</title>
		<link rel=Stylesheet href="style.css" type="text/css"/>
	</head>

	<body>
  <?php include "header.php";?>
<div id="main">


<?php
require_once "inc/functions.php";
require_once "inc/mail/mail.class.php";
include "inc/RegistrationFormPHP.php";

error_reporting(E_ERROR | E_PARSE);

if(isset($_POST['submit'])){
	
	//$AdminLevel = $_POST['vAdminLevel'];
	$AdminLevel = 0;
	$FirstName = $_POST['vFirstName'];
	$MiddleName = $_POST['vMiddleName'];
	$LastName = $_POST['vLastName'];
	$Phone = $_POST['vPhone'];
	$Address = $_POST['vAddress'];
	$City = $_POST['vCity'];
	$State = $_POST['vState'];
	$Zip = $_POST['vZip'];
	$Country = $_POST['vCountry'];
	$Gender = $_POST['vGender'];
	$FB = $_POST['vFB'];
	$Twitter = $_POST['vTwitter'];
	$Email = $_POST['vEmail'];
	$ConfirmEmail = $_POST['vConfirmEmail'];
	$Password = passHash($_POST['vPassword']);
	$ConfirmPassword = passHash($_POST['vConfirmPassword']);
	$Degree = $_POST['vDegree'];
	$School = $_POST['vSchool'];
	$Major = $_POST['vMajor'];
	$GradYear = $_POST['vGradYear'];
	$MentorOrMentee = $_POST['vMentorOrMentee'];

	$con = dbConnect();
	
	function MM($MentorOrMentee, $Mentor){
		switch($Mentor){
			case True:
				if($MentorOrMentee=="Mentor"){
					return 1;
				}
				else if($MentorOrMentee=="Mentee"){
					return 0;
				}
			case False:
				if($MentorOrMentee=="Mentor"){
					return 0;
				}
				else if($MentorOrMentee=="Mentee"){
					return 1;
				}
		}
	}
}
	

	if(isset($_POST['submit'])){
		$Mentorship = MM($MentorOrMentee, True);
		$Menteeship = MM($MentorOrMentee, False);
		
		if($AdminLevel==0){
			$sql = "Update USER set Email = '".$Email."', FirstName = '".$FirstName."', LastName = '".$LastName."',City = '".$City."', StateProvinceID = 1, CountryID = $Country, SeekingMentorship = $Mentorship, SeekingMenteeship = $Menteeship where Email = '".$Email."' and Password = '".$Password."' ;"; 
			$result = $con->query($sql);
			//echo $sql;
		}
	}

?>

        <div class="container containerinput" style="margin-top:75px">
          <!-- Feedback Form Starts Here -->

          <!-- Heading Of The Form -->

            <?php print "<h2>".$message."</h2>"; ?>


            <!-- Feedback Form Ends Here -->

              <form action="EditUser.php" id="form" method="post" name="form">
								<!--<p>
								Set Admin Level
								</p>
								<select id="adminLevel" name="vAdminLevel">
									<option value="" selected disabled hidden>Admin Level</option>
									<option value=0>User</option>
									<option value=3>Coordinator</option>
									<option value=1>Super Admin</option>
								</select>
								<br />
								<br />
								<input id="send" name="submit" type="submit" value="Save">
								<br />
								<br />-->
							<p>
							Personal Info
							</p>
              <?php print $firstBlank;?><input name="vFirstName" placeholder="*First Name" type="text" value="">
						  <input name="vMiddleName" placeholder="Middle Name" type="text" value="">
              <?php print $lastBlank;?><input name="vLastName" placeholder="*Last Name" type="text" value="">
							<?php print $lastBlank;?><input name="vPhone" placeholder="Phone Number" type="text" value="">
							<?php print $lastBlank;?><input name="vAddress" placeholder="Street Address" type="text" value="">
							<?php print $lastBlank;?><input name="vCity" placeholder="City" type="text" value="">
							<?php print $lastBlank;?><input name="vState" placeholder="State/Province" type="text" value="">
							<?php print $lastBlank;?><input name="vZip" placeholder="Zip" type="text" value="">
							<select id="country" name="vCountry">
								<option value="" selected disabled hidden>Select Country</option>
                <option value="1">USA</option>
                <option value="2">Myanmar</option>
								<option value="8">Mexico</option>
								<option value="10">Canada</option>
								<option value="12">Brazil</option>
								<option value="14">England</option>
								<option value="16">Spain</option>
								<option value="18">Ireland</option>
								<option value="19">New Zealand</option>
								<option value="33">Finland</option>
            	</select>
              <input id="gender" type="radio" name="vGender" value="male" checked="checked"> Male<br>
              <input id="gender" type="radio" name="vGender" value="female"> Female<br>
              <br />
							<p>
							Social Media Links
							</p>
							<?php print $lastBlank;?><input name="vFB" placeholder="Facebook Link" type="text" value="">
							<?php print $lastBlank;?><input name="vLinkedIn" placeholder="LinkedIn Link" type="text" value="">
							<?php print $lastBlank;?><input name="vTwitter" placeholder="Twitter Link" type="text" value="">
							<p>
							Login Info
							</p>
              <?php print $validateBlank;?>
              <?php print $matchEmail;?>
              <?php print $emailBlank;?><input name="vEmail" placeholder="*Your Email (Will serve as Username)" type="text" value="">
              <?php print $confirmEmailBlank;?><input name="vConfirmEmail" placeholder="*Confirm Your Email" type="text" value="">
              <?php print $matchBlank;?>
              <?php print $passwordBlank;?><input name="vPassword" placeholder="*Enter Password" type="password" value="">
              <?php print $confirmPasswordBlank;?><input name="vConfirmPassword" placeholder="*Confirm Your Password" type="password" value="">
							<p>
							Education
							</p>
							<select id="degree" name="vDegree">
								<option value="" selected disabled hidden>*Select Degree</option>
                <option value="Mentor">HS</option>
                <option value="Mentee">BS</option>
								<option value="Mentee">Master</option>
                <option value="Mentee">PHD</option>
                <option value="Mentee">Technical Certificate</option>
                <option value="Mentee">Other</option>
            	</select>
							<?php print $lastBlank;?><input name="vSchool" placeholder="*School Name" type="text" value="">
							<?php print $lastBlank;?><input name="vMajor" placeholder="*Major" type="text" value="">
							<?php print $lastBlank;?><input name="vGradYear" placeholder="*Year of Graduation" type="text" value="">
							<button>Add another degree</button>
							<p>
							Other Info
							</p>
              <select id="mentorOrMentee" name="vMentorOrMentee">
								<option value="" selected disabled hidden>Select Mentor or Mentee</option>
                <option value="Mentor">Mentor</option>
                <option value="Mentee">Mentee</option>
            	</select>

							<select id="identity" name="vIdentity">
								<option value="" selected disabled hidden>Select Work Status</option>
                <option value="student">Student</option>
                <option value="employed">Working Professional</option>
            	</select>
							<?php print $lastBlank;?><input name="vEmployer" placeholder="Employer (Required if Working Professional)" type="text" value="">
							<?php print $lastBlank;?><input name="vField" placeholder="Field of Profession (Required if Working Professional)" type="text" value="">
							<br/>
							<button>Upload Picture</button>
							<button>Upload Resume</button> <br/>

            	</br/>

							<input type="checkbox" id="agreeToTerms" name="vAgreeToTerms" value="agree">
							<label for="agreeToTerms">Agree to Terms?</label> <?php print $agreeBlank;?>
							<br/>
							<br/>
              <input id="send" name="submit" type="submit" value="Submit">
              </form>



      </div>
</div>


  </body>
</html>