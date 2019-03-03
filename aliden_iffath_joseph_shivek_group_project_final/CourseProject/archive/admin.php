
<div  id="mySidenav" class="sidenav">
					<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
  						<a href="editUser.php">Add a User</a><br/><br/><br/><br/><br/><br/>
  						<a href="MyAccountAdmin.php">Edit/Delete a User</a><br/><br/><br/><br/><br/><br/>
 						<a href="#">Run Report</a><br/><br/><br/><br/><br/><br/>
				  		<a href="#">Search Users</a><br/><br/><br/><br/><br/><br/>
						<a href="#">Download Data to Spreadsheet</a>
</div>
					<span style= "font-size:30px;cursor:pointer" onclick="openNav()">&#9776;<b>MENU</b></span>





<script>
/* Set the width of the side navigation to 250px and the left margin of the page content to 250px */
function openNav() {
    document.getElementById("mySidenav").style.width = "250px";
    document.getElementById("main").style.marginLeft = "250px";
}

/* Set the width of the side navigation to 0 and the left margin of the page content to 0 */
function closeNav() {
    document.getElementById("mySidenav").style.width = "0";
    document.getElementById("main").style.marginLeft = "0";
}
</script>
