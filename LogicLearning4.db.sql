BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "Subjects" (
	"subjectID"	INTEGER NOT NULL,
	"subjectName"	TEXT,
	PRIMARY KEY("subjectID")
);
CREATE TABLE IF NOT EXISTS "Attendance" (
	"attendanceID"	INTEGER NOT NULL,
	"startTime"	TEXT,
	"duration"	NUMERIC,
	PRIMARY KEY("attendanceID")
);
CREATE TABLE IF NOT EXISTS "Payroll" (
	"payrollID"	INTEGER NOT NULL,
	"teacherID"	INTEGER,
	"monthYear"	TEXT,
	"totalHoursWorked"	NUMERIC,
	"totalPay"	NUMERIC,
	FOREIGN KEY("teacherID") REFERENCES "Teachers",
	PRIMARY KEY("payrollID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Parents" (
	"parentID"	INTEGER NOT NULL,
	"parentFirstName"	TEXT,
	"parentLastName"	TEXT,
	"parentEmail"	TEXT,
	"parentPhoneNumber"	TEXT,
	PRIMARY KEY("parentID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "CreditHistory" (
	"creditHistoryID"	INTEGER NOT NULL,
	"studentID"	INTEGER,
	"date"	TEXT,
	"credits"	NUMERIC,
	FOREIGN KEY("studentID") REFERENCES "Students",
	PRIMARY KEY("creditHistoryID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "StudentParent" (
	"studentParentID"	INTEGER NOT NULL,
	"studentID"	INTEGER,
	"parentID"	INTEGER,
	FOREIGN KEY("studentID") REFERENCES "Students",
	FOREIGN KEY("parentID") REFERENCES "Parents",
	PRIMARY KEY("studentParentID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "TuitionRecord" (
	"tuitionID"	INTEGER NOT NULL,
	"studentID"	INTEGER,
	"subjectID"	INTEGER,
	"teacherID"	INTEGER,
	"hours"	REAL,
	FOREIGN KEY("teacherID") REFERENCES "Teachers",
	FOREIGN KEY("studentID") REFERENCES "Students",
	FOREIGN KEY("subjectID") REFERENCES "Subjects",
	PRIMARY KEY("tuitionID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Teachers" (
	"teacherID"	INTEGER NOT NULL,
	"teacherFirstName"	TEXT NOT NULL,
	"teacherLastName"	TEXT NOT NULL,
	"teacherEmail"	TEXT NOT NULL,
	"teacherPhone"	INTEGER NOT NULL,
	"Country"	TEXT,
	PRIMARY KEY("teacherID")
);
CREATE TABLE IF NOT EXISTS "Students" (
	"studentID"	INTEGER NOT NULL,
	"studentFirstName"	TEXT NOT NULL,
	"studentLastName"	TEXT NOT NULL,
	"studentEmail"	TEXT,
	"studentPhoneNumber"	TEXT,
	"currentCredits"	NUMERIC,
	PRIMARY KEY("studentID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "TuitionType" (
	"tuitionFeeID"	INTEGER NOT NULL,
	"TuitionName"	INTEGER,
	"hourlyRate"	REAL,
	"startDate"	TEXT,
	"endDate"	TEXT,
	PRIMARY KEY("tuitionFeeID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "StudentTeacher" (
	"StudentTeacherID"	INTEGER NOT NULL,
	"studentID"	INTEGER NOT NULL,
	"teacherID"	INTEGER NOT NULL,
	FOREIGN KEY("studentID") REFERENCES "Students",
	FOREIGN KEY("teacherID") REFERENCES "Teachers",
	PRIMARY KEY("StudentTeacherID" AUTOINCREMENT)
);
INSERT INTO "Subjects" ("subjectID","subjectName") VALUES (1,'Math');
INSERT INTO "Subjects" ("subjectID","subjectName") VALUES (2,'Coding');
INSERT INTO "Subjects" ("subjectID","subjectName") VALUES (3,'Physics');
INSERT INTO "Subjects" ("subjectID","subjectName") VALUES (4,'Chemistry');
INSERT INTO "Parents" ("parentID","parentFirstName","parentLastName","parentEmail","parentPhoneNumber") VALUES (1,'Pearl','Lien','pearllien@hotmail.com','416-317-8188');
INSERT INTO "Parents" ("parentID","parentFirstName","parentLastName","parentEmail","parentPhoneNumber") VALUES (2,'Leena','Velgekar','leenaart@gmail.com','647-274-2019');
INSERT INTO "Parents" ("parentID","parentFirstName","parentLastName","parentEmail","parentPhoneNumber") VALUES (3,'Ivan','Tyono','ivant1907@gmail.com','416-278-1386');
INSERT INTO "Parents" ("parentID","parentFirstName","parentLastName","parentEmail","parentPhoneNumber") VALUES (4,'Athru','Kuan','athru.kuan@gmail.com','(647)-830-1385');
INSERT INTO "Parents" ("parentID","parentFirstName","parentLastName","parentEmail","parentPhoneNumber") VALUES (5,'Peter','Reid','peter.reid899@gmail.com','');
INSERT INTO "Parents" ("parentID","parentFirstName","parentLastName","parentEmail","parentPhoneNumber") VALUES (6,'Cindy','Trac','cindy.trac@gmail.com','416-899-6788');
INSERT INTO "Parents" ("parentID","parentFirstName","parentLastName","parentEmail","parentPhoneNumber") VALUES (7,'Yasmine','Dang','yasminedang@gmail.com','416-894-8128');
INSERT INTO "Parents" ("parentID","parentFirstName","parentLastName","parentEmail","parentPhoneNumber") VALUES (8,'Adam','MacDonald',NULL,'416-660-2627');
INSERT INTO "CreditHistory" ("creditHistoryID","studentID","date","credits") VALUES (1,1,'2024-04-01',2);
INSERT INTO "StudentParent" ("studentParentID","studentID","parentID") VALUES (1,1,1);
INSERT INTO "StudentParent" ("studentParentID","studentID","parentID") VALUES (2,2,2);
INSERT INTO "StudentParent" ("studentParentID","studentID","parentID") VALUES (3,3,3);
INSERT INTO "StudentParent" ("studentParentID","studentID","parentID") VALUES (4,6,4);
INSERT INTO "StudentParent" ("studentParentID","studentID","parentID") VALUES (5,6,5);
INSERT INTO "StudentParent" ("studentParentID","studentID","parentID") VALUES (6,7,6);
INSERT INTO "StudentParent" ("studentParentID","studentID","parentID") VALUES (7,8,7);
INSERT INTO "StudentParent" ("studentParentID","studentID","parentID") VALUES (8,8,8);
INSERT INTO "Teachers" ("teacherID","teacherFirstName","teacherLastName","teacherEmail","teacherPhone","Country") VALUES (1,'Harold','Cordova','hayoyo1994@gmail.com','+591 67307349','Bolivia');
INSERT INTO "Teachers" ("teacherID","teacherFirstName","teacherLastName","teacherEmail","teacherPhone","Country") VALUES (2,'Pablo','Arias','pablitoariasortega@gmail.com','+591 68125777','Bolivia');
INSERT INTO "Teachers" ("teacherID","teacherFirstName","teacherLastName","teacherEmail","teacherPhone","Country") VALUES (3,'Muhammad','Saad','m.saad.ce@gmail.com ','+92 337 8642930','Pakistan');
INSERT INTO "Teachers" ("teacherID","teacherFirstName","teacherLastName","teacherEmail","teacherPhone","Country") VALUES (4,'Manual','Vasquez','manuvasquez1@gmail.com','+502 4847 2321','Guatemala');
INSERT INTO "Teachers" ("teacherID","teacherFirstName","teacherLastName","teacherEmail","teacherPhone","Country") VALUES (5,'Victor','Salazar','victorsalazar1997@gmail.com','+58 424-1906945','Venezuela');
INSERT INTO "Students" ("studentID","studentFirstName","studentLastName","studentEmail","studentPhoneNumber","currentCredits") VALUES (1,'Dean','Lien','','',2);
INSERT INTO "Students" ("studentID","studentFirstName","studentLastName","studentEmail","studentPhoneNumber","currentCredits") VALUES (2,'Abhishek','Velgekar','abhivel24@gmail.com ','647-549-4856',0);
INSERT INTO "Students" ("studentID","studentFirstName","studentLastName","studentEmail","studentPhoneNumber","currentCredits") VALUES (3,'Simon','Tyono',NULL,NULL,11);
INSERT INTO "Students" ("studentID","studentFirstName","studentLastName","studentEmail","studentPhoneNumber","currentCredits") VALUES (4,'Edward','Yu','edwardyu295@gmail.com','416-838-1389',12);
INSERT INTO "Students" ("studentID","studentFirstName","studentLastName","studentEmail","studentPhoneNumber","currentCredits") VALUES (5,'Cathy','Yu','cccathy.yu123xcute@gmail.com','416-838-1389',14);
INSERT INTO "Students" ("studentID","studentFirstName","studentLastName","studentEmail","studentPhoneNumber","currentCredits") VALUES (6,'Nolan','Reid','nolan.r12341@gmail.com',NULL,0);
INSERT INTO "Students" ("studentID","studentFirstName","studentLastName","studentEmail","studentPhoneNumber","currentCredits") VALUES (7,'Joshua','Sepa','jsepa053@gmail.com',NULL,0);
INSERT INTO "Students" ("studentID","studentFirstName","studentLastName","studentEmail","studentPhoneNumber","currentCredits") VALUES (8,'Magnus','MacDonald',NULL,NULL,16);
INSERT INTO "TuitionType" ("tuitionFeeID","TuitionName","hourlyRate","startDate","endDate") VALUES (1,'FamilyDiscount',20.0,'2024-01-01',NULL);
INSERT INTO "TuitionType" ("tuitionFeeID","TuitionName","hourlyRate","startDate","endDate") VALUES (2,'24Sessions',26.5,'2024-01-01',NULL);
INSERT INTO "TuitionType" ("tuitionFeeID","TuitionName","hourlyRate","startDate","endDate") VALUES (3,'12Sessions',30.25,'2024-01-01',NULL);
INSERT INTO "TuitionType" ("tuitionFeeID","TuitionName","hourlyRate","startDate","endDate") VALUES (4,'4Session',32.5,'2024-01-01',NULL);
INSERT INTO "TuitionType" ("tuitionFeeID","TuitionName","hourlyRate","startDate","endDate") VALUES (5,'1Session',38.0,'2024-01-01',NULL);
INSERT INTO "StudentTeacher" ("StudentTeacherID","studentID","teacherID") VALUES (1,1,1);
COMMIT;
