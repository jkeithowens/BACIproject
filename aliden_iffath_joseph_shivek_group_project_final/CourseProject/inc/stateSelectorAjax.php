<?php
// Array with names

// get the q parameter from URL
require_once("functions.php");
require_once("adminOBJ.php");

$list = "";
$q = "";
$state = "";
$fromSearch=False;
if(isset($_REQUEST["state"]))		$state = sanitize($_REQUEST["state"]);
if(isset($_REQUEST["q"]))			$q = sanitize($_REQUEST["q"]);
if(isset($_REQUEST["fromSearch"]))	$fromSearch=True;
// lookup all hints from array if $q is different from ""
// if ($q !== "") {
//     if ($q ==2) {
//       $list = stateOptionList();
//     } elseif ($q==1) {
//       $list = ProvOptionList();
//     } else {
//       $list = noState();
//     }
// }

// Output "no suggestion" if no hint was found or output correct values

?>


<?php

$connection = dbConnect();
if($connection === FALSE)
{
  array_push($feedback,'<p style ="color:red;">Database connection failed!</p>');
}
else
{
  //Calls SQL procedure that generates a list of countries
  $procedure1 = 'Call Get_States("'.$q.'")';
  $procedureResult1 = $connection->query($procedure1);
  if(!$procedureResult1) { //if results don't return an error is displayed
    array_push($feedback, '<p style = "color: red;">Couldn\'t get list of States!</p>');
  }
  else { 
  //if call is successful
    $htmlStates = array(); //creats an array to display the list as HTML
    $states = $procedureResult1->fetchAll(PDO::FETCH_OBJ);
	sortObjectsByName($states);
	//If "From Search" is selected, add an "any state' option.
	if($fromSearch)
		if($state == "")
			array_push($htmlStates, '<option id="" value="" selected>Any State In This Country</option>');
		else
			array_push($htmlStates, '<option id="" value="">Any State In This Country</option>');
	foreach( $states as $stateInDB)
	{
		//pushes each row into the array
		if($state == $stateInDB->ID)
		  array_push($htmlStates, '<option selected id="'. $stateInDB->ID . '" value="' . $stateInDB->ID . '">' . $stateInDB->Name . '</option>');
		else
		  array_push($htmlStates, '<option id="'. $stateInDB->ID . '" value="' . $stateInDB->ID . '">' . $stateInDB->Name . '</option>');
	}
	

    $procedureResult1->closeCursor();
  }
}
$stateList = '<select id="stateSelect" name="vState" >';
$stateList .= '<option id ="None" value="" disabled hidden>Select State</option>';
foreach ($htmlStates as &$value) {
    $stateList .= $value;
}
$stateList .=  '</select>';

// $state = $_REQUEST["state"];
//   $finder = 'id="' . $state . '"';
//   $count = 1;
//   $temp = 'id="' . $state . '"' . " selected";
// print $stateList
//
//   $stateList = str_replace($finder,$temp,$stateList, $count);

print $stateList;
//
// function stateOptionList()
// {
//   $state = $_REQUEST["state"];
// $stateList = '
//   <select id="stateSelect" name="vState" >
//   <option id ="None" value="" disabled hidden>Select State</option>
//   <option id="AL" value="AL">Alabama</option>
//   <option id="AK" value="AK">Alaska</option>
//   <option id="AZ" value="AZ">Arizona</option>
//   <option id="AR" value="AR">Arkansas</option>
//   <option id="CA" value="CA">California</option>
//   <option id="CO" value="CO">Colorado</option>
//   <option id="CT" value="CT">Connecticut</option>
//   <option id="DE" value="DE">Delaware</option>
//   <option id="DC" value="DC">District Of Columbia</option>
//   <option id="FL" value="FL">Florida</option>
//   <option id="GA" value="GA">Georgia</option>
//   <option id="HI" value="HI">Hawaii</option>
//   <option id="ID" value="ID">Idaho</option>
//   <option id="IL" value="IL">Illinois</option>
//   <option id="IN" value="IN">Indiana</option>
//   <option id="IA" value="IA">Iowa</option>
//   <option id="KS" value="KS">Kansas</option>
//   <option id="KY" value="KY">Kentucky</option>
//   <option id="LA" value="LA">Louisiana</option>
//   <option id="ME" value="ME">Maine</option>
//   <option id="MD" value="MD">Maryland</option>
//   <option id="MA" value="MA">Massachusetts</option>
//   <option id="MI" value="MI">Michigan</option>
//   <option id="MN" id="" value="MN">Minnesota</option>
//   <option id="MS" value="MS">Mississippi</option>
//   <option id="MO" value="MO">Missouri</option>
//   <option id="MT" value="MT">Montana</option>
//   <option id="NE" value="NE">Nebraska</option>
//   <option id="NV" value="NV">Nevada</option>
//   <option id="NH" value="NH">New Hampshire</option>
//   <option id="NJ" value="NJ">New Jersey</option>
//   <option id="NM" value="NM">New Mexico</option>
//   <option id="NY" value="NY">New York</option>
//   <option id="NC" value="NC">North Carolina</option>
//   <option id="ND" value="ND">North Dakota</option>
//   <option id="OH" value="OH">Ohio</option>
//   <option id="OK" value="OK">Oklahoma</option>
//   <option id="OR" value="OR">Oregon</option>
//   <option id="PA" value="PA">Pennsylvania</option>
//   <option id="RI" value="RI">Rhode Island</option>
//   <option id="SC" value="SC">South Carolina</option>
//   <option id="SD" value="SD">South Dakota</option>
//   <option id="TN" value="TN">Tennessee</option>
//   <option id="TX" value="TX">Texas</option>
//   <option id="UT" value="UT">Utah</option>
//   <option id="VT" value="VT">Vermont</option>
//   <option id="VA" value="VA">Virginia</option>
//   <option id="WA" value="WA">Washington</option>
//   <option id="WV" value="WV">West Virginia</option>
//   <option id="WI" id="" value="WI">Wisconsin</option>
//   <option id="WY" value="WY">Wyoming</option>
//   </select>';
//
//   $finder = 'id="' . $state . '"';
//   $count = 1;
//   $temp = 'id="' . $state . '"' . "selected";
//   $stateList = str_replace($finder,$temp,$stateList, $count);
//
//
//   return $stateList;
// }
//
//
// function ProvOptionList()
// {
//
// $provList = '
//   <select>
//   <option value="" disabled hidden>Select Providence</option>
//   <option value="Thaninthayi">Thaninthayi</option>
//   <option value="Mon">Mon</option>
//   <option value="Yangon">Yangon</option>
//   <option value="Ayeyarwaddy">Ayeyarwaddy</option>
//   <option value="Kayin">Kayin</option>
//   <option value="Bago">Bago</option>
//   <option value="Rakhine">Rakhine</option>
//   <option value="Magwe">Magwe</option>
//   <option value="Mandalay">Mandalay</option>
//   <option value="Kayah">Kayah</option>
//   <option value="Shan">Shan</option>
//   <option value="Sagaing">Sagaing</option>
//   <option value="Chin">Chin</option>
//   <option value="Kachin">Kachin</option>
//   </select>';
//
//   return $provList;
//   }
//
//   function noState()
//   {
//     $noState='<input placeholder="State/Province" type="text" value="">';
//     return $noState;
//   }

 ?>
