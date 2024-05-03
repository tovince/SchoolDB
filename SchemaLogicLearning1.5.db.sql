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
	FOREIGN KEY("parentID") REFERENCES "Parents",
	FOREIGN KEY("studentID") REFERENCES "Students",
	PRIMARY KEY("studentParentID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "TuitionRecord" (
	"tuitionID"	INTEGER NOT NULL,
	"studentID"	INTEGER,
	"subjectID"	INTEGER,
	"teacherID"	INTEGER,
	"hours"	REAL,
	FOREIGN KEY("subjectID") REFERENCES "Subjects",
	FOREIGN KEY("studentID") REFERENCES "Students",
	FOREIGN KEY("teacherID") REFERENCES "Teachers",
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
CREATE TABLE IF NOT EXISTS "StudentTeacherSubject" (
	"studentTeacherSubjectID"	INTEGER NOT NULL,
	"studentID"	INTEGER,
	"teacherID"	INTEGER,
	"subjectID"	INTEGER,
	FOREIGN KEY("teacherID") REFERENCES "Teachers",
	FOREIGN KEY("subjectID") REFERENCES "Subjects",
	FOREIGN KEY("studentID") REFERENCES "Students",
	PRIMARY KEY("studentTeacherSubjectID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "StudentSubject" (
	"studentSubjectID"	INTEGER NOT NULL,
	"studentID"	INTEGER,
	"subjectID"	INTEGER,
	"tuitionTypeID"	INTEGER,
	FOREIGN KEY("studentID") REFERENCES "Students",
	FOREIGN KEY("subjectID") REFERENCES "Subjects",
	FOREIGN KEY("tuitionTypeID") REFERENCES "TuitionType",
	PRIMARY KEY("studentSubjectID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "TuitionType" (
	"tuitionFeeID"	INTEGER NOT NULL,
	"TuitionName"	TEXT,
	"hourlyRate"	REAL,
	"startDate"	TEXT,
	"endDate"	TEXT,
	PRIMARY KEY("tuitionFeeID" AUTOINCREMENT)
);
CREATE VIEW StudentParentNamesView AS
SELECT 
    s.studentFirstName AS StudentFirstName,
    s.studentLastName AS StudentLastName,
    p.parentFirstName AS ParentFirstName,
    p.parentLastName AS ParentLastName
FROM 
    StudentParent sp
JOIN 
    Students s ON sp.studentID = s.studentID
JOIN 
    Parents p ON sp.parentID = p.parentID;
CREATE VIEW StudentTeacherSubjectNames AS
SELECT 
    s.studentID AS studentID,
    s.studentFirstName AS StudentFirstName,
    s.studentLastName AS StudentLastName,
    t.teacherID AS teacherID,
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
