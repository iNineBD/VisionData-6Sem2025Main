-- Drop table

-- DROP TABLE DW.dbo.Dim_Channel;

CREATE TABLE DW.dbo.Dim_Channel (
	ChannelKey int IDENTITY(1,1) NOT NULL,
	ChannelName nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK_Dim_Channel PRIMARY KEY (ChannelKey)
);

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

-- Drop table

-- DROP TABLE DW.dbo.Dim_Priorities;

CREATE TABLE DW.dbo.Dim_Priorities (
	PriorityKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PriorityId_BK int NULL,
	CONSTRAINT PK_Dim_Priorities PRIMARY KEY (PriorityKey)
);

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

-- Drop table

-- DROP TABLE DW.dbo.Dim_Status;

CREATE TABLE DW.dbo.Dim_Status (
	StatusKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	StatusId_BK int NULL,
	CONSTRAINT PK_Dim_Status PRIMARY KEY (StatusKey)
);

-- Drop table

-- DROP TABLE DW.dbo.Dim_Tags;

CREATE TABLE DW.dbo.Dim_Tags (
	TagKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	TagId_BK int NULL,
	CONSTRAINT PK_Dim_Tags PRIMARY KEY (TagKey)
);

-- Drop table

-- DROP TABLE DW.dbo.Dim_Users;

CREATE TABLE DW.dbo.Dim_Users (
	UserKey int IDENTITY(1,1) NOT NULL,
	FullName nvarchar(120) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsVIP bit NULL,
	UserId_BK int NULL,
	CONSTRAINT PK_Dim_Users PRIMARY KEY (UserKey)
);

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

-- Drop table

-- DROP TABLE DW.dbo.TermItems;

CREATE TABLE DW.dbo.TermItems (
	Id int IDENTITY(1,1) NOT NULL,
	TermId int NOT NULL,
	ItemOrder int DEFAULT 1 NOT NULL,
	Title nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Content text COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	IsMandatory bit DEFAULT 0 NOT NULL,
	IsActive bit DEFAULT 1 NOT NULL,
	CreatedAt datetime2 DEFAULT getdate() NOT NULL,
	UpdatedAt datetime2 NULL,
	CONSTRAINT PK__TermItem__3214EC077C5756B0 PRIMARY KEY (Id),
	CONSTRAINT FK_TermItems_TermId FOREIGN KEY (TermId) REFERENCES DW.dbo.TermsOfUse(Id) ON DELETE CASCADE
);
 CREATE NONCLUSTERED INDEX IDX_TermItems_IsActive ON DW.dbo.TermItems (  IsActive ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_TermItems_IsMandatory ON DW.dbo.TermItems (  IsMandatory ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_TermItems_TermId ON DW.dbo.TermItems (  TermId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;

-- Drop table

-- DROP TABLE DW.dbo.TermsOfUse;

CREATE TABLE DW.dbo.TermsOfUse (
	Id int IDENTITY(1,1) NOT NULL,
	Version nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Content text COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Title nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Description nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsActive bit DEFAULT 1 NOT NULL,
	EffectiveDate datetime2 DEFAULT getdate() NOT NULL,
	CreatedAt datetime2 DEFAULT getdate() NOT NULL,
	CreatedBy int NULL,
	UpdatedAt datetime2 NULL,
	UpdatedBy int NULL,
	CONSTRAINT PK__TermsOfU__3214EC07CD6A9661 PRIMARY KEY (Id),
	CONSTRAINT UQ__TermsOfU__0F540134960A169A UNIQUE (Version),
	CONSTRAINT FK_TermsOfUse_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES DW.dbo.tb_users(Id),
	CONSTRAINT FK_TermsOfUse_UpdatedBy FOREIGN KEY (UpdatedBy) REFERENCES DW.dbo.tb_users(Id)
);
 CREATE NONCLUSTERED INDEX IDX_TermsOfUse_EffectiveDate ON DW.dbo.TermsOfUse (  EffectiveDate ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_TermsOfUse_IsActive ON DW.dbo.TermsOfUse (  IsActive ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_TermsOfUse_Version ON DW.dbo.TermsOfUse (  Version ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;

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

-- Drop table

-- DROP TABLE DW.dbo.UserItemConsents;

CREATE TABLE DW.dbo.UserItemConsents (
	Id int IDENTITY(1,1) NOT NULL,
	UserConsentId int NOT NULL,
	ItemId int NOT NULL,
	Accepted bit NOT NULL,
	ConsentDate datetime2 DEFAULT getdate() NOT NULL,
	CONSTRAINT PK__UserItem__3214EC07A70D24D0 PRIMARY KEY (Id),
	CONSTRAINT FK_UserItemConsents_ItemId FOREIGN KEY (ItemId) REFERENCES DW.dbo.TermItems(Id),
	CONSTRAINT FK_UserItemConsents_UserConsentId FOREIGN KEY (UserConsentId) REFERENCES DW.dbo.UserTermConsents(Id) ON DELETE CASCADE
);
 CREATE NONCLUSTERED INDEX IDX_UserItemConsents_Accepted ON DW.dbo.UserItemConsents (  Accepted ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_UserItemConsents_ItemId ON DW.dbo.UserItemConsents (  ItemId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_UserItemConsents_UserConsentId ON DW.dbo.UserItemConsents (  UserConsentId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;

-- Drop table

-- DROP TABLE DW.dbo.UserTermConsents;

CREATE TABLE DW.dbo.UserTermConsents (
	Id int IDENTITY(1,1) NOT NULL,
	UserId int NOT NULL,
	TermId int NOT NULL,
	ConsentDate datetime2 DEFAULT getdate() NOT NULL,
	IsActive bit DEFAULT 1 NOT NULL,
	IPAddress nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	UserAgent nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	RevokedAt datetime2 NULL,
	RevokedReason nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK__UserTerm__3214EC07A349ACFA PRIMARY KEY (Id),
	CONSTRAINT FK_UserTermConsents_TermId FOREIGN KEY (TermId) REFERENCES DW.dbo.TermsOfUse(Id),
	CONSTRAINT FK_UserTermConsents_UserId FOREIGN KEY (UserId) REFERENCES DW.dbo.tb_users(Id) ON DELETE CASCADE
);
 CREATE NONCLUSTERED INDEX IDX_UserTermConsents_IsActive ON DW.dbo.UserTermConsents (  IsActive ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_UserTermConsents_TermId ON DW.dbo.UserTermConsents (  TermId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_UserTermConsents_UserId ON DW.dbo.UserTermConsents (  UserId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE UNIQUE NONCLUSTERED INDEX UNQ_UserTermConsents_Active ON DW.dbo.UserTermConsents (  UserId ASC  , TermId ASC  )  
	 WHERE  ([IsActive]=(1))
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;

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

-- DROP SCHEMA dbo;

CREATE SCHEMA dbo;
-- DW.dbo.Dim_Agents definition

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


-- DW.dbo.Dim_Categories definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Categories;

CREATE TABLE DW.dbo.Dim_Categories (
	CategoryKey int IDENTITY(1,1) NOT NULL,
	CategoryName nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SubcategoryName nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CategoryId_BK int NULL,
	CONSTRAINT PK_Dim_Categories PRIMARY KEY (CategoryKey)
);


-- DW.dbo.Dim_Channel definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Channel;

CREATE TABLE DW.dbo.Dim_Channel (
	ChannelKey int IDENTITY(1,1) NOT NULL,
	ChannelName nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK_Dim_Channel PRIMARY KEY (ChannelKey)
);


-- DW.dbo.Dim_Companies definition

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


-- DW.dbo.Dim_Dates definition

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


-- DW.dbo.Dim_Priorities definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Priorities;

CREATE TABLE DW.dbo.Dim_Priorities (
	PriorityKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PriorityId_BK int NULL,
	CONSTRAINT PK_Dim_Priorities PRIMARY KEY (PriorityKey)
);


-- DW.dbo.Dim_Products definition

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


-- DW.dbo.Dim_Status definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Status;

CREATE TABLE DW.dbo.Dim_Status (
	StatusKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	StatusId_BK int NULL,
	CONSTRAINT PK_Dim_Status PRIMARY KEY (StatusKey)
);


-- DW.dbo.Dim_Tags definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Tags;

CREATE TABLE DW.dbo.Dim_Tags (
	TagKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	TagId_BK int NULL,
	CONSTRAINT PK_Dim_Tags PRIMARY KEY (TagKey)
);


-- DW.dbo.Dim_Users definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Users;

CREATE TABLE DW.dbo.Dim_Users (
	UserKey int IDENTITY(1,1) NOT NULL,
	FullName nvarchar(120) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsVIP bit NULL,
	UserId_BK int NULL,
	CONSTRAINT PK_Dim_Users PRIMARY KEY (UserKey)
);


-- DW.dbo.Fact_Tickets definition

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


-- DW.dbo.tb_users definition

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


-- DW.dbo.TermsOfUse definition

-- Drop table

-- DROP TABLE DW.dbo.TermsOfUse;

CREATE TABLE DW.dbo.TermsOfUse (
	Id int IDENTITY(1,1) NOT NULL,
	Version nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Content text COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Title nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Description nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsActive bit DEFAULT 1 NOT NULL,
	EffectiveDate datetime2 DEFAULT getdate() NOT NULL,
	CreatedAt datetime2 DEFAULT getdate() NOT NULL,
	CreatedBy int NULL,
	UpdatedAt datetime2 NULL,
	UpdatedBy int NULL,
	CONSTRAINT PK__TermsOfU__3214EC07CD6A9661 PRIMARY KEY (Id),
	CONSTRAINT UQ__TermsOfU__0F540134960A169A UNIQUE (Version),
	CONSTRAINT FK_TermsOfUse_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES DW.dbo.tb_users(Id),
	CONSTRAINT FK_TermsOfUse_UpdatedBy FOREIGN KEY (UpdatedBy) REFERENCES DW.dbo.tb_users(Id)
);
 CREATE NONCLUSTERED INDEX IDX_TermsOfUse_EffectiveDate ON DW.dbo.TermsOfUse (  EffectiveDate ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_TermsOfUse_IsActive ON DW.dbo.TermsOfUse (  IsActive ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_TermsOfUse_Version ON DW.dbo.TermsOfUse (  Version ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- DW.dbo.UserAuthLogs definition

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


-- DW.dbo.UserTermConsents definition

-- Drop table

-- DROP TABLE DW.dbo.UserTermConsents;

CREATE TABLE DW.dbo.UserTermConsents (
	Id int IDENTITY(1,1) NOT NULL,
	UserId int NOT NULL,
	TermId int NOT NULL,
	ConsentDate datetime2 DEFAULT getdate() NOT NULL,
	IsActive bit DEFAULT 1 NOT NULL,
	IPAddress nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	UserAgent nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	RevokedAt datetime2 NULL,
	RevokedReason nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK__UserTerm__3214EC07A349ACFA PRIMARY KEY (Id),
	CONSTRAINT FK_UserTermConsents_TermId FOREIGN KEY (TermId) REFERENCES DW.dbo.TermsOfUse(Id),
	CONSTRAINT FK_UserTermConsents_UserId FOREIGN KEY (UserId) REFERENCES DW.dbo.tb_users(Id) ON DELETE CASCADE
);
 CREATE NONCLUSTERED INDEX IDX_UserTermConsents_IsActive ON DW.dbo.UserTermConsents (  IsActive ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_UserTermConsents_TermId ON DW.dbo.UserTermConsents (  TermId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_UserTermConsents_UserId ON DW.dbo.UserTermConsents (  UserId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE UNIQUE NONCLUSTERED INDEX UNQ_UserTermConsents_Active ON DW.dbo.UserTermConsents (  UserId ASC  , TermId ASC  )  
	 WHERE  ([IsActive]=(1))
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- DW.dbo.TermItems definition

-- Drop table

-- DROP TABLE DW.dbo.TermItems;

CREATE TABLE DW.dbo.TermItems (
	Id int IDENTITY(1,1) NOT NULL,
	TermId int NOT NULL,
	ItemOrder int DEFAULT 1 NOT NULL,
	Title nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Content text COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	IsMandatory bit DEFAULT 0 NOT NULL,
	IsActive bit DEFAULT 1 NOT NULL,
	CreatedAt datetime2 DEFAULT getdate() NOT NULL,
	UpdatedAt datetime2 NULL,
	CONSTRAINT PK__TermItem__3214EC077C5756B0 PRIMARY KEY (Id),
	CONSTRAINT FK_TermItems_TermId FOREIGN KEY (TermId) REFERENCES DW.dbo.TermsOfUse(Id) ON DELETE CASCADE
);
 CREATE NONCLUSTERED INDEX IDX_TermItems_IsActive ON DW.dbo.TermItems (  IsActive ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_TermItems_IsMandatory ON DW.dbo.TermItems (  IsMandatory ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_TermItems_TermId ON DW.dbo.TermItems (  TermId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- DW.dbo.UserItemConsents definition

-- Drop table

-- DROP TABLE DW.dbo.UserItemConsents;

CREATE TABLE DW.dbo.UserItemConsents (
	Id int IDENTITY(1,1) NOT NULL,
	UserConsentId int NOT NULL,
	ItemId int NOT NULL,
	Accepted bit NOT NULL,
	ConsentDate datetime2 DEFAULT getdate() NOT NULL,
	CONSTRAINT PK__UserItem__3214EC07A70D24D0 PRIMARY KEY (Id),
	CONSTRAINT FK_UserItemConsents_ItemId FOREIGN KEY (ItemId) REFERENCES DW.dbo.TermItems(Id),
	CONSTRAINT FK_UserItemConsents_UserConsentId FOREIGN KEY (UserConsentId) REFERENCES DW.dbo.UserTermConsents(Id) ON DELETE CASCADE
);
 CREATE NONCLUSTERED INDEX IDX_UserItemConsents_Accepted ON DW.dbo.UserItemConsents (  Accepted ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_UserItemConsents_ItemId ON DW.dbo.UserItemConsents (  ItemId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_UserItemConsents_UserConsentId ON DW.dbo.UserItemConsents (  UserConsentId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;

-- DROP SCHEMA dbo;

CREATE SCHEMA dbo;
-- DW.dbo.Dim_Agents definition

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


-- DW.dbo.Dim_Categories definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Categories;

CREATE TABLE DW.dbo.Dim_Categories (
	CategoryKey int IDENTITY(1,1) NOT NULL,
	CategoryName nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SubcategoryName nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CategoryId_BK int NULL,
	CONSTRAINT PK_Dim_Categories PRIMARY KEY (CategoryKey)
);


-- DW.dbo.Dim_Channel definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Channel;

CREATE TABLE DW.dbo.Dim_Channel (
	ChannelKey int IDENTITY(1,1) NOT NULL,
	ChannelName nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK_Dim_Channel PRIMARY KEY (ChannelKey)
);


-- DW.dbo.Dim_Companies definition

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


-- DW.dbo.Dim_Dates definition

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


-- DW.dbo.Dim_Priorities definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Priorities;

CREATE TABLE DW.dbo.Dim_Priorities (
	PriorityKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PriorityId_BK int NULL,
	CONSTRAINT PK_Dim_Priorities PRIMARY KEY (PriorityKey)
);


-- DW.dbo.Dim_Products definition

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


-- DW.dbo.Dim_Status definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Status;

CREATE TABLE DW.dbo.Dim_Status (
	StatusKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	StatusId_BK int NULL,
	CONSTRAINT PK_Dim_Status PRIMARY KEY (StatusKey)
);


-- DW.dbo.Dim_Tags definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Tags;

CREATE TABLE DW.dbo.Dim_Tags (
	TagKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	TagId_BK int NULL,
	CONSTRAINT PK_Dim_Tags PRIMARY KEY (TagKey)
);


-- DW.dbo.Dim_Users definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Users;

CREATE TABLE DW.dbo.Dim_Users (
	UserKey int IDENTITY(1,1) NOT NULL,
	FullName nvarchar(120) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsVIP bit NULL,
	UserId_BK int NULL,
	CONSTRAINT PK_Dim_Users PRIMARY KEY (UserKey)
);


-- DW.dbo.Fact_Tickets definition

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


-- DW.dbo.tb_users definition

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


-- DW.dbo.TermsOfUse definition

-- Drop table

-- DROP TABLE DW.dbo.TermsOfUse;

CREATE TABLE DW.dbo.TermsOfUse (
	Id int IDENTITY(1,1) NOT NULL,
	Version nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Content text COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Title nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Description nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsActive bit DEFAULT 1 NOT NULL,
	EffectiveDate datetime2 DEFAULT getdate() NOT NULL,
	CreatedAt datetime2 DEFAULT getdate() NOT NULL,
	CreatedBy int NULL,
	UpdatedAt datetime2 NULL,
	UpdatedBy int NULL,
	CONSTRAINT PK__TermsOfU__3214EC07CD6A9661 PRIMARY KEY (Id),
	CONSTRAINT UQ__TermsOfU__0F540134960A169A UNIQUE (Version),
	CONSTRAINT FK_TermsOfUse_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES DW.dbo.tb_users(Id),
	CONSTRAINT FK_TermsOfUse_UpdatedBy FOREIGN KEY (UpdatedBy) REFERENCES DW.dbo.tb_users(Id)
);
 CREATE NONCLUSTERED INDEX IDX_TermsOfUse_EffectiveDate ON DW.dbo.TermsOfUse (  EffectiveDate ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_TermsOfUse_IsActive ON DW.dbo.TermsOfUse (  IsActive ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_TermsOfUse_Version ON DW.dbo.TermsOfUse (  Version ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- DW.dbo.UserAuthLogs definition

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


-- DW.dbo.UserTermConsents definition

-- Drop table

-- DROP TABLE DW.dbo.UserTermConsents;

CREATE TABLE DW.dbo.UserTermConsents (
	Id int IDENTITY(1,1) NOT NULL,
	UserId int NOT NULL,
	TermId int NOT NULL,
	ConsentDate datetime2 DEFAULT getdate() NOT NULL,
	IsActive bit DEFAULT 1 NOT NULL,
	IPAddress nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	UserAgent nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	RevokedAt datetime2 NULL,
	RevokedReason nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK__UserTerm__3214EC07A349ACFA PRIMARY KEY (Id),
	CONSTRAINT FK_UserTermConsents_TermId FOREIGN KEY (TermId) REFERENCES DW.dbo.TermsOfUse(Id),
	CONSTRAINT FK_UserTermConsents_UserId FOREIGN KEY (UserId) REFERENCES DW.dbo.tb_users(Id) ON DELETE CASCADE
);
 CREATE NONCLUSTERED INDEX IDX_UserTermConsents_IsActive ON DW.dbo.UserTermConsents (  IsActive ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_UserTermConsents_TermId ON DW.dbo.UserTermConsents (  TermId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_UserTermConsents_UserId ON DW.dbo.UserTermConsents (  UserId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE UNIQUE NONCLUSTERED INDEX UNQ_UserTermConsents_Active ON DW.dbo.UserTermConsents (  UserId ASC  , TermId ASC  )  
	 WHERE  ([IsActive]=(1))
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- DW.dbo.TermItems definition

-- Drop table

-- DROP TABLE DW.dbo.TermItems;

CREATE TABLE DW.dbo.TermItems (
	Id int IDENTITY(1,1) NOT NULL,
	TermId int NOT NULL,
	ItemOrder int DEFAULT 1 NOT NULL,
	Title nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Content text COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	IsMandatory bit DEFAULT 0 NOT NULL,
	IsActive bit DEFAULT 1 NOT NULL,
	CreatedAt datetime2 DEFAULT getdate() NOT NULL,
	UpdatedAt datetime2 NULL,
	CONSTRAINT PK__TermItem__3214EC077C5756B0 PRIMARY KEY (Id),
	CONSTRAINT FK_TermItems_TermId FOREIGN KEY (TermId) REFERENCES DW.dbo.TermsOfUse(Id) ON DELETE CASCADE
);
 CREATE NONCLUSTERED INDEX IDX_TermItems_IsActive ON DW.dbo.TermItems (  IsActive ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_TermItems_IsMandatory ON DW.dbo.TermItems (  IsMandatory ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_TermItems_TermId ON DW.dbo.TermItems (  TermId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- DW.dbo.UserItemConsents definition

-- Drop table

-- DROP TABLE DW.dbo.UserItemConsents;

CREATE TABLE DW.dbo.UserItemConsents (
	Id int IDENTITY(1,1) NOT NULL,
	UserConsentId int NOT NULL,
	ItemId int NOT NULL,
	Accepted bit NOT NULL,
	ConsentDate datetime2 DEFAULT getdate() NOT NULL,
	CONSTRAINT PK__UserItem__3214EC07A70D24D0 PRIMARY KEY (Id),
	CONSTRAINT FK_UserItemConsents_ItemId FOREIGN KEY (ItemId) REFERENCES DW.dbo.TermItems(Id),
	CONSTRAINT FK_UserItemConsents_UserConsentId FOREIGN KEY (UserConsentId) REFERENCES DW.dbo.UserTermConsents(Id) ON DELETE CASCADE
);
 CREATE NONCLUSTERED INDEX IDX_UserItemConsents_Accepted ON DW.dbo.UserItemConsents (  Accepted ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_UserItemConsents_ItemId ON DW.dbo.UserItemConsents (  ItemId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_UserItemConsents_UserConsentId ON DW.dbo.UserItemConsents (  UserConsentId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;

-- DROP SCHEMA dbo;

CREATE SCHEMA dbo;
-- DW.dbo.Dim_Agents definition

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


-- DW.dbo.Dim_Categories definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Categories;

CREATE TABLE DW.dbo.Dim_Categories (
	CategoryKey int IDENTITY(1,1) NOT NULL,
	CategoryName nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SubcategoryName nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CategoryId_BK int NULL,
	CONSTRAINT PK_Dim_Categories PRIMARY KEY (CategoryKey)
);


-- DW.dbo.Dim_Channel definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Channel;

CREATE TABLE DW.dbo.Dim_Channel (
	ChannelKey int IDENTITY(1,1) NOT NULL,
	ChannelName nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK_Dim_Channel PRIMARY KEY (ChannelKey)
);


-- DW.dbo.Dim_Companies definition

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


-- DW.dbo.Dim_Dates definition

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


-- DW.dbo.Dim_Priorities definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Priorities;

CREATE TABLE DW.dbo.Dim_Priorities (
	PriorityKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PriorityId_BK int NULL,
	CONSTRAINT PK_Dim_Priorities PRIMARY KEY (PriorityKey)
);


-- DW.dbo.Dim_Products definition

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


-- DW.dbo.Dim_Status definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Status;

CREATE TABLE DW.dbo.Dim_Status (
	StatusKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	StatusId_BK int NULL,
	CONSTRAINT PK_Dim_Status PRIMARY KEY (StatusKey)
);


-- DW.dbo.Dim_Tags definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Tags;

CREATE TABLE DW.dbo.Dim_Tags (
	TagKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	TagId_BK int NULL,
	CONSTRAINT PK_Dim_Tags PRIMARY KEY (TagKey)
);


-- DW.dbo.Dim_Users definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Users;

CREATE TABLE DW.dbo.Dim_Users (
	UserKey int IDENTITY(1,1) NOT NULL,
	FullName nvarchar(120) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsVIP bit NULL,
	UserId_BK int NULL,
	CONSTRAINT PK_Dim_Users PRIMARY KEY (UserKey)
);


-- DW.dbo.Fact_Tickets definition

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


-- DW.dbo.tb_users definition

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


-- DW.dbo.TermsOfUse definition

-- Drop table

-- DROP TABLE DW.dbo.TermsOfUse;

CREATE TABLE DW.dbo.TermsOfUse (
	Id int IDENTITY(1,1) NOT NULL,
	Version nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Content text COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Title nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Description nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsActive bit DEFAULT 1 NOT NULL,
	EffectiveDate datetime2 DEFAULT getdate() NOT NULL,
	CreatedAt datetime2 DEFAULT getdate() NOT NULL,
	CreatedBy int NULL,
	UpdatedAt datetime2 NULL,
	UpdatedBy int NULL,
	CONSTRAINT PK__TermsOfU__3214EC07CD6A9661 PRIMARY KEY (Id),
	CONSTRAINT UQ__TermsOfU__0F540134960A169A UNIQUE (Version),
	CONSTRAINT FK_TermsOfUse_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES DW.dbo.tb_users(Id),
	CONSTRAINT FK_TermsOfUse_UpdatedBy FOREIGN KEY (UpdatedBy) REFERENCES DW.dbo.tb_users(Id)
);
 CREATE NONCLUSTERED INDEX IDX_TermsOfUse_EffectiveDate ON DW.dbo.TermsOfUse (  EffectiveDate ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_TermsOfUse_IsActive ON DW.dbo.TermsOfUse (  IsActive ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_TermsOfUse_Version ON DW.dbo.TermsOfUse (  Version ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- DW.dbo.UserAuthLogs definition

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


-- DW.dbo.UserTermConsents definition

-- Drop table

-- DROP TABLE DW.dbo.UserTermConsents;

CREATE TABLE DW.dbo.UserTermConsents (
	Id int IDENTITY(1,1) NOT NULL,
	UserId int NOT NULL,
	TermId int NOT NULL,
	ConsentDate datetime2 DEFAULT getdate() NOT NULL,
	IsActive bit DEFAULT 1 NOT NULL,
	IPAddress nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	UserAgent nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	RevokedAt datetime2 NULL,
	RevokedReason nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK__UserTerm__3214EC07A349ACFA PRIMARY KEY (Id),
	CONSTRAINT FK_UserTermConsents_TermId FOREIGN KEY (TermId) REFERENCES DW.dbo.TermsOfUse(Id),
	CONSTRAINT FK_UserTermConsents_UserId FOREIGN KEY (UserId) REFERENCES DW.dbo.tb_users(Id) ON DELETE CASCADE
);
 CREATE NONCLUSTERED INDEX IDX_UserTermConsents_IsActive ON DW.dbo.UserTermConsents (  IsActive ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_UserTermConsents_TermId ON DW.dbo.UserTermConsents (  TermId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_UserTermConsents_UserId ON DW.dbo.UserTermConsents (  UserId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE UNIQUE NONCLUSTERED INDEX UNQ_UserTermConsents_Active ON DW.dbo.UserTermConsents (  UserId ASC  , TermId ASC  )  
	 WHERE  ([IsActive]=(1))
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- DW.dbo.TermItems definition

-- Drop table

-- DROP TABLE DW.dbo.TermItems;

CREATE TABLE DW.dbo.TermItems (
	Id int IDENTITY(1,1) NOT NULL,
	TermId int NOT NULL,
	ItemOrder int DEFAULT 1 NOT NULL,
	Title nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Content text COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	IsMandatory bit DEFAULT 0 NOT NULL,
	IsActive bit DEFAULT 1 NOT NULL,
	CreatedAt datetime2 DEFAULT getdate() NOT NULL,
	UpdatedAt datetime2 NULL,
	CONSTRAINT PK__TermItem__3214EC077C5756B0 PRIMARY KEY (Id),
	CONSTRAINT FK_TermItems_TermId FOREIGN KEY (TermId) REFERENCES DW.dbo.TermsOfUse(Id) ON DELETE CASCADE
);
 CREATE NONCLUSTERED INDEX IDX_TermItems_IsActive ON DW.dbo.TermItems (  IsActive ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_TermItems_IsMandatory ON DW.dbo.TermItems (  IsMandatory ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_TermItems_TermId ON DW.dbo.TermItems (  TermId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- DW.dbo.UserItemConsents definition

-- Drop table

-- DROP TABLE DW.dbo.UserItemConsents;

CREATE TABLE DW.dbo.UserItemConsents (
	Id int IDENTITY(1,1) NOT NULL,
	UserConsentId int NOT NULL,
	ItemId int NOT NULL,
	Accepted bit NOT NULL,
	ConsentDate datetime2 DEFAULT getdate() NOT NULL,
	CONSTRAINT PK__UserItem__3214EC07A70D24D0 PRIMARY KEY (Id),
	CONSTRAINT FK_UserItemConsents_ItemId FOREIGN KEY (ItemId) REFERENCES DW.dbo.TermItems(Id),
	CONSTRAINT FK_UserItemConsents_UserConsentId FOREIGN KEY (UserConsentId) REFERENCES DW.dbo.UserTermConsents(Id) ON DELETE CASCADE
);
 CREATE NONCLUSTERED INDEX IDX_UserItemConsents_Accepted ON DW.dbo.UserItemConsents (  Accepted ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_UserItemConsents_ItemId ON DW.dbo.UserItemConsents (  ItemId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_UserItemConsents_UserConsentId ON DW.dbo.UserItemConsents (  UserConsentId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;

CREATE UNIQUE CLUSTERED INDEX PK_Dim_Agents ON DW.dbo.Dim_Agents (  AgentKey ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE UNIQUE CLUSTERED INDEX PK_Dim_Categories ON DW.dbo.Dim_Categories (  CategoryKey ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE UNIQUE CLUSTERED INDEX PK_Dim_Channel ON DW.dbo.Dim_Channel (  ChannelKey ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE UNIQUE CLUSTERED INDEX PK_Dim_Companies ON DW.dbo.Dim_Companies (  CompanyKey ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE UNIQUE CLUSTERED INDEX PK__Dim_Date__40DF45E3091279D1 ON DW.dbo.Dim_Dates (  DateKey ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE UNIQUE CLUSTERED INDEX PK_Dim_Priorities ON DW.dbo.Dim_Priorities (  PriorityKey ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE UNIQUE CLUSTERED INDEX PK_Dim_Products ON DW.dbo.Dim_Products (  ProductKey ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE UNIQUE CLUSTERED INDEX PK_Dim_Status ON DW.dbo.Dim_Status (  StatusKey ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE UNIQUE CLUSTERED INDEX PK_Dim_Tags ON DW.dbo.Dim_Tags (  TagKey ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE UNIQUE CLUSTERED INDEX PK_Dim_Users ON DW.dbo.Dim_Users (  UserKey ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE UNIQUE CLUSTERED INDEX PK_Fact_Tickets ON DW.dbo.Fact_Tickets (  TicketKey ASC  , TagKey ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE NONCLUSTERED INDEX IDX_TermItems_IsActive ON DW.dbo.TermItems (  IsActive ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE NONCLUSTERED INDEX IDX_TermItems_IsMandatory ON DW.dbo.TermItems (  IsMandatory ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE NONCLUSTERED INDEX IDX_TermItems_TermId ON DW.dbo.TermItems (  TermId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE UNIQUE CLUSTERED INDEX PK__TermItem__3214EC077C5756B0 ON DW.dbo.TermItems (  Id ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE NONCLUSTERED INDEX IDX_TermsOfUse_EffectiveDate ON DW.dbo.TermsOfUse (  EffectiveDate ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE NONCLUSTERED INDEX IDX_TermsOfUse_IsActive ON DW.dbo.TermsOfUse (  IsActive ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE NONCLUSTERED INDEX IDX_TermsOfUse_Version ON DW.dbo.TermsOfUse (  Version ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE UNIQUE CLUSTERED INDEX PK__TermsOfU__3214EC07CD6A9661 ON DW.dbo.TermsOfUse (  Id ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE UNIQUE NONCLUSTERED INDEX UQ__TermsOfU__0F540134960A169A ON DW.dbo.TermsOfUse (  Version ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE NONCLUSTERED INDEX IX_UserAuthLogs_CreatedAt ON DW.dbo.UserAuthLogs (  CreatedAt ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE NONCLUSTERED INDEX IX_UserAuthLogs_UserId ON DW.dbo.UserAuthLogs (  UserId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE UNIQUE CLUSTERED INDEX PK__UserAuth__3214EC0748455938 ON DW.dbo.UserAuthLogs (  Id ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE NONCLUSTERED INDEX IDX_UserItemConsents_Accepted ON DW.dbo.UserItemConsents (  Accepted ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE NONCLUSTERED INDEX IDX_UserItemConsents_ItemId ON DW.dbo.UserItemConsents (  ItemId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE NONCLUSTERED INDEX IDX_UserItemConsents_UserConsentId ON DW.dbo.UserItemConsents (  UserConsentId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE UNIQUE CLUSTERED INDEX PK__UserItem__3214EC07A70D24D0 ON DW.dbo.UserItemConsents (  Id ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE NONCLUSTERED INDEX IDX_UserTermConsents_IsActive ON DW.dbo.UserTermConsents (  IsActive ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE NONCLUSTERED INDEX IDX_UserTermConsents_TermId ON DW.dbo.UserTermConsents (  TermId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE NONCLUSTERED INDEX IDX_UserTermConsents_UserId ON DW.dbo.UserTermConsents (  UserId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE UNIQUE CLUSTERED INDEX PK__UserTerm__3214EC07A349ACFA ON DW.dbo.UserTermConsents (  Id ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE UNIQUE NONCLUSTERED INDEX UNQ_UserTermConsents_Active ON DW.dbo.UserTermConsents (  UserId ASC  , TermId ASC  )  
	 WHERE  ([IsActive]=(1))
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE NONCLUSTERED INDEX IX_Users_CreatedAt ON DW.dbo.tb_users (  CreatedAt ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE NONCLUSTERED INDEX IX_Users_Email ON DW.dbo.tb_users (  Email ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE NONCLUSTERED INDEX IX_Users_IsActive ON DW.dbo.tb_users (  IsActive ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE NONCLUSTERED INDEX IX_Users_MicrosoftId ON DW.dbo.tb_users (  MicrosoftId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE NONCLUSTERED INDEX IX_Users_UserType ON DW.dbo.tb_users (  UserType ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE UNIQUE CLUSTERED INDEX PK__tb_users__3214EC074020B120 ON DW.dbo.tb_users (  Id ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE UNIQUE NONCLUSTERED INDEX UQ__tb_users__0EF9C100E6E3E8CA ON DW.dbo.tb_users (  MicrosoftId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

CREATE UNIQUE NONCLUSTERED INDEX UQ__tb_users__A9D105342F133CDB ON DW.dbo.tb_users (  Email ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ];

-- DROP SCHEMA dbo;

CREATE SCHEMA dbo;
-- DW.dbo.Dim_Agents definition

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


-- DW.dbo.Dim_Categories definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Categories;

CREATE TABLE DW.dbo.Dim_Categories (
	CategoryKey int IDENTITY(1,1) NOT NULL,
	CategoryName nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SubcategoryName nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CategoryId_BK int NULL,
	CONSTRAINT PK_Dim_Categories PRIMARY KEY (CategoryKey)
);


-- DW.dbo.Dim_Channel definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Channel;

CREATE TABLE DW.dbo.Dim_Channel (
	ChannelKey int IDENTITY(1,1) NOT NULL,
	ChannelName nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK_Dim_Channel PRIMARY KEY (ChannelKey)
);


-- DW.dbo.Dim_Companies definition

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


-- DW.dbo.Dim_Dates definition

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


-- DW.dbo.Dim_Priorities definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Priorities;

CREATE TABLE DW.dbo.Dim_Priorities (
	PriorityKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PriorityId_BK int NULL,
	CONSTRAINT PK_Dim_Priorities PRIMARY KEY (PriorityKey)
);


-- DW.dbo.Dim_Products definition

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


-- DW.dbo.Dim_Status definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Status;

CREATE TABLE DW.dbo.Dim_Status (
	StatusKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	StatusId_BK int NULL,
	CONSTRAINT PK_Dim_Status PRIMARY KEY (StatusKey)
);


-- DW.dbo.Dim_Tags definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Tags;

CREATE TABLE DW.dbo.Dim_Tags (
	TagKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	TagId_BK int NULL,
	CONSTRAINT PK_Dim_Tags PRIMARY KEY (TagKey)
);


-- DW.dbo.Dim_Users definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Users;

CREATE TABLE DW.dbo.Dim_Users (
	UserKey int IDENTITY(1,1) NOT NULL,
	FullName nvarchar(120) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsVIP bit NULL,
	UserId_BK int NULL,
	CONSTRAINT PK_Dim_Users PRIMARY KEY (UserKey)
);


-- DW.dbo.Fact_Tickets definition

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


-- DW.dbo.tb_users definition

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


-- DW.dbo.TermsOfUse definition

-- Drop table

-- DROP TABLE DW.dbo.TermsOfUse;

CREATE TABLE DW.dbo.TermsOfUse (
	Id int IDENTITY(1,1) NOT NULL,
	Version nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Content text COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Title nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Description nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsActive bit DEFAULT 1 NOT NULL,
	EffectiveDate datetime2 DEFAULT getdate() NOT NULL,
	CreatedAt datetime2 DEFAULT getdate() NOT NULL,
	CreatedBy int NULL,
	UpdatedAt datetime2 NULL,
	UpdatedBy int NULL,
	CONSTRAINT PK__TermsOfU__3214EC07CD6A9661 PRIMARY KEY (Id),
	CONSTRAINT UQ__TermsOfU__0F540134960A169A UNIQUE (Version),
	CONSTRAINT FK_TermsOfUse_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES DW.dbo.tb_users(Id),
	CONSTRAINT FK_TermsOfUse_UpdatedBy FOREIGN KEY (UpdatedBy) REFERENCES DW.dbo.tb_users(Id)
);
 CREATE NONCLUSTERED INDEX IDX_TermsOfUse_EffectiveDate ON DW.dbo.TermsOfUse (  EffectiveDate ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_TermsOfUse_IsActive ON DW.dbo.TermsOfUse (  IsActive ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_TermsOfUse_Version ON DW.dbo.TermsOfUse (  Version ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- DW.dbo.UserAuthLogs definition

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


-- DW.dbo.UserTermConsents definition

-- Drop table

-- DROP TABLE DW.dbo.UserTermConsents;

CREATE TABLE DW.dbo.UserTermConsents (
	Id int IDENTITY(1,1) NOT NULL,
	UserId int NOT NULL,
	TermId int NOT NULL,
	ConsentDate datetime2 DEFAULT getdate() NOT NULL,
	IsActive bit DEFAULT 1 NOT NULL,
	IPAddress nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	UserAgent nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	RevokedAt datetime2 NULL,
	RevokedReason nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK__UserTerm__3214EC07A349ACFA PRIMARY KEY (Id),
	CONSTRAINT FK_UserTermConsents_TermId FOREIGN KEY (TermId) REFERENCES DW.dbo.TermsOfUse(Id),
	CONSTRAINT FK_UserTermConsents_UserId FOREIGN KEY (UserId) REFERENCES DW.dbo.tb_users(Id) ON DELETE CASCADE
);
 CREATE NONCLUSTERED INDEX IDX_UserTermConsents_IsActive ON DW.dbo.UserTermConsents (  IsActive ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_UserTermConsents_TermId ON DW.dbo.UserTermConsents (  TermId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_UserTermConsents_UserId ON DW.dbo.UserTermConsents (  UserId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE UNIQUE NONCLUSTERED INDEX UNQ_UserTermConsents_Active ON DW.dbo.UserTermConsents (  UserId ASC  , TermId ASC  )  
	 WHERE  ([IsActive]=(1))
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- DW.dbo.TermItems definition

-- Drop table

-- DROP TABLE DW.dbo.TermItems;

CREATE TABLE DW.dbo.TermItems (
	Id int IDENTITY(1,1) NOT NULL,
	TermId int NOT NULL,
	ItemOrder int DEFAULT 1 NOT NULL,
	Title nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Content text COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	IsMandatory bit DEFAULT 0 NOT NULL,
	IsActive bit DEFAULT 1 NOT NULL,
	CreatedAt datetime2 DEFAULT getdate() NOT NULL,
	UpdatedAt datetime2 NULL,
	CONSTRAINT PK__TermItem__3214EC077C5756B0 PRIMARY KEY (Id),
	CONSTRAINT FK_TermItems_TermId FOREIGN KEY (TermId) REFERENCES DW.dbo.TermsOfUse(Id) ON DELETE CASCADE
);
 CREATE NONCLUSTERED INDEX IDX_TermItems_IsActive ON DW.dbo.TermItems (  IsActive ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_TermItems_IsMandatory ON DW.dbo.TermItems (  IsMandatory ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_TermItems_TermId ON DW.dbo.TermItems (  TermId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- DW.dbo.UserItemConsents definition

-- Drop table

-- DROP TABLE DW.dbo.UserItemConsents;

CREATE TABLE DW.dbo.UserItemConsents (
	Id int IDENTITY(1,1) NOT NULL,
	UserConsentId int NOT NULL,
	ItemId int NOT NULL,
	Accepted bit NOT NULL,
	ConsentDate datetime2 DEFAULT getdate() NOT NULL,
	CONSTRAINT PK__UserItem__3214EC07A70D24D0 PRIMARY KEY (Id),
	CONSTRAINT FK_UserItemConsents_ItemId FOREIGN KEY (ItemId) REFERENCES DW.dbo.TermItems(Id),
	CONSTRAINT FK_UserItemConsents_UserConsentId FOREIGN KEY (UserConsentId) REFERENCES DW.dbo.UserTermConsents(Id) ON DELETE CASCADE
);
 CREATE NONCLUSTERED INDEX IDX_UserItemConsents_Accepted ON DW.dbo.UserItemConsents (  Accepted ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_UserItemConsents_ItemId ON DW.dbo.UserItemConsents (  ItemId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_UserItemConsents_UserConsentId ON DW.dbo.UserItemConsents (  UserConsentId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;

CREATE   PROCEDURE SP_RecalculateActiveTerm
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRANSACTION;

    BEGIN TRY
        -- Desativar todos os termos e seus itens
        UPDATE TermsOfUse
        SET IsActive = 0;

        -- Desativar todos os itens de termo
        UPDATE TermItems
        SET IsActive = 0;

        -- Declarar variável para armazenar o ID do termo que deve ser ativo
        DECLARE @ActiveTermId INT;

        -- Buscar o termo que deve estar ativo:
        -- 1. Data de vigência <= hoje
        -- 2. Ordenar por data de vigência DESC (mais recente primeiro)
        -- 3. Desempatar por data de criação DESC
        SELECT TOP 1 @ActiveTermId = Id
        FROM TermsOfUse
        WHERE CAST(EffectiveDate AS DATE) <= CAST(GETDATE() AS DATE)
        ORDER BY CAST(EffectiveDate AS DATE) DESC, CreatedAt DESC;

        -- Se não encontrou nenhum termo com data <= hoje,
        -- pegar o mais recente por data de criação
        IF @ActiveTermId IS NULL
        BEGIN
            SELECT TOP 1 @ActiveTermId = Id
            FROM TermsOfUse
            ORDER BY CreatedAt DESC;
        END

        -- Ativar o termo escolhido e seus itens
        IF @ActiveTermId IS NOT NULL
        BEGIN
            UPDATE TermsOfUse
            SET IsActive = 1
            WHERE Id = @ActiveTermId;

            -- Ativar os itens do termo ativo
            UPDATE TermItems
            SET IsActive = 1
            WHERE TermId = @ActiveTermId;
        END

        COMMIT TRANSACTION;

        -- Retornar sucesso
        SELECT 1 AS Success, @ActiveTermId AS ActiveTermId;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        -- Retornar erro
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;

-- DROP SCHEMA dbo;

CREATE SCHEMA dbo;
-- DW.dbo.Dim_Agents definition

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


-- DW.dbo.Dim_Categories definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Categories;

CREATE TABLE DW.dbo.Dim_Categories (
	CategoryKey int IDENTITY(1,1) NOT NULL,
	CategoryName nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SubcategoryName nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CategoryId_BK int NULL,
	CONSTRAINT PK_Dim_Categories PRIMARY KEY (CategoryKey)
);


-- DW.dbo.Dim_Channel definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Channel;

CREATE TABLE DW.dbo.Dim_Channel (
	ChannelKey int IDENTITY(1,1) NOT NULL,
	ChannelName nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK_Dim_Channel PRIMARY KEY (ChannelKey)
);


-- DW.dbo.Dim_Companies definition

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


-- DW.dbo.Dim_Dates definition

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


-- DW.dbo.Dim_Priorities definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Priorities;

CREATE TABLE DW.dbo.Dim_Priorities (
	PriorityKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PriorityId_BK int NULL,
	CONSTRAINT PK_Dim_Priorities PRIMARY KEY (PriorityKey)
);


-- DW.dbo.Dim_Products definition

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


-- DW.dbo.Dim_Status definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Status;

CREATE TABLE DW.dbo.Dim_Status (
	StatusKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	StatusId_BK int NULL,
	CONSTRAINT PK_Dim_Status PRIMARY KEY (StatusKey)
);


-- DW.dbo.Dim_Tags definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Tags;

CREATE TABLE DW.dbo.Dim_Tags (
	TagKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	TagId_BK int NULL,
	CONSTRAINT PK_Dim_Tags PRIMARY KEY (TagKey)
);


-- DW.dbo.Dim_Users definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Users;

CREATE TABLE DW.dbo.Dim_Users (
	UserKey int IDENTITY(1,1) NOT NULL,
	FullName nvarchar(120) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsVIP bit NULL,
	UserId_BK int NULL,
	CONSTRAINT PK_Dim_Users PRIMARY KEY (UserKey)
);


-- DW.dbo.Fact_Tickets definition

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


-- DW.dbo.tb_users definition

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


-- DW.dbo.TermsOfUse definition

-- Drop table

-- DROP TABLE DW.dbo.TermsOfUse;

CREATE TABLE DW.dbo.TermsOfUse (
	Id int IDENTITY(1,1) NOT NULL,
	Version nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Content text COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Title nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Description nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsActive bit DEFAULT 1 NOT NULL,
	EffectiveDate datetime2 DEFAULT getdate() NOT NULL,
	CreatedAt datetime2 DEFAULT getdate() NOT NULL,
	CreatedBy int NULL,
	UpdatedAt datetime2 NULL,
	UpdatedBy int NULL,
	CONSTRAINT PK__TermsOfU__3214EC07CD6A9661 PRIMARY KEY (Id),
	CONSTRAINT UQ__TermsOfU__0F540134960A169A UNIQUE (Version),
	CONSTRAINT FK_TermsOfUse_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES DW.dbo.tb_users(Id),
	CONSTRAINT FK_TermsOfUse_UpdatedBy FOREIGN KEY (UpdatedBy) REFERENCES DW.dbo.tb_users(Id)
);
 CREATE NONCLUSTERED INDEX IDX_TermsOfUse_EffectiveDate ON DW.dbo.TermsOfUse (  EffectiveDate ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_TermsOfUse_IsActive ON DW.dbo.TermsOfUse (  IsActive ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_TermsOfUse_Version ON DW.dbo.TermsOfUse (  Version ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- DW.dbo.UserAuthLogs definition

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


-- DW.dbo.UserTermConsents definition

-- Drop table

-- DROP TABLE DW.dbo.UserTermConsents;

CREATE TABLE DW.dbo.UserTermConsents (
	Id int IDENTITY(1,1) NOT NULL,
	UserId int NOT NULL,
	TermId int NOT NULL,
	ConsentDate datetime2 DEFAULT getdate() NOT NULL,
	IsActive bit DEFAULT 1 NOT NULL,
	IPAddress nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	UserAgent nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	RevokedAt datetime2 NULL,
	RevokedReason nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK__UserTerm__3214EC07A349ACFA PRIMARY KEY (Id),
	CONSTRAINT FK_UserTermConsents_TermId FOREIGN KEY (TermId) REFERENCES DW.dbo.TermsOfUse(Id),
	CONSTRAINT FK_UserTermConsents_UserId FOREIGN KEY (UserId) REFERENCES DW.dbo.tb_users(Id) ON DELETE CASCADE
);
 CREATE NONCLUSTERED INDEX IDX_UserTermConsents_IsActive ON DW.dbo.UserTermConsents (  IsActive ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_UserTermConsents_TermId ON DW.dbo.UserTermConsents (  TermId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_UserTermConsents_UserId ON DW.dbo.UserTermConsents (  UserId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE UNIQUE NONCLUSTERED INDEX UNQ_UserTermConsents_Active ON DW.dbo.UserTermConsents (  UserId ASC  , TermId ASC  )  
	 WHERE  ([IsActive]=(1))
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- DW.dbo.TermItems definition

-- Drop table

-- DROP TABLE DW.dbo.TermItems;

CREATE TABLE DW.dbo.TermItems (
	Id int IDENTITY(1,1) NOT NULL,
	TermId int NOT NULL,
	ItemOrder int DEFAULT 1 NOT NULL,
	Title nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Content text COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	IsMandatory bit DEFAULT 0 NOT NULL,
	IsActive bit DEFAULT 1 NOT NULL,
	CreatedAt datetime2 DEFAULT getdate() NOT NULL,
	UpdatedAt datetime2 NULL,
	CONSTRAINT PK__TermItem__3214EC077C5756B0 PRIMARY KEY (Id),
	CONSTRAINT FK_TermItems_TermId FOREIGN KEY (TermId) REFERENCES DW.dbo.TermsOfUse(Id) ON DELETE CASCADE
);
 CREATE NONCLUSTERED INDEX IDX_TermItems_IsActive ON DW.dbo.TermItems (  IsActive ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_TermItems_IsMandatory ON DW.dbo.TermItems (  IsMandatory ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_TermItems_TermId ON DW.dbo.TermItems (  TermId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- DW.dbo.UserItemConsents definition

-- Drop table

-- DROP TABLE DW.dbo.UserItemConsents;

CREATE TABLE DW.dbo.UserItemConsents (
	Id int IDENTITY(1,1) NOT NULL,
	UserConsentId int NOT NULL,
	ItemId int NOT NULL,
	Accepted bit NOT NULL,
	ConsentDate datetime2 DEFAULT getdate() NOT NULL,
	CONSTRAINT PK__UserItem__3214EC07A70D24D0 PRIMARY KEY (Id),
	CONSTRAINT FK_UserItemConsents_ItemId FOREIGN KEY (ItemId) REFERENCES DW.dbo.TermItems(Id),
	CONSTRAINT FK_UserItemConsents_UserConsentId FOREIGN KEY (UserConsentId) REFERENCES DW.dbo.UserTermConsents(Id) ON DELETE CASCADE
);
 CREATE NONCLUSTERED INDEX IDX_UserItemConsents_Accepted ON DW.dbo.UserItemConsents (  Accepted ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_UserItemConsents_ItemId ON DW.dbo.UserItemConsents (  ItemId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_UserItemConsents_UserConsentId ON DW.dbo.UserItemConsents (  UserConsentId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;

-- DROP SCHEMA dbo;

CREATE SCHEMA dbo;
-- DW.dbo.Dim_Agents definition

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


-- DW.dbo.Dim_Categories definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Categories;

CREATE TABLE DW.dbo.Dim_Categories (
	CategoryKey int IDENTITY(1,1) NOT NULL,
	CategoryName nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SubcategoryName nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CategoryId_BK int NULL,
	CONSTRAINT PK_Dim_Categories PRIMARY KEY (CategoryKey)
);


-- DW.dbo.Dim_Channel definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Channel;

CREATE TABLE DW.dbo.Dim_Channel (
	ChannelKey int IDENTITY(1,1) NOT NULL,
	ChannelName nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK_Dim_Channel PRIMARY KEY (ChannelKey)
);


-- DW.dbo.Dim_Companies definition

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


-- DW.dbo.Dim_Dates definition

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


-- DW.dbo.Dim_Priorities definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Priorities;

CREATE TABLE DW.dbo.Dim_Priorities (
	PriorityKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PriorityId_BK int NULL,
	CONSTRAINT PK_Dim_Priorities PRIMARY KEY (PriorityKey)
);


-- DW.dbo.Dim_Products definition

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


-- DW.dbo.Dim_Status definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Status;

CREATE TABLE DW.dbo.Dim_Status (
	StatusKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	StatusId_BK int NULL,
	CONSTRAINT PK_Dim_Status PRIMARY KEY (StatusKey)
);


-- DW.dbo.Dim_Tags definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Tags;

CREATE TABLE DW.dbo.Dim_Tags (
	TagKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	TagId_BK int NULL,
	CONSTRAINT PK_Dim_Tags PRIMARY KEY (TagKey)
);


-- DW.dbo.Dim_Users definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Users;

CREATE TABLE DW.dbo.Dim_Users (
	UserKey int IDENTITY(1,1) NOT NULL,
	FullName nvarchar(120) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsVIP bit NULL,
	UserId_BK int NULL,
	CONSTRAINT PK_Dim_Users PRIMARY KEY (UserKey)
);


-- DW.dbo.Fact_Tickets definition

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


-- DW.dbo.tb_users definition

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


-- DW.dbo.TermsOfUse definition

-- Drop table

-- DROP TABLE DW.dbo.TermsOfUse;

CREATE TABLE DW.dbo.TermsOfUse (
	Id int IDENTITY(1,1) NOT NULL,
	Version nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Content text COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Title nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Description nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsActive bit DEFAULT 1 NOT NULL,
	EffectiveDate datetime2 DEFAULT getdate() NOT NULL,
	CreatedAt datetime2 DEFAULT getdate() NOT NULL,
	CreatedBy int NULL,
	UpdatedAt datetime2 NULL,
	UpdatedBy int NULL,
	CONSTRAINT PK__TermsOfU__3214EC07CD6A9661 PRIMARY KEY (Id),
	CONSTRAINT UQ__TermsOfU__0F540134960A169A UNIQUE (Version),
	CONSTRAINT FK_TermsOfUse_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES DW.dbo.tb_users(Id),
	CONSTRAINT FK_TermsOfUse_UpdatedBy FOREIGN KEY (UpdatedBy) REFERENCES DW.dbo.tb_users(Id)
);
 CREATE NONCLUSTERED INDEX IDX_TermsOfUse_EffectiveDate ON DW.dbo.TermsOfUse (  EffectiveDate ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_TermsOfUse_IsActive ON DW.dbo.TermsOfUse (  IsActive ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_TermsOfUse_Version ON DW.dbo.TermsOfUse (  Version ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- DW.dbo.UserAuthLogs definition

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


-- DW.dbo.UserTermConsents definition

-- Drop table

-- DROP TABLE DW.dbo.UserTermConsents;

CREATE TABLE DW.dbo.UserTermConsents (
	Id int IDENTITY(1,1) NOT NULL,
	UserId int NOT NULL,
	TermId int NOT NULL,
	ConsentDate datetime2 DEFAULT getdate() NOT NULL,
	IsActive bit DEFAULT 1 NOT NULL,
	IPAddress nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	UserAgent nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	RevokedAt datetime2 NULL,
	RevokedReason nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK__UserTerm__3214EC07A349ACFA PRIMARY KEY (Id),
	CONSTRAINT FK_UserTermConsents_TermId FOREIGN KEY (TermId) REFERENCES DW.dbo.TermsOfUse(Id),
	CONSTRAINT FK_UserTermConsents_UserId FOREIGN KEY (UserId) REFERENCES DW.dbo.tb_users(Id) ON DELETE CASCADE
);
 CREATE NONCLUSTERED INDEX IDX_UserTermConsents_IsActive ON DW.dbo.UserTermConsents (  IsActive ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_UserTermConsents_TermId ON DW.dbo.UserTermConsents (  TermId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_UserTermConsents_UserId ON DW.dbo.UserTermConsents (  UserId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE UNIQUE NONCLUSTERED INDEX UNQ_UserTermConsents_Active ON DW.dbo.UserTermConsents (  UserId ASC  , TermId ASC  )  
	 WHERE  ([IsActive]=(1))
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- DW.dbo.TermItems definition

-- Drop table

-- DROP TABLE DW.dbo.TermItems;

CREATE TABLE DW.dbo.TermItems (
	Id int IDENTITY(1,1) NOT NULL,
	TermId int NOT NULL,
	ItemOrder int DEFAULT 1 NOT NULL,
	Title nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Content text COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	IsMandatory bit DEFAULT 0 NOT NULL,
	IsActive bit DEFAULT 1 NOT NULL,
	CreatedAt datetime2 DEFAULT getdate() NOT NULL,
	UpdatedAt datetime2 NULL,
	CONSTRAINT PK__TermItem__3214EC077C5756B0 PRIMARY KEY (Id),
	CONSTRAINT FK_TermItems_TermId FOREIGN KEY (TermId) REFERENCES DW.dbo.TermsOfUse(Id) ON DELETE CASCADE
);
 CREATE NONCLUSTERED INDEX IDX_TermItems_IsActive ON DW.dbo.TermItems (  IsActive ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_TermItems_IsMandatory ON DW.dbo.TermItems (  IsMandatory ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_TermItems_TermId ON DW.dbo.TermItems (  TermId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- DW.dbo.UserItemConsents definition

-- Drop table

-- DROP TABLE DW.dbo.UserItemConsents;

CREATE TABLE DW.dbo.UserItemConsents (
	Id int IDENTITY(1,1) NOT NULL,
	UserConsentId int NOT NULL,
	ItemId int NOT NULL,
	Accepted bit NOT NULL,
	ConsentDate datetime2 DEFAULT getdate() NOT NULL,
	CONSTRAINT PK__UserItem__3214EC07A70D24D0 PRIMARY KEY (Id),
	CONSTRAINT FK_UserItemConsents_ItemId FOREIGN KEY (ItemId) REFERENCES DW.dbo.TermItems(Id),
	CONSTRAINT FK_UserItemConsents_UserConsentId FOREIGN KEY (UserConsentId) REFERENCES DW.dbo.UserTermConsents(Id) ON DELETE CASCADE
);
 CREATE NONCLUSTERED INDEX IDX_UserItemConsents_Accepted ON DW.dbo.UserItemConsents (  Accepted ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_UserItemConsents_ItemId ON DW.dbo.UserItemConsents (  ItemId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_UserItemConsents_UserConsentId ON DW.dbo.UserItemConsents (  UserConsentId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;

-- DROP SCHEMA dbo;

CREATE SCHEMA dbo;
-- DW.dbo.Dim_Agents definition

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


-- DW.dbo.Dim_Categories definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Categories;

CREATE TABLE DW.dbo.Dim_Categories (
	CategoryKey int IDENTITY(1,1) NOT NULL,
	CategoryName nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SubcategoryName nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CategoryId_BK int NULL,
	CONSTRAINT PK_Dim_Categories PRIMARY KEY (CategoryKey)
);


-- DW.dbo.Dim_Channel definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Channel;

CREATE TABLE DW.dbo.Dim_Channel (
	ChannelKey int IDENTITY(1,1) NOT NULL,
	ChannelName nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK_Dim_Channel PRIMARY KEY (ChannelKey)
);


-- DW.dbo.Dim_Companies definition

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


-- DW.dbo.Dim_Dates definition

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


-- DW.dbo.Dim_Priorities definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Priorities;

CREATE TABLE DW.dbo.Dim_Priorities (
	PriorityKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PriorityId_BK int NULL,
	CONSTRAINT PK_Dim_Priorities PRIMARY KEY (PriorityKey)
);


-- DW.dbo.Dim_Products definition

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


-- DW.dbo.Dim_Status definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Status;

CREATE TABLE DW.dbo.Dim_Status (
	StatusKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	StatusId_BK int NULL,
	CONSTRAINT PK_Dim_Status PRIMARY KEY (StatusKey)
);


-- DW.dbo.Dim_Tags definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Tags;

CREATE TABLE DW.dbo.Dim_Tags (
	TagKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	TagId_BK int NULL,
	CONSTRAINT PK_Dim_Tags PRIMARY KEY (TagKey)
);


-- DW.dbo.Dim_Users definition

-- Drop table

-- DROP TABLE DW.dbo.Dim_Users;

CREATE TABLE DW.dbo.Dim_Users (
	UserKey int IDENTITY(1,1) NOT NULL,
	FullName nvarchar(120) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsVIP bit NULL,
	UserId_BK int NULL,
	CONSTRAINT PK_Dim_Users PRIMARY KEY (UserKey)
);


-- DW.dbo.Fact_Tickets definition

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


-- DW.dbo.tb_users definition

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


-- DW.dbo.TermsOfUse definition

-- Drop table

-- DROP TABLE DW.dbo.TermsOfUse;

CREATE TABLE DW.dbo.TermsOfUse (
	Id int IDENTITY(1,1) NOT NULL,
	Version nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Content text COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Title nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Description nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsActive bit DEFAULT 1 NOT NULL,
	EffectiveDate datetime2 DEFAULT getdate() NOT NULL,
	CreatedAt datetime2 DEFAULT getdate() NOT NULL,
	CreatedBy int NULL,
	UpdatedAt datetime2 NULL,
	UpdatedBy int NULL,
	CONSTRAINT PK__TermsOfU__3214EC07CD6A9661 PRIMARY KEY (Id),
	CONSTRAINT UQ__TermsOfU__0F540134960A169A UNIQUE (Version),
	CONSTRAINT FK_TermsOfUse_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES DW.dbo.tb_users(Id),
	CONSTRAINT FK_TermsOfUse_UpdatedBy FOREIGN KEY (UpdatedBy) REFERENCES DW.dbo.tb_users(Id)
);
 CREATE NONCLUSTERED INDEX IDX_TermsOfUse_EffectiveDate ON DW.dbo.TermsOfUse (  EffectiveDate ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_TermsOfUse_IsActive ON DW.dbo.TermsOfUse (  IsActive ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_TermsOfUse_Version ON DW.dbo.TermsOfUse (  Version ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- DW.dbo.UserAuthLogs definition

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


-- DW.dbo.UserTermConsents definition

-- Drop table

-- DROP TABLE DW.dbo.UserTermConsents;

CREATE TABLE DW.dbo.UserTermConsents (
	Id int IDENTITY(1,1) NOT NULL,
	UserId int NOT NULL,
	TermId int NOT NULL,
	ConsentDate datetime2 DEFAULT getdate() NOT NULL,
	IsActive bit DEFAULT 1 NOT NULL,
	IPAddress nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	UserAgent nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	RevokedAt datetime2 NULL,
	RevokedReason nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK__UserTerm__3214EC07A349ACFA PRIMARY KEY (Id),
	CONSTRAINT FK_UserTermConsents_TermId FOREIGN KEY (TermId) REFERENCES DW.dbo.TermsOfUse(Id),
	CONSTRAINT FK_UserTermConsents_UserId FOREIGN KEY (UserId) REFERENCES DW.dbo.tb_users(Id) ON DELETE CASCADE
);
 CREATE NONCLUSTERED INDEX IDX_UserTermConsents_IsActive ON DW.dbo.UserTermConsents (  IsActive ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_UserTermConsents_TermId ON DW.dbo.UserTermConsents (  TermId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_UserTermConsents_UserId ON DW.dbo.UserTermConsents (  UserId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE UNIQUE NONCLUSTERED INDEX UNQ_UserTermConsents_Active ON DW.dbo.UserTermConsents (  UserId ASC  , TermId ASC  )  
	 WHERE  ([IsActive]=(1))
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- DW.dbo.TermItems definition

-- Drop table

-- DROP TABLE DW.dbo.TermItems;

CREATE TABLE DW.dbo.TermItems (
	Id int IDENTITY(1,1) NOT NULL,
	TermId int NOT NULL,
	ItemOrder int DEFAULT 1 NOT NULL,
	Title nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Content text COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	IsMandatory bit DEFAULT 0 NOT NULL,
	IsActive bit DEFAULT 1 NOT NULL,
	CreatedAt datetime2 DEFAULT getdate() NOT NULL,
	UpdatedAt datetime2 NULL,
	CONSTRAINT PK__TermItem__3214EC077C5756B0 PRIMARY KEY (Id),
	CONSTRAINT FK_TermItems_TermId FOREIGN KEY (TermId) REFERENCES DW.dbo.TermsOfUse(Id) ON DELETE CASCADE
);
 CREATE NONCLUSTERED INDEX IDX_TermItems_IsActive ON DW.dbo.TermItems (  IsActive ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_TermItems_IsMandatory ON DW.dbo.TermItems (  IsMandatory ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_TermItems_TermId ON DW.dbo.TermItems (  TermId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- DW.dbo.UserItemConsents definition

-- Drop table

-- DROP TABLE DW.dbo.UserItemConsents;

CREATE TABLE DW.dbo.UserItemConsents (
	Id int IDENTITY(1,1) NOT NULL,
	UserConsentId int NOT NULL,
	ItemId int NOT NULL,
	Accepted bit NOT NULL,
	ConsentDate datetime2 DEFAULT getdate() NOT NULL,
	CONSTRAINT PK__UserItem__3214EC07A70D24D0 PRIMARY KEY (Id),
	CONSTRAINT FK_UserItemConsents_ItemId FOREIGN KEY (ItemId) REFERENCES DW.dbo.TermItems(Id),
	CONSTRAINT FK_UserItemConsents_UserConsentId FOREIGN KEY (UserConsentId) REFERENCES DW.dbo.UserTermConsents(Id) ON DELETE CASCADE
);
 CREATE NONCLUSTERED INDEX IDX_UserItemConsents_Accepted ON DW.dbo.UserItemConsents (  Accepted ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_UserItemConsents_ItemId ON DW.dbo.UserItemConsents (  ItemId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IDX_UserItemConsents_UserConsentId ON DW.dbo.UserItemConsents (  UserConsentId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;

CREATE TRIGGER TR_TermItems_CheckSingleMandatory
ON dbo.TermItems
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT TermId
        FROM dbo.TermItems
        WHERE IsMandatory = 1 AND IsActive = 1
        GROUP BY TermId
        HAVING COUNT(*) > 1
    )
    BEGIN
        RAISERROR('Cada termo pode ter apenas 1 item obrigatório ativo', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;

CREATE   TRIGGER TR_TermsOfUse_RecalculateActive
ON TermsOfUse
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Se houve inserção ou atualização de EffectiveDate ou IsActive
    IF EXISTS (
        SELECT 1
        FROM inserted i
        LEFT JOIN deleted d ON i.Id = d.Id
        WHERE d.Id IS NULL -- INSERT
           OR i.EffectiveDate <> d.EffectiveDate -- UPDATE EffectiveDate
           OR i.IsActive <> d.IsActive -- UPDATE IsActive
    )
    BEGIN
        -- Recalcular termo ativo
        EXEC SP_RecalculateActiveTerm;
    END
END;