-- DROP SCHEMA DW;

CREATE SCHEMA DW;
-- [banco-api].DW.Dim_Agents definition

-- Drop table

-- DROP TABLE [banco-api].DW.Dim_Agents;

CREATE TABLE [banco-api].DW.Dim_Agents (
	AgentKey int IDENTITY(1,1) NOT NULL,
	FullName nvarchar(120) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	DepartmentName nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsActive bit NULL,
	AgentId_BK int NULL,
	CONSTRAINT PK__Dim_Agen__035B2D778BC0A937 PRIMARY KEY (AgentKey)
);


-- [banco-api].DW.Dim_Categories definition

-- Drop table

-- DROP TABLE [banco-api].DW.Dim_Categories;

CREATE TABLE [banco-api].DW.Dim_Categories (
	CategoryKey int IDENTITY(1,1) NOT NULL,
	CategoryName nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SubcategoryName nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CategoryId_BK int NULL,
	CONSTRAINT PK__Dim_Cate__76B0FE4157607DDA PRIMARY KEY (CategoryKey)
);


-- [banco-api].DW.Dim_Channel definition

-- Drop table

-- DROP TABLE [banco-api].DW.Dim_Channel;

CREATE TABLE [banco-api].DW.Dim_Channel (
	ChannelKey int IDENTITY(1,1) NOT NULL,
	ChannelName nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK__Dim_Tick__D88CB9CC838F87BD PRIMARY KEY (ChannelKey)
);


-- [banco-api].DW.Dim_Companies definition

-- Drop table

-- DROP TABLE [banco-api].DW.Dim_Companies;

CREATE TABLE [banco-api].DW.Dim_Companies (
	CompanyKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(120) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Segmento nvarchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CNPJ varchar(32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CompanyId_BK int NULL,
	CONSTRAINT PK__Dim_Comp__5A25F59BBB30792D PRIMARY KEY (CompanyKey)
);


-- [banco-api].DW.Dim_Priorities definition

-- Drop table

-- DROP TABLE [banco-api].DW.Dim_Priorities;

CREATE TABLE [banco-api].DW.Dim_Priorities (
	PriorityKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PriorityId_BK int NULL,
	CONSTRAINT PK__Dim_Prio__B13FBEA7820AA572 PRIMARY KEY (PriorityKey)
);


-- [banco-api].DW.Dim_Products definition

-- Drop table

-- DROP TABLE [banco-api].DW.Dim_Products;

CREATE TABLE [banco-api].DW.Dim_Products (
	ProductKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Code nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsActive bit NULL,
	ProductId_BK int NULL,
	CONSTRAINT PK__Dim_Prod__A15E99B38196BCBE PRIMARY KEY (ProductKey)
);


-- [banco-api].DW.Dim_Status definition

-- Drop table

-- DROP TABLE [banco-api].DW.Dim_Status;

CREATE TABLE [banco-api].DW.Dim_Status (
	StatusKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	StatusId_BK int NULL,
	CONSTRAINT PK__Dim_Stat__096C98C3C05B2F29 PRIMARY KEY (StatusKey)
);


-- [banco-api].DW.Dim_Tags definition

-- Drop table

-- DROP TABLE [banco-api].DW.Dim_Tags;

CREATE TABLE [banco-api].DW.Dim_Tags (
	TagKey int IDENTITY(1,1) NOT NULL,
	Name nvarchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	TagId_BK int NULL,
	CONSTRAINT PK__Dim_Tags__CA370A7A1983CFFA PRIMARY KEY (TagKey)
);


-- [banco-api].DW.Dim_Users definition

-- Drop table

-- DROP TABLE [banco-api].DW.Dim_Users;

CREATE TABLE [banco-api].DW.Dim_Users (
	UserKey int IDENTITY(1,1) NOT NULL,
	FullName nvarchar(120) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsVIP bit NULL,
	UserId_BK int NULL,
	CONSTRAINT PK__Dim_User__296ADCF18B324DBF PRIMARY KEY (UserKey)
);


-- [banco-api].DW.Fact_Tickets definition

-- Drop table

-- DROP TABLE [banco-api].DW.Fact_Tickets;

CREATE TABLE [banco-api].DW.Fact_Tickets (
	TicketKey bigint IDENTITY(1,1) NOT NULL,
	UserKey int NULL,
	AgentKey int NULL,
	CompanyKey int NULL,
	CategoryKey int NULL,
	PriorityKey int NULL,
	StatusKey int NULL,
	ProductKey int NULL,
	TagKey int NULL,
	QtTickets int NULL,
	ChannelKey int NULL,
	CONSTRAINT PK__Fact_Tic__D88CB9CC7CB8B557 PRIMARY KEY (TicketKey),
	CONSTRAINT FK__Fact_Tick__Agent__607251E5 FOREIGN KEY (AgentKey) REFERENCES [banco-api].DW.Dim_Agents(AgentKey),
	CONSTRAINT FK__Fact_Tick__Categ__625A9A57 FOREIGN KEY (CategoryKey) REFERENCES [banco-api].DW.Dim_Categories(CategoryKey),
	CONSTRAINT FK__Fact_Tick__Compa__6166761E FOREIGN KEY (CompanyKey) REFERENCES [banco-api].DW.Dim_Companies(CompanyKey),
	CONSTRAINT FK__Fact_Tick__Prior__634EBE90 FOREIGN KEY (PriorityKey) REFERENCES [banco-api].DW.Dim_Priorities(PriorityKey),
	CONSTRAINT FK__Fact_Tick__Produ__65370702 FOREIGN KEY (ProductKey) REFERENCES [banco-api].DW.Dim_Products(ProductKey),
	CONSTRAINT FK__Fact_Tick__Statu__6442E2C9 FOREIGN KEY (StatusKey) REFERENCES [banco-api].DW.Dim_Status(StatusKey),
	CONSTRAINT FK__Fact_Tick__TagKe__662B2B3B FOREIGN KEY (TagKey) REFERENCES [banco-api].DW.Dim_Tags(TagKey),
	CONSTRAINT FK__Fact_Tick__UserK__5F7E2DAC FOREIGN KEY (UserKey) REFERENCES [banco-api].DW.Dim_Users(UserKey),
	CONSTRAINT fk_fact_channel FOREIGN KEY (ChannelKey) REFERENCES [banco-api].DW.Dim_Channel(ChannelKey)
);