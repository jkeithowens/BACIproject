<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8"/>
		<title>My Template</title>
		<link rel=Stylesheet href="style.css" type="text/css"/>
	</head>

	<body>
<?php include "header.php"; ?>

		<div id = "main">
			<?php

			//calls dependencies
			require_once "functions.php";
			require_once "RegistrationFormPHP.php";

			//GET request that captures the activation code as variable "a"
			// $activationCode = "";
			// if(isset($_GET['a']))	{
			//   $activationCode = $_GET['a'];
			// }
			// $activationMessage = ""; //sets initial activation message to empty

			//calls function to make sure code is 50 digits and alphanumeric
			// if (codeValidate($activationCode)==true) {
			//   //displays message showing successful activation
			// $activationMessage = "activation successful";
			// }
			// else {
			//displays message showing failed activation
			// $activationMessage = "activation failed";
			// }



			?>
			            <!-- Form for login Starts Here -->
			        <div class="container containerinput" style="margin-top:75px">
			          <div>
			          <!-- Heading Of The Form -->
			            <H1>Login:</H1>
			            <!-- <?php print $activationMessage;?> -->
			              <form action="#" id="form" method="post" name="form">
			                <!-- Form contains a field for login and password -->
			              <?php print $emailBlank . $validateBlank;?><input name="vEmail" placeholder="Your Email" type="text" value="">
			              <?php print $passwordBlank;?><input name="vPassword" placeholder="Enter Password" type="password" value="">
			              <br />
			              <input id="send" name="submit" type="submit" value="Submit">
			            </form>
									<a href="register.php">
										<p>Sign Up</p>
									</a>
									<a href="forgotPassword.php">
										<p>Forgot Password</p>
									</a>
			          </div>
			        </div>
		</div>


		<div>
			<a href="adminLogin.php">Admin Login</a>
		</div>

	</body>

</html>
