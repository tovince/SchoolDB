BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "Teachers" (
	"teacherID"	INTEGER NOT NULL,
	"teacherFirstName"	TEXT NOT NULL,
	"teacherLastName"	TEXT NOT NULL,
	"teacherEmail"	TEXT NOT NULL,
	"teacherPhone"	INTEGER NOT NULL,
	PRIMARY KEY("teacherID")
);
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
CREATE TABLE IF NOT EXISTS "StudentTeacher" (
	"studentID"	INTEGER NOT NULL COLLATE UTF16CI,
	"teacherID"	INTEGER NOT NULL COLLATE UTF16CI,
	PRIMARY KEY("studentID","teacherID"),
	FOREIGN KEY("studentID") REFERENCES "Students",
	FOREIGN KEY("teacherID") REFERENCES "Teachers"
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
CREATE TABLE IF NOT EXISTS "Tuition" (
	"tuitionID"	INTEGER NOT NULL,
	"studentID"	INTEGER,
	"subjectID"	INTEGER,
	"teacherID"	INTEGER,
	"hours"	REAL,
	PRIMARY KEY("tuitionID" AUTOINCREMENT),
	FOREIGN KEY("teacherID") REFERENCES "Teachers",
	FOREIGN KEY("studentID") REFERENCES "Students",
	FOREIGN KEY("subjectID") REFERENCES "Subjects"
);
CREATE TABLE IF NOT EXISTS "TuitionFees" (
	"tuitionFeeID"	INTEGER NOT NULL,
	"subjectID"	INTEGER,
	"teacherID"	INTEGER,
	"hourlyRate"	INTEGER,
	PRIMARY KEY("tuitionFeeID" AUTOINCREMENT),
	FOREIGN KEY("subjectID") REFERENCES "Subjects",
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
CREATE TABLE IF NOT EXISTS "Students" (
	"studentID"	INTEGER NOT NULL,
	"studentFirstName"	TEXT NOT NULL,
	"studentLastName"	TEXT NOT NULL,
	"studentEmail"	TEXT,
	"studentPhoneNumber"	TEXT,
	"currentCredits"	NUMERIC,
	"parentID"	INTEGER,
	PRIMARY KEY("studentID" AUTOINCREMENT)
);
INSERT INTO "Students" ("studentID","studentFirstName","studentLastName","studentEmail","studentPhoneNumber","currentCredits","parentID") VALUES (1,'John','Doe','','','',NULL);
COMMIT;
