CREATE TABLE `department` (
	`dep_name` varchar(20) NOT NULL,
	`address` varchar(20) NOT NULL,
	`phone` varchar(16),
	PRIMARY KEY (`dep_name`)
) DEFAULT CHARSET=gbk;

CREATE TABLE `doctor` (
	`doc_id` varchar(8) NOT NULL,
	`doc_name` varchar(20) NOT NULL,
	`DOB` date NOT NULL,
	`position` varchar(16) NOT NULL,
	`dep_name` varchar(20) NOT NULL,
	`hiredate` date NOT NULL,
	PRIMARY KEY (`doc_id`),
	FOREIGN KEY (`dep_name`) REFERENCES department(`dep_name`)
) DEFAULT CHARSET=gbk;

CREATE TABLE `patient` (
	`pat_id` varchar(16) NOT NULL,
	`pat_name` varchar(20) NOT NULL,
	`bed` varchar(16),
	`doc_id` varchar(8) NOT NULL,
	`diagnosis` varchar(64) NOT NULL,
	PRIMARY KEY (`pat_id`),
	FOREIGN KEY (`doc_id`) REFERENCES doctor(`doc_id`)
) DEFAULT CHARSET=gbk;

CREATE TABLE `belongs` (
	`doc_id` varchar(8) NOT NULL,
	`dep_name` varchar(20) NOT NULL,
	PRIMARY KEY (`doc_id`),
	FOREIGN KEY (`doc_id`) REFERENCES doctor(`doc_id`),
	FOREIGN KEY (`dep_name`) REFERENCES department(`dep_name`)
) DEFAULT CHARSET=gbk;

CREATE TABLE `diagnose` (
	`pat_id` varchar(16) NOT NULL,
	`doc_id` varchar(8) NOT NULL,
	PRIMARY KEY (`pat_id`),
	FOREIGN KEY (`pat_id`) REFERENCES patient(`pat_id`),
	FOREIGN KEY (`doc_id`) REFERENCES doctor(`doc_id`)
) DEFAULT CHARSET=gbk;
