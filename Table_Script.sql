/*Author name: Rahul Barthwal*/
/*Objective: Table Creation*/

USE [GridStructure]
GO
/****** Object:  Table [dbo].[ProductDetails]    Script Date: 12/23/2021 6:55:46 PM ******/
DROP TABLE IF EXISTS [dbo].[ProductDetails]
GO
/****** Object:  Table [dbo].[ProductDetails]    Script Date: 12/23/2021 6:55:46 PM ******/
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
INSERT [dbo].[ProductDetails] ([Product_Id], [Name], [Quantity_Per_Unit], [Unit_Price], [Units_In_Stock]) VALUES (8, N'One Plus 8 Pro', 30, 750, 20)
GO
INSERT [dbo].[ProductDetails] ([Product_Id], [Name], [Quantity_Per_Unit], [Unit_Price], [Units_In_Stock]) VALUES (9, N'IPhone 13 Max Pro', 21, 1500, 15)
GO
SET IDENTITY_INSERT [dbo].[ProductDetails] OFF
GO
