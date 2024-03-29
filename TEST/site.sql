USE [dbX]
GO
SET IDENTITY_INSERT [dbo].[tPSite] ON 

INSERT [dbo].[tPSite] ([SiteID], [ProductID], [Name], [Image], [OpenTime], [Latitude], [Longitude], [Address], [Description]) VALUES (2, 1, N'巴拉巴拉的第一站點', NULL, N'08:00 ~ 20:00', N'25.0402', N'121.5146', NULL, NULL)
INSERT [dbo].[tPSite] ([SiteID], [ProductID], [Name], [Image], [OpenTime], [Latitude], [Longitude], [Address], [Description]) VALUES (5, 1, N'巴拉巴拉的第二站點', NULL, N'08:00 ~ 20:00', N'25.0264', N'121.5431', NULL, NULL)
INSERT [dbo].[tPSite] ([SiteID], [ProductID], [Name], [Image], [OpenTime], [Latitude], [Longitude], [Address], [Description]) VALUES (6, 2, N'明明的第一站點', NULL, N'08:00 ~ 20:00', N'25.0358', N'121.5675', NULL, NULL)
INSERT [dbo].[tPSite] ([SiteID], [ProductID], [Name], [Image], [OpenTime], [Latitude], [Longitude], [Address], [Description]) VALUES (7, 2, N'明明的第二戰點', NULL, N'08:00 ~ 20:00', N'24.1208', N'120.6676', NULL, NULL)
INSERT [dbo].[tPSite] ([SiteID], [ProductID], [Name], [Image], [OpenTime], [Latitude], [Longitude], [Address], [Description]) VALUES (8, 3, N'西瓜的第一站點', N'1.jpg', N'08:00 ~ 20:00', N'24.1623', N'120.6415', N'南區', N'西瓜站點1描述')
INSERT [dbo].[tPSite] ([SiteID], [ProductID], [Name], [Image], [OpenTime], [Latitude], [Longitude], [Address], [Description]) VALUES (10, 3, N'西瓜的第2站點', N'2.jpg', N'08:00 ~ 20:00', N'22.9923', N'120.2042', N'北區', N'西瓜站點2描述')
INSERT [dbo].[tPSite] ([SiteID], [ProductID], [Name], [Image], [OpenTime], [Latitude], [Longitude], [Address], [Description]) VALUES (11, 3, N'西瓜的第3站點', N'3.jpg', N'08:00~20:00', N'23.0382', N'120.1827', N'東區', N'西瓜站點3描述')
SET IDENTITY_INSERT [dbo].[tPSite] OFF
GO
SET IDENTITY_INSERT [dbo].[tPSiteRoom] ON 

INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [status], [Description], [RoomPassWord]) VALUES (1, 2, 1, 10.0000, 100.0000, 15, N'14.jpg', 0, N'站點8房間1描述', NULL)
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [status], [Description], [RoomPassWord]) VALUES (2, 2, 5, 15.0000, 150.0000, 150, N'5.jpg', 0, N'站點8房間1描述', NULL)
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [status], [Description], [RoomPassWord]) VALUES (3, 5, 1, 11.0000, 110.0000, 33, N'202303chengbao.jpg', 0, N'站點8房間1描述', NULL)
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [status], [Description], [RoomPassWord]) VALUES (4, 5, 5, 12.0000, 120.0000, 25, N'4.jpg', 0, N'站點8房間1描述', NULL)
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [status], [Description], [RoomPassWord]) VALUES (5, 6, 2, 13.0000, 130.0000, 20, N'13.jpg', 0, N'站點8房間1描述', NULL)
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [status], [Description], [RoomPassWord]) VALUES (6, 6, 3, 14.0000, 140.0000, 15, N'12.jpg', 0, N'站點8房間1描述', NULL)
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [status], [Description], [RoomPassWord]) VALUES (7, 8, 2, 14.0000, 140.0000, 10, N'11.jpg', 0, N'站點8房間1描述', N'123')
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [status], [Description], [RoomPassWord]) VALUES (8, 8, 3, 13.0000, 130.0000, 15, N'9.jpg', 0, N'站點8房間2描述', N'456')
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [status], [Description], [RoomPassWord]) VALUES (9, 8, 1, 12.0000, 120.0000, 17, N'8.jpg', 0, N'站點8房間3描述', N'789')
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [status], [Description], [RoomPassWord]) VALUES (10, 10, 5, 12.0000, 130.0000, 16, N'7.jpg', 0, N'站點10房間1描述', N'111')
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [status], [Description], [RoomPassWord]) VALUES (11, 11, 1, 10.0000, 100.0000, 9, N'6.jpg', 0, N'站點11房間1描述', N'222')
INSERT [dbo].[tPSiteRoom] ([RoomID], [SiteID], [CategoryID], [HourPrice], [DatePrice], [Ping], [Image], [status], [Description], [RoomPassWord]) VALUES (12, 11, 4, 11.0000, 121.0000, 18, N'10.jpg', 0, N'站點11房間2描述', N'333')
SET IDENTITY_INSERT [dbo].[tPSiteRoom] OFF
GO
