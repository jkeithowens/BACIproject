<?php
session_start(); //this must be the very first line on the php page, to register this page to use session variables
session_destroy();
echo("<script>location.href = 'Location:login.php';</script>");

?>
