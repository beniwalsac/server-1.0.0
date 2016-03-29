drop database if exists cop290;
create database if not exists cop290;
use cop290;
select database();

CREATE TABLE IF NOT EXISTS user_details (
         -- ID    		INT UNSIGNED NOT NULL AUTO_INCREMENT,
         username  	VARCHAR(20)  NOT NULL DEFAULT '',
         first_name VARCHAR(20)  NOT NULL DEFAULT '',
         last_name 	VARCHAR(20)  NOT NULL DEFAULT '',
         password	VARCHAR(20)  NOT NULL DEFAULT '',
         type_user  INT UNSIGNED NOT NULL DEFAULT 0,
         -- 0-student, 1- faculty, 2- worker
         special   	INT UNSIGNED NOT NULL DEFAULT 0,
         -- 0-not special, 1-special
         api_key	CHAR(32) NOT NULL DEFAULT '',
         PRIMARY KEY  (username)
       );

/*
INSERT INTO user_details (username, first_name, last_name, password, type_user, special) VALUES
         ('cs1140212', 'Aryan', 'Garg', 'aryangarg', 0, 0),
         ('cs1110200', 'Shubham', 'Jindal', 'shubham jindal', 1, 1),
         ('cs1140220', 'Gurtej', 'Sohi', 'gurtejsohi', 0, 0),
         ('vinay', 'Vinay', 'Rebeiro', 'vinay', 1, 1),
         ('cs1140250', 'Sachin', 'Beniwal', 'sachin', 0, 0),
         ('electrician', 'e', 'n', 'elec', 2, 0);
*/

CREATE TABLE IF NOT EXISTS public_complaints (
         compID    		INT UNSIGNED NOT NULL AUTO_INCREMENT,
         -- userID  		INT UNSIGNED NOT NULL,	-- userID of the person who filed the complaint
         username  		VARCHAR(20)  NOT NULL DEFAULT '',
         -- addresseeID 	INT UNSIGNED NOT NULL,
         addressee  	VARCHAR(20)  NOT NULL DEFAULT '',
         complaint 		VARCHAR(1000) NOT NULL DEFAULT '',
         hostel			VARCHAR(20) NOT NULL DEFAULT '',
         cTimeStamp		TIMESTAMP DEFAULT NOW(),
         votes  		INT UNSIGNED NOT NULL DEFAULT 0,
         comp_status	VARCHAR(10)   NOT NULL DEFAULT '',
         PRIMARY KEY  (compID)
       );
/*       
INSERT INTO public_complaints (username,  addressee, complaint, hostel, votes, comp_status) VALUES
         ('cs1110200', 'electrician', 'mess fan not working', 'vindhyanchal', 0, 0),
         ('cs1140212', 'vinay', 'assignment is taking so much time. plz postpone the deadline', 'insti', 7, 0),
         ('cs1140212', 'electrician', 'toaster not working', 'udaigiri', 0, 0);
*/         
ALTER TABLE public_complaints
       ADD FOREIGN KEY (username) REFERENCES user_details (username);

       
/*
SELECT user_details.username, first_name, complaint, addressee 
       FROM user_details, public_complaints 
       WHERE user_details.username = public_complaints.username;
*/


CREATE TABLE IF NOT EXISTS individual_complaints (
         compID    		INT UNSIGNED NOT NULL AUTO_INCREMENT,
         -- userID  		INT UNSIGNED NOT NULL,	-- userID of the person who filed the complaint
         username  		VARCHAR(20)  NOT NULL DEFAULT '',
         -- addresseeID 	INT UNSIGNED NOT NULL,
         addressee  	VARCHAR(20)  NOT NULL DEFAULT '',
         complaint 		VARCHAR(1000) NOT NULL DEFAULT '',
         cTimeStamp		TIMESTAMP DEFAULT NOW(),
         comp_status	VARCHAR(10)   NOT NULL DEFAULT '',
         PRIMARY KEY  (compID)
       );
       /*
INSERT INTO individual_complaints (username,  addressee, complaint, comp_status) VALUES
         ('cs1140220', 'electrician', 'fan not working', 0),
         ('vinay', 'electrician', 'ac needs to be repaired', 0),
         ('cs1140250', 'electrician', 'tubelight not working', 0);          
         */
ALTER TABLE individual_complaints
       ADD FOREIGN KEY (username) REFERENCES user_details (username);


CREATE TABLE IF NOT EXISTS pub_comp_comments (
         compID    		INT UNSIGNED NOT NULL,
         -- userID		INT UNSIGNED NOT NULL,
         username  		VARCHAR(20)  NOT NULL DEFAULT '',
         comments 		VARCHAR(1000) NOT NULL DEFAULT '',
         cTimeStamp		TIMESTAMP DEFAULT NOW(),
         s_no    		INT UNSIGNED NOT NULL AUTO_INCREMENT,
         PRIMARY KEY  (s_no)
       );
/*
INSERT INTO pub_comp_comments (compID, username,  comments) VALUES
         (1, 'cs1140220', 'jaldi theek karo. garmi lag rhi hai'),
         (2, 'cs1140250', 'haan aur time chahiye'),
         (2, 'cs1140220', '1 din aur do'); 
*/
ALTER TABLE pub_comp_comments
       ADD FOREIGN KEY (compID) REFERENCES public_complaints (compID);


CREATE TABLE IF NOT EXISTS ind_comp_comments (
         compID    		INT UNSIGNED NOT NULL,
         -- userID		INT UNSIGNED NOT NULL,
         username  		VARCHAR(20)  NOT NULL DEFAULT '',
         comments 		VARCHAR(1000) NOT NULL DEFAULT '',
         cTimeStamp		TIMESTAMP DEFAULT NOW(),
         s_no    		INT UNSIGNED NOT NULL AUTO_INCREMENT,
         PRIMARY KEY  (s_no)
       );
/*
INSERT INTO pub_comp_comments (compID, username,  comments) VALUES
         (1, 'cs1140220', 'jaldi theek karo. garmi lag rhi hai'),
         (2, 'cs1140250', 'haan aur time chahiye'),
         (2, 'cs1140220', '1 din aur do'); 
*/
ALTER TABLE pub_comp_comments
       ADD FOREIGN KEY (compID) REFERENCES public_complaints (compID);


CREATE TABLE IF NOT EXISTS ind_comp_comments (
         compID    		INT UNSIGNED NOT NULL,
         -- userID		INT UNSIGNED NOT NULL,
         username  		VARCHAR(20)  NOT NULL DEFAULT '',
         comments 		VARCHAR(1000) NOT NULL DEFAULT '',
         cTimeStamp		TIMESTAMP DEFAULT NOW(),
         s_no    		INT UNSIGNED NOT NULL AUTO_INCREMENT,
         PRIMARY KEY  (s_no)
       );
ALTER TABLE ind_comp_comments
       ADD FOREIGN KEY (compID) REFERENCES individual_complaints (compID);
       

CREATE TABLE IF NOT EXISTS groups_n_rights (
         -- userID    		INT UNSIGNED NOT NULL,
         username  		VARCHAR(20)  NOT NULL DEFAULT '',
         groups			VARCHAR(20) NOT NULL DEFAULT '',
         res_right		bool NOT NULL DEFAULT false,
         s_no    		INT UNSIGNED NOT NULL AUTO_INCREMENT,
         PRIMARY KEY  (s_no)
       );
/*
INSERT INTO groups_n_rights (username, groups, res_right) VALUES
         ('cs1140212', 'Satpura', 0),
         ('cs1110200', 'Vindhyanchal', 1),
         ('cs1140220', 'Udaigiri', 0),
         ('vinay', 'Satpura', 1),
         ('vinay', 'Vindhyanchal', 1),
         ('vinay', 'Udaigiri', 1),
         ('vinay', 'Girnar', 1),
         ('cs1140250', 'Udaigiri', 0);
*/
ALTER TABLE groups_n_rights
       ADD FOREIGN KEY (username) REFERENCES user_details (username);