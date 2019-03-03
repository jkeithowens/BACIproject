<?php
	$newCountry = "";
	$demoArray = array("United States Of America", "Myanmar", "Australia", "United Kingdom", "France", "Spain", "Italy");
	if(isset($_POST["newCountry"]))
	{
		$newCountry = $_POST["newCountry"];
		array_push($demoArray, $newCountry);
	}
?>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8"/>
		<title>Add New Countries</title>
		<link rel=Stylesheet href="style.css" type="text/css"/>
	</head>

	<body>
<?php include "header.php";?>

		<div id = "main">
			        <div class="container containerinput" style="margin-top:75px">
			          <div>
			            <h1>Current countries list:</h1>
						<?php
						for($index = 0; $index < count($demoArray); $index++)
						{
							echo "<p>" . $demoArray[$index] . "</p>";
						}
						?>
			              <form action="#" id="form" method="post" name="form">
						  <h1>Enter new country name</h1>
						  <input placeholder="Country name" type = "text" name = "newCountry"/>
			              <br />
			              <input id="send" name="submit" type="submit" value="Submit">
			            </form>
			          </div>
			        </div>
		</div>

	</body>

</html>
