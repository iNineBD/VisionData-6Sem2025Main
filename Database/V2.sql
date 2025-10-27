-- DROP SCHEMA dbo;

CREATE SCHEMA dbo;
-- DW.dbo.Dim_Agents definição

-- Drop table

-- DROP TABLE DW.dbo.Dim_Agents;

CREATE TABLE DW.dbo.Dim_Agents (
	AgentKey int IDENTITY(1,1) NOT NULL,
	FullName nvarchar(120) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	DepartmentName nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsActive bit NULL,
	AgentId_BK int NULL,
	CONSTRAINT PK_Dim_Agents PRIMARY KEY (AgentKey)
);


-- DW.dbo.Dim_Categories definição

-- Drop table

-- DROP TABLE DW.dbo.Dim_Categories;

CREATE TABLE DW.dbo.Dim_Categories (
	CategoryKey int IDENTITY(1,1) NOT NULL,
	CategoryName nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SubcategoryName nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CategoryId_BK int NULL,
	CONSTRAINT PK_Dim_Categories PRIMARY KEY (CategoryKey)
);


-- DW.dbo.Dim_Channel definição

-- Drop table

-- DROP TABLE DW.dbo.Dim_Channel;

CREATE TABLE DW.dbo.Dim_Channel (
	ChannelKey int IDENTITY(1,1) NOT NULL,
	ChannelName nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK_Dim_Channel PRIMARY KEY (ChannelKey)
);


-- DW.dbo.Dim_Companies definição

-- Drop table

-- DROP TABLE DW.dbo.Dim_Companies;

CREATE TABLE DW.dbo.Dim_Companies (
	CompanyKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(120) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Segmento nvarchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CNPJ varchar(32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CompanyId_BK int NULL,
	CONSTRAINT PK_Dim_Companies PRIMARY KEY (CompanyKey)
);


-- DW.dbo.Dim_Dates definição

-- Drop table

-- DROP TABLE DW.dbo.Dim_Dates;

CREATE TABLE DW.dbo.Dim_Dates (
	DateKey int NOT NULL,
	[Year] int NULL,
	[Month] int NULL,
	[Day] int NULL,
	[Hour] int NULL,
	[Minute] int NULL,
	CONSTRAINT PK__Dim_Date__40DF45E3091279D1 PRIMARY KEY (DateKey)
);


-- DW.dbo.Dim_Priorities definição

-- Drop table

-- DROP TABLE DW.dbo.Dim_Priorities;

CREATE TABLE DW.dbo.Dim_Priorities (
	PriorityKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PriorityId_BK int NULL,
	CONSTRAINT PK_Dim_Priorities PRIMARY KEY (PriorityKey)
);


-- DW.dbo.Dim_Products definição

-- Drop table

-- DROP TABLE DW.dbo.Dim_Products;

CREATE TABLE DW.dbo.Dim_Products (
	ProductKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Code nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsActive bit NULL,
	ProductId_BK int NULL,
	CONSTRAINT PK_Dim_Products PRIMARY KEY (ProductKey)
);


-- DW.dbo.Dim_Status definição

-- Drop table

-- DROP TABLE DW.dbo.Dim_Status;

CREATE TABLE DW.dbo.Dim_Status (
	StatusKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	StatusId_BK int NULL,
	CONSTRAINT PK_Dim_Status PRIMARY KEY (StatusKey)
);


-- DW.dbo.Dim_Tags definição

-- Drop table

-- DROP TABLE DW.dbo.Dim_Tags;

CREATE TABLE DW.dbo.Dim_Tags (
	TagKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	TagId_BK int NULL,
	CONSTRAINT PK_Dim_Tags PRIMARY KEY (TagKey)
);


-- DW.dbo.Dim_Users definição

-- Drop table

-- DROP TABLE DW.dbo.Dim_Users;

CREATE TABLE DW.dbo.Dim_Users (
	UserKey int IDENTITY(1,1) NOT NULL,
	FullName nvarchar(120) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsVIP bit NULL,
	UserId_BK int NULL,
	CONSTRAINT PK_Dim_Users PRIMARY KEY (UserKey)
);


-- DW.dbo.Fact_Tickets definição

-- Drop table

-- DROP TABLE DW.dbo.Fact_Tickets;

CREATE TABLE DW.dbo.Fact_Tickets (
	TicketKey bigint IDENTITY(1,1) NOT NULL,
	UserKey int NULL,
	AgentKey int NULL,
	CompanyKey int NULL,
	CategoryKey int NULL,
	PriorityKey int NULL,
	StatusKey int NULL,
	ProductKey int NULL,
	TagKey int NOT NULL,
	ChannelKey int NULL,
	QtTickets int NULL,
	EntryDateKey int NULL,
	ClosedDateKey int NULL,
	FirstResponseDateKey int NULL,
	CONSTRAINT PK_Fact_Tickets PRIMARY KEY (TicketKey,TagKey),
	CONSTRAINT FK_FactTickets_Agent FOREIGN KEY (AgentKey) REFERENCES DW.dbo.Dim_Agents(AgentKey),
	CONSTRAINT FK_FactTickets_Category FOREIGN KEY (CategoryKey) REFERENCES DW.dbo.Dim_Categories(CategoryKey),
	CONSTRAINT FK_FactTickets_Channel FOREIGN KEY (ChannelKey) REFERENCES DW.dbo.Dim_Channel(ChannelKey),
	CONSTRAINT FK_FactTickets_ClosedDate FOREIGN KEY (ClosedDateKey) REFERENCES DW.dbo.Dim_Dates(DateKey),
	CONSTRAINT FK_FactTickets_Company FOREIGN KEY (CompanyKey) REFERENCES DW.dbo.Dim_Companies(CompanyKey),
	CONSTRAINT FK_FactTickets_CreatedDate FOREIGN KEY (EntryDateKey) REFERENCES DW.dbo.Dim_Dates(DateKey),
	CONSTRAINT FK_FactTickets_FirstResponseDate FOREIGN KEY (FirstResponseDateKey) REFERENCES DW.dbo.Dim_Dates(DateKey),
	CONSTRAINT FK_FactTickets_Priority FOREIGN KEY (PriorityKey) REFERENCES DW.dbo.Dim_Priorities(PriorityKey),
	CONSTRAINT FK_FactTickets_Product FOREIGN KEY (ProductKey) REFERENCES DW.dbo.Dim_Products(ProductKey),
	CONSTRAINT FK_FactTickets_Status FOREIGN KEY (StatusKey) REFERENCES DW.dbo.Dim_Status(StatusKey),
	CONSTRAINT FK_FactTickets_Tag FOREIGN KEY (TagKey) REFERENCES DW.dbo.Dim_Tags(TagKey),
	CONSTRAINT FK_FactTickets_User FOREIGN KEY (UserKey) REFERENCES DW.dbo.Dim_Users(UserKey)
);


-- DW.dbo.tb_users definição

-- Drop table

-- DROP TABLE DW.dbo.tb_users;

CREATE TABLE DW.dbo.tb_users (
	Id int IDENTITY(1,1) NOT NULL,
	Name nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Email nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	PasswordHash nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	UserType nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	MicrosoftId nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsActive bit DEFAULT 1 NOT NULL,
	CreatedAt datetime2 DEFAULT getdate() NOT NULL,
	UpdatedAt datetime2 NULL,
	LastLoginAt datetime2 NULL,
	CreatedBy int NULL,
	UpdatedBy int NULL,
	CONSTRAINT PK__tb_users__3214EC074020B120 PRIMARY KEY (Id),
	CONSTRAINT UQ__tb_users__0EF9C100E6E3E8CA UNIQUE (MicrosoftId),
	CONSTRAINT UQ__tb_users__A9D105342F133CDB UNIQUE (Email),
	CONSTRAINT FK_Users_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES DW.dbo.tb_users(Id),
	CONSTRAINT FK_Users_UpdatedBy FOREIGN KEY (UpdatedBy) REFERENCES DW.dbo.tb_users(Id)
);
 CREATE NONCLUSTERED INDEX IX_Users_CreatedAt ON DW.dbo.tb_users (  CreatedAt ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Users_Email ON DW.dbo.tb_users (  Email ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Users_IsActive ON DW.dbo.tb_users (  IsActive ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Users_MicrosoftId ON DW.dbo.tb_users (  MicrosoftId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Users_UserType ON DW.dbo.tb_users (  UserType ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
ALTER TABLE DW.dbo.tb_users WITH NOCHECK ADD CONSTRAINT CK__tb_users__UserTy__6D0D32F4 CHECK (([UserType]='VIEWER' OR [UserType]='AGENT' OR [UserType]='MANAGER' OR [UserType]='ADMIN'));


-- DW.dbo.UserAuthLogs definição

-- Drop table

-- DROP TABLE DW.dbo.UserAuthLogs;

CREATE TABLE DW.dbo.UserAuthLogs (
	Id int IDENTITY(1,1) NOT NULL,
	UserId int NOT NULL,
	AuthType nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	IPAddress nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	UserAgent nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Success bit NOT NULL,
	ErrorMessage nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreatedAt datetime2 DEFAULT getdate() NOT NULL,
	CONSTRAINT PK__UserAuth__3214EC0748455938 PRIMARY KEY (Id),
	CONSTRAINT FK_UserAuthLogs_UserId FOREIGN KEY (UserId) REFERENCES DW.dbo.tb_users(Id)
);
 CREATE NONCLUSTERED INDEX IX_UserAuthLogs_CreatedAt ON DW.dbo.UserAuthLogs (  CreatedAt ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_UserAuthLogs_UserId ON DW.dbo.UserAuthLogs (  UserId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
ALTER TABLE DW.dbo.UserAuthLogs WITH NOCHECK ADD CONSTRAINT CK__UserAuthL__AuthT__73BA3083 CHECK (([AuthType]='MICROSOFT' OR [AuthType]='JWT'));