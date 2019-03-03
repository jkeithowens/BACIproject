<?php
require_once ("mail/mail.class.php");

function createMentorshipRequest($connection, $mentorID, $menteeID, $requester, $requesterEmail, $recipientEmail, &$feedback)
{
	$procedure = 'call sp_count_requests("'. $mentorID . '","' . $menteeID . '");';
	$procedureCall = $connection->query($procedure);
	if(!$procedureCall)
		array_push($feedback, '<p style = "color: red;">Error retrieving requests list.</p>');
	else
	{
		//If the query executed successfully, get the count.
		$result = $procedureCall->fetch(PDO::FETCH_OBJ);
		$count = $result->c;
		$procedureCall->closeCursor();
		if($count > 0)
			array_push($feedback, '<p style = "color: red;">A mentorship or mentorship request to this user already exists.</p>');
		else
		{
			//Check to see if this is a mentee who is already paired.
			$statementText = "SELECT COUNT(*) as c FROM PAIRED_MENTEES WHERE MenteeID = ?";
			$statement = $connection->prepare($statementText);
			$result = $statement->execute(array($menteeID));
			if(!$result)
				array_push($feedback, '<p style = "color: red;">Error while checking if this user is already paired.</p>');
			else
			{
				//Get the count from the prepared statement and close the cursor.
				$output = $statement->fetch(PDO::FETCH_OBJ);
				$statement->closeCursor();
				$count = $output->c;
				if($count > 0)
				{
					array_push($feedback, '<p style = "color: red;">This mentee is already paired with a mentor.</p>');
				}
				else
				{
					//If we're here, create a request.  Requests are entries in the MENTOR_HISTORY table with null times.
					$procedure = 'call sp_create_new_mentorship("' . $mentorID . '","' . $menteeID . '","' . $requester .'");';
					$procedureCall = $connection->query($procedure);
					if($procedureCall === FALSE)
						array_push($feedback, '<p style = "color: red;">Failed to create mentorship. </p>');
					else
					{
						$toname = 'BACI USER';
						$fromname = 'BACI Pairing System';
						$subject = 'BACI Mentorship Request';
						$messagebody = 'You have received a mentor/mentee pairing request from ' . $requesterEmail . ' ';
						$messagebody .= 'Please log in to jkeithowens.owensenterprises.net/CourseProject/login.php and reply to this request.'
						$headers =
							'Return-Path: ' . $requesterEmail . "\r\n" .
							'From: ' . $fromname . ' <' . $requesterEmail . '>' . "\r\n" .
							'X-Priority: 3' . "\r\n" .
							'X-Mailer: PHP ' . phpversion() .  "\r\n" .
							'Reply-To: ' . $fromname . ' <' . $requesterEmail . '>' . "\r\n" .
							'MIME-Version: 1.0' . "\r\n" .
							'Content-Transfer-Encoding: 8bit' . "\r\n" .
							'Content-Type: text/plain; charset=UTF-8' . "\r\n";
						$params = '-f ' . $requesterEmail;
						$testSent = mail($recipientEmail, $subject, $messagebody, $headers, $params);
						if ($testSent==true)
						//calls mail function to send out the activation email, shows message if successful
						// $mailer = new Mail();
						// $subject = 'Pairing Request';
						// $body = '<h1>You have received a mentor/mentee pairing request from ' . $requesterEmail . '</h1>';
						// $body .= '<p>Please <a href="jkeithowens.owensenterprises.net/CourseProject/login.php">log in</a> to reply to this request.</a>';
						// if (($mailer->sendMail($recipientEmail,'BACI USER', $subject, $body))==true)
						{
							//If we were on the startMentorship page, go back to the mentorList.
							if(strpos($_SERVER["PHP_SELF"],"startMentorship.php") !== FALSE)
							echo("<script>location.href = 'mentorList.php';</script>");
							//If we didn't get redirected, issue a success message.
							array_push($feedback, '<p style">Request successfully sent!</p>');
						}
						else
						{
							echo('failed');
						}
					}
				}
			}
		}
	}
}
?>
