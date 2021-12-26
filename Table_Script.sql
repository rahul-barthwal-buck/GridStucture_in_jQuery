/*Author name: Rahul Barthwal*/
/*Objective: Table Creation*/

USE [GridStructure]
GO
/****** Object:  Table [dbo].[ProductDetails]    Script Date: 12/26/2021 10:04:06 PM ******/
DROP TABLE IF EXISTS [dbo].[ProductDetails]
GO
/****** Object:  Table [dbo].[ProductDetails]    Script Date: 12/26/2021 10:04:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductDetails](
	[Product_Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
	[Quantity_Per_Unit] [int] NOT NULL,
	[Unit_Price] [int] NOT NULL,
	[Units_In_Stock] [int] NOT NULL,
 CONSTRAINT [PK_ProductDetails] PRIMARY KEY CLUSTERED 
(
	[Product_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ProductDetails] ON 
GO
INSERT [dbo].[ProductDetails] ([Product_Id], [Name], [Quantity_Per_Unit], [Unit_Price], [Units_In_Stock]) VALUES (8, N'One Plus 8 Pro', 30, 750, 26)
GO
INSERT [dbo].[ProductDetails] ([Product_Id], [Name], [Quantity_Per_Unit], [Unit_Price], [Units_In_Stock]) VALUES (9, N'IPhone 13 Max Pro', 21, 1500, 16)
GO
INSERT [dbo].[ProductDetails] ([Product_Id], [Name], [Quantity_Per_Unit], [Unit_Price], [Units_In_Stock]) VALUES (11, N'Realme X2 pro', 24, 450, 27)
GO
INSERT [dbo].[ProductDetails] ([Product_Id], [Name], [Quantity_Per_Unit], [Unit_Price], [Units_In_Stock]) VALUES (12, N'Realme Nazro 50A', 35, 340, 12)
GO
INSERT [dbo].[ProductDetails] ([Product_Id], [Name], [Quantity_Per_Unit], [Unit_Price], [Units_In_Stock]) VALUES (14, N'IPhone 13 mini', 34, 1300, 30)
GO
INSERT [dbo].[ProductDetails] ([Product_Id], [Name], [Quantity_Per_Unit], [Unit_Price], [Units_In_Stock]) VALUES (15, N'Oppo reno', 11, 500, 33)
GO
INSERT [dbo].[ProductDetails] ([Product_Id], [Name], [Quantity_Per_Unit], [Unit_Price], [Units_In_Stock]) VALUES (16, N'Nokia 123', 45, 400, 24)
GO
INSERT [dbo].[ProductDetails] ([Product_Id], [Name], [Quantity_Per_Unit], [Unit_Price], [Units_In_Stock]) VALUES (17, N'Nokia k234', 23, 345, 56)
GO
INSERT [dbo].[ProductDetails] ([Product_Id], [Name], [Quantity_Per_Unit], [Unit_Price], [Units_In_Stock]) VALUES (18, N'Micromax k10', 324, 200, 70)
GO
INSERT [dbo].[ProductDetails] ([Product_Id], [Name], [Quantity_Per_Unit], [Unit_Price], [Units_In_Stock]) VALUES (19, N'Samsung A31', 23, 500, 11)
GO
INSERT [dbo].[ProductDetails] ([Product_Id], [Name], [Quantity_Per_Unit], [Unit_Price], [Units_In_Stock]) VALUES (21, N'Samsung A51', 45, 500, 45)
GO
INSERT [dbo].[ProductDetails] ([Product_Id], [Name], [Quantity_Per_Unit], [Unit_Price], [Units_In_Stock]) VALUES (22, N'Poco X3', 23, 400, 25)
GO
SET IDENTITY_INSERT [dbo].[ProductDetails] OFF
GO
