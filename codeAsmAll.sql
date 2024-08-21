CREATE DATABASE StudentGrading;
GO

-- Sử dụng cơ sở dữ liệu
USE StudentGrading;
GO

-- Tạo bảng Students
CREATE TABLE Students (
    S_ID INT PRIMARY KEY,
    S_Name VARCHAR(20) NOT NULL,
    S_Address VARCHAR(20) NOT NULL,
    S_Class VARCHAR(10) NOT NULL,
    S_Gender VARCHAR(10) NOT NULL CHECK (S_Gender IN ('Male', 'Female')),
    S_Dateofbirth DATE NOT NULL,
    Citizen_identification INT NOT NULL
);
GO

-- Hiển thị dữ liệu trong bảng Students
SELECT * FROM Students;
GO

-- Chèn dữ liệu vào bảng Students
INSERT INTO Students VALUES 
(10240, N'Vu Dinh Cong', 'Hai Duong', 'SE06201', 'Male', '2000/02/07', 0302295501),
(20230, N'Vu Dinh Cong', 'Hai Duong', 'SE06201', 'Male', '2000/04/11', 0302288501),
(30430, N'Vu Dinh Cong', 'Hai Duong', 'SE06201', 'Male', '2000/07/03', 0962295501),
(40330, N'Vu Dinh Cong', 'Hai Duong', 'SE06201', 'Male', '2000/10/02', 0012295501),
(51020, N'Vu Dinh Cong', 'Hai Duong', 'SE06201', 'Male', '2000/12/09', 0302295501);
GO

-- Cập nhật dữ liệu trong bảng Students
UPDATE Students


-- Tạo bảng Course
CREATE TABLE Course (
    C_ID INT PRIMARY KEY,
    C_Name VARCHAR(20) NOT NULL,
    Course_description VARCHAR(50) NOT NULL,
    C_Starttime TIME NOT NULL,
    C_Endtime TIME NOT NULL,
    C_Teacher VARCHAR(20) NOT NULL
);
GO

-- Hiển thị dữ liệu trong bảng Course
SELECT * FROM Course;
GO

-- Chèn dữ liệu vào bảng Course
INSERT INTO Course VALUES
(1, 'Database', 'no des', '07:30:00', '11:30:00', 'Dinh Van Dong'),
(2, 'WDD', 'no des', '11:30:00', '16:30:00', 'Dinh Van Dong'),
(3, 'Security', 'no des', '16:30:00', '20:30:00', 'Nguyen Hong Hanh'),
(4, 'DSA', 'no des', '07:30:00', '11:30:00', 'Dinh Van Dong'),
(5, 'BI', 'no des', '11:30:00', '16:30:00', 'Dinh Van Dong'),
(6, 'Semi Final', 'no des', '16:30:00', '20:30:00', 'Nguyen Hong Hanh');
GO

-- Tạo bảng Teachers
CREATE TABLE Teachers (
    T_ID INT PRIMARY KEY,
    T_Name VARCHAR(20) NOT NULL,
    T_Gender VARCHAR(10) NOT NULL CHECK (T_Gender IN ('Male', 'Female')),
    T_Dateofbirth DATE NOT NULL,
    T_Address VARCHAR(30) NOT NULL,
    Recruitment DATE NOT NULL
);
GO

-- Hiển thị dữ liệu trong bảng Teachers
SELECT * FROM Teachers;
GO

-- Chèn dữ liệu vào bảng Teachers
INSERT INTO Teachers VALUES
(27, 'Dinh Van Dong', 'Male', '1985/10/10', 'HN', '2021/09/23'),
(28, 'Nguyen Thi Hoa', 'Female', '1986/07/12', 'HN', '2022/01/11'),
(29, 'Nguyen Hong Hanh', 'Male', '1982/12/11', 'HN', '2020/10/21'),
(32, 'Nguyen Van Nam', 'Male', '1981/11/11', 'HN', '2020/11/23'),
(33, 'Dinh Van Dong', 'Male', '1985/10/10', 'HN', '2021/09/23');
GO

-- Tạo bảng Mark
CREATE TABLE Mark (
    S_ID INT REFERENCES Students(S_ID),
    C_ID INT REFERENCES Course(C_ID),
    attendance VARCHAR(10) NOT NULL CHECK (attendance LIKE '%%'),
    assm1 INT NOT NULL,
    assm2 INT NOT NULL,
    CONSTRAINT pk PRIMARY KEY (S_ID, C_ID)
);
GO

-- Hiển thị dữ liệu trong bảng Mark
SELECT * FROM Mark;
GO

-- Chèn dữ liệu vào bảng Mark
INSERT INTO Mark VALUES
(1024, 1, '13%', 65, 75),
(2023, 2, '7%', 85, 90),
(3043, 3, '3%', 60, 70),
(1024, 4, '110%', 70, 80),
(5102, 5, '20%', 70, 80),
(1024, 6, '0%', 65, 70);
GO

-- Tạo bảng Teachers_Course
CREATE TABLE Teachers_Course (
    T_ID INT REFERENCES Teachers(T_ID),
    C_ID INT REFERENCES Course(C_ID),
    CONSTRAINT pk2 PRIMARY KEY (T_ID, C_ID)
);
GO

-- Hiển thị dữ liệu trong bảng Teachers_Course
SELECT * FROM Teachers_Course;
GO

-- Chèn dữ liệu vào bảng Teachers_Course
INSERT INTO Teachers_Course VALUES
(33, 1),
(27, 2),
(28, 3),
(29, 4),
(32, 5);
GO

-- Tạo bảng Account
CREATE TABLE Account (
    id INT PRIMARY KEY NOT NULL,
    username VARCHAR(20) NOT NULL UNIQUE,
    u_password VARCHAR(50) NOT NULL,
    u_role VARCHAR(10) NOT NULL
);
GO

-- Hiển thị dữ liệu trong bảng Account
SELECT * FROM Account;
GO

-- Chèn dữ liệu vào bảng Account
INSERT INTO Account VALUES
(1, 'admin', '12345', 'admin'),
(2, 'cong', '12345', 'user'),
(3, 'user2', '12345', 'user'),
(4, 'user3', '12345', 'user'),
(5, 'user4', '12345', 'user'),
(6, 'user5', '12345', 'user');
GO

-- Truy vấn tổng hợp từ bảng Mark
SELECT 
    Mark.S_ID, 
    Students.S_Name, 
    Mark.C_ID, 
    Course.C_Name, 
    Mark.attendance, 
    Mark.assm1, 
    Mark.assm2
FROM Mark
LEFT JOIN Students ON Mark.S_ID = Students.S_ID
LEFT JOIN Course ON Mark.C_ID = Course.C_ID;
GO

-- Truy vấn tổng hợp từ bảng Teachers_Course
SELECT 
    Teachers_Course.T_ID, 
    Teachers.T_Name, 
    Teachers_Course.C_ID, 
    Course.C_Name, 
    Course.C_Starttime, 
    Course.C_Endtime
FROM Teachers_Course
LEFT JOIN Teachers ON Teachers_Course.T_ID = Teachers.T_ID
LEFT JOIN Course ON Teachers_Course.C_ID = Course.C_ID;
GO