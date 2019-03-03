<?php
      
	$choice= "";
	if(isset($_POST['opt']))
	{
		$choice = trim($_POST['opt']);
	}
?>

<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8"/>
		<title>My Template</title>
		<link rel=Stylesheet href="style.css" type="text/css"/>
		<script language="javascript">
					var i = 1;
					function changeIt()
					{

					my_div.innerHTML = my_div.innerHTML +"<br><input type='text' name='mytext'+ i>"
					i++;
					}
					</script>
	</head>

	<body>
<?php include "header.php";
 ?>

		<div id = "main">
		         	
			        <div class="container " style="margin-top:75px">
			          <div>
			          <!-- Heading Of The Form -->
			            <H1><b>SEARCH: </b></H1>
			     	      <form action="#" id="form" method="post" name="form">
				      <!-- Giving them an option to search for an individual or a list of mentors or mentees or both-->
					
				        <b>I want to search for:</b>
 					<select name = 'opt'>
					<option value = "Mentors">Mentors</option>
					<option value = "Mentees">Mentees</option>
					<option value = "Mentors and Mentees">Mentors and Mentees</option>
					</select>
				        <br/><br/><br/>	
					
					<div id="my_div"></div>
					<?php
					if($choice == null)
					{
                                        }
					else
					{
					?>
					<b>First Name:</b>
					<input name = "fn" id = "fn" type = "text" maxlength = "60" Placeholder="First Name"/>
					<br/>
					<br/>
					<br/>
			
  
					<b>Last Name:</b>
					<input name = "ln" id = "ln" type = "text" maxlength = "60" Placeholder="Last Name"/>
					<br/>
					<br/>
					<br/>

					<b>Country:</b>
					<select name = "">
					<option value = "Australia">Europe</option>
					<option value = "Canada">Canada</option>
					<option value = "China">China</option>
					<option value = "France">France</option>
					<option value = "Germany">Germany</option>
					<option value = "India">India</option>
					<option value = "Myanmar">Myanmar</option>
					<option value = "Russia">Russia</option>
					<option value = "Spain">Spain</option>	
					<option value = "United Kingdom">United Kingdom</option>
					<option value = "United States of America">United States of America</option>
					
					
					</select>
					<br/>
					<br/>
					<br/>


					<b>City:</b>
					<input name = "city" id = "city" type = "text" maxlength = "60" Placeholder="City"/>
					<br/>
					<br/>
					<br/>

					<b>Field of Interest:</b>
					<input name = "interest" id = "interest" type = "text" maxlength = "60" Placeholder="Field of Interest"/>
					<br/>
					<br/>
					<br/>
				
					
<?php
					}
?>
					
	
				     

					<input name = "end" type = "submit" value = "Submit" />
					<br/>
					<br/>
					<br/>

				      
					</form>
			          </div>
			        </div>
		</div>

	</body>

</html>
