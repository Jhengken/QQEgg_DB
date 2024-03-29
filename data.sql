USE [dbX]
GO
SET IDENTITY_INSERT [dbo].[tCustomers] ON 

INSERT [dbo].[tCustomers] ([CustomerID], [Name], [Sex], [Email], [Phone], [Password], [Birth], [CreditCard], [CreditPoints], [BlackListed]) VALUES (1, N'欸另', NULL, N'111@gmail.com', N'0911111111', N'$2a$10$1FJqseug2mCQE8h7FdbTIOdBIjq0.hSgBDDupSINPXKpVJCgbshiG', NULL, NULL, 100, 1)
INSERT [dbo].[tCustomers] ([CustomerID], [Name], [Sex], [Email], [Phone], [Password], [Birth], [CreditCard], [CreditPoints], [BlackListed]) VALUES (2, N'阿奇', NULL, N'222@gmail.com', N'0922222222', N'$2a$10$psmPdpAmXTvN322JsIjY5.tVKjF3SWzN2GxOPp9b5FlT9Z0ZfeLSW', NULL, NULL, 100, 1)
INSERT [dbo].[tCustomers] ([CustomerID], [Name], [Sex], [Email], [Phone], [Password], [Birth], [CreditCard], [CreditPoints], [BlackListed]) VALUES (3, N'Ken ccc', NULL, N'sam831019ya@gmail.com', N'123', N'$2a$12$K1l.d7FTDhvFi7/mLWE32u7/0yWaBgx3SA0gW.JfNcK8nYZos.xzC', NULL, NULL, 100, 0)
INSERT [dbo].[tCustomers] ([CustomerID], [Name], [Sex], [Email], [Phone], [Password], [Birth], [CreditCard], [CreditPoints], [BlackListed]) VALUES (13, N'124124', NULL, N'xiang0316xiang@gmail.com', N'44444', NULL, NULL, NULL, 100, 0)
INSERT [dbo].[tCustomers] ([CustomerID], [Name], [Sex], [Email], [Phone], [Password], [Birth], [CreditCard], [CreditPoints], [BlackListed]) VALUES (14, N'Ken ccc', NULL, N'sam831020ya@gmail.com', NULL, N'$2a$12$dH7aN.ehaBbCj1MkcaBs1OQAFOobz1WLymIXWHITeAIXy3Iyys3Je', NULL, NULL, 100, 0)
SET IDENTITY_INSERT [dbo].[tCustomers] OFF
GO
SET IDENTITY_INSERT [dbo].[tSuppliers] ON 

INSERT [dbo].[tSuppliers] ([SupplierID], [Name], [Email], [Phone], [Password], [Address], [CreditPoints], [BlackListed]) VALUES (1, N'宜琳', N'bb@gmail.com', N'0911199987', NULL, N'台南市南區', 100, 0)
INSERT [dbo].[tSuppliers] ([SupplierID], [Name], [Email], [Phone], [Password], [Address], [CreditPoints], [BlackListed]) VALUES (8, N'明明', N'mm@gmail.com', N'09222', N'$2a$10$XoqMCqqABSZ6mRDuy0XyPeTXCc07.hGR9KHAlddSYfSfnKVzq7fri', N'台南市東區', 100, 0)
INSERT [dbo].[tSuppliers] ([SupplierID], [Name], [Email], [Phone], [Password], [Address], [CreditPoints], [BlackListed]) VALUES (9, N'賣西瓜', N'mimi@gmail.com', N'09333', N'$2a$10$3btEagcgJcfV1s9l4q0npOrlr1VHlYmoiONr6msz4wvldxb.4NSYy', NULL, 100, 0)
SET IDENTITY_INSERT [dbo].[tSuppliers] OFF
GO
SET IDENTITY_INSERT [dbo].[tProducts] ON 

INSERT [dbo].[tProducts] ([ProductID], [SupplierID], [Name]) VALUES (1, 1, N'宜琳')
INSERT [dbo].[tProducts] ([ProductID], [SupplierID], [Name]) VALUES (2, 8, N'明明的產品')
INSERT [dbo].[tProducts] ([ProductID], [SupplierID], [Name]) VALUES (3, 9, N'賣西瓜')
SET IDENTITY_INSERT [dbo].[tProducts] OFF
GO
SET IDENTITY_INSERT [dbo].[tCOrders] ON 

INSERT [dbo].[tCOrders] ([OrderID], [TradeNo], [CustomerID], [ProductID], [OrderDate], [CancelDate], [StartDate], [EndDate]) VALUES (1, N'20230328081727768581', 3, 1, CAST(N'2023-03-28T08:18:00.250' AS DateTime), NULL, CAST(N'2023-03-29T01:00:00.000' AS DateTime), CAST(N'2023-03-29T02:00:00.000' AS DateTime))
INSERT [dbo].[tCOrders] ([OrderID], [TradeNo], [CustomerID], [ProductID], [OrderDate], [CancelDate], [StartDate], [EndDate]) VALUES (2, N'20230328081914911751', 3, 1, CAST(N'2023-03-28T08:19:32.483' AS DateTime), NULL, CAST(N'2023-03-29T01:00:00.000' AS DateTime), CAST(N'2023-03-29T04:00:00.000' AS DateTime))
INSERT [dbo].[tCOrders] ([OrderID], [TradeNo], [CustomerID], [ProductID], [OrderDate], [CancelDate], [StartDate], [EndDate]) VALUES (3, N'20230328082343550843', 3, 1, CAST(N'2023-03-28T08:24:07.737' AS DateTime), CAST(N'2023-03-29T10:37:11.723' AS DateTime), CAST(N'2023-03-29T00:00:00.000' AS DateTime), CAST(N'2023-03-31T12:00:00.000' AS DateTime))
INSERT [dbo].[tCOrders] ([OrderID], [TradeNo], [CustomerID], [ProductID], [OrderDate], [CancelDate], [StartDate], [EndDate]) VALUES (4, N'20230328171849885233', 3, 1, CAST(N'2023-03-28T17:19:51.507' AS DateTime), CAST(N'2023-03-29T10:37:09.433' AS DateTime), CAST(N'2023-03-29T03:30:00.000' AS DateTime), CAST(N'2023-03-29T11:30:00.000' AS DateTime))
INSERT [dbo].[tCOrders] ([OrderID], [TradeNo], [CustomerID], [ProductID], [OrderDate], [CancelDate], [StartDate], [EndDate]) VALUES (5, N'20230328172108784351', 3, 3, CAST(N'2023-03-28T17:21:49.367' AS DateTime), NULL, CAST(N'2023-03-29T03:00:00.000' AS DateTime), CAST(N'2023-03-28T01:30:00.000' AS DateTime))
INSERT [dbo].[tCOrders] ([OrderID], [TradeNo], [CustomerID], [ProductID], [OrderDate], [CancelDate], [StartDate], [EndDate]) VALUES (6, N'20230328175640001312', 3, 1, CAST(N'2023-03-28T17:57:06.210' AS DateTime), NULL, CAST(N'2023-03-29T01:00:00.000' AS DateTime), CAST(N'2023-03-29T02:30:00.000' AS DateTime))
INSERT [dbo].[tCOrders] ([OrderID], [TradeNo], [CustomerID], [ProductID], [OrderDate], [CancelDate], [StartDate], [EndDate]) VALUES (9, N'20230328175640001313', 3, 1, CAST(N'2023-03-28T17:57:06.210' AS DateTime), NULL, CAST(N'2023-03-29T01:00:00.000' AS DateTime), CAST(N'2023-03-31T12:00:00.000' AS DateTime))
INSERT [dbo].[tCOrders] ([OrderID], [TradeNo], [CustomerID], [ProductID], [OrderDate], [CancelDate], [StartDate], [EndDate]) VALUES (10, N'20230328175923715861', 3, 1, CAST(N'2023-03-28T17:59:47.810' AS DateTime), CAST(N'2023-03-29T10:37:07.160' AS DateTime), CAST(N'2023-03-29T02:00:00.000' AS DateTime), CAST(N'2023-03-31T12:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[tCOrders] OFF
GO
SET IDENTITY_INSERT [dbo].[tCategory] ON 

INSERT [dbo].[tCategory] ([CategoryID], [Name]) VALUES (1, N'多人辦公室')
INSERT [dbo].[tCategory] ([CategoryID], [Name]) VALUES (2, N'會議室')
INSERT [dbo].[tCategory] ([CategoryID], [Name]) VALUES (3, N'工作室')
INSERT [dbo].[tCategory] ([CategoryID], [Name]) VALUES (4, N'展演空間')
INSERT [dbo].[tCategory] ([CategoryID], [Name]) VALUES (5, N'廚房')
SET IDENTITY_INSERT [dbo].[tCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[tPSite] ON 

INSERT [dbo].[tPSite] ([SiteID], [ProductID], [Name], [Image], [OpenTime], [Latitude], [Longitude], [Address], [Description]) VALUES (2, 1, N'巴拉巴拉的第一站點1232', N'4.jpg', N'08:00~20:00', N'25.0402', N'121.5146', NULL, NULL)
INSERT [dbo].[tPSite] ([SiteID], [ProductID], [Name], [Image], [OpenTime], [Latitude], [Longitude], [Address], [Description]) VALUES (5, 1, N'巴拉巴拉的第二站點', N'5.jpg', N'08:00~20:00', N'25.0264', N'121.5431', NULL, NULL)
INSERT [dbo].[tPSite] ([SiteID], [ProductID], [Name], [Image], [OpenTime], [Latitude], [Longitude], [Address], [Description]) VALUES (6, 2, N'明明的第一站點', N'6.jpg', N'08:00~20:00', N'25.0358', N'121.5675', NULL, NULL)
INSERT [dbo].[tPSite] ([SiteID], [ProductID], [Name], [Image], [OpenTime], [Latitude], [Longitude], [Address], [Description]) VALUES (7, 2, N'明明的第二戰點', N'7.jpg', N'08:00~20:00', N'24.1208', N'120.6676', NULL, NULL)
INSERT [dbo].[tPSite] ([SiteID], [ProductID], [Name], [Image], [OpenTime], [Latitude], [Longitude], [Address], [Description]) VALUES (8, 3, N'西瓜的第一站點', N'1.jpg', N'08:00~20:00', N'24.1623', N'120.6415', N'南區', N'西瓜站點1描述')
INSERT [dbo].[tPSite] ([SiteID], [ProductID], [Name], [Image], [OpenTime], [Latitude], [Longitude], [Address], [Description]) VALUES (10, 3, N'西瓜的第2站點', N'2.jpg', N'08:00~20:00', N'22.9923', N'120.2042', N'北區', N'西瓜站點2描述')
INSERT [dbo].[tPSite] ([SiteID], [ProductID], [Name], [Image], [OpenTime], [Latitude], [Longitude], [Address], [Description]) VALUES (11, 3, N'西瓜的第3站點', N'3.jpg', N'08:00~20:00', N'23.0382', N'120.1827', N'東區', N'西瓜站點3描述')
SET IDENTITY_INSERT [dbo].[tPSite] OFF
GO
SET IDENTITY_INSERT [dbo].[tPSiteRoom] ON 

INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [Iframe], [status], [Description], [RoomPassWord]) VALUES (1, 2, 1, 10, 100, 15, N'1-1.jpg', N'https://www.google.com/maps/embed?pb=!1m14!1m12!1m3!1d7659.347455093681!2d121.55109751793309!3d25.043221512102214!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1szh-TW!2stw!4v1679994074845!5m2!1szh-TW!2stw', 0, N'站點8房間1描述', N'123')
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [Iframe], [status], [Description], [RoomPassWord]) VALUES (2, 2, 5, 15, 150, 150, N'5-1.jpg', N'https://www.google.com/maps/embed?pb=!1m14!1m12!1m3!1d7659.347455093681!2d121.55109751793309!3d25.043221512102214!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1szh-TW!2stw!4v1679994074845!5m2!1szh-TW!2stw', 0, N'站點8房間1描述', N'123')
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [Iframe], [status], [Description], [RoomPassWord]) VALUES (3, 5, 5, 33, 120, 2222222, N'1-2.jpg', N'https://www.google.com/maps/embed?pb=!1m14!1m12!1m3!1d7659.347455093681!2d121.55109751793309!3d25.043221512102214!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1szh-TW!2stw!4v1679994074845!5m2!1szh-TW!2stw', 0, N'站點8房間1描述', N'123')
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [Iframe], [status], [Description], [RoomPassWord]) VALUES (5, 6, 2, 13, 130, 20, N'2-1.jpg', N'https://www.google.com/maps/embed?pb=!1m14!1m12!1m3!1d7659.347455093681!2d121.55109751793309!3d25.043221512102214!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1szh-TW!2stw!4v1679994074845!5m2!1szh-TW!2stw', 0, N'站點8房間1描述', N'123')
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [Iframe], [status], [Description], [RoomPassWord]) VALUES (6, 6, 3, 14, 140, 15, N'3-1.jpg', N'https://www.google.com/maps/embed?pb=!1m14!1m12!1m3!1d7659.347455093681!2d121.55109751793309!3d25.043221512102214!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1szh-TW!2stw!4v1679994074845!5m2!1szh-TW!2stw', 0, N'站點8房間1描述', N'123')
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [Iframe], [status], [Description], [RoomPassWord]) VALUES (7, 8, 2, 15, 140, 10, N'2-2.jpg', N'https://www.google.com/maps/embed?pb=!1m14!1m12!1m3!1d7659.347455093681!2d121.55109751793309!3d25.043221512102214!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1szh-TW!2stw!4v1679994074845!5m2!1szh-TW!2stw', 0, N'站點8房間1描述', N'123')
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [Iframe], [status], [Description], [RoomPassWord]) VALUES (8, 8, 3, 13, 130, 15, N'3-2.jpg', N'https://www.google.com/maps/embed?pb=!1m14!1m12!1m3!1d7659.347455093681!2d121.55109751793309!3d25.043221512102214!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1szh-TW!2stw!4v1679994074845!5m2!1szh-TW!2stw', 0, N'站點8房間2描述', N'456')
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [Iframe], [status], [Description], [RoomPassWord]) VALUES (9, 8, 1, 10, 120, 17, N'1-3.jpg', N'https://www.google.com/maps/embed?pb=!1m14!1m12!1m3!1d7659.347455093681!2d121.55109751793309!3d25.043221512102214!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1szh-TW!2stw!4v1679994074845!5m2!1szh-TW!2stw', 0, N'站點8房間3描述', N'789')
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [Iframe], [status], [Description], [RoomPassWord]) VALUES (10, 10, 5, 12, 130, 16, N'5-2.jpg', N'https://www.google.com/maps/embed?pb=!1m14!1m12!1m3!1d7659.347455093681!2d121.55109751793309!3d25.043221512102214!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1szh-TW!2stw!4v1679994074845!5m2!1szh-TW!2stw', 0, N'站點10房間1描述', N'111')
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [Iframe], [status], [Description], [RoomPassWord]) VALUES (11, 11, 1, 10, 100, 9, N'1-1.jpg', N'https://www.google.com/maps/embed?pb=!1m14!1m12!1m3!1d7659.347455093681!2d121.55109751793309!3d25.043221512102214!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1szh-TW!2stw!4v1679994074845!5m2!1szh-TW!2stw', 0, N'站點11房間1描述', N'222')
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [Iframe], [status], [Description], [RoomPassWord]) VALUES (12, 11, 4, 11, 121, 18, N'4-1.jpg', N'https://www.google.com/maps/embed?pb=!1m14!1m12!1m3!1d7659.347455093681!2d121.55109751793309!3d25.043221512102214!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1szh-TW!2stw!4v1679994074845!5m2!1szh-TW!2stw', 0, N'站點11房間2描述', N'333')
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [Iframe], [status], [Description], [RoomPassWord]) VALUES (13, 8, 5, 120, 1230, 15, N'20230328101951982roomPhoto.jpg', N'https://www.google.com/maps/embed?pb=!1m14!1m12!1m3!1d7659.347455093681!2d121.55109751793309!3d25.043221512102214!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1szh-TW!2stw!4v1679994074845!5m2!1szh-TW!2stw', 0, N'好廚房', NULL)
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [Iframe], [status], [Description], [RoomPassWord]) VALUES (15, 5, 4, 15, 123, 18, N'20230328191215859roomPhoto.jpg', N'asd', 0, N'asd', NULL)
SET IDENTITY_INSERT [dbo].[tPSiteRoom] OFF
GO
SET IDENTITY_INSERT [dbo].[tETitle] ON 

INSERT [dbo].[tETitle] ([TitleID], [TitleName]) VALUES (1, N'空間環境')
INSERT [dbo].[tETitle] ([TitleID], [TitleName]) VALUES (2, N'設備相關')
SET IDENTITY_INSERT [dbo].[tETitle] OFF
GO
SET IDENTITY_INSERT [dbo].[tEvaluations] ON 

INSERT [dbo].[tEvaluations] ([EvaluationID], [CustomerID], [RoomID], [TitleID], [Date], [Description], [Response], [Star]) VALUES (1, 3, 2, 1, CAST(N'2023-03-28T17:45:16.680' AS DateTime), N'123', NULL, 5)
INSERT [dbo].[tEvaluations] ([EvaluationID], [CustomerID], [RoomID], [TitleID], [Date], [Description], [Response], [Star]) VALUES (3, 3, 7, 2, CAST(N'2023-03-28T17:55:18.733' AS DateTime), N'讚', NULL, 5)
INSERT [dbo].[tEvaluations] ([EvaluationID], [CustomerID], [RoomID], [TitleID], [Date], [Description], [Response], [Star]) VALUES (6, 3, 2, 1, CAST(N'2023-03-28T18:03:55.037' AS DateTime), N'讚', NULL, 5)
SET IDENTITY_INSERT [dbo].[tEvaluations] OFF
GO
SET IDENTITY_INSERT [dbo].[tCoupons] ON 

INSERT [dbo].[tCoupons] ([CouponID], [Code], [Discount], [ExpiryDate], [Quantity], [Available], [HowPoint]) VALUES (1, N'100', 95.0000, CAST(N'2023-04-04T00:00:00.000' AS DateTime), 100, 1, 5)
SET IDENTITY_INSERT [dbo].[tCoupons] OFF
GO
INSERT [dbo].[tCOrderDetail] ([OrderID], [RoomID], [CouponID], [Price]) VALUES (2, 2, NULL, 45)
INSERT [dbo].[tCOrderDetail] ([OrderID], [RoomID], [CouponID], [Price]) VALUES (3, 2, NULL, 450)
INSERT [dbo].[tCOrderDetail] ([OrderID], [RoomID], [CouponID], [Price]) VALUES (4, 2, NULL, 120)
INSERT [dbo].[tCOrderDetail] ([OrderID], [RoomID], [CouponID], [Price]) VALUES (5, 7, NULL, 37)
INSERT [dbo].[tCOrderDetail] ([OrderID], [RoomID], [CouponID], [Price]) VALUES (6, 2, NULL, 22)
INSERT [dbo].[tCOrderDetail] ([OrderID], [RoomID], [CouponID], [Price]) VALUES (10, 2, NULL, 127)
GO
SET IDENTITY_INSERT [dbo].[tManagers] ON 

INSERT [dbo].[tManagers] ([ManagerID], [Name], [Email], [Phone], [Password]) VALUES (1, N'elin', N'elin@gmail.com', N'0912', N'elin')
SET IDENTITY_INSERT [dbo].[tManagers] OFF
GO
