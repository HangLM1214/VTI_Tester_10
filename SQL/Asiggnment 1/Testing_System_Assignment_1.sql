DROP DATABASE IF EXISTS exam_system;
CREATE DATABASE exam_system;
USE exam_system;

CREATE TABLE department(
department_id 	INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
department_name VARCHAR(100)
);
CREATE TABLE `positon`(
position_id 	INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
position_name 	ENUM('dev', 'test', 'scrum master', 'pm')
);
CREATE TABLE `account`(
account_id 		INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
email 			VARCHAR(150) UNIQUE KEY,
user_name 		VARCHAR(50) UNIQUE KEY,
full_name 		VARCHAR(50),
department_id 	INT UNSIGNED,
FOREIGN KEY (department_id) REFERENCES department(department_id),
position_id 	INT UNSIGNED,
FOREIGN KEY (position_id) REFERENCES `positon`(position_id),
create_date 	DATE
);
CREATE TABLE `group`(
group_id 		INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
group_name 		VARCHAR(150),
creator_id 		INT UNSIGNED,
FOREIGN KEY(creator_id) REFERENCES `account`(account_id),
creater_date 	DATE
);
CREATE TABLE group_account(
group_id 	INT UNSIGNED,
account_id 	INT UNSIGNED,
join_date 	DATE,
PRIMARY KEY(group_id, account_id),
FOREIGN KEY(group_id) REFERENCES `group`(group_id),
FOREIGN KEY(account_id) REFERENCES `account`(account_id)
);
CREATE TABLE type_question(
type_id 	INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
type_name 	ENUM('essay', 'multiple-choice')
);
CREATE TABLE category_question(
category_id 	INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
category_name 	VARCHAR(50)
);
CREATE TABLE question(
question_id 	INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
content 		VARCHAR(1000),
category_id 	INT UNSIGNED,
FOREIGN KEY (category_id) REFERENCES category_question(category_id),
type_id 		INT UNSIGNED,
FOREIGN KEY (type_id) REFERENCES type_question(type_id),
creator_id 		INT UNSIGNED,
FOREIGN KEY (creator_id) REFERENCES `account`(account_id),
create_date 	DATE
);
CREATE TABLE answer(
answer_id 		INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
content 		VARCHAR(256),
question_id 	INT UNSIGNED,
is_correct 		BOOLEAN,
FOREIGN KEY (question_id ) REFERENCES question(question_id )
);
CREATE TABLE exam(
exam_id 		INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
`code` 			VARCHAR(50),
title 			VARCHAR(50),
category_id 	INT UNSIGNED,
FOREIGN KEY (category_id) REFERENCES category_question(category_id),
duration 		TIME,
creator_id 		INT UNSIGNED,
FOREIGN KEY (creator_id) REFERENCES `account`(account_id),
create_date		DATE
);
CREATE TABLE exam_question(
exam_id 		INT UNSIGNED,
question_id 	INT UNSIGNED,
PRIMARY KEY(exam_id, question_id),
FOREIGN KEY (exam_id) REFERENCES exam(exam_id),
FOREIGN KEY (question_id) REFERENCES question(question_id)
);