---Script to create Cape_Codd tables in the QACS database for purchase order stored procedure

/****** Object:  Table [dbo].[tblUSPBuyer]    Script Date: 5/12/2015 10:08:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblUSPBuyer](
	[Buyer] [varchar](55) NOT NULL,
	[Department] [varchar](60) NULL,
PRIMARY KEY CLUSTERED 
(
	[Buyer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblUSPWarehouse]    Script Date: 11/9/2015 11:46:20 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[tblUSPWarehouse](
	[WarehouseID] [int] NOT NULL,
	[WarehouseCity] [char](30) NOT NULL,
	[WarehouseState] [char](2) NOT NULL,
	[Manager] [char](35) NULL,
	[SquareFeet] [int] NULL,
 CONSTRAINT [WAREHOUSE_PK] PRIMARY KEY CLUSTERED 
(
	[WarehouseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[tblUSPInventory]    Script Date: 5/12/2015 10:08:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblUSPInventory](
	[WarehouseID] [int] NOT NULL,
	[SKU] [int] NOT NULL,
	[SKU_Description] [char](35) NOT NULL,
	[QuantityOnHand] [int] NULL,
	[QuantityOnOrder] [int] NULL,
 CONSTRAINT [INVENTORY_PK] PRIMARY KEY CLUSTERED 
(
	[WarehouseID] ASC,
	[SKU] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblUSPOrderItem]    Script Date: 5/12/2015 10:08:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUSPOrderItem](
	[OrderNumber] [int] NOT NULL,
	[SKU] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Price] [money] NOT NULL,
	[ExtendedPrice] [money] NOT NULL,
 CONSTRAINT [ORDER_ITEM_PK] PRIMARY KEY CLUSTERED 
(
	[SKU] ASC,
	[OrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblUSPPerson]    Script Date: 5/12/2015 10:08:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblUSPPerson](
	[PersonID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NULL,
	[LastName] [varchar](50) NULL,
	[FirstName] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblUSPRetailOrder]    Script Date: 5/12/2015 10:08:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblUSPRetailOrder](
	[OrderNumber] [int] NOT NULL,
	[StoreNumber] [int] NULL,
	[StoreZip] [char](9) NULL,
	[OrderMonth] [char](12) NOT NULL,
	[OrderYear] [int] NOT NULL,
	[OrderTotal] [money] NULL,
 CONSTRAINT [RETAIL_ORDER_PK] PRIMARY KEY CLUSTERED 
(
	[OrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblUSPSkuData]    Script Date: 5/12/2015 10:08:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblUSPSkuData](
	[SKU] [int] NOT NULL,
	[SKU_Description] [char](35) NOT NULL,
	[Department] [char](30) NOT NULL,
	[Buyer] [varchar](55) NOT NULL,
 CONSTRAINT [SKU_DATA_PK] PRIMARY KEY CLUSTERED 
(
	[SKU] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO


INSERT [dbo].[tblUSPWarehouse] ([WarehouseID], [WarehouseCity], [WarehouseState], [Manager], [SquareFeet]) VALUES (100, N'Atlanta                       ', N'GA', N'Dave Jones                         ', 125000)
GO
INSERT [dbo].[tblUSPWarehouse] ([WarehouseID], [WarehouseCity], [WarehouseState], [Manager], [SquareFeet]) VALUES (200, N'Chicago                       ', N'IL', N'Lucille Smith                      ', 100000)
GO
INSERT [dbo].[tblUSPWarehouse] ([WarehouseID], [WarehouseCity], [WarehouseState], [Manager], [SquareFeet]) VALUES (300, N'Bangor                        ', N'ME', N'Bart Evans                         ', 150000)
GO
INSERT [dbo].[tblUSPWarehouse] ([WarehouseID], [WarehouseCity], [WarehouseState], [Manager], [SquareFeet]) VALUES (400, N'Seattle                       ', N'WA', N'Dale Rogers                        ', 130000)
GO
INSERT [dbo].[tblUSPWarehouse] ([WarehouseID], [WarehouseCity], [WarehouseState], [Manager], [SquareFeet]) VALUES (500, N'San Francisco                 ', N'CA', N'Grace Jefferson                    ', 200000)
GO


INSERT [dbo].[tblUSPInventory] ([WarehouseID], [SKU], [SKU_Description], [QuantityOnHand], [QuantityOnOrder]) VALUES (100, 100100, N'Std. Scuba Tank, Yellow            ', 48, 202)
INSERT [dbo].[tblUSPInventory] ([WarehouseID], [SKU], [SKU_Description], [QuantityOnHand], [QuantityOnOrder]) VALUES (100, 100200, N'Std. Scuba Tank, Magenta           ', 20, 210)
INSERT [dbo].[tblUSPInventory] ([WarehouseID], [SKU], [SKU_Description], [QuantityOnHand], [QuantityOnOrder]) VALUES (100, 101100, N'Dive Mask, Small Clear             ', 0, 500)
INSERT [dbo].[tblUSPOrderItem] ([OrderNumber], [SKU], [Quantity], [Price], [ExtendedPrice]) VALUES (3003, 100200, 10, 55.5000, 555.0000)
INSERT [dbo].[tblUSPOrderItem] ([OrderNumber], [SKU], [Quantity], [Price], [ExtendedPrice]) VALUES (3004, 201000, 2, 55.5000, 5550.0000)
INSERT [dbo].[tblUSPOrderItem] ([OrderNumber], [SKU], [Quantity], [Price], [ExtendedPrice]) VALUES (3004, 301000, 2, 55.5000, 5550.0000)
SET IDENTITY_INSERT [dbo].[tblUSPPerson] ON 

INSERT [dbo].[tblUSPPerson] ([PersonID], [Name], [LastName], [FirstName]) VALUES (1, N'Xiaofeng Chen', NULL, NULL)
INSERT [dbo].[tblUSPPerson] ([PersonID], [Name], [LastName], [FirstName]) VALUES (2, N'Kraig Pencil', NULL, NULL)
INSERT [dbo].[tblUSPPerson] ([PersonID], [Name], [LastName], [FirstName]) VALUES (3, N'John Smith', NULL, NULL)
INSERT [dbo].[tblUSPPerson] ([PersonID], [Name], [LastName], [FirstName]) VALUES (4, N'Johnson, Mike', NULL, NULL)
INSERT [dbo].[tblUSPPerson] ([PersonID], [Name], [LastName], [FirstName]) VALUES (5, N'Clinton, Mike', NULL, NULL)
INSERT [dbo].[tblUSPPerson] ([PersonID], [Name], [LastName], [FirstName]) VALUES (6, N'Bush, Mike', NULL, NULL)
INSERT [dbo].[tblUSPPerson] ([PersonID], [Name], [LastName], [FirstName]) VALUES (13, N'Washington, Mike', NULL, NULL)
INSERT [dbo].[tblUSPPerson] ([PersonID], [Name], [LastName], [FirstName]) VALUES (17, N'Lincoln, Abraham', NULL, NULL)
INSERT [dbo].[tblUSPPerson] ([PersonID], [Name], [LastName], [FirstName]) VALUES (18, N'Jefferson, Abraham', NULL, NULL)
INSERT [dbo].[tblUSPPerson] ([PersonID], [Name], [LastName], [FirstName]) VALUES (21, N'Jefferson, Son', NULL, NULL)
INSERT [dbo].[tblUSPPerson] ([PersonID], [Name], [LastName], [FirstName]) VALUES (22, N'Nikson, Son', NULL, NULL)
INSERT [dbo].[tblUSPPerson] ([PersonID], [Name], [LastName], [FirstName]) VALUES (23, N'Lincoln, Son', NULL, NULL)
INSERT [dbo].[tblUSPPerson] ([PersonID], [Name], [LastName], [FirstName]) VALUES (24, N'Lincoln, John', NULL, NULL)
INSERT [dbo].[tblUSPPerson] ([PersonID], [Name], [LastName], [FirstName]) VALUES (25, N'Clinton, John', NULL, NULL)
INSERT [dbo].[tblUSPPerson] ([PersonID], [Name], [LastName], [FirstName]) VALUES (7, N'Test Person', NULL, NULL)
INSERT [dbo].[tblUSPPerson] ([PersonID], [Name], [LastName], [FirstName]) VALUES (26, N'Smith, Kyle', NULL, NULL)
INSERT [dbo].[tblUSPPerson] ([PersonID], [Name], [LastName], [FirstName]) VALUES (27, N'Smith, Kyle', NULL, NULL)
INSERT [dbo].[tblUSPPerson] ([PersonID], [Name], [LastName], [FirstName]) VALUES (1026, N'Jackson smith', NULL, NULL)
INSERT [dbo].[tblUSPPerson] ([PersonID], [Name], [LastName], [FirstName]) VALUES (1027, N'Jackson smith', N'smith', NULL)
INSERT [dbo].[tblUSPPerson] ([PersonID], [Name], [LastName], [FirstName]) VALUES (1028, N'Jackson Chen', N'Chen', NULL)
SET IDENTITY_INSERT [dbo].[tblUSPPerson] OFF
INSERT [dbo].[tblUSPRetailOrder] ([OrderNumber], [StoreNumber], [StoreZip], [OrderMonth], [OrderYear], [OrderTotal]) VALUES (300, 10, N'98110    ', N'Janurary    ', 2015, 500.0000)
INSERT [dbo].[tblUSPRetailOrder] ([OrderNumber], [StoreNumber], [StoreZip], [OrderMonth], [OrderYear], [OrderTotal]) VALUES (1000, 10, N'98110    ', N'December    ', 2010, 445.0000)
INSERT [dbo].[tblUSPRetailOrder] ([OrderNumber], [StoreNumber], [StoreZip], [OrderMonth], [OrderYear], [OrderTotal]) VALUES (2000, 20, N'02335    ', N'December    ', 2010, 310.0000)
INSERT [dbo].[tblUSPRetailOrder] ([OrderNumber], [StoreNumber], [StoreZip], [OrderMonth], [OrderYear], [OrderTotal]) VALUES (3000, 10, N'98110    ', N'January     ', 2011, 480.0000)
INSERT [dbo].[tblUSPRetailOrder] ([OrderNumber], [StoreNumber], [StoreZip], [OrderMonth], [OrderYear], [OrderTotal]) VALUES (3002, 10, N'98110    ', N'Janurary    ', 2015, 500.0000)
INSERT [dbo].[tblUSPRetailOrder] ([OrderNumber], [StoreNumber], [StoreZip], [OrderMonth], [OrderYear], [OrderTotal]) VALUES (3003, 10, N'98110    ', N'Janurary    ', 2015, 500.0000)
INSERT [dbo].[tblUSPRetailOrder] ([OrderNumber], [StoreNumber], [StoreZip], [OrderMonth], [OrderYear], [OrderTotal]) VALUES (3004, 10, N'98110    ', N'Janurary    ', 2015, 500.0000)
INSERT [dbo].[tblUSPSkuData] ([SKU], [SKU_Description], [Department], [Buyer]) VALUES (100100, N'Std. Scuba Tank, Yellow            ', N'Water Sports                  ', N'Pete Hansen                        ')
INSERT [dbo].[tblUSPSkuData] ([SKU], [SKU_Description], [Department], [Buyer]) VALUES (100200, N'Std. Scuba Tank, Magenta           ', N'Water Sports                  ', N'Pete Hansen                        ')
INSERT [dbo].[tblUSPSkuData] ([SKU], [SKU_Description], [Department], [Buyer]) VALUES (101100, N'Dive Mask, Small Clear             ', N'Water Sports                  ', N'Nancy Meyers                       ')
INSERT [dbo].[tblUSPSkuData] ([SKU], [SKU_Description], [Department], [Buyer]) VALUES (101200, N'Dive Mask, Med Clear               ', N'Water Sports                  ', N'Nancy Meyers                       ')
INSERT [dbo].[tblUSPSkuData] ([SKU], [SKU_Description], [Department], [Buyer]) VALUES (201000, N'Half-dome Tent                     ', N'Camping                       ', N'Cindy Lo                           ')
INSERT [dbo].[tblUSPSkuData] ([SKU], [SKU_Description], [Department], [Buyer]) VALUES (202000, N'Half-dome Tent Vestibule           ', N'Camping                       ', N'Cindy Lo                           ')
INSERT [dbo].[tblUSPSkuData] ([SKU], [SKU_Description], [Department], [Buyer]) VALUES (301000, N'Light Fly Climbing Harness         ', N'Climbing                      ', N'Jerry Martin                       ')
INSERT [dbo].[tblUSPSkuData] ([SKU], [SKU_Description], [Department], [Buyer]) VALUES (302000, N'Locking Carabiner, Oval            ', N'Climbing                      ', N'Jerry Martin                       ')
INSERT [dbo].[tblUSPSkuData] ([SKU], [SKU_Description], [Department], [Buyer]) VALUES (303000, N'Climbing rope-6 inch               ', N'Climbing                      ', N'Pete Hansen')
ALTER TABLE [dbo].[tblUSPInventory]  WITH CHECK ADD  CONSTRAINT [SKU_DATA_Relationship] FOREIGN KEY([SKU])
REFERENCES [dbo].[tblUSPSkuData] ([SKU])
GO
ALTER TABLE [dbo].[tblUSPInventory] CHECK CONSTRAINT [SKU_DATA_Relationship]
GO
ALTER TABLE [dbo].[tblUSPInventory]  WITH CHECK ADD  CONSTRAINT [WAREHOUSE_Relationship] FOREIGN KEY([WarehouseID])
REFERENCES [dbo].[tblUSPWarehouse] ([WarehouseID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[tblUSPInventory] CHECK CONSTRAINT [WAREHOUSE_Relationship]
GO
ALTER TABLE [dbo].[tblUSPOrderItem]  WITH CHECK ADD  CONSTRAINT [RETAIL_ORDER_Relationship] FOREIGN KEY([OrderNumber])
REFERENCES [dbo].[tblUSPRetailOrder] ([OrderNumber])
GO
ALTER TABLE [dbo].[tblUSPOrderItem] CHECK CONSTRAINT [RETAIL_ORDER_Relationship]
GO
ALTER TABLE [dbo].[tblUSPOrderItem]  WITH CHECK ADD  CONSTRAINT [SKU_Relationship] FOREIGN KEY([SKU])
REFERENCES [dbo].[tblUSPSkuData] ([SKU])
GO
ALTER TABLE [dbo].[tblUSPOrderItem] CHECK CONSTRAINT [SKU_Relationship]
GO
