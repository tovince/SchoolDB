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
