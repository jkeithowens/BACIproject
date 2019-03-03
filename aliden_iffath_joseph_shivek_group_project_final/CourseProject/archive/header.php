<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.6/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

  <?php
  $pageTitle = "";
  $URL = $_SERVER["PHP_SELF"];
  switch( $URL )
  {
  	case("/GroupProject/admin.php"):
  		$pageTitle = "Administrative page";
  		break;
  	case("/GroupProject/configure.php"):
  		$pageTitle = "Edit Account Details";
  		break;
  	case("/GroupProject/login.php"):
  		$pageTitle = "A network for students and professionals across the United States.";
  		break;
  	case("/GroupProject/forgot_password.php"):
  		$pageTitle = "Forgot Password";
  		break;
  	case("/GroupProject/add_countries.php"):
  		$pageTitle = "Administrative functions:  Add Country to list.";
  		break;
  	case("/GroupProject/add_degree_levels.php"):
  		$pageTitle = "Administrative functions:  Add Education Levels to list.";
  		break;
  	case("/GroupProject/EditUser.php"):
  		$pageTitle = "Administrative functions:  Edit user.";
  		break;
  	case("/GroupProject/Register.php"):
  		$pageTitle = "Registration Page";
  		break;
  	case("/GroupProject/search.php"):
  		$pageTitle = "Search";
  		break;
  	default:
  		$pageTitle = $URL;
  }
  ?>



<div id = "navBar">
  <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
    <img class="img-fluid" style = "max-height: 70px" src="BaciLogo.png" alt="logo"/>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarsExampleDefault">
      <ul class="navbar-nav mr-auto">
        <li class="nav-item active">
          <a class="nav-link" href="login.php">Home <span class="sr-only">(current)</span></a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="Register.php">Register</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="configure.php">Configure</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="login.php">Login<span class="sr-only">(current)</span></a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="https://thebaci.org/" target="_blank">The Baci</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Admin</a>
          <div class="dropdown-menu" aria-labelledby="dropdown01">
            <a class="dropdown-item" href="about">Add an Admin</a>
            <a class="dropdown-item" href="cost">Edit/Delete an Admin</a>
            <a class="dropdown-item" href="#" target="_blank">Run Report</a>
            <a class="dropdown-item" href="search.php">Search Users</a>
            <a class="dropdown-item" href="EditUser.php">Edit/Delete a User</a>
            <a class="dropdown-item" href="add_countries.php">Add a Country</a>
            <a class="dropdown-item" href="add_degree_levels.php">Add a Degree Option</a>
            <a class="dropdown-item" href="#">Download Data to Spreadsheet</a>
          </div>
        </li>
      </ul>
    </div>
  </nav>
</div>

<div id = "header">
  <h3>Myanmar Students and Professionals Network USA
</h1>
  <h6><?php echo $pageTitle;?></h3>
</div>
