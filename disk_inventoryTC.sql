-- Created by Tyler Chilcote on 3-9-2020
-- last updated on 3-10-2020

--drop database if it exists
USE master;
GO
drop database if exists disk_inventoryTC

--creates database and uses it
create database disk_inventoryTC;
use disk_inventoryTC;
go

--creates status table
CREATE TABLE Status (
	StatusID INT PRIMARY KEY IDENTITY,
	Info VARCHAR(255)
);

--creates DiskType table
CREATE TABLE DiskType (
	DiskTypeID INT PRIMARY KEY IDENTITY,
	Info VARCHAR(255)
);

--creates Genre table
CREATE TABLE Genre (
	GenreID INT PRIMARY KEY IDENTITY,
	Info VARCHAR(255)
);

--creates ArtistType table
CREATE TABLE ArtistType (
	ArtistTypeID INT PRIMARY KEY IDENTITY,
	Info VARCHAR(255)
);

--creates Disk table
CREATE TABLE Disk (
	DiskID INT PRIMARY KEY IDENTITY,
	DiskName VARCHAR(255) NOT NULL,
	ReleaseDate DATETIME NOT NULL,
	DiskTypeID INT REFERENCES DiskType (DiskTypeID), -- makes foreign keys to genre, artisttype, and status tables
	GenreID INT REFERENCES Genre (GenreID),
	StatusID INT REFERENCES Status (StatusID)
);

--creates artist table
CREATE TABLE Artist (
	ArtistID INT PRIMARY KEY IDENTITY,
	ArtistName VARCHAR(60) NOT NULL,
	ArtistTypeID INT REFERENCES ArtistType (ArtistTypeID) --makes foreign key to artisttype table
);

--creates borrower table
CREATE TABLE Borrower (
	BorrowerID INT PRIMARY KEY IDENTITY,
	FName VARCHAR(60) NOT NULL,
	LName VARCHAR(60) NOT NULL,
	PhoneNum VARCHAR(12) DEFAULT NULL
);

--creates DiskHasArtist table
CREATE TABLE DiskHasArtist (
	ArtistID INT REFERENCES Artist (ArtistID), 
	DiskID INT REFERENCES Disk (DiskID), --gets both the primary keys from artist and disk tables
	BorrowedDate DATETIME NOT NULL
);

--creates DiskHasBorrower table
CREATE TABLE DiskHasBorrower (
	BorrowerID INT REFERENCES Borrower (BorrowerID), 
	DiskID INT REFERENCES Disk (DiskID), --gets both the primary keys from borrower and disk tables
	BorrowDate DATETIME NOT NULL,
	ReturnDate DATETIME
);