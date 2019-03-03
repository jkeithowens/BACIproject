-- phpMyAdmin SQL Dump
-- version 4.0.10.20
-- https://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 06, 2018 at 11:47 AM
-- Server version: 5.1.73
-- PHP Version: 5.3.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `owensent_Project`
--

DELIMITER $$
--
-- Procedures
--
CREATE PROCEDURE `Get_Countries`()
select * from COUNTRY
where Active = 1$$

CREATE PROCEDURE `Get_States`(IN `country` INT(100))
select * from STATES_PROVINCES
where Active = 1 and CountryID = country$$

CREATE PROCEDURE `SP_ACTIVATE_COUNTRY`(IN `descr` VARCHAR(100))
    NO SQL
UPDATE COUNTRY
SET Active = 1
WHERE Name = descr$$

CREATE PROCEDURE `SP_ACTIVATE_DEGREE`(IN `descr` VARCHAR(100))
UPDATE EDUCATION_TYPE
SET Active = 1
WHERE DegreeLevel = descr$$

CREATE PROCEDURE `SP_ACTIVATE_STATE`(IN `descr` VARCHAR(100), IN `id` INT(10))
    NO SQL
UPDATE STATES_PROVINCES
SET Active = 1
WHERE Name = descr and CountryID = id$$

CREATE PROCEDURE `SP_Activate_User`(IN `e` VARCHAR(200))
UPDATE USER
SET Activated = 1
WHERE Email = e$$

CREATE PROCEDURE `SP_Add_Country`(IN country VARCHAR(50))
insert into COUNTRY values(null,country,'1')$$

CREATE PROCEDURE `SP_Add_Degree`(IN `degree` VARCHAR(50))
insert into EDUCATION_TYPE values(null,degree, 1)$$

CREATE PROCEDURE `SP_Add_State`(IN `state` VARCHAR(50), IN `id` INT(10))
insert into STATES_PROVINCES values(null,state,id,'1')$$

CREATE PROCEDURE `SP_Add_User`(IN `username` VARCHAR(100), IN `password` VARCHAR(100), IN `email` VARCHAR(100), IN `firstname` VARCHAR(100), IN `lastname` VARCHAR(100), IN `address` VARCHAR(100), IN `city` VARCHAR(100), IN `stateid` BIGINT(20), IN `countryid` TINYINT(4), IN `seekingmentorship` BOOLEAN, IN `seekingmentership` BOOLEAN, IN `resumelink` VARCHAR(100), IN `activated` BOOLEAN, IN `gender` VARCHAR(30), IN `birthdate` DATE, IN `twitter` VARCHAR(500), IN `facebook` VARCHAR(500), IN `linkedin` VARCHAR(500), IN `activationcode` VARCHAR(60), IN `zip` VARCHAR(10), IN `phone` VARCHAR(17), IN `workstatus` VARCHAR(100), IN `employer` VARCHAR(250), IN `field` VARCHAR(200), IN `state` VARCHAR(100), IN `middlename` VARCHAR(100))
INSERT INTO `aliden_db`.`USER` (`Username`,
`Password` ,
`Email` ,
`FirstName` ,
`LastName` ,
`Address` ,
`City` ,
`StateProvinceID` ,
`CountryID` ,
`SeekingMentorship` ,
`SeekingMenteeship` ,
`ResumeURL`, 
`Activated`,
`Gender`,
`DOB`,
`TwitterURL`,
`FacebookURL`,
`LinkedInURL`,
`ActivationCode`,
`ZipCode`,
`Phone`,
`WorkStatus`,
`Employer`,
`Field`,
    `StateProvince`,
    `MiddleName`
) 
VALUES (username, password, email, firstname, lastname, address, city, stateid,
countryid, seekingmentorship, seekingmenteeship, resumelink, activated,
gender, birthdate, twitter, facebook, linkedin, activationcode, zip, phone,
workstatus, employer, field,state,middlename)$$

CREATE PROCEDURE `SP_Add_User_Education`(IN `userid` BIGINT(20), IN `type` TINYINT(4), IN `schoolname` VARCHAR(100), IN `major` VARCHAR(100), IN `year` INT)
INSERT INTO  `aliden_db`.`USER_EDUCATION` (
`UserID` ,
`Type` ,
`SchoolName` ,
`Major`,
`GradYear`
)
VALUES (
userid, type, schoolname, major, year
)$$

CREATE PROCEDURE `SP_Add_User_Links`(IN `userid` BIGINT(20), IN `linktypeid` BIGINT(20), IN `url` VARCHAR(250))
INSERT INTO `aliden_db`.`SOCIAL_MEDIA_LINK` ( `UserID`, `LinkTypeID`, `URL`) VALUES ( userid, linktypeid,url)$$

CREATE PROCEDURE `SP_Add_User_Phone`(IN `userid` BIGINT(20), IN `numbertypeid` TINYINT(4), IN `countrycode` TINYINT(2), IN `areacode` INT(3), IN `lastseven` INT(7))
INSERT INTO  `aliden_db`.`PHONE` (
`UserID` ,
`NumberTypeID` ,
`CountryCode` ,
`AreaCode` ,
`LastSeven`
)
VALUES (  userid,  numbertypeid,  countrycode,  areacode,  lastseven
)$$

CREATE PROCEDURE `sp_add_user_v2`(IN `eml` VARCHAR(200), IN `psswrd` VARCHAR(100), IN `frstnm` VARCHAR(100), IN `mddlnm` VARCHAR(100), IN `lstnm` VARCHAR(100), IN `yob` YEAR, IN `phn` VARCHAR(17), IN `addrss` VARCHAR(100), IN `cty` VARCHAR(100), IN `cntryid` TINYINT, IN `sttprvncid` BIGINT, IN `zp` VARCHAR(10), IN `gndr` VARCHAR(30), IN `fcbk` VARCHAR(500), IN `lnkdn` VARCHAR(500), IN `twttr` VARCHAR(500), IN `skmntr` BOOLEAN, IN `skmntee` BOOLEAN, IN `wrkstts` VARCHAR(100), IN `emplyr` VARCHAR(250), IN `fld` VARCHAR(200), IN `pic` VARCHAR(200), IN `rsm` VARCHAR(200), IN `actvtd` BOOLEAN, IN `actcd` VARCHAR(60))
    NO SQL
INSERT INTO USER
(
    `Email`,
    `Password`,
    `FirstName`,
    `MiddleName`,
    `LastName`,
    `BirthYear`,
    `Phone`,
    `Address`,
    `City`,
    `CountryID`,
    `StateProvinceID`,
    `ZipCode`,
    `Gender`,
    `FacebookURL`,
    `LinkedInURL`,
    `TwitterURL`,
    `SeekingMentorship`,
    `SeekingMenteeship`,
    `WorkStatus`,
    `Employer`,
    `Field`,
    `ImageURL`,
    `ResumeURL`,
    `Activated`,
    `ActivationCode`,
    `RegisterDate`
)
VALUES
(
    eml,
    psswrd,
    frstnm,
    mddlnm,
    lstnm,
    yob,
    phn,
    addrss,
    cty,
    cntryid,
    sttprvncid,
    zp,
    gndr,
    fcbk,
    lnkdn,
    twttr,
    skmntr,
    skmntee,
    wrkstts,
    emplyr,
    fld,
    pic,
    rsm,
    actvtd,
    actcd,
    CURRENT_TIMESTAMP
)$$

CREATE PROCEDURE `sp_admin_create_new_mentorship`(IN `mentor` BIGINT, IN `mentee` BIGINT, IN `requester` BIGINT, IN `start` DATE)
INSERT INTO MENTOR_HISTORY (MentorID, MenteeID, RequestedBy, StartDate, RequestDate)
VALUES (mentor, mentee, requester, start, CURRENT_TIMESTAMP)$$

CREATE PROCEDURE `sp_admin_get_permissions`(IN `uname` VARCHAR(100))
select TypeID from ADMIN where Username = uname$$

CREATE PROCEDURE `sp_change_admin_password`(uname varchar(100), pwd varchar(100))
UPDATE ADMIN
SET Password = pwd
WHERE Username = uname$$

CREATE PROCEDURE `sp_change_admin_permissions`(uname varchar(100), permissions tinyInt)
UPDATE ADMIN
SET TypeID = permissions
WHERE username = uname$$

CREATE PROCEDURE `sp_confirm_mentorship`(IN `start` DATE, IN `i` BIGINT)
    NO SQL
UPDATE MENTOR_HISTORY
SET StartDate = start
WHERE MENTOR_HISTORY.ID = i$$

CREATE PROCEDURE `sp_count`(IN `inputDescription` VARCHAR(100))
select count(*) as c from ADMIN_TYPE where Description = inputDescription$$

CREATE PROCEDURE `SP_COUNTRY_ACTIVE_CHECK`(IN `descr` VARCHAR(100))
    NO SQL
SELECT Active 
FROM COUNTRY
WHERE Name = descr$$

CREATE PROCEDURE `sp_count_admins`(IN `uname` VARCHAR(100), IN `pwd` VARCHAR(100))
select count(*) as c from ADMIN where Username = uname and Password = pwd$$

CREATE PROCEDURE `sp_count_admins_by_username`(IN `uname` VARCHAR(100))
select COUNT(*) as c from ADMIN where Username = uname$$

CREATE PROCEDURE `SP_COUNT_ALL_COUNTRY`(IN `descr` VARCHAR(100))
    NO SQL
SELECT COUNT(*) AS c FROM COUNTRY WHERE Name = descr$$

CREATE PROCEDURE `SP_COUNT_ALL_STATE`(IN `descr` VARCHAR(100), IN `country` INT(100))
    NO SQL
SELECT COUNT(*) AS c FROM STATES_PROVINCES WHERE Name = descr and CountryID = country$$

CREATE PROCEDURE `SP_COUNT_COUNTRY`(IN `country` VARCHAR(100))
Select count(*) as c from COUNTRY where NAME = country and Active = 1$$

CREATE PROCEDURE `SP_COUNT_DEGREE`(IN degree VARCHAR(50))
Select count(*) as c from EDUCATION_TYPE where DegreeLevel = degree$$

CREATE PROCEDURE `sp_count_requests`(IN `mentor` BIGINT, IN `mentee` BIGINT)
    NO SQL
SELECT COUNT(*) as c
FROM MENTOR_HISTORY
WHERE MentorID = mentor AND MenteeID = mentee AND EndDate IS NULL AND RejectDate IS NULL$$

CREATE PROCEDURE `SP_COUNT_STATE`(IN `state` VARCHAR(100), IN `id` INT(10))
Select count(*) as c from STATES_PROVINCES where NAME = state and Active = 1 and CountryID = id$$

CREATE PROCEDURE `sp_count_user1`(IN `eml` VARCHAR(200), IN `pwd` VARCHAR(100))
select count(*) as c from USER where Email = eml and Password = pwd and Activated = 1$$

CREATE PROCEDURE `SP_Count_Users`(IN `eml` VARCHAR(100))
select count(*) as c from USER where Email = eml$$

CREATE PROCEDURE `sp_count_users_by_email`(IN `em` VARCHAR(200))
    NO SQL
select count(*) as c from USER where Email = em$$

CREATE PROCEDURE `sp_count_users_by_email_activationCode`(IN `e` VARCHAR(200), IN `a` VARCHAR(60))
    NO SQL
SELECT COUNT(*) as c
FROM USERS
WHERE Email = e and ActivationCode = a$$

CREATE PROCEDURE `sp_count_users_by_email_resetPIN`(IN `e` VARCHAR(200), IN `pin` VARCHAR(6))
    NO SQL
SELECT COUNT(*) AS c
FROM USER
WHERE Email = e AND ResetPIN = pin$$

CREATE PROCEDURE `sp_create_new_admin`(IN `uname` VARCHAR(100), IN `pwd` VARCHAR(100), IN `type` TINYINT)
INSERT INTO ADMIN (Username, Password, TypeID) values(uname, pwd, type)$$

CREATE PROCEDURE `sp_create_new_mentorship`(IN `mentor` BIGINT, IN `mentee` BIGINT, IN `requester` BIGINT)
    NO SQL
INSERT INTO MENTOR_HISTORY (MentorID, MenteeID, RequestedBy, RequestDate)
VALUES (mentor, mentee, requester, CURRENT_TIMESTAMP)$$

CREATE PROCEDURE `SP_DEACTIVATE_COUNTRY`(IN country VARCHAR(50))
UPDATE COUNTRY
SET Active = 0 where Name = country$$

CREATE PROCEDURE `SP_DEACTIVATE_DEGREE`(IN `degree` VARCHAR(50))
UPDATE EDUCATION_TYPE
SET Active = 0 where DegreeLevel = degree$$

CREATE PROCEDURE `SP_DEACTIVATE_STATE`(IN `state` VARCHAR(50), IN `id` INT(10))
UPDATE STATES_PROVINCES
SET Active = 0 where Name = state and CountryID = id$$

CREATE PROCEDURE `SP_DEGREE_ACTIVE_CHECK`(IN `descr` VARCHAR(100))
SELECT Active 
FROM EDUCATION_TYPE
WHERE DegreeLevel = descr$$

CREATE PROCEDURE `sp_delete_admin`(uname varchar(100))
DELETE FROM ADMIN
WHERE Username = uname$$

CREATE PROCEDURE `sp_delete_user`(IN `em` VARCHAR(200))
    NO SQL
UPDATE USER
SET Activated = 0, ActivationCode = NULL
WHERE Email = em$$

CREATE PROCEDURE `sp_edit_user`(IN `eml` VARCHAR(200), IN `frstnm` VARCHAR(100), IN `mddlnm` VARCHAR(100), IN `lstnm` VARCHAR(100), IN `phn` VARCHAR(17), IN `addrss` VARCHAR(100), IN `cty` VARCHAR(100), IN `stt` BIGINT, IN `cntry` TINYINT, IN `zpcd` VARCHAR(10), IN `gndr` VARCHAR(30), IN `fburl` VARCHAR(500), IN `lnkdnurl` VARCHAR(500), IN `twttrurl` VARCHAR(500), IN `skngmntr` BOOLEAN, IN `skngmntee` BOOLEAN, IN `wrkstts` VARCHAR(100), IN `emplr` VARCHAR(250), IN `fld` VARCHAR(200), IN `iurl` VARCHAR(200), IN `rurl` VARCHAR(200))
    NO SQL
UPDATE USER
SET
FirstName = frstnm,
MiddleName = mddlnm,
LastName = lstnm,
Phone = phn,
Address = addrss,
City = cty,
StateProvinceID = stt,
CountryID = cntry,
ZipCode = zpcd,
Gender = gndr,

FacebookURL = fburl,
LinkedInURL = lnkdnurl,
TwitterURL = twttrurl,

SeekingMentorship = skngmntr,
SeekingMenteeship = skngmntee,

WorkStatus = wrkstts,
Employer = emplr,
Field = fld,

ImageURL = iurl,
ResumeURL = rurl

WHERE
Email = eml$$

CREATE PROCEDURE `SP_FIND_USER_ID`(IN `e` VARCHAR(200), IN `pwd` VARCHAR(100))
Select ID from USER where Email = e and password = pwd$$

CREATE PROCEDURE `sp_get_admin_list`()
select ADMIN.Username, ADMIN_TYPE.Description FROM ADMIN
INNER JOIN ADMIN_TYPE ON ADMIN.TypeID = ADMIN_TYPE.ID$$

CREATE PROCEDURE `sp_get_admin_types`()
select * from ADMIN_TYPE$$

CREATE PROCEDURE `sp_get_all_education_by_email`(IN `e` VARCHAR(200))
    NO SQL
SELECT USER_EDUCATION.ID AS RecordID, USER.Email, EDUCATION_TYPE.DegreeLevel, USER_EDUCATION.SchoolName, USER_EDUCATION.Major, USER_EDUCATION.GradYear
FROM USER_EDUCATION

INNER JOIN USER
ON USER.ID = USER_EDUCATION.UserID

INNER JOIN EDUCATION_TYPE
ON USER_EDUCATION.Type = EDUCATION_TYPE.ID

WHERE USER.Email = e$$

CREATE PROCEDURE `sp_get_all_potential_mentees`()
    NO SQL
SELECT USER.*, ( year(CURRENT_TIMESTAMP) - USER.BirthYear ) AS ApproxAge,

STATES_PROVINCES.Name AS StateProvinceFromID, COUNTRY.Name AS Country, 

PAIRED_MENTEES.Pairs

FROM USER

LEFT JOIN STATES_PROVINCES
ON STATES_PROVINCES.ID = USER.StateProvinceID

INNER JOIN COUNTRY
ON COUNTRY.ID = USER.CountryID

LEFT JOIN PAIRED_MENTEES
ON PAIRED_MENTEES.MenteeID = USER.ID


WHERE USER.SeekingMentorship = 1 AND PAIRS IS NULL OR PAIRS = 0 AND Activated = 1$$

CREATE PROCEDURE `sp_get_all_potential_mentors`()
    NO SQL
SELECT USER.*, ( year(CURRENT_TIMESTAMP) - USER.BirthYear ) AS ApproxAge,

STATES_PROVINCES.Name AS StateProvinceFromID, COUNTRY.Name AS Country


FROM USER

LEFT JOIN STATES_PROVINCES
ON STATES_PROVINCES.ID = USER.StateProvinceID

INNER JOIN COUNTRY
ON COUNTRY.ID = USER.CountryID

WHERE USER.SeekingMenteeship = 1 AND Activated = 1$$

CREATE PROCEDURE `SP_Get_Country_ID`(IN `countryname` VARCHAR(100))
select * from COUNTRY where NAME = countryname$$

CREATE PROCEDURE `SP_Get_Degrees`()
select * from EDUCATION_TYPE
where Active = 1$$

CREATE PROCEDURE `SP_Get_Degree_ID`(IN `deg` VARCHAR(100))
select id as degreeid from EDUCATION_TYPE where DegreeLevel = deg$$

CREATE PROCEDURE `SP_Get_Email_By_ID`(IN `userid` BIGINT(20))
SELECT * FROM USER WHERE ID = userid$$

CREATE PROCEDURE `sp_get_mentees`(IN `eml` VARCHAR(200))
    NO SQL
SELECT MENTEE.Email, MENTEE.FirstName, MENTEE.LastName, MENTEE.Phone, MENTEE.Address, MENTEE.City, MENTEE.StateProvince, COUNTRY.Name as Country, MENTOR_HISTORY.StartDate


FROM MENTOR_HISTORY

INNER JOIN
USER MENTOR
ON MENTOR_HISTORY.MentorID = MENTOR.ID

INNER JOIN
USER MENTEE
ON MENTOR_HISTORY.MenteeID = MENTEE.ID

INNER JOIN
COUNTRY
ON MENTEE.CountryID = COUNTRY.ID

WHERE MENTOR.Email = eml 
AND MENTOR_HISTORY.StartDate IS NOT NULL
AND MENTOR_HISTORY.RejectDate IS NULL
AND MENTOR_HISTORY.EndDate IS NULL$$

CREATE PROCEDURE `SP_Get_State_ID`(IN `statename` VARCHAR(100))
    READS SQL DATA
select id from state_provinces where name = statename$$

CREATE PROCEDURE `sp_get_userTable_data_by_email`(IN `e` VARCHAR(200))
    NO SQL
SELECT USER.*,

COUNTRY.Name AS Country,
STATES_PROVINCES.Name AS StateProvinceFromID,
( year(CURRENT_TIMESTAMP) - USER.BirthYear ) AS ApproxAge


FROM USER

LEFT JOIN COUNTRY
ON COUNTRY.ID = USER.CountryID

LEFT JOIN STATES_PROVINCES
ON STATES_PROVINCES.ID = USER.StateProvinceID

WHERE Email = e$$

CREATE PROCEDURE `SP_Get_User_ID`(IN `e` VARCHAR(200))
select ID as userid from USER where Email = e$$

CREATE PROCEDURE `sp_lab_activate_user`(IN `e` VARCHAR(200))
    NO SQL
UPDATE LAB_USER
SET Activated = 1
WHERE Email = e$$

CREATE PROCEDURE `sp_lab_add_status`(IN `newUserID` BIGINT, IN `newStatusID` BIGINT)
    NO SQL
insert into LAB_STATUS(UserID, StatusID, Active) values (newUserID, newStatusID, 1)$$

CREATE PROCEDURE `sp_lab_change_password`(IN `e` VARCHAR(200), IN `pwd` VARCHAR(100))
    NO SQL
UPDATE LAB_USER
SET Password = pwd
WHERE Email = e$$

CREATE PROCEDURE `sp_lab_count_users_by_email`(IN `e` VARCHAR(200))
    NO SQL
select count(*) as c from LAB_USER where Email = e$$

CREATE PROCEDURE `sp_lab_count_users_by_email_password`(IN `e` VARCHAR(200), IN `pwd` VARCHAR(100))
    NO SQL
SELECT COUNT(*) as c
FROM LAB_USER
WHERE Email = e and Password = pwd$$

CREATE PROCEDURE `sp_lab_create_user`(IN `fname` VARCHAR(100), IN `lname` VARCHAR(100), IN `e` VARCHAR(200), IN `pass` VARCHAR(100), IN `gen` TINYINT, IN `dept` BIGINT, IN `code` VARCHAR(55))
    NO SQL
insert into LAB_USER (FirstName, LastName, Email, Password, GenderID, DepartmentID, ActivationCode, Activated) values (fname, lname, e, pass, gen, dept, code, 0)$$

CREATE PROCEDURE `sp_lab_get_activation_code`(IN `e` VARCHAR(200))
    NO SQL
SELECT ActivationCode FROM LAB_USER WHERE Email = e$$

CREATE PROCEDURE `sp_lab_get_activation_status`(IN `e` VARCHAR(200))
    NO SQL
SELECT Activated
FROM LAB_USER
WHERE Email = e$$

CREATE PROCEDURE `sp_lab_get_departments_list`()
    NO SQL
SELECT Description
FROM LAB_DEPARTMENT$$

CREATE PROCEDURE `sp_lab_get_department_id`(IN `descr` VARCHAR(100))
    NO SQL
SELECT ID FROM LAB_DEPARTMENT WHERE descr = Description$$

CREATE PROCEDURE `sp_lab_get_gender_from_id`(IN `i` TINYINT)
    NO SQL
SELECT Description
FROM LAB_GENDER
WHERE ID = i$$

CREATE PROCEDURE `sp_lab_get_gender_id`(IN `descr` VARCHAR(20))
    NO SQL
SELECT ID FROM LAB_GENDER WHERE Description = descr$$

CREATE PROCEDURE `sp_lab_get_last_names`(IN `n` VARCHAR(100))
    NO SQL
SELECT LAB_USER.ID, LAB_USER.FirstName, LAB_USER.LastName, LAB_USER.Email, LAB_GENDER.Description AS Gender, LAB_DEPARTMENT.Description AS Department
FROM LAB_USER

INNER JOIN LAB_GENDER
ON LAB_USER.GenderID = LAB_GENDER.ID

INNER JOIN LAB_DEPARTMENT
ON LAB_USER.DepartmentID = LAB_DEPARTMENT.ID

WHERE LastName LIKE CONCAT(n , '%')$$

CREATE PROCEDURE `sp_lab_get_status`(IN `uid` BIGINT)
    NO SQL
SELECT Description FROM LAB_STATUS 
INNER JOIN LAB_STATUS_TYPES 
ON LAB_STATUS.StatusID = LAB_STATUS_TYPES.ID
WHERE UserID = uid and Active = 1$$

CREATE PROCEDURE `sp_lab_get_status_id`(IN `descr` VARCHAR(100))
    NO SQL
SELECT ID FROM LAB_STATUS_TYPES WHERE Description = descr$$

CREATE PROCEDURE `sp_lab_get_userdata`(IN `e` VARCHAR(200), IN `pwd` VARCHAR(100))
SELECT LAB_USER.ID AS ID, LAB_USER.FirstName AS FirstName, LAB_USER.LastName AS LastName, LAB_USER.Email AS Email, LAB_USER.Password AS Password, LAB_GENDER.Description AS Gender, LAB_DEPARTMENT.Description AS Department, LAB_USER.ActivationCode AS ActivationCode, LAB_USER.Activated AS Activated
FROM LAB_USER 
INNER JOIN LAB_GENDER ON LAB_USER.GenderID = LAB_GENDER.ID
INNER JOIN LAB_DEPARTMENT ON LAB_USER.DepartmentID = LAB_DEPARTMENT.ID
WHERE LAB_USER.Email = e AND LAB_USER.Password = pwd$$

CREATE PROCEDURE `sp_lab_get_users`()
    NO SQL
SELECT LAB_USER.ID, LAB_USER.FirstName, LAB_USER.LastName, LAB_USER.Email, LAB_GENDER.Description AS Gender, LAB_DEPARTMENT.Description AS Department
FROM LAB_USER

INNER JOIN LAB_GENDER
ON LAB_USER.GenderID = LAB_GENDER.ID

INNER JOIN LAB_DEPARTMENT
ON LAB_USER.DepartmentID = LAB_DEPARTMENT.ID$$

CREATE PROCEDURE `sp_lab_get_users_by_last_name`(IN `n` VARCHAR(100))
    NO SQL
SELECT LAB_USER.ID, LAB_USER.FirstName, LAB_USER.LastName, LAB_USER.Email, LAB_GENDER.Description AS Gender, LAB_DEPARTMENT.Description AS Department
FROM LAB_USER

INNER JOIN LAB_GENDER
ON LAB_USER.GenderID = LAB_GENDER.ID

INNER JOIN LAB_DEPARTMENT
ON LAB_USER.DepartmentID = LAB_DEPARTMENT.ID

WHERE LastName LIKE CONCAT(n , '%')
AND Activated = 1$$

CREATE PROCEDURE `sp_lab_get_users_by_last_names_specific`(IN `n` VARCHAR(100))
    NO SQL
SELECT LAB_USER.ID, LAB_USER.FirstName, LAB_USER.LastName, LAB_USER.Email, LAB_GENDER.Description AS Gender, LAB_DEPARTMENT.Description AS Department
FROM LAB_USER

INNER JOIN LAB_GENDER
ON LAB_USER.GenderID = LAB_GENDER.ID

INNER JOIN LAB_DEPARTMENT
ON LAB_USER.DepartmentID = LAB_DEPARTMENT.ID

WHERE LastName = n
AND Activated = 1$$

CREATE PROCEDURE `sp_lab_get_user_id_by_email`(IN `e` VARCHAR(200))
    NO SQL
SELECT ID FROM LAB_USER WHERE Email = e$$

CREATE PROCEDURE `sp_reject_mentorship`(IN `reject` DATE, IN `i` BIGINT)
    NO SQL
UPDATE MENTOR_HISTORY
SET RejectDate = reject, EndDate = reject
WHERE MENTOR_HISTORY.ID = i$$

CREATE PROCEDURE `sp_reject_mentorship_by_menteeID`(IN `date` DATE, IN `i` BIGINT)
    NO SQL
UPDATE MENTOR_HISTORY
SET RejectDate = date
WHERE MenteeID = i and StartDate IS NULL$$

CREATE PROCEDURE `SP_STATE_ACTIVE_CHECK`(IN `descr` VARCHAR(100), IN `id` INT(100))
    NO SQL
SELECT Active 
FROM STATES_PROVINCES
WHERE Name = descr and CountryID = id$$

CREATE PROCEDURE `sp_unpair_mentorship`(IN `end` DATE, IN `i` BIGINT)
UPDATE MENTOR_HISTORY
SET EndDate = end
WHERE MENTOR_HISTORY.ID = i$$

CREATE PROCEDURE `SP_UPDATE_COUNTRY`(IN `newCountry` VARCHAR(100), IN `oldCountry` VARCHAR(100))
UPDATE COUNTRY
SET NAME = newCountry where NAME = oldCountry$$

CREATE PROCEDURE `SP_UPDATE_DEGREE`(IN `newDegree` VARCHAR(50), IN `oldDegree` VARCHAR(50))
UPDATE EDUCATION_TYPE
SET DegreeLevel = newDegree where DegreeLevel = oldDegree$$

CREATE PROCEDURE `SP_Update_Password`(IN `e` VARCHAR(200), IN `newPwd` VARCHAR(100))
UPDATE USER
SET Password = newPwd WHERE Email = e$$

CREATE PROCEDURE `sp_update_resetPIN`(IN `e` VARCHAR(200), IN `pin` VARCHAR(6))
    NO SQL
UPDATE USER
SET ResetPIN = pin
WHERE Email = e$$

CREATE PROCEDURE `SP_UPDATE_STATE`(IN `newState` VARCHAR(100), IN `oldState` VARCHAR(100), IN `id` INT(10))
UPDATE STATES_PROVINCES
SET NAME = newState where NAME = oldState and CountryID = id$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ADMIN`
--

CREATE TABLE IF NOT EXISTS `ADMIN` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Username` varchar(100) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `TypeID` tinyint(4) NOT NULL COMMENT 'Foreign key to ADMIN_TYPE.ID',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Username` (`Username`),
  KEY `TypeID` (`TypeID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=22 ;

--
-- Dumping data for table `ADMIN`
--

INSERT INTO `ADMIN` (`ID`, `Username`, `Password`, `TypeID`) VALUES
(1, 'SuperAdmin', 'J5226c4403b2792762b885f27445b0053471262d', 1),
(7, 'Andrew', 'J40ab2bae07bedc4c163f679a746f7ab7fb5d1fa', 2),
(13, 'Admin', 'Jce0359f12857f2a90c7de465f40a95f01cb5da9', 2),
(14, 'Coordinator', 'Jce0359f12857f2a90c7de465f40a95f01cb5da9', 3),
(16, 'Sample', 'Jbc5de83cf1daf79ed5b2f13f93d7c05d01d0388', 3),
(17, 'Sample2', 'J367c48dd193d56ea7b0baad25b19455e529f5ee', 2),
(18, 'TestCoordinator1', 'J8dc405051a9d42608afe41cf18830e3eddf3db1', 2),
(20, 'ExampleAdmin', 'Jbc5de83cf1daf79ed5b2f13f93d7c05d01d0388', 2);

-- --------------------------------------------------------

--
-- Table structure for table `ADMIN_TYPE`
--

CREATE TABLE IF NOT EXISTS `ADMIN_TYPE` (
  `ID` tinyint(4) NOT NULL AUTO_INCREMENT,
  `Description` varchar(100) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `ADMIN_TYPE`
--

INSERT INTO `ADMIN_TYPE` (`ID`, `Description`) VALUES
(1, 'SuperAdmin'),
(2, 'Admin'),
(3, 'Coordinator');

-- --------------------------------------------------------

--
-- Stand-in structure for view `AVAILABLE_MENTEES`
--
CREATE TABLE IF NOT EXISTS `AVAILABLE_MENTEES` (
`ID` bigint(20)
,`Username` varchar(100)
,`Email` varchar(100)
,`FirstName` varchar(100)
,`MiddleName` varchar(100)
,`LastName` varchar(100)
,`Gender` varchar(30)
,`Address` varchar(100)
,`City` varchar(100)
,`StateProvince` varchar(100)
,`StateProvinceFromID` varchar(100)
,`Country` varchar(100)
,`SeekingMentorship` tinyint(1)
,`SeekingMenteeship` tinyint(1)
,`ResumeURL` varchar(200)
,`ImageURL` varchar(200)
,`FacebookURL` varchar(500)
,`LinkedInURL` varchar(500)
,`TwitterURL` varchar(500)
,`ResetPIN` varchar(6)
,`Pairs` bigint(21)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `AVAILABLE_MENTORS`
--
CREATE TABLE IF NOT EXISTS `AVAILABLE_MENTORS` (
`ID` bigint(20)
,`Username` varchar(100)
,`Email` varchar(100)
,`FirstName` varchar(100)
,`MiddleName` varchar(100)
,`LastName` varchar(100)
,`Gender` varchar(30)
,`Address` varchar(100)
,`City` varchar(100)
,`StateProvince` varchar(100)
,`StateProvinceFromID` varchar(100)
,`Country` varchar(100)
,`SeekingMentorship` tinyint(1)
,`SeekingMenteeship` tinyint(1)
,`ResumeURL` varchar(200)
,`ImageURL` varchar(200)
,`FacebookURL` varchar(500)
,`LinkedInURL` varchar(500)
,`TwitterURL` varchar(500)
,`ResetPIN` varchar(6)
);
-- --------------------------------------------------------

--
-- Table structure for table `COUNTRY`
--

CREATE TABLE IF NOT EXISTS `COUNTRY` (
  `ID` tinyint(4) NOT NULL AUTO_INCREMENT COMMENT 'Could this instead by user defined, allowing it to match phone number country codes?',
  `Name` varchar(100) NOT NULL,
  `Active` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=53 ;

--
-- Dumping data for table `COUNTRY`
--

INSERT INTO `COUNTRY` (`ID`, `Name`, `Active`) VALUES
(1, 'Myanmar', 1),
(2, 'United States of America', 1),
(8, 'Mexico', 1),
(10, 'Spain', 1),
(12, 'Australia', 1),
(14, 'Italy', 1),
(16, 'Russia', 1),
(18, 'UAE', 1),
(19, 'Japan', 1),
(33, 'South Africa', 1),
(41, 'Turkey', 1),
(50, 'China', 1),
(51, 'South Korea', 1),
(52, 'Soviet Union', 0);

-- --------------------------------------------------------

--
-- Stand-in structure for view `DOWNLOADABLE_USERS`
--
CREATE TABLE IF NOT EXISTS `DOWNLOADABLE_USERS` (
`ID` bigint(20)
,`Username` varchar(100)
,`Email` varchar(100)
,`FirstName` varchar(100)
,`MiddleName` varchar(100)
,`LastName` varchar(100)
,`Gender` varchar(30)
,`BirthYear` year(4)
,`ZipCode` varchar(10)
,`Phone` varchar(17)
,`Address` varchar(100)
,`City` varchar(100)
,`StateProvinceID` bigint(20)
,`StateProvince` varchar(100)
,`CountryID` tinyint(4)
,`SeekingMentorship` tinyint(1)
,`SeekingMenteeship` tinyint(1)
,`WorkStatus` varchar(100)
,`Employer` varchar(250)
,`Field` varchar(200)
,`ResumeURL` varchar(200)
,`ImageURL` varchar(200)
,`FacebookURL` varchar(500)
,`LinkedInURL` varchar(500)
,`TwitterURL` varchar(500)
,`Activated` tinyint(1)
,`RegisterDate` date
,`Country` varchar(100)
,`StateProvinceFromID` varchar(100)
,`ApproxAge` int(5) unsigned
);
-- --------------------------------------------------------

--
-- Table structure for table `EDUCATION_TYPE`
--

CREATE TABLE IF NOT EXISTS `EDUCATION_TYPE` (
  `ID` tinyint(4) NOT NULL AUTO_INCREMENT,
  `DegreeLevel` varchar(80) NOT NULL,
  `Active` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `DegreeLevel` (`DegreeLevel`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `EDUCATION_TYPE`
--

INSERT INTO `EDUCATION_TYPE` (`ID`, `DegreeLevel`, `Active`) VALUES
(1, 'HS Diploma', 1),
(2, 'Associates Degree', 1),
(4, 'Bachelors Degree', 1),
(5, 'Technical Certificate', 1),
(6, 'PHD', 1),
(7, 'Master of Sciences', 1),
(8, 'GED', 1),
(9, 'Masters of being Awesome', 0),
(10, 'School', 1);

-- --------------------------------------------------------

--
-- Table structure for table `LAB_DEPARTMENT`
--

CREATE TABLE IF NOT EXISTS `LAB_DEPARTMENT` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(100) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `LAB_DEPARTMENT`
--

INSERT INTO `LAB_DEPARTMENT` (`ID`, `Description`) VALUES
(1, 'Computer Science'),
(2, 'Computer Engineering'),
(3, 'System Administration'),
(4, 'Other');

-- --------------------------------------------------------

--
-- Table structure for table `LAB_GENDER`
--

CREATE TABLE IF NOT EXISTS `LAB_GENDER` (
  `ID` tinyint(4) NOT NULL AUTO_INCREMENT,
  `Description` varchar(20) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `LAB_GENDER`
--

INSERT INTO `LAB_GENDER` (`ID`, `Description`) VALUES
(1, 'not specified'),
(2, 'male'),
(3, 'female');

-- --------------------------------------------------------

--
-- Table structure for table `LAB_STATUS`
--

CREATE TABLE IF NOT EXISTS `LAB_STATUS` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserID` bigint(20) NOT NULL COMMENT 'Foreign key to LAB_USER.ID',
  `StatusID` bigint(20) NOT NULL COMMENT 'Foreign key to LAB_STATUS_TYPES',
  `Active` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `UserID` (`UserID`,`StatusID`),
  KEY `StatusID` (`StatusID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `LAB_STATUS`
--

INSERT INTO `LAB_STATUS` (`ID`, `UserID`, `StatusID`, `Active`) VALUES
(3, 6, 1, 1),
(4, 6, 3, 1),
(5, 7, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `LAB_STATUS_TYPES`
--

CREATE TABLE IF NOT EXISTS `LAB_STATUS_TYPES` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(100) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `LAB_STATUS_TYPES`
--

INSERT INTO `LAB_STATUS_TYPES` (`ID`, `Description`) VALUES
(1, 'student'),
(2, 'staff'),
(3, 'faculty');

-- --------------------------------------------------------

--
-- Table structure for table `LAB_USER`
--

CREATE TABLE IF NOT EXISTS `LAB_USER` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(100) NOT NULL,
  `LastName` varchar(100) NOT NULL,
  `Email` varchar(200) NOT NULL,
  `Password` varchar(100) NOT NULL COMMENT 'at least TRY to salt & hash these!',
  `GenderID` tinyint(4) NOT NULL COMMENT 'Foreign key to LAB_GENDER',
  `DepartmentID` bigint(20) NOT NULL COMMENT 'Foreign key to LAB_DEPARTMENT',
  `ActivationCode` varchar(55) NOT NULL,
  `Activated` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Email` (`Email`),
  KEY `GenderID` (`GenderID`,`DepartmentID`),
  KEY `DepartmentID` (`DepartmentID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=27 ;

--
-- Dumping data for table `LAB_USER`
--

INSERT INTO `LAB_USER` (`ID`, `FirstName`, `LastName`, `Email`, `Password`, `GenderID`, `DepartmentID`, `ActivationCode`, `Activated`) VALUES
(6, 'Andrew', 'Liden', 'deactivated@no.com', '8bc5de83cf1daf79ed5b2f13f93d7c05d01d0388', 2, 1, 'CA9T4WUMZFBPPDINV5IMYDT3AMHKBZ66LMAY7ZOPQCTEPURAWDDU0U9', 1),
(7, 'Andrew', 'Liden', 'aliden@iu.edu', '8bc5de83cf1daf79ed5b2f13f93d7c05d01d0388', 2, 1, 'YX9HO5LUM8XXJK14WFSQYL05HHDEA2A00FR2SL82A0GUB38RAI2QXD9', 1),
(8, 'Fake', 'User', 'f@k.e', '18ad10fd4a67f21fc07b1aa5046b410f6b2bedf1', 1, 1, 'CA9T4WUMZFBPPDINV5IMYDT3AMHKBZ66LMAY7ZOPQCTEPURAWDDU0U9', 1),
(9, 'No step', 'On snek', 'sn@k.e', '8bc5de83cf1daf79ed5b2f13f93d7c05d01d0388', 1, 1, 'CA9T4WUMZFBPPDINV5IMYDT3AMHKBZ66LMAY7ZOPQCTEPURAWDDU0U9', 1),
(10, 'Bobby', 'User', 'bobby@fakeEmail.com', '8bc5de83cf1daf79ed5b2f13f93d7c05d01d0388', 2, 1, 'CA9T4WUMZFBPPDINV5IMYDT3AMHKBZ66LMAY7ZOPQCTEPURAWDDU0U9', 1),
(11, 'Little Bobby', 'Tables', 'DROP TABLE IF EXISTS LAB_USER;--@EMAIL.COM', '8bc5de83cf1daf79ed5b2f13f93d7c05d01d0388', 2, 1, 'CA9T4WUMZFBPPDINV5IMYDT3AMHKBZ66LMAY7ZOPQCTEPURAWDDU0U9', 1),
(12, 'Griffin', 'McElroy', 'topPodcaster@fakeEmail.com', '8bc5de83cf1daf79ed5b2f13f93d7c05d01d0388', 2, 1, 'CA9T4WUMZFBPPDINV5IMYDT3AMHKBZ66LMAY7ZOPQCTEPURAWDDU0U9', 1),
(13, 'The ghost', 'inside the machine', '2spooky@4me.com', '8bc5de83cf1daf79ed5b2f13f93d7c05d01d0388', 1, 3, 'CA9T4WUMZFBPPDINV5IMYDT3AMHKBZ66LMAY7ZOPQCTEPURAWDDU0U9', 1),
(14, 'Ada', 'Lovelace', 'no@email.com', '8bc5de83cf1daf79ed5b2f13f93d7c05d01d0388', 3, 1, 'YX9HO5LUM8XXJK14WFSQYL05HHDEA2A00FR2SL82A0GUB38RAI2QXD9', 1),
(15, 'Monty', 'Python', 'holy@grail.com', '18ad10fd4a67f21fc07b1aa5046b410f6b2bedf1', 2, 4, '', 1),
(16, 'Charles', 'Babbage', 'computer@science.guy', '18ad10fd4a67f21fc07b1aa5046b410f6b2bedf1', 2, 1, '', 1),
(17, 'Deactivated User', 'If I showed up on queries, Andrew messed up', 'sentinal@user.com', 'test', 1, 4, '', 0),
(18, 'Alan', 'Turing', 'turing@test.com', 'test', 2, 1, '', 1),
(19, 'Travis', 'McElroy', 'alsoTopPodcster@fakeEmail.com', '', 2, 4, '', 1),
(21, 'Justin', 'McElroy', 'stillAlsoTopPodcaster@fakeEmail.com', '', 2, 4, '', 1),
(22, 'Bill', 'Gates', 'no@testvalue.com', '', 2, 2, '', 1),
(24, 'Steve', 'Jobs', '9@10.com', '', 2, 2, '', 1),
(25, 'Linus', 'Torvalds', 'user@use.cool', '', 2, 2, '', 1),
(26, 'Richard', 'Stallman', 'fsf@something.something', '', 2, 2, '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `MENTOR_HISTORY`
--

CREATE TABLE IF NOT EXISTS `MENTOR_HISTORY` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `MentorID` bigint(20) NOT NULL COMMENT 'Foreign key to USER.ID',
  `MenteeID` bigint(20) NOT NULL COMMENT 'Foreign key to USER.ID.  Cannot match MetorID',
  `RejectDate` date DEFAULT NULL,
  `StartDate` date DEFAULT NULL,
  `EndDate` date DEFAULT NULL,
  `RequestedBy` bigint(20) NOT NULL,
  `RequestDate` date NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `MentorID` (`MentorID`,`MenteeID`),
  KEY `MenteeID` (`MenteeID`),
  KEY `RequestedBy` (`RequestedBy`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=85 ;

--
-- Dumping data for table `MENTOR_HISTORY`
--

INSERT INTO `MENTOR_HISTORY` (`ID`, `MentorID`, `MenteeID`, `RejectDate`, `StartDate`, `EndDate`, `RequestedBy`, `RequestDate`) VALUES
(11, 49, 97, NULL, '2018-11-06', '2018-11-10', 49, '2018-11-13'),
(15, 49, 92, NULL, '2018-11-15', '2018-12-04', 49, '2018-11-13'),
(16, 96, 97, '2018-11-14', NULL, '2018-11-14', 96, '2018-11-13'),
(17, 112, 91, '2018-11-09', '2018-11-09', '2018-11-13', 112, '2018-11-13'),
(18, 112, 96, '2018-11-09', '2018-11-09', '2018-11-13', 112, '2018-11-13'),
(19, 112, 92, '2018-11-09', '2018-11-09', '2018-11-13', 112, '2018-11-13'),
(20, 112, 91, '2018-11-09', '2018-11-09', '2018-11-13', 112, '2018-11-13'),
(21, 99, 91, '2018-11-09', '2018-11-09', '2018-11-09', 91, '2018-11-13'),
(22, 49, 91, '2018-11-09', '2018-11-09', '2018-11-09', 91, '2018-11-13'),
(23, 93, 91, '2018-11-09', NULL, NULL, 91, '2018-11-13'),
(24, 98, 91, '2018-11-09', NULL, NULL, 91, '2018-11-13'),
(25, 112, 91, '2018-11-09', '2018-11-09', '2018-11-13', 91, '2018-11-13'),
(26, 112, 91, '2018-11-09', '2018-11-09', '2018-11-13', 112, '2018-11-13'),
(27, 112, 91, '2018-11-09', '2018-11-09', '2018-11-13', 91, '2018-11-13'),
(28, 112, 91, NULL, '2018-11-09', '2018-11-13', 112, '2018-11-13'),
(29, 98, 91, '2018-11-09', '2018-11-09', '2018-11-09', 91, '2018-11-13'),
(30, 93, 91, '2018-11-09', '2018-11-09', '2018-11-09', 91, '2018-11-13'),
(31, 49, 91, '2018-11-09', '2018-11-09', '2018-11-09', 91, '2018-11-13'),
(32, 112, 91, NULL, '2018-11-09', '2018-11-13', 91, '2018-11-13'),
(33, 112, 111, '2018-11-09', '2018-11-09', '2018-11-13', 112, '2018-11-13'),
(34, 112, 113, NULL, '2018-11-09', '2018-11-13', 112, '2018-11-13'),
(35, 114, 113, NULL, '2018-11-10', '2018-11-10', 114, '2018-11-13'),
(36, 114, 113, '2018-11-10', '2018-11-10', '2018-11-10', 114, '2018-11-13'),
(37, 114, 113, '2018-11-10', '2018-11-10', '2018-11-10', 114, '2018-11-13'),
(44, 114, 113, NULL, '2018-11-10', '2018-11-10', 114, '2018-11-13'),
(45, 49, 96, NULL, '2018-11-10', '2018-11-15', 49, '2018-11-13'),
(46, 114, 113, NULL, '2018-11-10', '2018-11-10', 114, '2018-11-13'),
(47, 114, 113, NULL, '2018-11-10', '2018-11-10', 114, '2018-11-13'),
(48, 99, 113, NULL, '2018-11-10', '2018-11-10', 99, '2018-11-13'),
(49, 114, 113, NULL, '2018-11-10', '2018-11-10', 114, '2018-11-13'),
(50, 49, 113, NULL, '2018-11-10', '2018-11-10', 49, '2018-11-13'),
(51, 114, 92, NULL, '2018-11-10', '2018-11-10', 114, '2018-11-13'),
(52, 49, 113, NULL, '2018-11-10', '2018-11-10', 49, '2018-11-13'),
(53, 49, 92, NULL, '2018-11-10', '2018-11-10', 49, '2018-11-13'),
(54, 49, 113, NULL, '2018-11-10', '2018-11-10', 49, '2018-11-13'),
(55, 93, 115, NULL, '2018-11-10', '2018-11-15', 93, '2018-11-13'),
(56, 119, 111, '2018-11-13', '2018-11-13', '2018-11-13', 119, '2018-11-13'),
(57, 93, 92, NULL, '2018-11-14', '2018-12-05', 93, '2018-11-14'),
(58, 128, 97, NULL, '2018-11-15', '2018-12-05', 128, '2018-11-15'),
(59, 128, 96, '2018-12-03', NULL, '2018-12-03', 96, '2018-11-15'),
(60, 112, 132, NULL, '2018-11-15', '2018-11-15', 112, '2018-11-15'),
(61, 117, 132, NULL, '2018-12-05', '2018-12-05', 132, '2018-11-15'),
(62, 93, 132, NULL, '2018-11-15', NULL, 93, '2018-11-15'),
(67, 49, 96, NULL, '2018-11-30', '2018-12-01', 49, '2018-11-30'),
(69, 49, 129, NULL, '2018-11-30', '2018-12-01', 49, '2018-11-30'),
(70, 49, 96, NULL, '2018-11-30', '2018-12-05', 49, '2018-11-30'),
(71, 49, 129, NULL, '2018-11-30', '2018-12-01', 49, '2018-11-30'),
(72, 49, 111, NULL, '2018-11-30', NULL, 49, '2018-11-30'),
(73, 93, 115, NULL, '2018-11-30', '2018-12-06', 93, '2018-11-30'),
(74, 49, 91, NULL, '2018-11-30', '2018-12-05', 49, '2018-11-30'),
(75, 49, 113, NULL, '2018-11-30', NULL, 49, '2018-11-30'),
(76, 49, 113, NULL, '2018-11-30', '2018-12-01', 49, '2018-11-30'),
(77, 49, 142, NULL, '2018-12-01', NULL, 49, '2018-12-01'),
(78, 128, 159, '2018-12-05', NULL, '2018-12-05', 159, '2018-12-01'),
(79, 49, 159, NULL, '2018-12-04', NULL, 49, '2018-12-04'),
(80, 114, 166, NULL, '2018-12-05', '2018-12-05', 114, '2018-12-05'),
(81, 114, 92, NULL, '2018-12-05', NULL, 114, '2018-12-05'),
(82, 167, 129, NULL, '2018-12-06', '2018-12-06', 167, '2018-12-06'),
(83, 114, 97, NULL, '2018-12-06', NULL, 114, '2018-12-06'),
(84, 167, 115, '2018-12-06', NULL, '2018-12-06', 167, '2018-12-06');

-- --------------------------------------------------------

--
-- Stand-in structure for view `PAIRED_MENTEES`
--
CREATE TABLE IF NOT EXISTS `PAIRED_MENTEES` (
`MenteeID` bigint(20)
,`Pairs` bigint(21)
);
-- --------------------------------------------------------

--
-- Table structure for table `PHONE`
--

CREATE TABLE IF NOT EXISTS `PHONE` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserID` bigint(20) NOT NULL COMMENT 'Foreign key to USER.ID',
  `NumberTypeID` tinyint(4) NOT NULL,
  `CountryCode` tinyint(2) NOT NULL COMMENT 'Keeping phone numbers as 3 entries allows for numeric, yet formatted storage of numbers.',
  `AreaCode` int(3) NOT NULL,
  `LastSeven` int(7) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `UserID` (`UserID`),
  KEY `CountryCode` (`CountryCode`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='This departs from our ER diagram, which will need updated.' AUTO_INCREMENT=28 ;

--
-- Dumping data for table `PHONE`
--

INSERT INTO `PHONE` (`ID`, `UserID`, `NumberTypeID`, `CountryCode`, `AreaCode`, `LastSeven`) VALUES
(22, 91, 1, 0, 0, 0),
(23, 92, 1, 12, 345, 6789123),
(24, 93, 1, 123, 456, 7890),
(26, 95, 1, 0, 317, 9928936),
(27, 96, 1, 1, 765, 5555555);

-- --------------------------------------------------------

--
-- Table structure for table `PHONE_NUMBER_TYPES`
--

CREATE TABLE IF NOT EXISTS `PHONE_NUMBER_TYPES` (
  `ID` tinyint(4) NOT NULL AUTO_INCREMENT,
  `Description` varchar(30) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `PHONE_NUMBER_TYPES`
--

INSERT INTO `PHONE_NUMBER_TYPES` (`ID`, `Description`) VALUES
(1, 'Cellular'),
(2, 'Landline'),
(3, 'Business'),
(4, 'Fax');

-- --------------------------------------------------------

--
-- Stand-in structure for view `READABLE_ACTIVATED_USERS`
--
CREATE TABLE IF NOT EXISTS `READABLE_ACTIVATED_USERS` (
`ID` bigint(20)
,`Username` varchar(100)
,`Password` varchar(100)
,`Email` varchar(100)
,`FirstName` varchar(100)
,`MiddleName` varchar(100)
,`LastName` varchar(100)
,`Gender` varchar(30)
,`BirthYear` year(4)
,`ZipCode` varchar(10)
,`Phone` varchar(17)
,`Address` varchar(100)
,`City` varchar(100)
,`StateProvinceID` bigint(20)
,`StateProvince` varchar(100)
,`CountryID` tinyint(4)
,`SeekingMentorship` tinyint(1)
,`SeekingMenteeship` tinyint(1)
,`WorkStatus` varchar(100)
,`Employer` varchar(250)
,`Field` varchar(200)
,`ResumeURL` varchar(200)
,`ImageURL` varchar(200)
,`FacebookURL` varchar(500)
,`LinkedInURL` varchar(500)
,`TwitterURL` varchar(500)
,`ResetPIN` varchar(6)
,`Activated` tinyint(1)
,`ActivationCode` varchar(60)
,`RegisterDate` date
,`Country` varchar(100)
,`StateProvinceFromID` varchar(100)
,`ApproxAge` int(5) unsigned
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `READABLE_MENTOR_HISTORY`
--
CREATE TABLE IF NOT EXISTS `READABLE_MENTOR_HISTORY` (
`RecordID` bigint(20)
,`MenteeID` bigint(20)
,`MenteeEmail` varchar(100)
,`MenteeFirstName` varchar(100)
,`MenteeLastName` varchar(100)
,`MenteePhone` varchar(17)
,`MenteeAddress` varchar(100)
,`MenteeCity` varchar(100)
,`MenteeStateProvince` varchar(100)
,`MenteeCountry` varchar(100)
,`MentorID` bigint(20)
,`MentorEmail` varchar(100)
,`MentorFirstName` varchar(100)
,`MentorLastName` varchar(100)
,`MentorPhone` varchar(17)
,`MentorAddress` varchar(100)
,`MentorCity` varchar(100)
,`MentorStateProvince` varchar(100)
,`MentorCountry` varchar(100)
,`StartDate` date
,`EndDate` date
,`RejectDate` date
,`RequestDate` date
,`RequesterEmail` varchar(100)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `READABLE_PAIRED_MENTEES`
--
CREATE TABLE IF NOT EXISTS `READABLE_PAIRED_MENTEES` (
`MenteeID` bigint(20)
,`Pairs` bigint(21)
,`MenteeEmail` varchar(100)
);
-- --------------------------------------------------------

--
-- Table structure for table `SOCIAL_MEDIA_LINK`
--

CREATE TABLE IF NOT EXISTS `SOCIAL_MEDIA_LINK` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserID` bigint(20) NOT NULL COMMENT 'Foreign key to USER.ID',
  `LinkTypeID` bigint(20) NOT NULL COMMENT 'Foreign key to SOCIAL_MEDIA_TYPES.ID',
  `URL` varchar(250) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `UserID` (`UserID`,`LinkTypeID`),
  KEY `LinkTypeID` (`LinkTypeID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=84 ;

--
-- Dumping data for table `SOCIAL_MEDIA_LINK`
--

INSERT INTO `SOCIAL_MEDIA_LINK` (`ID`, `UserID`, `LinkTypeID`, `URL`) VALUES
(51, 91, 1, ''),
(52, 91, 2, ''),
(53, 91, 3, ''),
(54, 92, 1, 'fname/facebook.com'),
(55, 92, 2, 'fname/twitter.com'),
(56, 92, 3, 'lname/linkedin.com'),
(57, 93, 1, ''),
(58, 93, 2, ''),
(59, 93, 3, ''),
(63, 95, 1, 'shivek'),
(64, 95, 2, ''),
(65, 95, 3, ''),
(66, 96, 1, ''),
(67, 96, 2, ''),
(68, 96, 3, ''),
(69, 97, 1, ''),
(70, 97, 2, ''),
(71, 97, 3, ''),
(72, 98, 1, 'fb.com'),
(73, 98, 2, ''),
(74, 98, 3, ''),
(75, 99, 1, ''),
(76, 99, 2, '');

-- --------------------------------------------------------

--
-- Table structure for table `SOCIAL_MEDIA_LINK_TYPES`
--

CREATE TABLE IF NOT EXISTS `SOCIAL_MEDIA_LINK_TYPES` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Description` varchar(100) NOT NULL,
  `URLprefix` varchar(100) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `SOCIAL_MEDIA_LINK_TYPES`
--

INSERT INTO `SOCIAL_MEDIA_LINK_TYPES` (`ID`, `Description`, `URLprefix`) VALUES
(1, 'Facebook', 'http://www.facebook.com/'),
(2, 'Twitter', 'http://www.twitter.com/'),
(3, 'LinkedIn', 'https://www.linkedin.com/');

-- --------------------------------------------------------

--
-- Table structure for table `STATE`
--

CREATE TABLE IF NOT EXISTS `STATE` (
  `ID` tinyint(4) NOT NULL AUTO_INCREMENT COMMENT 'Could this instead by user defined, allowing it to match phone number country codes?',
  `Name` varchar(100) NOT NULL,
  `Active` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=43 ;

--
-- Dumping data for table `STATE`
--

INSERT INTO `STATE` (`ID`, `Name`, `Active`) VALUES
(1, 'Where did this table come from?', 1),
(2, 'Where did this table come from?', 1),
(8, 'Where did this table come from?', 1),
(10, 'Where did this table come from?', 1),
(12, 'Where did this table come from?', 1),
(14, 'Where did this table come from?', 1),
(16, 'Where did this table come from?', 1),
(18, 'Where did this table come from?', 1),
(19, 'Where did this table come from?', 1),
(33, 'Where did this table come from?', 1),
(41, 'Where did this table come from?', 1),
(42, 'Where did this table come from?', 1);

-- --------------------------------------------------------

--
-- Table structure for table `STATES_PROVINCES`
--

CREATE TABLE IF NOT EXISTS `STATES_PROVINCES` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `CountryID` tinyint(4) NOT NULL COMMENT 'Foreign key to COUNTRY.ID',
  `Active` int(1) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `CountryID` (`CountryID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=77 ;

--
-- Dumping data for table `STATES_PROVINCES`
--

INSERT INTO `STATES_PROVINCES` (`ID`, `Name`, `CountryID`, `Active`) VALUES
(1, 'Indiana', 2, 1),
(2, 'Ohio', 2, 1),
(3, 'Kentucky', 2, 1),
(4, 'California', 2, 1),
(5, 'Chiapas', 8, 1),
(6, 'New Mexico', 2, 1),
(8, 'Nevada', 2, 1),
(9, 'New South Wales', 12, 1),
(10, 'Western Australia', 12, 1),
(11, 'Queensland', 12, 1),
(12, 'South Australia', 12, 1),
(13, 'Victoria', 12, 1),
(14, 'Tasmania', 12, 1),
(15, 'New York', 2, 1),
(16, 'Magway Region', 1, 1),
(17, 'Kyoto', 19, 1),
(18, 'Aguascalientes', 8, 1),
(19, 'Baja California', 8, 1),
(20, 'Baja California Sur', 8, 1),
(21, 'Campeche', 8, 1),
(22, 'Distrito Federal', 8, 1),
(23, 'Illinois', 2, 1),
(24, 'Guangdong Province', 50, 1),
(25, 'South Tyrol', 14, 1),
(26, 'Amur Oblast', 16, 1),
(27, 'Cape of Good Hope', 33, 1),
(28, 'Asturias', 10, 1),
(29, 'Konya', 41, 1),
(30, 'Emirate of Abu Dhabi', 18, 1),
(31, 'Nebraska', 2, 1),
(32, 'Kansas', 2, 1),
(33, 'Arkansas', 2, 1),
(34, 'Alabama', 2, 1),
(35, 'North Carolina', 2, 1),
(36, 'South Carolina', 2, 1),
(37, 'North Dakota', 2, 1),
(38, 'South Dakota', 2, 1),
(39, 'Vermont', 2, 1),
(40, 'Maine', 2, 1),
(41, 'Alaska', 2, 1),
(42, 'Arizona', 2, 1),
(43, 'Colorado', 2, 1),
(44, 'Connecticut', 2, 1),
(45, 'Delaware', 2, 1),
(46, 'Florida', 2, 1),
(47, 'Georgia', 2, 1),
(48, 'Hawaii', 2, 1),
(49, 'Idaho', 2, 1),
(50, 'Iowa', 2, 1),
(51, 'Louisiana', 2, 1),
(52, 'Maryland', 2, 1),
(53, 'Massachusetts', 2, 1),
(54, 'Michigan', 2, 1),
(55, 'Minnesota', 2, 1),
(56, 'Mississippi', 2, 1),
(57, 'Missouri', 2, 1),
(58, 'Montana', 2, 1),
(59, 'New Hampshire', 2, 1),
(60, 'New Jersey', 2, 1),
(61, 'Oklahoma', 2, 1),
(62, 'Oregon', 2, 1),
(63, 'Pennsylvania', 2, 1),
(64, 'Rhode Island', 2, 1),
(65, 'Tennessee', 2, 1),
(66, 'Texas', 2, 1),
(67, 'Utah', 2, 1),
(68, 'Virginia', 2, 1),
(69, 'Washington', 2, 1),
(70, 'West Virginia', 2, 1),
(71, 'Wisconsin', 2, 1),
(72, 'Wyoming', 2, 1),
(73, 'District of Columbia', 2, 1),
(74, 'Jeju', 51, 1),
(75, 'Ukraine', 52, 1),
(76, 'Puerto Rico', 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `USER`
--

CREATE TABLE IF NOT EXISTS `USER` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Username` varchar(100) DEFAULT NULL COMMENT 'Depracated:  Use email instead!',
  `Password` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'In the final version of this program, DO NOT STORE ANY PASSWORDS IN PLAINTEXT.',
  `Email` varchar(100) NOT NULL,
  `FirstName` varchar(100) NOT NULL COMMENT 'Should we do something about the cultural difference in Myanmar regarding names?  Or should we expect Myanmar users to adapt to the US custom?',
  `MiddleName` varchar(100) DEFAULT NULL,
  `LastName` varchar(100) NOT NULL,
  `Gender` varchar(30) NOT NULL,
  `BirthYear` year(4) DEFAULT NULL,
  `ZipCode` varchar(10) DEFAULT NULL,
  `Phone` varchar(17) DEFAULT NULL COMMENT '+##(###)###-####',
  `Address` varchar(100) NOT NULL COMMENT 'This may benefit from its own table.',
  `City` varchar(100) NOT NULL COMMENT 'This is directly related to address.  If address gets its own table, this should also be in it.',
  `StateProvinceID` bigint(20) DEFAULT NULL COMMENT 'This is a foreign key to the STATES_PROVINCES table.  It is also related to addresses.  If the address table is separated, this will likely leave with it.',
  `StateProvince` varchar(100) DEFAULT NULL,
  `CountryID` tinyint(4) NOT NULL COMMENT 'This is a foreign key to the COUNTRY table.  It is related to address, but also related to other facts about the user (citizenship, for example)  It is disputable whether it would leave along with the addresses if the address table is separated.',
  `SeekingMentorship` tinyint(1) NOT NULL COMMENT 'Seeking Mentorship as in "I am a mentee, looking for a mentor"',
  `SeekingMenteeship` tinyint(1) NOT NULL COMMENT 'Seeking Menteeship as in, "I am a mentor, looking for mentees."',
  `WorkStatus` varchar(100) DEFAULT NULL,
  `Employer` varchar(250) DEFAULT NULL,
  `Field` varchar(200) DEFAULT NULL,
  `ResumeURL` varchar(200) DEFAULT NULL,
  `ImageURL` varchar(200) DEFAULT NULL,
  `FacebookURL` varchar(500) DEFAULT NULL,
  `LinkedInURL` varchar(500) DEFAULT NULL,
  `TwitterURL` varchar(500) DEFAULT NULL,
  `ResetPIN` varchar(6) DEFAULT NULL,
  `Activated` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'This is used to determine if the user has gone through email activation.  It defaults to zero',
  `ActivationCode` varchar(60) DEFAULT NULL,
  `RegisterDate` date NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Username` (`Username`),
  KEY `StateProvinceID` (`StateProvinceID`),
  KEY `CountryID` (`CountryID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=168 ;

--
-- Dumping data for table `USER`
--

INSERT INTO `USER` (`ID`, `Username`, `Password`, `Email`, `FirstName`, `MiddleName`, `LastName`, `Gender`, `BirthYear`, `ZipCode`, `Phone`, `Address`, `City`, `StateProvinceID`, `StateProvince`, `CountryID`, `SeekingMentorship`, `SeekingMenteeship`, `WorkStatus`, `Employer`, `Field`, `ResumeURL`, `ImageURL`, `FacebookURL`, `LinkedInURL`, `TwitterURL`, `ResetPIN`, `Activated`, `ActivationCode`, `RegisterDate`) VALUES
(6, 'TestUser', 'Jbc5de83cf1daf79ed5b2f13f93d7c05d01d0388', 'f@k.e', 'Test', '', 'User', 'male', 1970, NULL, NULL, '1234 Test Lane', 'Test Zone', 1, 'Indiana', 1, 0, 0, NULL, NULL, NULL, '', '', '', NULL, NULL, NULL, 1, NULL, '2018-11-10'),
(49, 'aliden@iu.edu', 'J8ad10fd4a67f21fc07b1aa5046b410f6b2bedf1', 'aliden@iu.edoooooh', 'Pauline', '', 'Liden', 'female', 1989, NULL, NULL, '123 Place Lane', 'Indianapolis', 1, 'Indiana', 1, 0, 1, NULL, NULL, NULL, '', '', '', NULL, NULL, NULL, 1, NULL, '2018-11-10'),
(81, 'fake@email.com', 'Jbc5de83cf1daf79ed5b2f13f93d7c05d01d0388', 'fake@email.com', 'Peter', '', 'Hark', 'male', 1989, NULL, NULL, '1234 Place Lane', 'Indianapolis', 1, 'Indiana', 1, 0, 0, NULL, NULL, NULL, 'http://corsair.cs.iupui.edu:23081/CourseProject/Register.php', '', '', NULL, NULL, NULL, 1, NULL, '2018-11-10'),
(91, '1@q.com', 'Jbc5de83cf1daf79ed5b2f13f93d7c05d01d0388', '101010@q.com', 'zi', '', 'WWWWW', 'male', 1980, '', '', 'Some place', 'indianapolis', 16, '', 1, 1, 0, '', '', '', 'http://user.resume.php', '', '', '', '', NULL, 1, NULL, '2018-11-10'),
(92, 'fname@test.com', 'J7a6a55977799930571281f7baad1f4dfa6012e4', 'fname@test.com', 'George', '', 'Sams', 'male', 1980, NULL, NULL, 'somestreet', 'somecity', 1, 'Indiana', 18, 1, 0, NULL, NULL, NULL, 'http://user.resume.php', '', '', NULL, NULL, NULL, 1, NULL, '2018-11-10'),
(93, 'joekeitho@yahoo.com', 'Jbc5de83cf1daf79ed5b2f13f93d7c05d01d0388', 'joekeitho@yahoo.com', 'Joseph', 'A', 'Owens', 'male', 1988, '', '', '123 Place Lane', 'City', 16, 'Indiana', 1, 0, 1, '', '', '', 'http://user.resume.php', '', '', '', '', NULL, 1, NULL, '2018-11-10'),
(95, 'shivcoolbunty@gmail.com', 'tempPassword', 'shivcoolbunty@gmail.com', 'shivek', '', 'potlacheruvu', 'male', 1995, NULL, NULL, '49 w maryland st, beside banana republic', 'Indianapolis', 1, 'Indiana', 1, 0, 0, NULL, NULL, NULL, 'http://user.resume.php', '', '', NULL, NULL, NULL, 1, NULL, '2018-11-10'),
(96, 'joekeitho@gmail.com', 'J825588eb02fc871b00858def79bcc81712cd78c', 'joekeitho@gmail.com', 'Keith', '', 'Owens', 'male', 1988, '', '', '543543 TEST Dr', 'Westfield', 16, '16', 1, 1, 0, '', '', '', 'http://user.resume.php', '', '', '', '', NULL, 1, NULL, '2018-11-10'),
(97, 'testtdfadfasfdasfdas@yahoo.com', 'J59c102892ba6710188ec7912c85191e67f3d157', 'testtdfadfasfdasfdas@yahoo.com', 'bobby', '', 'Noon', 'male', 1980, NULL, NULL, '15725 test dr', 'Westfield', 1, 'Indiana', 1, 1, 0, NULL, NULL, NULL, 'http://user.resume.php', '', '', NULL, NULL, NULL, 1, NULL, '2018-11-10'),
(98, 'omkarchanda06@gmail.com', 'Jeb6123b1ed97a454db1fd76cf8a179cbb08050f', 'omkarchanda06@gmail.com', 'omkar', NULL, 'Chan', 'male', 1995, NULL, NULL, 'dfdgdg', 'california', 1, 'Indiana', 1, 0, 1, NULL, NULL, NULL, 'http://user.resume.php', NULL, NULL, NULL, NULL, NULL, 1, NULL, '2018-11-10'),
(99, 'omkar.chanda@panzertechnologies.net', '', 'omkar.chanda@panzertechnologies.net', 'omkar', NULL, 'Chasndra', 'male', 1995, NULL, NULL, 'dfdgdg', 'california', 1, 'Indiana', 1, 0, 1, NULL, NULL, NULL, 'http://user.resume.php', NULL, NULL, NULL, NULL, NULL, 1, NULL, '2018-11-10'),
(111, NULL, 'J94a8fe5ccb19ba61c4c0873d391e987982fbbd3', 'test@user.com', 'Lindsay', 'B', 'Liden', 'female', 1989, '12345', '(555)555-5555', '12345 Place Street', 'Indianapolis', 1, 'Indiana', 2, 1, 0, 'Student', '', 'Computer Science', '', '', NULL, NULL, NULL, NULL, 1, '', '2018-11-10'),
(112, NULL, 'Jbc5de83cf1daf79ed5b2f13f93d7c05d01d0388', 'aliden@iu2.edu', 'Jimmy&#39;; UPDATE USER SET Password = &#34;password&#34;; UPDATE USER SET&#34;', 'B', 'Liden', 'male', 1989, '', '+01(317)456-7891', '1234 Place Drive', 'Some City', 1, '', 1, 0, 1, '', 'Sample Employer', 'Breaking it all&#34;,&#34;&#34;,&#34;&#34;); UPDATE USER SET MiddleName=&#39;Okay, that\\&#39;s fixed&#39;;--', 'resume/2018_11_13_1542135876_alideniu.edursm.pdf', 'img/user/2018_11_13_1542135856_alideniu.eduimg.png', 'http://www.facebook.com/example', 'http://www.linkedin.com/example', 'http://www.twitter.com/example', NULL, 0, NULL, '2018-11-10'),
(113, NULL, 'Jbc5de83cf1daf79ed5b2f13f93d7c05d01d0388', 'example@user.com', 'Trogdor', 'The', 'Burninator', 'male', 1989, '', '(123)456-7890', '12345 Da Streetz', 'Fishers', 1, 'Indiana', 2, 1, 0, 'student', 'People who hire people', 'Computer Science', 'resume/2018_11_13_1542122684_exampleuser.comrsm.pdf', '', '', '', '', NULL, 1, 'SLZMV0YT228TT2TPP4OA67VLS6RIS6NEAP42FEEOFJVIH8DI1Z1I5E00JXBH', '2018-11-10'),
(114, NULL, 'Jbc5de83cf1daf79ed5b2f13f93d7c05d01d0388', 'another@example.com', 'Strong', '', 'Bad', 'male', 1989, '', '(123)456-7880', 'Strong Bad&#39;s Place', 'Strong Badia', 6, 'Free Country', 2, 0, 1, 'student', 'People who hire people', 'Computer Science', '', 'img/user/2018_11_13_1542145902_anotherexample.comimg.png', '', '', '', NULL, 1, 'PCUGR8B874LONU0P678CRKWL1JCJOPTM61D94LF0ENXICQRPP6JVSEH53OMO', '2018-11-10'),
(115, NULL, 'Jbc5de83cf1daf79ed5b2f13f93d7c05d01d0388', 'more@testusers.com', 'Manny', 'B', 'Eloriza', 'male', 1989, '', '(123)456-7890', '12', 'Fishers', 17, 'Some cool place', 19, 1, 0, 'student', '', '', '', '', '', '', '', NULL, 1, 'VGLZG96OF7JIIKZ744FKE68NEG09E5EJBVQWNDW7SRHLIZQBILPDDRV98WUK', '2018-11-10'),
(117, NULL, 'Jbc5de83cf1daf79ed5b2f13f93d7c05d01d0388', 'andrewliden1989old@gmail.com', 'Andrew', 'Old Entry', 'Liden', 'male', 1989, '', '(123)456-7890', '123 Place Drive', 'Fishers', 1, '', 2, 0, 1, 'student', 'People who hire people', 'Computer Science', '', '', '', '', '', NULL, 1, '9GSSS7TJJ0IX7G5CZ8AYKSSWX8LNGOCQARC7H1GY75XTRF59IUORJKI5279L', '2018-11-10'),
(119, NULL, 'Jbc5de83cf1daf79ed5b2f13f93d7c05d01d0388', 'ryoushi19@gmail.com', 'Ryanna', 'B', 'Lex', 'female', 1989, '', '(123)456-7891', '___ Drive', 'Fishers', 1, '', 2, 0, 1, 'student', 'An employer', 'Something exciting', '', 'img/user/example.png', 'http://www.facebook.com/user1', 'http://www.linkedin.com/user2', 'http://www.twitter.com/user', NULL, 1, '93HJ8YI8OLXLU2BM83C4CJQBKZOVXOMFOZLV3WG51ZSRKXIN937ANEEBSLCQ', '2018-11-10'),
(128, NULL, 'Jbc5de83cf1daf79ed5b2f13f93d7c05d01d0388', 'mario@mushroomKingdomWarpPipe.com', 'Mario', '', 'Mario', 'male', 1981, '12345', '(555)555-5555', 'World 1', 'Donut Plains', 1, 'Indiana', 2, 0, 1, 'employed', 'Mushroom Kingdom', 'Princess Rescuer', 'resume/Document1.pdf', 'img/user/mario-pose2.png', '', '', '', NULL, 1, 'QQKNURIUCCACY95ZOJ6E33NN81576MBUD2VCDGSTGOL2RSCFMWVO12J43HSY', '2018-11-12'),
(129, NULL, 'Jbc5de83cf1daf79ed5b2f13f93d7c05d01d0388', 'koopa@mushroomKingdomWarpPipe.com', 'Koopa', 'Troopa', 'Green Shell', 'male', 1983, '', '(555)987-6543', 'World 2-2', 'Donut Plains', 1, 'Indiana', 2, 1, 0, 'employed', 'Bowser', 'Mario-stopping', 'resume/2018_11_12_1542048544_koopamushroomKingdomWarpPipe.comrsm.pdf', 'img/user/2018_11_12_1542048544_koopamushroomKingdomWarpPipe.comimg.png', '', '', '', NULL, 1, 'QOMB6CNDQHVF2A5EBX5Q3RGBJWRBC3JDJ15R4U7G8WX6KCJHT1LMAC73DXXL', '2018-11-12'),
(132, NULL, 'Jbc5de83cf1daf79ed5b2f13f93d7c05d01d0388', 'goomba@mushroomKingdomWarpPipe.com', 'Goomba', '', 'Kuribo', 'other', 1983, '', '(123)456-7880', 'World 1-1', 'Donut Plains', 1, '1', 2, 1, 0, 'employed', 'Bowser', 'Stopping Mario', '__NO FILE__', 'img/user/2018_11_12_1542050640_goombamushroomKingdomWarpPipe.comimg.png', '', '', '', NULL, 1, '9ZY1AEUYGDES1RFK397L0EFGKVZ93D49XUMX7L9E3NCZD7CN0MWAN8QKTIQF', '2018-11-12'),
(134, NULL, 'Jce0359f12857f2a90c7de465f40a95f01cb5da9', 'exampleuser@example.com', 'Example', 'Of A', 'User', 'male', 1980, '46033', '', '123 Example Zone', 'Example City', 1, 'IN', 2, 0, 1, 'student', '', '', '__NO FILE__', '__NO FILE__', '', '', '', NULL, 1, '1MG1A985HO1EI1CDR000X6S63FXRJSRCRMI23GB74BOHE4G7XYHNQIH7YMXI', '2018-11-26'),
(139, NULL, 'Jbc5de83cf1daf79ed5b2f13f93d7c05d01d0388', 'newExample@user.com', 'Example', 'User', 'O&#39;Brian', 'male', 1989, '12345', '(123)456-7890', '123 Place Lane', 'Fishers', 1, 'IN', 2, 0, 1, 'student', '', '', '__NO FILE__', '__NO FILE__', 'http://www.facebook.com/example', '', '', NULL, 1, 'XXBBFU8KY79PNI3MPXNDID9D3O9RHJ7ELTBVS5DEIOCQ98NYNVN9FLP7VURP', '2018-11-30'),
(140, NULL, 'Jbc5de83cf1daf79ed5b2f13f93d7c05d01d0388', 'aliden@iu.edu', 'Andrew&#39;', 'B', 'Liden', 'male', 1989, '', '(123)456-7890', '123 Place Lane', 'Fishers', 1, '', 2, 0, 1, 'student', 'Employer', 'Field', '__NO FILE__', 'img/user/2018_12_04_1543936470_alideniu.eduimg.jpg', 'http://www.facebook.com/example', '', '', NULL, 1, 'FA2PY6SA7H19U7LMDO3WXK3OF0FHVOMWUJXI3HES09KUSHHOHNBN53154S4R', '2018-11-30'),
(141, NULL, 'Jbc5de83cf1daf79ed5b2f13f93d7c05d01d0388', 'op@function.com', 'Andrew', 'B', 'Liden', 'male', 1989, '', '(123)456-7890', '123 Place Lane', 'Fishers', 73, '', 2, 0, 1, '', '', '', '__NO FILE__', '__NO FILE__', 'http://www.facebook.com/example', '', '', NULL, 1, 'TJASPELSSJOLT3QE4WPE4HRZ8BBG3DQMTG7YDZWWYSACJUMHCQ8FL8FL729V', '2018-11-30'),
(142, NULL, 'Jce0359f12857f2a90c7de465f40a95f01cb5da9', 'jane_doe@yahoo.com', 'Jane', 'Mary', 'Doe', 'female', 1994, '', '(317)603-0729', '123 Dreary Ln.', 'Chicago', 23, 'IL', 2, 1, 0, 'student', '', '', '__NO FILE__', 'img/user/2018_12_04_1543937065_jane_doeyahoo.comimg.jpg', '', '', '', NULL, 1, '3CIRRLOTRF73SO49BBWJMQ1LQ7YXA9QU1QRSVROEXPQG2CWA7XNA0VL2084Q', '2018-11-30'),
(143, NULL, 'Jbc5de83cf1daf79ed5b2f13f93d7c05d01d0388', 'another@exampleuser.com', 'Andrew', 'B', 'Liden', 'male', 1989, '12345', '', '123 Place Lane', 'Fishers', 1, 'IN', 2, 0, 1, 'student', '', '', '__NO FILE__', '__NO FILE__', '', '', '', NULL, 1, 'Q6UBK9EP14TIQ72P90KNMGWNGFIJ0FJ30SPL0XWYXWMK75SVUE3AIS8K3OM6', '2018-12-01'),
(149, NULL, 'Jbc5de83cf1daf79ed5b2f13f93d7c05d01d0388', 'new@user.com', 'New', '', 'User', 'male', 1980, '12345', '', '123 Place Lane', 'City', 25, NULL, 14, 0, 1, 'student', '', '', '__NO FILE__', '__NO FILE__', '', '', '', NULL, 1, 'SGDTN3ZPZ9ZN0UKHT2ZCAR5V4W9ZM323WN0RHUKURM4OMC62X5EMDPEN02A5', '2018-12-01'),
(159, NULL, 'J825588eb02fc871b00858def79bcc81712cd78c', 'owenskeith@hotmail.com', 'Joseph', 'K', 'Owens', 'male', 1993, '', '', '15725 Wildrye Dr', 'Westfield', 1, NULL, 2, 1, 0, 'student', '', '', '__NO FILE__', '__NO FILE__', '', '', '', NULL, 1, 'KEQ0045GKLF0WV91KN4RFODHAJJJ5DAWEJMQF7DO349P06IEG5BOSTHOD39T', '2018-12-01'),
(160, NULL, 'J59c102892ba6710188ec7912c85191e67f3d157', 'fdasfadsdfadsf@fdasfdafdasf.com', 'George', '', 'Harrison', 'male', 1986, '', '', '12345 Abby Rd.', 'London', 30, NULL, 18, 0, 1, 'employed', '', '', '__NO FILE__', '__NO FILE__', '', '', '', NULL, 0, 'PEOAWYDYR9WVP3FTHEOCHKPZ3D06IXJBJPU1VU1E00FLR9BCR5Q5MJLQ22B3', '2018-12-01'),
(161, NULL, 'Jbc5de83cf1daf79ed5b2f13f93d7c05d01d0388', 'yetAnotherTest@email.com', 'Testing', '', 'Working Pro', 'male', 1920, '12345', '', '123 Place Lane', 'Placeville', 1, NULL, 2, 0, 0, 'employed', '', '', '__NO FILE__', '__NO FILE__', '', '', '', NULL, 1, 'GJ3MNOXNBS34P46189GCYLUX1ERWMUCG90X2RHWRNPVAVAPOJ37CCHKQZME4', '2018-12-03'),
(162, NULL, 'Jbc5de83cf1daf79ed5b2f13f93d7c05d01d0388', 'anotherTest@email.com', 'Test', '', 'User', 'male', 1992, '', '', '123 Place Drive', 'City', 3, NULL, 2, 0, 0, 'employed', 'Employer & field requirement', 'Is now complete when user is working pro.', 'resume/2018_12_03_1543863925_anotherTestemail.comrsm.jpg', 'img/user/2018_12_03_1543863790_anotherTestemail.comimg.jpg', '', '', '', NULL, 1, 'RCWBR7Q04MWFI8HAT0DSKI8C6RPBQLKQ459Y4FLOUASJ7M2KF5BNR7Z726LR', '2018-12-03'),
(165, NULL, 'J7a6a55977799930571281f7baad1f4dfa6012e4', 'zeba.sayeeda@gmail.com', 'Iffath', 'Zeba', 'Sayeeda', 'female', 1998, '', '(123)456-7891', 'Lakes', 'Indianapolis', 16, NULL, 1, 1, 0, 'student', '', '', 'resume/2018_12_04_1543934493_zeba.sayeedagmail.comrsm.txt', 'img/user/2018_12_04_1543934829_zeba.sayeedagmail.comimg.png', '', '', '', NULL, 1, 'KCGCKPMF38MXPJP0G8Z15J3G6J3M9IFS8O1KG0BAOVUPP6MH9BDSV1KPF87U', '2018-12-04'),
(166, NULL, 'Jbc5de83cf1daf79ed5b2f13f93d7c05d01d0388', 'finalTest@user.com', 'Another Test', 'User', 'For this website', 'other', 1999, '12345', '', '123 Place lane', 'Fishers', 1, NULL, 2, 1, 0, 'employed', 'An employer', 'Computer Science', '__NO FILE__', '__NO FILE__', '', '', '', NULL, 1, 'DHN7IVLNFXFO0NWASEAN6732BRFDQSMR7CXB8V0AZGXL8UWY9WJY1UCN24HF', '2018-12-04'),
(167, NULL, 'Jbc5de83cf1daf79ed5b2f13f93d7c05d01d0388', 'andrewliden1989@gmail.com', 'Andrew', 'B', 'Liden', 'male', 1989, '', '', '123 Place Lane', 'city', 44, NULL, 2, 0, 1, 'student', '', '', '__NO FILE__', '', '', '', '', NULL, 1, '3Y10483L6BE9D17KGTNHVRPM3EMF0DHW0G8M9Q2ULDG7IQZ10B6TAWFP0940', '2018-12-06');

-- --------------------------------------------------------

--
-- Table structure for table `USER_EDUCATION`
--

CREATE TABLE IF NOT EXISTS `USER_EDUCATION` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserID` bigint(20) NOT NULL COMMENT 'Foreign key to USER.ID',
  `Type` tinyint(4) NOT NULL COMMENT 'Foreign key to EDUCATION_TYPE.ID',
  `SchoolName` varchar(100) NOT NULL,
  `Major` varchar(100) NOT NULL,
  `GradYear` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `UserID` (`UserID`,`Type`),
  KEY `Type` (`Type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=205 ;

--
-- Dumping data for table `USER_EDUCATION`
--

INSERT INTO `USER_EDUCATION` (`ID`, `UserID`, `Type`, `SchoolName`, `Major`, `GradYear`) VALUES
(108, 49, 2, 'Ivy Tech Community College', 'General Studies', NULL),
(126, 91, 4, 'IUPUI', 'CS', NULL),
(127, 92, 5, 'Anns', 'CS', NULL),
(128, 93, 6, 'School', 'Cool', NULL),
(130, 95, 1, 'CELL WIRELESS', 'computer science', NULL),
(131, 96, 4, 'tesths', 'testmj', NULL),
(134, 97, 4, 'test', 'majortest', NULL),
(135, 98, 1, 'zphs', 'kjfo', NULL),
(136, 99, 1, 'zphs', 'kjfo', NULL),
(137, 99, 1, 'Another School', 'Cool stuff', NULL),
(138, 97, 5, 'IUPUI', 'Mathematics', NULL),
(140, 112, 2, 'Ivy Tech Community College', 'General Studies', 2017),
(141, 117, 2, 'Ivy Tech Community College', 'General Studies', 2017),
(142, 119, 7, 'Definitely a real degree', 'Yes, I majored in something and got a masters', 2017),
(151, 128, 7, 'World 8-4', 'Saving Princesses', 1983),
(152, 129, 1, 'World 1-1', 'Walking left, then right', 1983),
(155, 132, 1, 'World 1-1', 'Being Stomped On', 1983),
(158, 114, 6, 'Compe386', 'Checking Emails', 2005),
(161, 134, 1, 'The School of Hard Knocks', 'Testing things', 2011),
(168, 139, 1, 'SQL Injection', 'Sanitized Inputs', 2018),
(171, 142, 1, 'Pike High School', 'General Studies', 1999),
(172, 96, 1, 'NHS', 'Academic Honors', 2005),
(173, 143, 2, 'Test School', 'Test University', 1999),
(177, 149, 4, 'Sample school', 'new entry', 2005),
(178, 140, 1, 'Some kind of school', 'Studying', 2008),
(184, 132, 1, 'Andrew&#39;s School', 'Something', 2018),
(185, 132, 2, 'Another School', 'Coding, I guess', 2018),
(186, 159, 1, 'NES', 'Honors', 2013),
(187, 159, 4, 'Purdue', 'MET', 2005),
(190, 159, 4, 'Purdue', 'honors', 2005),
(191, 159, 6, 'Purdue', 'Nursing', 2009),
(192, 159, 4, 'Purdue', 'honors', 2005),
(193, 159, 6, 'Purdue', 'Nursing', 2009),
(194, 160, 1, 'Abby School', 'Guitar', 2004),
(195, 160, 2, 'New England School of Chowder', 'Cooking', 2011),
(197, 159, 2, 'Ivy Tech', 'Nursing', 2005),
(198, 161, 4, 'Server stuff', 'Makin&#39; stuff work', 1980),
(199, 162, 1, 'Server stuff', 'Makin&#39; stuff work', 2004),
(202, 165, 4, 'IUPUI', 'CS', 2020),
(203, 166, 1, 'Ivy Tech Community College', 'General Studies', 2016),
(204, 167, 1, 'School', 'Major', 2009);

-- --------------------------------------------------------

--
-- Structure for view `AVAILABLE_MENTEES`
--
DROP TABLE IF EXISTS `AVAILABLE_MENTEES`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `AVAILABLE_MENTEES` AS select `USER`.`ID` AS `ID`,`USER`.`Username` AS `Username`,`USER`.`Email` AS `Email`,`USER`.`FirstName` AS `FirstName`,`USER`.`MiddleName` AS `MiddleName`,`USER`.`LastName` AS `LastName`,`USER`.`Gender` AS `Gender`,`USER`.`Address` AS `Address`,`USER`.`City` AS `City`,`USER`.`StateProvince` AS `StateProvince`,`STATES_PROVINCES`.`Name` AS `StateProvinceFromID`,`COUNTRY`.`Name` AS `Country`,`USER`.`SeekingMentorship` AS `SeekingMentorship`,`USER`.`SeekingMenteeship` AS `SeekingMenteeship`,`USER`.`ResumeURL` AS `ResumeURL`,`USER`.`ImageURL` AS `ImageURL`,`USER`.`FacebookURL` AS `FacebookURL`,`USER`.`LinkedInURL` AS `LinkedInURL`,`USER`.`TwitterURL` AS `TwitterURL`,`USER`.`ResetPIN` AS `ResetPIN`,`PAIRED_MENTEES`.`Pairs` AS `Pairs` from (((`USER` left join `STATES_PROVINCES` on((`STATES_PROVINCES`.`ID` = `USER`.`StateProvinceID`))) join `COUNTRY` on((`COUNTRY`.`ID` = `USER`.`CountryID`))) left join `PAIRED_MENTEES` on((`PAIRED_MENTEES`.`MenteeID` = `USER`.`ID`))) where (((`USER`.`SeekingMentorship` = 1) and isnull(`PAIRED_MENTEES`.`Pairs`)) or (`PAIRED_MENTEES`.`Pairs` = 0));

-- --------------------------------------------------------

--
-- Structure for view `AVAILABLE_MENTORS`
--
DROP TABLE IF EXISTS `AVAILABLE_MENTORS`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `AVAILABLE_MENTORS` AS select `USER`.`ID` AS `ID`,`USER`.`Username` AS `Username`,`USER`.`Email` AS `Email`,`USER`.`FirstName` AS `FirstName`,`USER`.`MiddleName` AS `MiddleName`,`USER`.`LastName` AS `LastName`,`USER`.`Gender` AS `Gender`,`USER`.`Address` AS `Address`,`USER`.`City` AS `City`,`USER`.`StateProvince` AS `StateProvince`,`STATES_PROVINCES`.`Name` AS `StateProvinceFromID`,`COUNTRY`.`Name` AS `Country`,`USER`.`SeekingMentorship` AS `SeekingMentorship`,`USER`.`SeekingMenteeship` AS `SeekingMenteeship`,`USER`.`ResumeURL` AS `ResumeURL`,`USER`.`ImageURL` AS `ImageURL`,`USER`.`FacebookURL` AS `FacebookURL`,`USER`.`LinkedInURL` AS `LinkedInURL`,`USER`.`TwitterURL` AS `TwitterURL`,`USER`.`ResetPIN` AS `ResetPIN` from ((`USER` left join `STATES_PROVINCES` on((`STATES_PROVINCES`.`ID` = `USER`.`StateProvinceID`))) join `COUNTRY` on((`COUNTRY`.`ID` = `USER`.`CountryID`))) where (`USER`.`SeekingMenteeship` = 1);

-- --------------------------------------------------------

--
-- Structure for view `DOWNLOADABLE_USERS`
--
DROP TABLE IF EXISTS `DOWNLOADABLE_USERS`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `DOWNLOADABLE_USERS` AS select `USER`.`ID` AS `ID`,`USER`.`Username` AS `Username`,`USER`.`Email` AS `Email`,`USER`.`FirstName` AS `FirstName`,`USER`.`MiddleName` AS `MiddleName`,`USER`.`LastName` AS `LastName`,`USER`.`Gender` AS `Gender`,`USER`.`BirthYear` AS `BirthYear`,`USER`.`ZipCode` AS `ZipCode`,`USER`.`Phone` AS `Phone`,`USER`.`Address` AS `Address`,`USER`.`City` AS `City`,`USER`.`StateProvinceID` AS `StateProvinceID`,`USER`.`StateProvince` AS `StateProvince`,`USER`.`CountryID` AS `CountryID`,`USER`.`SeekingMentorship` AS `SeekingMentorship`,`USER`.`SeekingMenteeship` AS `SeekingMenteeship`,`USER`.`WorkStatus` AS `WorkStatus`,`USER`.`Employer` AS `Employer`,`USER`.`Field` AS `Field`,`USER`.`ResumeURL` AS `ResumeURL`,`USER`.`ImageURL` AS `ImageURL`,`USER`.`FacebookURL` AS `FacebookURL`,`USER`.`LinkedInURL` AS `LinkedInURL`,`USER`.`TwitterURL` AS `TwitterURL`,`USER`.`Activated` AS `Activated`,`USER`.`RegisterDate` AS `RegisterDate`,`COUNTRY`.`Name` AS `Country`,`STATES_PROVINCES`.`Name` AS `StateProvinceFromID`,(year(now()) - `USER`.`BirthYear`) AS `ApproxAge` from ((`USER` left join `COUNTRY` on((`COUNTRY`.`ID` = `USER`.`CountryID`))) left join `STATES_PROVINCES` on((`STATES_PROVINCES`.`ID` = `USER`.`StateProvinceID`)));

-- --------------------------------------------------------

--
-- Structure for view `PAIRED_MENTEES`
--
DROP TABLE IF EXISTS `PAIRED_MENTEES`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `PAIRED_MENTEES` AS select `MENTOR_HISTORY`.`MenteeID` AS `MenteeID`,count(0) AS `Pairs` from `MENTOR_HISTORY` where ((`MENTOR_HISTORY`.`StartDate` is not null) and isnull(`MENTOR_HISTORY`.`EndDate`) and isnull(`MENTOR_HISTORY`.`RejectDate`)) group by `MENTOR_HISTORY`.`MenteeID`;

-- --------------------------------------------------------

--
-- Structure for view `READABLE_ACTIVATED_USERS`
--
DROP TABLE IF EXISTS `READABLE_ACTIVATED_USERS`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `READABLE_ACTIVATED_USERS` AS select `USER`.`ID` AS `ID`,`USER`.`Username` AS `Username`,`USER`.`Password` AS `Password`,`USER`.`Email` AS `Email`,`USER`.`FirstName` AS `FirstName`,`USER`.`MiddleName` AS `MiddleName`,`USER`.`LastName` AS `LastName`,`USER`.`Gender` AS `Gender`,`USER`.`BirthYear` AS `BirthYear`,`USER`.`ZipCode` AS `ZipCode`,`USER`.`Phone` AS `Phone`,`USER`.`Address` AS `Address`,`USER`.`City` AS `City`,`USER`.`StateProvinceID` AS `StateProvinceID`,`USER`.`StateProvince` AS `StateProvince`,`USER`.`CountryID` AS `CountryID`,`USER`.`SeekingMentorship` AS `SeekingMentorship`,`USER`.`SeekingMenteeship` AS `SeekingMenteeship`,`USER`.`WorkStatus` AS `WorkStatus`,`USER`.`Employer` AS `Employer`,`USER`.`Field` AS `Field`,`USER`.`ResumeURL` AS `ResumeURL`,`USER`.`ImageURL` AS `ImageURL`,`USER`.`FacebookURL` AS `FacebookURL`,`USER`.`LinkedInURL` AS `LinkedInURL`,`USER`.`TwitterURL` AS `TwitterURL`,`USER`.`ResetPIN` AS `ResetPIN`,`USER`.`Activated` AS `Activated`,`USER`.`ActivationCode` AS `ActivationCode`,`USER`.`RegisterDate` AS `RegisterDate`,`COUNTRY`.`Name` AS `Country`,`STATES_PROVINCES`.`Name` AS `StateProvinceFromID`,(year(now()) - `USER`.`BirthYear`) AS `ApproxAge` from ((`USER` left join `COUNTRY` on((`COUNTRY`.`ID` = `USER`.`CountryID`))) left join `STATES_PROVINCES` on((`STATES_PROVINCES`.`ID` = `USER`.`StateProvinceID`))) where (`USER`.`Activated` = 1);

-- --------------------------------------------------------

--
-- Structure for view `READABLE_MENTOR_HISTORY`
--
DROP TABLE IF EXISTS `READABLE_MENTOR_HISTORY`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `READABLE_MENTOR_HISTORY` AS select `MENTOR_HISTORY`.`ID` AS `RecordID`,`MENTEE`.`ID` AS `MenteeID`,`MENTEE`.`Email` AS `MenteeEmail`,`MENTEE`.`FirstName` AS `MenteeFirstName`,`MENTEE`.`LastName` AS `MenteeLastName`,`MENTEE`.`Phone` AS `MenteePhone`,`MENTEE`.`Address` AS `MenteeAddress`,`MENTEE`.`City` AS `MenteeCity`,`MENTEE`.`StateProvince` AS `MenteeStateProvince`,`MENTEECOUNTRY`.`Name` AS `MenteeCountry`,`MENTOR`.`ID` AS `MentorID`,`MENTOR`.`Email` AS `MentorEmail`,`MENTOR`.`FirstName` AS `MentorFirstName`,`MENTOR`.`LastName` AS `MentorLastName`,`MENTOR`.`Phone` AS `MentorPhone`,`MENTOR`.`Address` AS `MentorAddress`,`MENTOR`.`City` AS `MentorCity`,`MENTOR`.`StateProvince` AS `MentorStateProvince`,`MENTORCOUNTRY`.`Name` AS `MentorCountry`,`MENTOR_HISTORY`.`StartDate` AS `StartDate`,`MENTOR_HISTORY`.`EndDate` AS `EndDate`,`MENTOR_HISTORY`.`RejectDate` AS `RejectDate`,`MENTOR_HISTORY`.`RequestDate` AS `RequestDate`,`REQUESTER`.`Email` AS `RequesterEmail` from (((((`MENTOR_HISTORY` join `USER` `MENTOR` on((`MENTOR_HISTORY`.`MentorID` = `MENTOR`.`ID`))) join `USER` `MENTEE` on((`MENTOR_HISTORY`.`MenteeID` = `MENTEE`.`ID`))) join `USER` `REQUESTER` on((`MENTOR_HISTORY`.`RequestedBy` = `REQUESTER`.`ID`))) join `COUNTRY` `MENTEECOUNTRY` on((`MENTEE`.`CountryID` = `MENTEECOUNTRY`.`ID`))) join `COUNTRY` `MENTORCOUNTRY` on((`MENTOR`.`CountryID` = `MENTORCOUNTRY`.`ID`)));

-- --------------------------------------------------------

--
-- Structure for view `READABLE_PAIRED_MENTEES`
--
DROP TABLE IF EXISTS `READABLE_PAIRED_MENTEES`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `READABLE_PAIRED_MENTEES` AS select `PAIRED_MENTEES`.`MenteeID` AS `MenteeID`,`PAIRED_MENTEES`.`Pairs` AS `Pairs`,`USER`.`Email` AS `MenteeEmail` from (`PAIRED_MENTEES` join `USER` on((`PAIRED_MENTEES`.`MenteeID` = `USER`.`ID`)));

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ADMIN`
--
ALTER TABLE `ADMIN`
  ADD CONSTRAINT `ADMIN_ibfk_1` FOREIGN KEY (`TypeID`) REFERENCES `ADMIN_TYPE` (`ID`);

--
-- Constraints for table `LAB_STATUS`
--
ALTER TABLE `LAB_STATUS`
  ADD CONSTRAINT `LAB_STATUS_ibfk_2` FOREIGN KEY (`StatusID`) REFERENCES `LAB_STATUS_TYPES` (`ID`),
  ADD CONSTRAINT `LAB_STATUS_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `LAB_USER` (`ID`);

--
-- Constraints for table `LAB_USER`
--
ALTER TABLE `LAB_USER`
  ADD CONSTRAINT `LAB_USER_ibfk_2` FOREIGN KEY (`DepartmentID`) REFERENCES `LAB_DEPARTMENT` (`ID`),
  ADD CONSTRAINT `LAB_USER_ibfk_1` FOREIGN KEY (`GenderID`) REFERENCES `LAB_GENDER` (`ID`);

--
-- Constraints for table `MENTOR_HISTORY`
--
ALTER TABLE `MENTOR_HISTORY`
  ADD CONSTRAINT `MENTOR_HISTORY_ibfk_1` FOREIGN KEY (`MentorID`) REFERENCES `USER` (`ID`),
  ADD CONSTRAINT `MENTOR_HISTORY_ibfk_2` FOREIGN KEY (`MenteeID`) REFERENCES `USER` (`ID`),
  ADD CONSTRAINT `MENTOR_HISTORY_ibfk_3` FOREIGN KEY (`RequestedBy`) REFERENCES `USER` (`ID`);

--
-- Constraints for table `PHONE`
--
ALTER TABLE `PHONE`
  ADD CONSTRAINT `PHONE_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `USER` (`ID`);

--
-- Constraints for table `SOCIAL_MEDIA_LINK`
--
ALTER TABLE `SOCIAL_MEDIA_LINK`
  ADD CONSTRAINT `SOCIAL_MEDIA_LINK_ibfk_2` FOREIGN KEY (`LinkTypeID`) REFERENCES `SOCIAL_MEDIA_LINK_TYPES` (`ID`),
  ADD CONSTRAINT `SOCIAL_MEDIA_LINK_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `USER` (`ID`);

--
-- Constraints for table `STATES_PROVINCES`
--
ALTER TABLE `STATES_PROVINCES`
  ADD CONSTRAINT `STATES_PROVINCES_ibfk_1` FOREIGN KEY (`CountryID`) REFERENCES `COUNTRY` (`ID`);

--
-- Constraints for table `USER`
--
ALTER TABLE `USER`
  ADD CONSTRAINT `USER_ibfk_1` FOREIGN KEY (`StateProvinceID`) REFERENCES `STATES_PROVINCES` (`ID`),
  ADD CONSTRAINT `USER_ibfk_2` FOREIGN KEY (`CountryID`) REFERENCES `COUNTRY` (`ID`);

--
-- Constraints for table `USER_EDUCATION`
--
ALTER TABLE `USER_EDUCATION`
  ADD CONSTRAINT `USER_EDUCATION_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `USER` (`ID`),
  ADD CONSTRAINT `USER_EDUCATION_ibfk_2` FOREIGN KEY (`Type`) REFERENCES `EDUCATION_TYPE` (`ID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

