BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "Subjects" (
	"subjectID"	INTEGER NOT NULL,
	"subjectName"	TEXT,
	PRIMARY KEY("subjectID")
);
CREATE TABLE IF NOT EXISTS "Payroll" (
	"payrollID"	INTEGER NOT NULL,
	"teacherID"	INTEGER,
	"monthYear"	TEXT,
	"totalHoursWorked"	NUMERIC,
	"totalPay"	NUMERIC,
	PRIMARY KEY("payrollID" AUTOINCREMENT),
	FOREIGN KEY("teacherID") REFERENCES "Teachers"
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
	PRIMARY KEY("creditHistoryID" AUTOINCREMENT),
	FOREIGN KEY("studentID") REFERENCES "Students"
);
CREATE TABLE IF NOT EXISTS "StudentParent" (
	"studentParentID"	INTEGER NOT NULL,
	"studentID"	INTEGER,
	"parentID"	INTEGER,
	PRIMARY KEY("studentParentID" AUTOINCREMENT),
	FOREIGN KEY("studentID") REFERENCES "Students",
	FOREIGN KEY("parentID") REFERENCES "Parents"
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
CREATE TABLE IF NOT EXISTS "StudentTeacherSubject" (
	"studentTeacherSubjectID"	INTEGER NOT NULL,
	"studentID"	INTEGER,
	"teacherID"	INTEGER,
	"subjectID"	INTEGER,
	PRIMARY KEY("studentTeacherSubjectID" AUTOINCREMENT),
	FOREIGN KEY("teacherID") REFERENCES "Teachers",
	FOREIGN KEY("studentID") REFERENCES "Students",
	FOREIGN KEY("subjectID") REFERENCES "Subjects"
);
CREATE TABLE IF NOT EXISTS "StudentSubject" (
	"studentSubjectID"	INTEGER NOT NULL,
	"studentID"	INTEGER,
	"subjectID"	INTEGER,
	"tuitionTypeID"	INTEGER,
	PRIMARY KEY("studentSubjectID" AUTOINCREMENT),
	FOREIGN KEY("studentID") REFERENCES "Students",
	FOREIGN KEY("subjectID") REFERENCES "Subjects",
	FOREIGN KEY("tuitionTypeID") REFERENCES "TuitionType"
);
CREATE TABLE IF NOT EXISTS "TuitionType" (
	"tuitionFeeID"	INTEGER NOT NULL,
	"TuitionName"	TEXT,
	"hourlyRate"	REAL,
	"startDate"	TEXT,
	"endDate"	TEXT,
	PRIMARY KEY("tuitionFeeID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Teachers" (
	"teacherID"	INTEGER NOT NULL,
	"teacherFirstName"	TEXT NOT NULL,
	"teacherLastName"	TEXT NOT NULL,
	"teacherEmail"	TEXT NOT NULL,
	"teacherPhone"	INTEGER NOT NULL,
	"country"	TEXT,
	"meetingLink"	TEXT,
	PRIMARY KEY("teacherID")
);
CREATE TABLE IF NOT EXISTS "StaffAvailability" (
	"ID"	int,
	"teacherID"	int,
	"DayOfWeek"	varchar(50),
	"StartTime"	time,
	"EndTime"	time,
	PRIMARY KEY("ID"),
	FOREIGN KEY("teacherID") REFERENCES "Teachers"("teacherID")
);
CREATE TABLE IF NOT EXISTS "TuitionRecord" (
	"tuitionID"	INTEGER NOT NULL,
	"date"	TEXT,
	"duration"	INTEGER,
	"studentID"	NUMERIC,
	"subjectID"	INTEGER,
	"teacherID"	INTEGER,
	"studentTeacherSubjectID"	INTEGER,
	PRIMARY KEY("tuitionID" AUTOINCREMENT),
	FOREIGN KEY("subjectID") REFERENCES "Subjects",
	FOREIGN KEY("studentID") REFERENCES "Students",
	FOREIGN KEY("teacherID") REFERENCES "Teachers"
);
CREATE TABLE IF NOT EXISTS "Invoices" (
	"invoiceID"	INTEGER,
	"studentID"	INTEGER,
	"parentID"	INTEGER,
	"dateIssued"	DATE,
	"dueDate"	DATE,
	"totalAmount"	DECIMAL(10, 2),
	"paid"	BOOLEAN,
	"dateMonthYear"	TEXT,
	PRIMARY KEY("invoiceID" AUTOINCREMENT),
	FOREIGN KEY("studentID") REFERENCES "Students"("studentID"),
	FOREIGN KEY("parentID") REFERENCES "StudentParent"("parentID")
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
INSERT INTO "Parents" ("parentID","parentFirstName","parentLastName","parentEmail","parentPhoneNumber") VALUES (9,'Dave','Sepa','sepadav@gmail.com ',NULL);
INSERT INTO "CreditHistory" ("creditHistoryID","studentID","date","credits") VALUES (1,1,'2024-03-31',3);
INSERT INTO "CreditHistory" ("creditHistoryID","studentID","date","credits") VALUES (2,1,'2024-02-28',6);
INSERT INTO "CreditHistory" ("creditHistoryID","studentID","date","credits") VALUES (3,2,'2024-04-30',0);
INSERT INTO "CreditHistory" ("creditHistoryID","studentID","date","credits") VALUES (4,3,'2024-04-30',7);
INSERT INTO "StudentParent" ("studentParentID","studentID","parentID") VALUES (1,1,1);
INSERT INTO "StudentParent" ("studentParentID","studentID","parentID") VALUES (2,2,2);
INSERT INTO "StudentParent" ("studentParentID","studentID","parentID") VALUES (3,3,3);
INSERT INTO "StudentParent" ("studentParentID","studentID","parentID") VALUES (4,6,4);
INSERT INTO "StudentParent" ("studentParentID","studentID","parentID") VALUES (5,6,5);
INSERT INTO "StudentParent" ("studentParentID","studentID","parentID") VALUES (6,7,6);
INSERT INTO "StudentParent" ("studentParentID","studentID","parentID") VALUES (7,8,7);
INSERT INTO "StudentParent" ("studentParentID","studentID","parentID") VALUES (8,8,8);
INSERT INTO "StudentParent" ("studentParentID","studentID","parentID") VALUES (9,7,9);
INSERT INTO "Students" ("studentID","studentFirstName","studentLastName","studentEmail","studentPhoneNumber","currentCredits") VALUES (1,'Dean','Lien','','',2);
INSERT INTO "Students" ("studentID","studentFirstName","studentLastName","studentEmail","studentPhoneNumber","currentCredits") VALUES (2,'Abhishek','Velgekar','abhivel24@gmail.com ','647-549-4856',0);
INSERT INTO "Students" ("studentID","studentFirstName","studentLastName","studentEmail","studentPhoneNumber","currentCredits") VALUES (3,'Simon','Tyono',NULL,NULL,7);
INSERT INTO "Students" ("studentID","studentFirstName","studentLastName","studentEmail","studentPhoneNumber","currentCredits") VALUES (4,'Edward','Yu','edwardyu295@gmail.com','416-838-1389',12);
INSERT INTO "Students" ("studentID","studentFirstName","studentLastName","studentEmail","studentPhoneNumber","currentCredits") VALUES (5,'Cathy','Yu','cccathy.yu123xcute@gmail.com','416-838-1389',14);
INSERT INTO "Students" ("studentID","studentFirstName","studentLastName","studentEmail","studentPhoneNumber","currentCredits") VALUES (6,'Nolan','Reid','nolan.r12341@gmail.com',NULL,0);
INSERT INTO "Students" ("studentID","studentFirstName","studentLastName","studentEmail","studentPhoneNumber","currentCredits") VALUES (7,'Joshua','Sepa','jsepa053@gmail.com',NULL,0);
INSERT INTO "Students" ("studentID","studentFirstName","studentLastName","studentEmail","studentPhoneNumber","currentCredits") VALUES (8,'Magnus','MacDonald',NULL,NULL,16);
INSERT INTO "StudentTeacherSubject" ("studentTeacherSubjectID","studentID","teacherID","subjectID") VALUES (1,1,1,1);
INSERT INTO "StudentTeacherSubject" ("studentTeacherSubjectID","studentID","teacherID","subjectID") VALUES (2,1,2,2);
INSERT INTO "StudentTeacherSubject" ("studentTeacherSubjectID","studentID","teacherID","subjectID") VALUES (3,2,1,1);
INSERT INTO "StudentTeacherSubject" ("studentTeacherSubjectID","studentID","teacherID","subjectID") VALUES (4,2,3,2);
INSERT INTO "StudentTeacherSubject" ("studentTeacherSubjectID","studentID","teacherID","subjectID") VALUES (5,3,4,1);
INSERT INTO "StudentTeacherSubject" ("studentTeacherSubjectID","studentID","teacherID","subjectID") VALUES (6,4,5,1);
INSERT INTO "StudentTeacherSubject" ("studentTeacherSubjectID","studentID","teacherID","subjectID") VALUES (7,4,3,2);
INSERT INTO "StudentTeacherSubject" ("studentTeacherSubjectID","studentID","teacherID","subjectID") VALUES (8,5,5,1);
INSERT INTO "StudentTeacherSubject" ("studentTeacherSubjectID","studentID","teacherID","subjectID") VALUES (9,5,3,2);
INSERT INTO "StudentTeacherSubject" ("studentTeacherSubjectID","studentID","teacherID","subjectID") VALUES (10,6,5,1);
INSERT INTO "StudentTeacherSubject" ("studentTeacherSubjectID","studentID","teacherID","subjectID") VALUES (11,7,1,1);
INSERT INTO "StudentTeacherSubject" ("studentTeacherSubjectID","studentID","teacherID","subjectID") VALUES (12,8,3,2);
INSERT INTO "StudentSubject" ("studentSubjectID","studentID","subjectID","tuitionTypeID") VALUES (1,1,1,2);
INSERT INTO "StudentSubject" ("studentSubjectID","studentID","subjectID","tuitionTypeID") VALUES (2,1,2,2);
INSERT INTO "StudentSubject" ("studentSubjectID","studentID","subjectID","tuitionTypeID") VALUES (3,2,1,2);
INSERT INTO "StudentSubject" ("studentSubjectID","studentID","subjectID","tuitionTypeID") VALUES (4,2,2,2);
INSERT INTO "StudentSubject" ("studentSubjectID","studentID","subjectID","tuitionTypeID") VALUES (5,3,1,2);
INSERT INTO "StudentSubject" ("studentSubjectID","studentID","subjectID","tuitionTypeID") VALUES (6,4,1,2);
INSERT INTO "StudentSubject" ("studentSubjectID","studentID","subjectID","tuitionTypeID") VALUES (7,4,2,2);
INSERT INTO "StudentSubject" ("studentSubjectID","studentID","subjectID","tuitionTypeID") VALUES (8,5,1,2);
INSERT INTO "StudentSubject" ("studentSubjectID","studentID","subjectID","tuitionTypeID") VALUES (9,5,2,2);
INSERT INTO "StudentSubject" ("studentSubjectID","studentID","subjectID","tuitionTypeID") VALUES (10,6,1,1);
INSERT INTO "StudentSubject" ("studentSubjectID","studentID","subjectID","tuitionTypeID") VALUES (11,7,1,1);
INSERT INTO "StudentSubject" ("studentSubjectID","studentID","subjectID","tuitionTypeID") VALUES (12,8,2,2);
INSERT INTO "TuitionType" ("tuitionFeeID","TuitionName","hourlyRate","startDate","endDate") VALUES (1,'FamilyDiscount',20.0,'2024-01-01',NULL);
INSERT INTO "TuitionType" ("tuitionFeeID","TuitionName","hourlyRate","startDate","endDate") VALUES (2,'24Sessions',26.5,'2024-01-01',NULL);
INSERT INTO "TuitionType" ("tuitionFeeID","TuitionName","hourlyRate","startDate","endDate") VALUES (3,'12Sessions',30.25,'2024-01-01',NULL);
INSERT INTO "TuitionType" ("tuitionFeeID","TuitionName","hourlyRate","startDate","endDate") VALUES (4,'4Session',32.5,'2024-01-01',NULL);
INSERT INTO "TuitionType" ("tuitionFeeID","TuitionName","hourlyRate","startDate","endDate") VALUES (5,'1Session',38.0,'2024-01-01',NULL);
INSERT INTO "Teachers" ("teacherID","teacherFirstName","teacherLastName","teacherEmail","teacherPhone","country","meetingLink") VALUES (1,'Harold','Cordova','hayoyo1994@gmail.com','+591 67307349','Bolivia','https://logic-learning.whereby.com/harold-math');
INSERT INTO "Teachers" ("teacherID","teacherFirstName","teacherLastName","teacherEmail","teacherPhone","country","meetingLink") VALUES (2,'Pablo','Arias','pablitoariasortega@gmail.com','+591 68125777','Bolivia','https://meet.google.com/qft-ngxd-bqa');
INSERT INTO "Teachers" ("teacherID","teacherFirstName","teacherLastName","teacherEmail","teacherPhone","country","meetingLink") VALUES (3,'Muhammad','Saad','m.saad.ce@gmail.com ','+92 337 8642930','Pakistan','https://meet.google.com/cap-rfug-stw');
INSERT INTO "Teachers" ("teacherID","teacherFirstName","teacherLastName","teacherEmail","teacherPhone","country","meetingLink") VALUES (4,'Manual','Vasquez','manuvasquez1@gmail.com','+502 4847 2321','Guatemala','https://logic-learning.whereby.com/manuel.v');
INSERT INTO "Teachers" ("teacherID","teacherFirstName","teacherLastName","teacherEmail","teacherPhone","country","meetingLink") VALUES (5,'Victor','Salazar','victorsalazar1997@gmail.com','+58 424-1906945','Venezuela','https://meet.google.com/had-uhie-pae');
INSERT INTO "TuitionRecord" ("tuitionID","date","duration","studentID","subjectID","teacherID","studentTeacherSubjectID") VALUES (1,'2024-01-20',60,1,1,1,1);
INSERT INTO "TuitionRecord" ("tuitionID","date","duration","studentID","subjectID","teacherID","studentTeacherSubjectID") VALUES (2,'2024-01-27',60,1,1,1,1);
INSERT INTO "TuitionRecord" ("tuitionID","date","duration","studentID","subjectID","teacherID","studentTeacherSubjectID") VALUES (3,'2024-02-03',60,1,1,1,1);
INSERT INTO "TuitionRecord" ("tuitionID","date","duration","studentID","subjectID","teacherID","studentTeacherSubjectID") VALUES (4,'2024-02-10',60,1,1,1,1);
INSERT INTO "TuitionRecord" ("tuitionID","date","duration","studentID","subjectID","teacherID","studentTeacherSubjectID") VALUES (5,'2024-02-17',60,1,1,1,1);
INSERT INTO "TuitionRecord" ("tuitionID","date","duration","studentID","subjectID","teacherID","studentTeacherSubjectID") VALUES (6,'2024-03-09',60,1,1,1,1);
INSERT INTO "TuitionRecord" ("tuitionID","date","duration","studentID","subjectID","teacherID","studentTeacherSubjectID") VALUES (7,'2024-03-16',60,1,1,1,1);
INSERT INTO "TuitionRecord" ("tuitionID","date","duration","studentID","subjectID","teacherID","studentTeacherSubjectID") VALUES (8,'2024-03-30',60,1,1,1,1);
INSERT INTO "TuitionRecord" ("tuitionID","date","duration","studentID","subjectID","teacherID","studentTeacherSubjectID") VALUES (9,'2024-01-20',60,1,2,2,2);
INSERT INTO "TuitionRecord" ("tuitionID","date","duration","studentID","subjectID","teacherID","studentTeacherSubjectID") VALUES (10,'2024-01-27',60,1,2,2,2);
INSERT INTO "TuitionRecord" ("tuitionID","date","duration","studentID","subjectID","teacherID","studentTeacherSubjectID") VALUES (11,'2024-02-17',60,1,2,2,2);
INSERT INTO "TuitionRecord" ("tuitionID","date","duration","studentID","subjectID","teacherID","studentTeacherSubjectID") VALUES (12,'2024-04-06',60,1,1,1,1);
INSERT INTO "TuitionRecord" ("tuitionID","date","duration","studentID","subjectID","teacherID","studentTeacherSubjectID") VALUES (13,'2024-04-13',60,1,1,1,1);
INSERT INTO "TuitionRecord" ("tuitionID","date","duration","studentID","subjectID","teacherID","studentTeacherSubjectID") VALUES (14,'2024-04-27',60,1,1,1,1);
INSERT INTO "TuitionRecord" ("tuitionID","date","duration","studentID","subjectID","teacherID","studentTeacherSubjectID") VALUES (15,'2024-04-13',60,1,2,2,2);
INSERT INTO "TuitionRecord" ("tuitionID","date","duration","studentID","subjectID","teacherID","studentTeacherSubjectID") VALUES (16,'2024-04-27',60,1,2,2,2);
INSERT INTO "TuitionRecord" ("tuitionID","date","duration","studentID","subjectID","teacherID","studentTeacherSubjectID") VALUES (17,'2024-05-04',60,1,1,1,1);
INSERT INTO "TuitionRecord" ("tuitionID","date","duration","studentID","subjectID","teacherID","studentTeacherSubjectID") VALUES (18,'2024-05-11',60,1,1,1,1);
INSERT INTO "TuitionRecord" ("tuitionID","date","duration","studentID","subjectID","teacherID","studentTeacherSubjectID") VALUES (19,'2024-05-18',60,1,1,1,1);
INSERT INTO "TuitionRecord" ("tuitionID","date","duration","studentID","subjectID","teacherID","studentTeacherSubjectID") VALUES (20,'2024-05-04',60,1,2,2,2);
INSERT INTO "TuitionRecord" ("tuitionID","date","duration","studentID","subjectID","teacherID","studentTeacherSubjectID") VALUES (21,'2024-05-11',60,1,2,2,2);
INSERT INTO "TuitionRecord" ("tuitionID","date","duration","studentID","subjectID","teacherID","studentTeacherSubjectID") VALUES (22,'2024-05-18',60,1,2,2,2);
CREATE TRIGGER PopulateTuitionRecord
AFTER INSERT ON TuitionRecord
FOR EACH ROW
BEGIN
    UPDATE TuitionRecord
    SET
        studentID = (SELECT studentID FROM StudentTeacherSubject WHERE studentTeacherSubjectID = NEW.studentTeacherSubjectID),
        subjectID = (SELECT subjectID FROM StudentTeacherSubject WHERE studentTeacherSubjectID = NEW.studentTeacherSubjectID),
        teacherID = (SELECT teacherID FROM StudentTeacherSubject WHERE studentTeacherSubjectID = NEW.studentTeacherSubjectID)
    WHERE tuitionID = NEW.tuitionID;
END;
CREATE VIEW StudentParentNamesView AS
SELECT 
    s.studentFirstName AS studentFirstName,
    s.studentLastName AS studentLastName,
    p.parentFirstName AS parentFirstName,
    p.parentLastName AS parentLastName,
	p.parentEmail AS parentEmail,
	p.parentPhoneNumber AS parentPhoneNumber
FROM 
    StudentParent sp
JOIN 
    Students s ON sp.studentID = s.studentID
JOIN 
    Parents p ON sp.parentID = p.parentID;
CREATE VIEW StudentTeacherSubjectNames AS
SELECT 
    sts.studentTeacherSubjectID AS STSID,
    s.studentID AS StudentID,
    s.studentFirstName AS StudentFirstName,
    s.studentLastName AS StudentLastName,
    t.teacherID AS TeacherID,
    t.teacherFirstName AS TeacherFirstName,
    t.teacherLastName AS TeacherLastName,
    sub.subjectName AS SubjectName,
    s.currentCredits AS CurrentCredits
FROM 
    StudentTeacherSubject sts
JOIN 
    Students s ON sts.studentID = s.studentID
JOIN 
    Teachers t ON sts.teacherID = t.teacherID
JOIN 
    Subjects sub ON sts.subjectID = sub.subjectID;
COMMIT;
