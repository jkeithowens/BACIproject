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
		<title>Add User</title>
		<link rel=Stylesheet href="style.css" type="text/css"/>
	  <script src="Register.js"></script>

	</head>

	<body>
  <?php include "header.php"; ?>
<div id="main">


<?php
require_once("inc/functions.php");
require_once("inc/mail/mail.class.php");
include("inc/RegistrationFormPHP.php");


$feedback = array();

$connection = dbConnect();

if($connection === false) //checking connection
	echo "No connection";
else
{	//connection successful
//echo "connected";

//calling the list of degrees from the database for the dropdown list
$procedure = 'Call SP_Get_Degrees()';
$procedureResult = $connection->query($procedure);
if(!$procedureResult) { //if results don't return an error is displayed
	array_push($feedback, '<p style = "color: red;">Couldn\'t get list of Degrees!</p>');
}
else { //if call is sucessful
	$degreeArray = array(); //creats an array to display the list as HTML
	while($row = $procedureResult->fetch(PDO::FETCH_ASSOC)) {
	//pushes each row into the array
	array_push($degreeArray, $row["DegreeLevel"]);
	};
	$procedureResult->closeCursor();
}

//calling the list of countries from the database for the dropdown list
$procedure1 = 'Call Get_Countries()';
$procedureResult1 = $connection->query($procedure1);
if(!$procedureResult1) { //if results don't return an error is displayed
	array_push($feedback, '<p style = "color: red;">Couldn\'t get list of Countries!</p>');
}
else { //if call is sucessful
	$countryArray = array(); //creats an array to display the list as HTML
	while($row = $procedureResult1->fetch(PDO::FETCH_ASSOC)) {
	//pushes each row into the array
	array_push($countryArray, $row["Name"]);
	};
	$procedureResult1->closeCursor();
}


//once the data has been submitted
if(isset($_POST['submit']))
{
$firstname = "";
$lastname = "";
$email = "";
$confirmEmail = "";
$password = "";
$confirmPassword = "";
$address = "";
$city = "";
$state = "";
$country = "";
$mentorormentee = "";
$degree = "";
$degree2 = "";
$degree3 = "";
$countrycode = "";
$areacode= "";
$lastseven = " ";
$fblink = "";
$linkedInlink = "";
$twitterlink = "";

$linktypeid = 0;
$numbertypeid = 1;


$resumeurl= "http://user.resume.php"; //a dummy url for now
$stateid = 1;
$countryid = 0;
$userid = 0;
$degreeid=0;
$activated = 0;
$count = 0;
$checke = false;
$checkp = false;
$code = "";
$msg = "";
$seekingmentor = 0;
$seekingmentee = 0;

//checking all the input data
if(isset($_POST['vFirstName']))
{
$firstname = trim($_POST['vFirstName']);
}
if(isset($_POST['vLastName']))
{
$lastname = trim($_POST['vLastName']);
}

if(isset($_POST['vEmail']))
{
	$email= trim($_POST['vEmail']);
	$checke  = emailchecker($email); //validating email
	if($checke == false)
		$emailBlank = '<font color="red">Invalid Email</font>';
$username = $email;   //username is the same as email
}

if(isset($_POST['vConfirmEmail']))
{
$confirmEmail= trim($_POST['vConfirmEmail']);
}

if(isset($_POST['vConfirmPassword']))
{
$confirmPassword=trim($_POST['vConfirmPassword']);
}

if(isset($_POST['vPassword']))
{
$password=trim($_POST['vPassword']);
$checkp = passwordCheck($password, $confirmPassword, 8, $feedback);
if($checkp == false)
	$passwordBlank = '<font color="red">Password should contain atleast 9 characters including both letters and numbers</font>';
else
	$hashpassword=passHash($password);		//converting the password to a hash form
}



if(isset($_POST['vAddress']))
{
$address = trim($_POST['vAddress']);
}

if(isset($_POST['vCity']))
{
$city = trim($_POST['vCity']);
}

if(isset($_POST['vState']))
{
$state = trim($_POST['vState']);
}

if(isset($_POST['vCountry']))
{
$country = trim($_POST['vCountry']);
}

if(isset($_POST['vMentorOrMentee']))
{
$mentorormentee = trim($_POST['vMentorOrMentee']);
}

if(isset($_POST['vDegree'])) {$degree = trim($_POST['vDegree']);}
if(isset($_POST['vDegree2'])) {$degree2 = trim($_POST['vDegree2']);}
if(isset($_POST['vDegree3'])) {$degree3 = trim($_POST['vDegree3']);}

if(isset($_POST['vSchool'])){$school = trim($_POST['vSchool']);}
if(isset($_POST['vSchool2'])){$school2 = trim($_POST['vSchool2']);}
if(isset($_POST['vSchool3'])){$school3 = trim($_POST['vSchool3']);}

if(isset($_POST['vMajor'])){$major = trim($_POST['vMajor']);}
if(isset($_POST['vMajor2'])){$major2 = trim($_POST['vMajor2']);}
if(isset($_POST['vMajor3'])){$major3 = trim($_POST['vMajor3']);}

if(isset($_POST['vGradYear'])){$gradyear = trim($_POST['vGradYear']);}
if(isset($_POST['vGradYear2'])){$gradyear2 = trim($_POST['vGradYear2']);}
if(isset($_POST['vGradYear3'])){$gradyear3 = trim($_POST['vGradYear3']);}

if(isset($_POST['vPhoneCountry']))
{
	$countrycode = trim($_POST['vPhoneCountry']);
}
if(isset($_POST['vPhoneArea']))
{
	$areacode = trim($_POST['vPhoneArea']);
}
if(isset($_POST['vPhoneDigits']))
{
	$lastseven = trim($_POST['vPhoneDigits']);
}
if(isset($_POST['vFB']))
{
	$fblink = trim($_POST['vFB']);

}
if(isset($_POST['vLinkedIn']))
{
	$linkedInlink = trim($_POST['vLinkedIn']);
}
if(isset($_POST['vTwitter']))
{
	$twitterlink = trim($_POST['vTwitter']);
}
if(isset($_POST['vMentorOrMentee']))
{
	$mentorormentee = trim($_POST['vMentorOrMentee']);
	if($mentorormentee == "Mentor")
	{
		$seekingmentor = 0;
		$seekingmentee = 1;
	}
	else if($mentorormentee == "Mentee")
	{
		$seekingmentor = 1;
		$seekingmentee = 0;
	}
}

//Counting the number of users with the input username
$procedure = 'Call SP_Count_Users("' . $username . '")';
$procedureResult = $connection->query($procedure);
if(!$procedureResult) //if results don't return an error is displayed
{
	array_push($feedback, '<p style = "color:red;">Query Error.</p>');
}
else
{
	//get the usercount.
	$row = $procedureResult->fetch(PDO::FETCH_OBJ);
	$count = $row->c;
	//Close the cursor.
	$procedureResult->closeCursor();
}

//checking if the user already exists
if($count>0)
{

	echo "Username already exists";
	}
else
{ //user doesn't exist so we start entering their data into the database

//Getting the country id from the COUNTRY table
$procedure = 'Call SP_Get_Country_ID("' . $country . '")';
$procedureResult = $connection->query($procedure);
if(!$procedureResult) { //if results don't return an error is displayed
	array_push($feedback, '<p style = "color: red;">Couldn\'t get Country ID!</p>');
}
else { //if call is sucessful
	$row = $procedureResult->fetch(PDO::FETCH_OBJ);
	$countryid = $row->countryid;
	//Close the cursor.
	$procedureResult->closeCursor();
}

//getting the degrees id from the EDUCATION_TYPE table
$procedure = 'Call SP_Get_Degree_ID("' . $degree . '")';
$procedureResult = $connection->query($procedure);
if(!$procedureResult) { //if results don't return an error is displayed
	array_push($feedback, '<p style = "color: red;">Couldn\'t get Degree ID!</p>');
}
else { //if call is sucessful
	$row = $procedureResult->fetch(PDO::FETCH_OBJ);
	$degreeid = $row->degreeid;
	//Close the cursor.
	$procedureResult->closeCursor();
}

//getting the degrees id from the EDUCATION_TYPE table
if (isset($_POST['vDegree2'])) {
	$procedure = 'Call SP_Get_Degree_ID("' . $degree2 . '")';
	$procedureResult = $connection->query($procedure);
	if(!$procedureResult) { //if results don't return an error is displayed
		array_push($feedback, '<p style = "color: red;">Couldn\'t get Degree ID!</p>');
	}
	else { //if call is sucessful
		$row = $procedureResult->fetch(PDO::FETCH_OBJ);
		$degreeid2 = $row->degreeid;
		//Close the cursor.
		$procedureResult->closeCursor();
	}
}


//getting the degrees id from the EDUCATION_TYPE table
if (isset($_POST['vDegree3'])) {
	$procedure = 'Call SP_Get_Degree_ID("' . $degree3 . '")';
	$procedureResult = $connection->query($procedure);
	if(!$procedureResult) { //if results don't return an error is displayed
		array_push($feedback, '<p style = "color: red;">Couldn\'t get Degree ID!</p>');
	}
	else { //if call is sucessful
		$row = $procedureResult->fetch(PDO::FETCH_OBJ);
		$degreeid3 = $row->degreeid;
		//Close the cursor.
		$procedureResult->closeCursor();
	}
}
//entering data into the USER table
if(!empty($username))
{
$procedure = 'call SP_Add_User("' . $username . '","' . $hashpassword . '","' . $email . '","' . $firstname . '","' . $lastname . '","' . $address . '",
"' . $city . '","' . $stateid . '","' . $countryid . '","' . $seekingmentor . '","' . $seekingmentee . '","' . $resumeurl . '","' . $activated . '")';
try
			{
				$connection->query($procedure);
				//echo "User created!";
				array_push($feedback, '<p>User created successfully!</p>');
			}
			catch(PDOException $e)
			{
				//If there's an error, give feedback.  Don't give the specific exception to users.
				array_push($feedback, '<p style = color: red">Error querying database. User not created</p>');
			}

//getting the user id alloted to the user
$procedure = 'Call SP_Get_User_ID("' . $username . '")';
$procedureResult = $connection->query($procedure);
if(!$procedureResult) { //if results don't return an error is displayed
	array_push($feedback, '<p style = "color: red;">Couldn\'t get list of Degrees!</p>');
}
else { //if call is sucessful
	$row = $procedureResult->fetch(PDO::FETCH_OBJ);
	$userid = $row->userid;
	//Close the cursor.
	$procedureResult->closeCursor();
}
}

//Adding the education details of the user to the USER_EDUCATION table
$procedure = 'Call SP_Add_User_Education("' . $userid . '", "' . $degreeid . '", "' . $school . '", "' . $major . '")';
try
			{
				$connection->query($procedure);
				//echo "User Education Added!";
				array_push($feedback, '<p>User  Education Added successfully!</p>');
			}
			catch(PDOException $e)
			{
				//If there's an error, give feedback.  Don't give the specific exception to users.
				array_push($feedback, '<p style = color: red">Error querying database. User Education not created</p>');

				}

if (isset($_POST['vDegree2'])) {
$procedure = 'Call SP_Add_User_Education("' . $userid . '", "' . $degreeid2 . '", "' . $school2 . '", "' . $major2 . '")';
try
			{
				$connection->query($procedure);
				//echo "User Education Added!";
				array_push($feedback, '<p>User  Education Added successfully!</p>');
			}
			catch(PDOException $e)
			{
				//If there's an error, give feedback.  Don't give the specific exception to users.
				array_push($feedback, '<p style = color: red">Error querying database. User Education not created</p>');

				}
}

if (isset($_POST['vDegree3'])) {
$procedure = 'Call SP_Add_User_Education("' . $userid . '", "' . $degreeid3 . '", "' . $school3 . '", "' . $major3 . '")';
try
			{
				$connection->query($procedure);
				//echo "User Education Added!";
				array_push($feedback, '<p>User  Education Added successfully!</p>');
			}
			catch(PDOException $e)
			{
				//If there's an error, give feedback.  Don't give the specific exception to users.
				array_push($feedback, '<p style = color: red">Error querying database. User Education not created</p>');

				}

//Adding the phone number of the user to the PHONE table
$procedure = 'Call SP_Add_User_Phone("' . $userid . '", "' . $numbertypeid . '", "' . $countrycode . '", "' . $areacode . '", "' . $lastseven . '")';
try
			{
				$connection->query($procedure);
				//echo "User Phone Number Added!";
				array_push($feedback, '<p>User Phone number Added successfully!</p>');
			}
			catch(PDOException $e)
			{
				//If there's an error, give feedback.  Don't give the specific exception to users.
				array_push($feedback, '<p style = color: red">Error querying database. User Phone number not added</p>');

				}
}

//adding the facebook link provided by the user to the SOCIAL_MEDIA_LINK table
$url = $fblink;
$linktypeid = 1;
$procedure = 'Call SP_Add_User_Links("' . $userid . '", "' . $linktypeid . '", "' . $url . '")';
try
			{
				$connection->query($procedure);
				//echo "User Links Added!";
				array_push($feedback, '<p>User Link Added successfully!</p>');
			}
			catch(PDOException $e)
			{
				//If there's an error, give feedback.  Don't give the specific exception to users.
				array_push($feedback, '<p style = color: red">Error querying database. User Links have not been added</p>');
			}

//adding the twitter link provided by the user to the SOCIAL_MEDIA_LINK table
$url = $twitterlink;
$linktypeid = 2;
$procedure = 'Call SP_Add_User_Links("' . $userid . '", "' . $linktypeid . '", "' . $url . '")';
try
			{
				$connection->query($procedure);
				//echo "User Links Added!";
				array_push($feedback, '<p>User  Link Added successfully!</p>');
			}
			catch(PDOException $e)
			{
				//If there's an error, give feedback.  Don't give the specific exception to users.
				array_push($feedback, '<p style = color: red">Error querying database. User Links have not been added</p>');
			}

//adding the LinkedIn link provided by the user to the SOCIAL_MEDIA_LINK table
$url = $linkedInlink;
$linktypeid = 3;
$procedure = 'Call SP_Add_User_Links("' . $userid . '", "' . $linktypeid . '", "' . $url . '")';
try
			{
				$connection->query($procedure);
				//echo "User Links Added!";
				array_push($feedback, '<p>User  Link Added successfully!</p>');
			}
			catch(PDOException $e)
			{
				//If there's an error, give feedback.  Don't give the specific exception to users.
				array_push($feedback, '<p style = color: red">Error querying database. User Links have not been added</p>');
			}

//once the user has registered, an activation email is sent to them
echo "Thank you for registering. An activation email has been sent to your registered email id." ;
$code = randomCodeGenerator(50);		//generates a random code
$msg = activateCode($email,$firstname,$code);  //sends the code


//Activates the user by inserting 1 in the Activated field of the USER table
$procedure = 'Call SP_Activate_User("' . $username . '")';
$procedureResult = $connection->query($procedure);
}
}
}

?>

        <div class="container containerinput" style="margin-top:15px">
          <!-- Feedback Form Starts Here -->

          <!-- Heading Of The Form -->

            <?php print "<h2>".$message."</h2>"; ?>


            <!-- Feedback Form Ends Here -->

              <form action="" id="form" method="post" name="form">
							<p>
							Personal Info
							</p>
              <?php print $firstBlank;?><input name="vFirstName" placeholder="*First Name" type="text" value="">
						  <input name="vMiddleName" placeholder="Middle Name" type="text" value="">
              <?php print $lastBlank;?><input name="vLastName" placeholder="*Last Name" type="text" value="">
							<?php print $lastBlank;?><input class="phone" name="vPhoneCountry" placeholder="Country Code" type="text" value="">
							<?php print $lastBlank;?><input class="phone" name="vPhoneArea" placeholder="Area Code" type="text" value="">
							<?php print $lastBlank;?><input class="phone" name="vPhoneDigits" placeholder="Last 7 Digits" type="text" value="">
							<?php print $lastBlank;?><input name="vAddress" placeholder="Street Address" type="text" value="">
							<?php print $lastBlank;?><input name="vCity" placeholder="City" type="text" value="">
							<?php print $lastBlank;?><input name="vState" placeholder="State/Province" type="text" value="">
							<?php print $lastBlank;?><input name="vZip" placeholder="Zip" type="text" value="">
							<select id="country" name="vCountry">
								<option value="" selected disabled hidden>Select Country</option>
								<?php
								//runs for each loop to get the country value for each country from the array
								foreach ($countryArray as &$value) {
								    print '<option value="'.$value.'">'.$value."</option>" . "<br />";
								}
								?>
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
							<div id="degreeDiv">
								<div id="degree1">
									<select id="degree" name="vDegree">
										<option value="" selected disabled hidden>*Select Degree</option>
										<?php
										//runs for each loop to get the degree value for each degree from the array
										foreach ($degreeArray as &$value) {
										    print '<option value="'.$value.'">'.$value."</option>" . "<br />";
										}
										?>
									<?php print $lastBlank;?><input name="vSchool" placeholder="*School Name" type="text" value="">
									<?php print $lastBlank;?><input name="vMajor" placeholder="*Major" type="text" value="">
									<?php print $lastBlank;?><input name="vGradYear" placeholder="*Year of Graduation" type="text" value="">
									<button type="button"  class="addDeg" id="addDegreeButton1">Add another degree</button>
								</div>
							</div>
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
