<?php
	$newEducationLevel = "";
	$demoArray = array("Masters","Bachelor's","Associates","GED");
	if(isset($_POST["newEducationLevel"]))
	{
		$newEducationLevel = $_POST["newEducationLevel"];
		array_push($demoArray, $newEducationLevel);
	}
?>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8"/>
		<title>Add New Education Levels</title>
		<link rel=Stylesheet href="style.css" type="text/css"/>
	</head>

	<body>
<?php include "header.php"; ?>

		<div id = "main">
			        <div class="container containerinput" style="margin-top:75px">
			          <div>
			            <h1>Current education levels:</h1>
						<?php
						for($index = 0; $index < count($demoArray); $index++)
						{
							echo "<p>" . $demoArray[$index] . "</p>";
						}
						?>
			              <form action="#" id="form" method="post" name="form">
						  <h1>Enter new education level</h1>
						  <input placeholder="Name of education level" type = "text" name = "newEducationLevel"/>
			              <br />
			              <input id="send" name="submit" type="submit" value="Submit">
			            </form>
			          </div>
			        </div>
		</div>

	</body>

</html>
