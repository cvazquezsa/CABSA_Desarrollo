SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

--#region tablas, funciones y procedimientos de sistema
/****** Objeto:  Table [dbo].[sx_node_security]    Fecha de la secuencia de comandos: 11/23/2010 15:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sx_node_security]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sx_node_security](
	[node_id] [varchar](50) NOT NULL,
	[node_password] [varchar](50) NOT NULL,
	[registration_enabled] [smallint] NULL DEFAULT ((0)),
	[registration_time] [datetime] NULL,
	[initial_load_enabled] [smallint] NULL DEFAULT ((0)),
	[initial_load_time] [datetime] NULL,
	[created_at_node_id] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[node_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Objeto:  Table [dbo].[sx_node_identity]    Fecha de la secuencia de comandos: 11/23/2010 15:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sx_node_identity]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sx_node_identity](
	[node_id] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[node_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Objeto:  Table [dbo].[sx_node_group]    Fecha de la secuencia de comandos: 11/23/2010 15:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sx_node_group]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sx_node_group](
	[node_group_id] [varchar](50) NOT NULL,
	[description] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[node_group_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Objeto:  Table [dbo].[sx_node_group_link]    Fecha de la secuencia de comandos: 11/23/2010 15:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sx_node_group_link]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sx_node_group_link](
	[source_node_group_id] [varchar](50) NOT NULL,
	[target_node_group_id] [varchar](50) NOT NULL,
	[data_event_action] [char](1) NOT NULL DEFAULT ('W'),
PRIMARY KEY CLUSTERED 
(
	[source_node_group_id] ASC,
	[target_node_group_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Objeto:  Table [dbo].[sx_node_host]    Fecha de la secuencia de comandos: 11/23/2010 15:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sx_node_host]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sx_node_host](
	[node_id] [varchar](50) NOT NULL,
	[host_name] [varchar](255) NOT NULL,
	[ip_address] [varchar](50) NULL,
	[os_user] [varchar](50) NULL,
	[os_name] [varchar](50) NULL,
	[os_arch] [varchar](50) NULL,
	[os_version] [varchar](50) NULL,
	[available_processors] [int] NULL DEFAULT ((0)),
	[free_memory_bytes] [decimal](19, 0) NULL DEFAULT ((0)),
	[total_memory_bytes] [decimal](19, 0) NULL DEFAULT ((0)),
	[max_memory_bytes] [decimal](19, 0) NULL DEFAULT ((0)),
	[java_version] [varchar](50) NULL,
	[java_vendor] [varchar](255) NULL,
	[symmetric_version] [varchar](50) NULL,
	[timezone_offset] [varchar](6) NULL,
	[heartbeat_time] [datetime] NULL,
	[last_restart_time] [datetime] NOT NULL,
	[create_time] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[node_id] ASC,
	[host_name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Objeto:  Table [dbo].[sx_node_host_channel_stats]    Fecha de la secuencia de comandos: 11/23/2010 15:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sx_node_host_channel_stats]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sx_node_host_channel_stats](
	[node_id] [varchar](50) NOT NULL,
	[host_name] [varchar](255) NOT NULL,
	[channel_id] [varchar](20) NOT NULL,
	[start_time] [datetime] NOT NULL,
	[end_time] [datetime] NOT NULL,
	[data_routed] [decimal](19, 0) NULL DEFAULT ((0)),
	[data_unrouted] [decimal](19, 0) NULL DEFAULT ((0)),
	[data_event_inserted] [decimal](19, 0) NULL DEFAULT ((0)),
	[data_extracted] [decimal](19, 0) NULL DEFAULT ((0)),
	[data_bytes_extracted] [decimal](19, 0) NULL DEFAULT ((0)),
	[data_extracted_errors] [decimal](19, 0) NULL DEFAULT ((0)),
	[data_bytes_sent] [decimal](19, 0) NULL DEFAULT ((0)),
	[data_sent] [decimal](19, 0) NULL DEFAULT ((0)),
	[data_sent_errors] [decimal](19, 0) NULL DEFAULT ((0)),
	[data_loaded] [decimal](19, 0) NULL DEFAULT ((0)),
	[data_bytes_loaded] [decimal](19, 0) NULL DEFAULT ((0)),
	[data_loaded_errors] [decimal](19, 0) NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[node_id] ASC,
	[host_name] ASC,
	[channel_id] ASC,
	[start_time] ASC,
	[end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Objeto:  Table [dbo].[sx_channel]    Fecha de la secuencia de comandos: 11/23/2010 15:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sx_channel]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sx_channel](
	[channel_id] [varchar](20) NOT NULL,
	[processing_order] [int] NOT NULL DEFAULT ((1)),
	[max_batch_size] [int] NOT NULL DEFAULT ((1000)),
	[max_batch_to_send] [int] NOT NULL DEFAULT ((60)),
	[max_data_to_route] [int] NOT NULL DEFAULT ((100000)),
	[extract_period_millis] [int] NOT NULL DEFAULT ((0)),
	[enabled] [smallint] NOT NULL DEFAULT ((1)),
	[use_old_data_to_route] [smallint] NOT NULL DEFAULT ((1)),
	[use_row_data_to_route] [smallint] NOT NULL DEFAULT ((1)),
	[use_pk_data_to_route] [smallint] NOT NULL DEFAULT ((1)),
	[contains_big_lob] [smallint] NOT NULL DEFAULT ((0)),
	[batch_algorithm] [varchar](50) NOT NULL DEFAULT ('default'),
	[description] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[channel_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Objeto:  Table [dbo].[sx_node_channel_ctl]    Fecha de la secuencia de comandos: 11/23/2010 15:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sx_node_channel_ctl]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sx_node_channel_ctl](
	[node_id] [varchar](50) NOT NULL,
	[channel_id] [varchar](20) NOT NULL,
	[suspend_enabled] [smallint] NULL DEFAULT ((0)),
	[ignore_enabled] [smallint] NULL DEFAULT ((0)),
	[last_extract_time] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[node_id] ASC,
	[channel_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Objeto:  Table [dbo].[sx_node_group_channel_window]    Fecha de la secuencia de comandos: 11/23/2010 15:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sx_node_group_channel_window]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sx_node_group_channel_window](
	[node_group_id] [varchar](50) NOT NULL,
	[channel_id] [varchar](20) NOT NULL,
	[start_time] [datetime] NOT NULL,
	[end_time] [datetime] NOT NULL,
	[enabled] [smallint] NOT NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[node_group_id] ASC,
	[channel_id] ASC,
	[start_time] ASC,
	[end_time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Objeto:  Table [dbo].[sx_trigger]    Fecha de la secuencia de comandos: 11/23/2010 15:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sx_trigger]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sx_trigger](
	[trigger_id] [varchar](50) NOT NULL,
	[source_catalog_name] [varchar](50) NULL,
	[source_schema_name] [varchar](50) NULL,
	[source_table_name] [varchar](50) NOT NULL,
	[channel_id] [varchar](20) NOT NULL,
	[sync_on_update] [smallint] NOT NULL DEFAULT ((1)),
	[sync_on_insert] [smallint] NOT NULL DEFAULT ((1)),
	[sync_on_delete] [smallint] NOT NULL DEFAULT ((1)),
	[sync_on_incoming_batch] [smallint] NOT NULL DEFAULT ((0)),
	[name_for_update_trigger] [varchar](50) NULL,
	[name_for_insert_trigger] [varchar](50) NULL,
	[name_for_delete_trigger] [varchar](50) NULL,
	[sync_on_update_condition] [text] NULL,
	[sync_on_insert_condition] [text] NULL,
	[sync_on_delete_condition] [text] NULL,
	[external_select] [text] NULL,
	[tx_id_expression] [text] NULL,
	[excluded_column_names] [text] NULL,
	[create_time] [datetime] NOT NULL,
	[last_update_by] [varchar](50) NULL,
	[last_update_time] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[trigger_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Objeto:  Table [dbo].[sx_router]    Fecha de la secuencia de comandos: 11/23/2010 15:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sx_router]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sx_router](
	[router_id] [varchar](50) NOT NULL,
	[target_catalog_name] [varchar](50) NULL,
	[target_schema_name] [varchar](50) NULL,
	[target_table_name] [varchar](50) NULL,
	[source_node_group_id] [varchar](50) NOT NULL,
	[target_node_group_id] [varchar](50) NOT NULL,
	[router_type] [varchar](50) NULL,
	[router_expression] [text] NULL,
	[sync_on_update] [smallint] NOT NULL DEFAULT ((1)),
	[sync_on_insert] [smallint] NOT NULL DEFAULT ((1)),
	[sync_on_delete] [smallint] NOT NULL DEFAULT ((1)),
	[create_time] [datetime] NOT NULL,
	[last_update_by] [varchar](50) NULL,
	[last_update_time] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[router_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Objeto:  Table [dbo].[sx_trigger_router]    Fecha de la secuencia de comandos: 11/23/2010 15:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sx_trigger_router]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sx_trigger_router](
	[trigger_id] [varchar](50) NOT NULL,
	[router_id] [varchar](50) NOT NULL,
	[initial_load_order] [int] NOT NULL DEFAULT ((1)),
	[initial_load_select] [text] NULL,
	[ping_back_enabled] [smallint] NOT NULL DEFAULT ((0)),
	[create_time] [datetime] NOT NULL,
	[last_update_by] [varchar](50) NULL,
	[last_update_time] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[trigger_id] ASC,
	[router_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Objeto:  Table [dbo].[sx_parameter]    Fecha de la secuencia de comandos: 11/23/2010 15:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sx_parameter]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sx_parameter](
	[external_id] [varchar](50) NOT NULL,
	[node_group_id] [varchar](50) NOT NULL,
	[param_key] [varchar](100) NOT NULL,
	[param_value] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[external_id] ASC,
	[node_group_id] ASC,
	[param_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Objeto:  Table [dbo].[sx_registration_redirect]    Fecha de la secuencia de comandos: 11/23/2010 15:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sx_registration_redirect]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sx_registration_redirect](
	[registrant_external_id] [varchar](50) NOT NULL,
	[registration_node_id] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[registrant_external_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Objeto:  Table [dbo].[sx_trigger_hist]    Fecha de la secuencia de comandos: 11/23/2010 15:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sx_trigger_hist]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sx_trigger_hist](
	[trigger_hist_id] [int] IDENTITY(1,1) NOT NULL,
	[trigger_id] [varchar](50) NOT NULL,
	[source_table_name] [varchar](50) NOT NULL,
	[source_catalog_name] [varchar](50) NULL,
	[source_schema_name] [varchar](50) NULL,
	[name_for_update_trigger] [varchar](50) NOT NULL,
	[name_for_insert_trigger] [varchar](50) NOT NULL,
	[name_for_delete_trigger] [varchar](50) NOT NULL,
	[table_hash] [decimal](19, 0) NOT NULL,
	[trigger_row_hash] [decimal](19, 0) NOT NULL,
	[column_names] [text] NOT NULL,
	[pk_column_names] [text] NOT NULL,
	[last_trigger_build_reason] [char](1) NOT NULL,
	[create_time] [datetime] NOT NULL,
	[inactive_time] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[trigger_hist_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Objeto:  Table [dbo].[sx_data]    Fecha de la secuencia de comandos: 11/23/2010 15:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sx_data]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sx_data](
	[data_id] [int] IDENTITY(1,1) NOT NULL,
	[table_name] [varchar](50) NOT NULL,
	[event_type] [char](1) NOT NULL,
	[row_data] [text] NULL,
	[pk_data] [text] NULL,
	[old_data] [text] NULL,
	[trigger_hist_id] [int] NOT NULL,
	[channel_id] [varchar](20) NULL,
	[transaction_id] [varchar](255) NULL,
	[source_node_id] [varchar](50) NULL,
	[external_data] [varchar](50) NULL,
	[create_time] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[data_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[sx_data]') AND name = N'idx_d_channel_id')
CREATE NONCLUSTERED INDEX [idx_d_channel_id] ON [dbo].[sx_data] 
(
	[data_id] ASC,
	[channel_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Objeto:  Table [dbo].[sx_data_ref]    Fecha de la secuencia de comandos: 11/23/2010 15:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sx_data_ref]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sx_data_ref](
	[ref_data_id] [int] NOT NULL,
	[ref_time] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ref_data_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Objeto:  Table [dbo].[sx_data_gap]    Fecha de la secuencia de comandos: 11/23/2010 15:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sx_data_gap]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sx_data_gap](
	[start_id] [int] NOT NULL,
	[end_id] [int] NOT NULL,
	[status] [char](2) NULL,
	[create_time] [datetime] NOT NULL,
	[last_update_hostname] [varchar](255) NULL,
	[last_update_time] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[start_id] ASC,
	[end_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[sx_data_gap]') AND name = N'idx_dg_status')
CREATE NONCLUSTERED INDEX [idx_dg_status] ON [dbo].[sx_data_gap] 
(
	[status] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Objeto:  Table [dbo].[sx_data_event]    Fecha de la secuencia de comandos: 11/23/2010 15:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sx_data_event]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sx_data_event](
	[data_id] [int] NOT NULL,
	[batch_id] [int] NOT NULL DEFAULT ((-1)),
	[router_id] [varchar](50) NOT NULL,
	[create_time] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[data_id] ASC,
	[batch_id] ASC,
	[router_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[sx_data_event]') AND name = N'idx_de_batchid')
CREATE NONCLUSTERED INDEX [idx_de_batchid] ON [dbo].[sx_data_event] 
(
	[batch_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[sx_data_event]') AND name = N'idx_de_data_id')
CREATE NONCLUSTERED INDEX [idx_de_data_id] ON [dbo].[sx_data_event] 
(
	[data_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Objeto:  Table [dbo].[sx_outgoing_batch]    Fecha de la secuencia de comandos: 11/23/2010 15:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sx_outgoing_batch]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sx_outgoing_batch](
	[batch_id] [int] IDENTITY(1,1) NOT NULL,
	[node_id] [varchar](50) NULL,
	[channel_id] [varchar](20) NULL,
	[status] [char](2) NULL,
	[load_flag] [smallint] NULL DEFAULT ((0)),
	[error_flag] [smallint] NULL DEFAULT ((0)),
	[byte_count] [int] NOT NULL DEFAULT ((0)),
	[extract_count] [int] NOT NULL DEFAULT ((0)),
	[sent_count] [int] NOT NULL DEFAULT ((0)),
	[load_count] [int] NOT NULL DEFAULT ((0)),
	[data_event_count] [int] NOT NULL DEFAULT ((0)),
	[reload_event_count] [int] NOT NULL DEFAULT ((0)),
	[insert_event_count] [int] NOT NULL DEFAULT ((0)),
	[update_event_count] [int] NOT NULL DEFAULT ((0)),
	[delete_event_count] [int] NOT NULL DEFAULT ((0)),
	[other_event_count] [int] NOT NULL DEFAULT ((0)),
	[router_millis] [int] NOT NULL DEFAULT ((0)),
	[network_millis] [int] NOT NULL DEFAULT ((0)),
	[filter_millis] [int] NOT NULL DEFAULT ((0)),
	[load_millis] [int] NOT NULL DEFAULT ((0)),
	[extract_millis] [int] NOT NULL DEFAULT ((0)),
	[sql_state] [varchar](10) NULL,
	[sql_code] [int] NOT NULL DEFAULT ((0)),
	[sql_message] [text] NULL,
	[failed_data_id] [int] NOT NULL DEFAULT ((0)),
	[last_update_hostname] [varchar](255) NULL,
	[last_update_time] [datetime] NULL,
	[create_time] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[batch_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[sx_outgoing_batch]') AND name = N'idx_ob_in_error')
CREATE NONCLUSTERED INDEX [idx_ob_in_error] ON [dbo].[sx_outgoing_batch] 
(
	[error_flag] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[sx_outgoing_batch]') AND name = N'idx_ob_node_chanl_status')
CREATE NONCLUSTERED INDEX [idx_ob_node_chanl_status] ON [dbo].[sx_outgoing_batch] 
(
	[node_id] ASC,
	[status] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Objeto:  Table [dbo].[sx_incoming_batch]    Fecha de la secuencia de comandos: 11/23/2010 15:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sx_incoming_batch]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sx_incoming_batch](
	[batch_id] [int] NOT NULL,
	[node_id] [varchar](50) NOT NULL,
	[channel_id] [varchar](20) NULL,
	[status] [char](2) NULL,
	[network_millis] [int] NOT NULL DEFAULT ((0)),
	[filter_millis] [int] NOT NULL DEFAULT ((0)),
	[database_millis] [int] NOT NULL DEFAULT ((0)),
	[failed_row_number] [int] NOT NULL DEFAULT ((0)),
	[byte_count] [int] NOT NULL DEFAULT ((0)),
	[statement_count] [int] NOT NULL DEFAULT ((0)),
	[fallback_insert_count] [int] NOT NULL DEFAULT ((0)),
	[fallback_update_count] [int] NOT NULL DEFAULT ((0)),
	[missing_delete_count] [int] NOT NULL DEFAULT ((0)),
	[skip_count] [int] NOT NULL DEFAULT ((0)),
	[sql_state] [varchar](10) NULL,
	[sql_code] [int] NOT NULL DEFAULT ((0)),
	[sql_message] [text] NULL,
	[last_update_hostname] [varchar](255) NULL,
	[last_update_time] [datetime] NULL,
	[create_time] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[batch_id] ASC,
	[node_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[sx_incoming_batch]') AND name = N'idx_ib_time_status')
CREATE NONCLUSTERED INDEX [idx_ib_time_status] ON [dbo].[sx_incoming_batch] 
(
	[create_time] ASC,
	[status] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Objeto:  Table [dbo].[sx_lock]    Fecha de la secuencia de comandos: 11/23/2010 15:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sx_lock]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sx_lock](
	[lock_id] [varchar](50) NOT NULL,
	[lock_action] [varchar](50) NOT NULL,
	[locking_server_id] [varchar](255) NULL,
	[lock_time] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[lock_id] ASC,
	[lock_action] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Objeto:  UserDefinedFunction [dbo].[sx_base64_encode]    Fecha de la secuencia de comandos: 11/23/2010 15:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sx_base64_encode]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
                                 
                                create function [dbo].[sx_base64_encode](@data varbinary(max)) returns varchar(max)
                                  with schemabinding, returns null on null input
                                  begin
                                    return ( select [text()] = @data for xml path('''') )
                                  end                                
                                
                            ' 
END
GO
/****** Objeto:  UserDefinedFunction [dbo].[sx_triggers_disabled]    Fecha de la secuencia de comandos: 11/23/2010 15:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sx_triggers_disabled]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
                                
                                create function [dbo].[sx_triggers_disabled]() returns smallint
                                begin
                                  declare @disabled varchar(1);
                                  set @disabled = coalesce(replace(substring(cast(context_info() as varchar), 1, 1), 0x0, ''''), '''');
                                  if @disabled is null or @disabled != ''1''
                                    return 0;
                                  return 1;
                                end
                                
                            ' 
END
GO
/****** Objeto:  UserDefinedFunction [dbo].[sx_node_disabled]    Fecha de la secuencia de comandos: 11/23/2010 15:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sx_node_disabled]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
                                
                                create function [dbo].[sx_node_disabled]() returns varchar(50)
                                begin
                                  declare @node varchar(50);
                                  set @node = coalesce(replace(substring(cast(context_info() as varchar), 2, 50), 0x0, ''''), '''');
                                  return @node;
                                end
                                
                            ' 
END
GO
/****** Objeto:  Table [dbo].[sx_node]    Fecha de la secuencia de comandos: 11/23/2010 15:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sx_node]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sx_node](
	[node_id] [varchar](50) NOT NULL,
	[node_group_id] [varchar](50) NOT NULL,
	[external_id] [varchar](50) NOT NULL,
	[sync_enabled] [smallint] NULL DEFAULT ((0)),
	[sync_url] [varchar](255) NULL,
	[schema_version] [varchar](50) NULL,
	[symmetric_version] [varchar](50) NULL,
	[database_type] [varchar](50) NULL,
	[database_version] [varchar](50) NULL,
	[heartbeat_time] [datetime] NULL,
	[timezone_offset] [varchar](6) NULL,
	[batch_to_send_count] [int] NULL DEFAULT ((0)),
	[batch_in_error_count] [int] NULL DEFAULT ((0)),
	[created_at_node_id] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[node_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
--#endregion

--#region Tabla sx_schema
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sx_schema]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sx_schema](
	[SchemaID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[SchemaDate] [datetime] NOT NULL DEFAULT (getdate()),
	[Script] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[SchemaID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
--#endregion

--#region tgSchemaInsert
if exists (select * from sysobjects where id = object_id('dbo.tgSchemaInsert') and sysstat & 0xf = 8) drop trigger dbo.tgSchemaInsert
GO
CREATE TRIGGER tgSchemaInsert ON sx_schema
FOR INSERT
AS BEGIN
  DECLARE
    @Datos varchar(max)
  SELECT @Datos = Script FROM Inserted
  EXEC(@Datos)  
END
GO
--#endregion

--#region sxExecSQLSchema
if exists (select * from sysobjects where id = object_id('dbo.sxExecSQLSchema') and type = 'P') drop procedure dbo.sxExecSQLSchema
GO             
CREATE PROCEDURE sxExecSQLSchema
	@SQL VARCHAR(max)
AS
BEGIN
	DECLARE @errno int, @errmsg varchar(max)
	BEGIN TRANSACTION
		BEGIN TRY
			INSERT INTO sx_schema (Script) VALUES (@SQL)
		END TRY
		BEGIN CATCH
			SELECT 
				@errno = ERROR_NUMBER(), @errmsg = ERROR_MESSAGE()
		END CATCH
	IF @errno IS NOT NULL ROLLBACK
	ELSE COMMIT

	SELECT @errno AS 'ErrorNumber', @errmsg AS 'ErrorMessage'
END
GO
--#endregion

--#region Tabla sx_relations
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sx_relations]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sx_relations](
	[group_id_from] [varchar](50) NOT NULL,
	[group_id_to] [varchar](50) NOT NULL,
	[table_group] [varchar](50) NOT NULL,
	[relation_type] [char](4) NULL,
	[sync_cascade_override] [smallint] NULL
 CONSTRAINT [PK_sx_relations] PRIMARY KEY CLUSTERED 
(
	[group_id_from] ASC,
	[group_id_to] ASC,
	[table_group] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
--#endregion

--#region Tabla sx_table_group
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sx_table_group]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sx_table_group](
	[table_group] [varchar](20) NOT NULL,
	[sync_cascade] [smallint] NOT NULL,
	[load_order] [int] NOT NULL,
	[channel] [varchar](50) NOT NULL
 CONSTRAINT [PK_sx_table_group] PRIMARY KEY CLUSTERED 
(
	[table_group] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
--#endregion

--#region Tabla sx_table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sx_table]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sx_table](
	[table_group] [varchar](20) NOT NULL,
	[table_name] [varchar](50) NOT NULL,
	[ignore_fields] [text] NULL,
	[sync_cascade_override] [smallint] NULL,
	[channel_override] [varchar](20) NULL,
 CONSTRAINT [PK_sx_table] PRIMARY KEY CLUSTERED 
(
	[table_name] ASC,
	[table_group] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
--#endregion

--#region sxAddGroupLink
if exists (select * from sysobjects where id = object_id('dbo.sxAddGroupLink') and type = 'P') drop procedure dbo.sxAddGroupLink
GO             
CREATE PROCEDURE sxAddGroupLink
	@from VARCHAR(10),
	@to VARCHAR(10)
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM sx_node_group_link WHERE source_node_group_id = @from AND target_node_group_id = @to)
		INSERT INTO sx_node_group_link (source_node_group_id, target_node_group_id, data_event_action)
		VALUES (@from, @to, 'W')
	IF NOT EXISTS(SELECT * FROM sx_node_group_link WHERE source_node_group_id = @to AND target_node_group_id = @from)
		INSERT INTO sx_node_group_link (source_node_group_id, target_node_group_id, data_event_action)
		VALUES (@to, @from, 'P')
END
GO
--#endregion

--#region sxDeleteGroupLink
if exists (select * from sysobjects where id = object_id('dbo.sxDeleteGroupLink') and type = 'P') drop procedure dbo.sxDeleteGroupLink
GO             
CREATE PROCEDURE sxDeleteGroupLink
	@from VARCHAR(10),
	@to VARCHAR(10)
AS
BEGIN
DELETE FROM sx_node_group_link WHERE (source_node_group_id = @from AND target_node_group_id = @to) OR (source_node_group_id = @to AND target_node_group_id = @from)
END
GO
--#endregion

--#region	sxAddRouter
if exists (select * from sysobjects where id = object_id('dbo.sxAddRouter') and type = 'P') drop procedure dbo.sxAddRouter
GO             
CREATE PROCEDURE sxAddRouter
	@from VARCHAR(10),
	@to VARCHAR(10),
	@table_group VARCHAR(20),
	@type varchar(50) = NULL,
	@expression varchar(255) = NULL
AS
BEGIN
	DECLARE @router_id VARCHAR(50)
	SELECT @router_id = 'rt_'+@table_group+'_'+@from+'_'+@to

	IF NOT EXISTS (SELECT * FROM sx_router WHERE router_id = @router_id)
		INSERT INTO sx_router (router_id, source_node_group_id, target_node_group_id, router_type, router_expression, sync_on_update, sync_on_insert, sync_on_delete, create_time, last_update_time)
		VALUES (@router_id, @from, @to, @type, @expression, 1, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
	ELSE
		UPDATE sx_router SET sync_on_update = 1, sync_on_insert = 1, sync_on_delete = 1 WHERE router_id = @router_id
	-- solo hacemos uno, e invocamos sxRouter dos veces si es necesario
	/*
	IF NOT EXISTS (SELECT * FROM sx_router WHERE router_id = @router_id_to)
		INSERT INTO sx_router (router_id, source_node_group_id, target_node_group_id, router_type, router_expression, sync_on_update, sync_on_insert, sync_on_delete, create_time, last_update_time)
		VALUES (@router_id_to, @to, @from, @type, @expression, 1, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
	*/
END
GO
--#endregion

--#region	sxDisableRouter
if exists (select * from sysobjects where id = object_id('dbo.sxDisableRouter') and type = 'P') drop procedure dbo.sxDisableRouter
GO             
CREATE PROCEDURE sxDisableRouter
	@from VARCHAR(10),
	@to VARCHAR(10)
AS
BEGIN
	DECLARE @router_id VARCHAR(25)
	SELECT @router_id = 'rt_'+@from+'_'+@to
	UPDATE sx_router SET sync_on_update = 0, sync_on_insert = 0, sync_on_delete = 0 WHERE router_id = @router_id
END
GO
--#endregion

--#region	sxEnableRouter
if exists (select * from sysobjects where id = object_id('dbo.sxEnableRouter') and type = 'P') drop procedure dbo.sxEnableRouter
GO             
CREATE PROCEDURE sxEnableRouter
	@from VARCHAR(10),
	@to VARCHAR(10)
AS
BEGIN
	DECLARE @router_id VARCHAR(25)
	SELECT @router_id = 'rt_'+@from+'_'+@to
	UPDATE sx_router SET sync_on_update = 1, sync_on_insert = 1, sync_on_delete = 1 WHERE router_id = @router_id
END
GO
--#endregion

--#region	sxDeleteRouter
if exists (select * from sysobjects where id = object_id('dbo.sxDeleteRouter') and type = 'P') drop procedure dbo.sxDeleteRouter
GO             
CREATE PROCEDURE sxDeleteRouter
	@from VARCHAR(10),
	@to VARCHAR(10)
AS
BEGIN
	DECLARE @router_id VARCHAR(25)
	SELECT @router_id = 'rt_'+@from+'_'+@to

	DELETE FROM sx_router WHERE router_id = @router_id
	DELETE FROM sx_trigger_router WHERE router_id = @router_id
END
GO
--#endregion

--#region	sxAddRouterByID
if exists (select * from sysobjects where id = object_id('dbo.sxAddRouterByID') and type = 'P') drop procedure dbo.sxAddRouterByID
GO             
CREATE PROCEDURE sxAddRouterByID
	@router_id VARCHAR(50),
	@from VARCHAR(10),
	@to VARCHAR(10),
	@type varchar(50) = NULL,
	@expression varchar(255) = NULL
AS
BEGIN
	IF NOT EXISTS (SELECT * FROM sx_router WHERE router_id = @router_id)
		INSERT INTO sx_router (router_id, source_node_group_id, target_node_group_id, router_type, router_expression, sync_on_update, sync_on_insert, sync_on_delete, create_time, last_update_time)
		VALUES (@router_id, @from, @to, @type, @expression, 1, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
	ELSE
		UPDATE sx_router SET sync_on_update = 1, sync_on_insert = 1, sync_on_delete = 1 WHERE router_id = @router_id
END
GO
--#endregion

if exists (select * from sysobjects where id = object_id('dbo.sxGetTableIgnoredFields') and type = 'P') drop procedure dbo.sxGetTableIgnoredFields
GO             
CREATE PROCEDURE sxGetTableIgnoredFields
	@table_name varchar(50),
	@additional_fields nvarchar(max),
	@ignored_fields nvarchar(max) OUTPUT
AS
BEGIN
DECLARE @field_name nvarchar(128)
SELECT @ignored_fields = ''

DECLARE crTimestampFields CURSOR LOCAL FOR
SELECT name FROM sys.columns
WHERE object_id = OBJECT_ID(@table_name)
AND system_type_id = 189
OPEN crTimestampFields
FETCH NEXT FROM crTimestampFields INTO @field_name
WHILE @@FETCH_STATUS = 0
BEGIN
	SELECT @ignored_fields = @ignored_fields + @field_name + ','

	FETCH NEXT FROM crTimestampFields INTO @field_name
END
CLOSE crTimestampFields
DEALLOCATE crTimestampFields

DECLARE crComputedFields CURSOR LOCAL FOR
SELECT name FROM sys.computed_columns
WHERE object_id = OBJECT_ID(@table_name)
OPEN crComputedFields
FETCH NEXT FROM crComputedFields INTO @field_name
WHILE @@FETCH_STATUS = 0
BEGIN
	SELECT @ignored_fields = @ignored_fields + @field_name + ','

	FETCH NEXT FROM crComputedFields INTO @field_name
END
CLOSE crComputedFields
DEALLOCATE crComputedFields

IF @additional_fields IS NOT NULL SELECT @ignored_fields = @ignored_fields + @additional_fields
IF CHARINDEX(',', REVERSE(@ignored_fields)) = 1 SELECT @ignored_fields = SUBSTRING(@ignored_fields, 0, LEN(@ignored_fields))
SELECT @ignored_fields = NULLIF(@ignored_fields, '')

END
GO

--#region sxAddTrigger
if exists (select * from sysobjects where id = object_id('dbo.sxAddTrigger') and type = 'P') drop procedure dbo.sxAddTrigger
GO             
CREATE PROCEDURE sxAddTrigger
	@table_name VARCHAR(50),
	@from VARCHAR(10),
	@to VARCHAR(10),
	@table_group VARCHAR(20),
	@relation CHAR(4) = 'both',
	@additional_ignore_fields nvarchar(max) = NULL,
	@sync_cascade SMALLINT = 1,
	@load_order INT = 200,
	@channel VARCHAR(20) = 'normal'
AS
BEGIN
	DECLARE @trigger_id_from VARCHAR(50), @trigger_id_to VARCHAR(50), @router_id_from VARCHAR(50), @router_id_to VARCHAR(50), @ignore_fields nvarchar(max)

	SELECT @router_id_from = 'rt_'+@table_group+'_'+@from+'_'+@to
	SELECT @router_id_to = 'rt_'+@table_group+'_'+@to+'_'+@from

	SELECT @trigger_id_from = 'tg_dn_'+@from+'_'+@table_name
	SELECT @trigger_id_to = 'tg_up_'+@to+'_'+@table_name
	
	EXEC sxGetTableIgnoredFields @table_name, @additional_ignore_fields,  @ignore_fields OUTPUT
	SELECT @ignore_fields = CONVERT(text, @ignore_fields)

	IF @relation IN ('both', 'push')
	BEGIN
		IF EXISTS (SELECT * FROM sx_trigger WHERE trigger_id LIKE 'tg_up_'+@from+'_'+@table_name)
			UPDATE sx_trigger SET sync_on_incoming_batch = 1, excluded_column_names = @ignore_fields WHERE trigger_id LIKE 'tg_up_'+@from+'_'+@table_name
		IF NOT EXISTS (SELECT * FROM sx_trigger WHERE trigger_id = @trigger_id_to )
			INSERT INTO sx_trigger (trigger_id, source_table_name, channel_id, excluded_column_names, sync_on_incoming_batch, create_time, last_update_time)
			VALUES (@trigger_id_to, @table_name, @channel, @ignore_fields, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
		ELSE
			UPDATE sx_trigger SET sync_on_update = 1, sync_on_insert = 1, sync_on_delete = 1, channel_id = @channel, excluded_column_names = @ignore_fields WHERE trigger_id = @trigger_id_to
		IF NOT EXISTS (SELECT * FROM sx_trigger_router WHERE trigger_id = @trigger_id_to AND router_id = @router_id_to)
			INSERT INTO sx_trigger_router (trigger_id, router_id, initial_load_order, create_time, last_update_time)
			VALUES (@trigger_id_to, @router_id_to, @load_order, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
	END
	IF @relation IN ('both', 'pull')
	BEGIN
		IF EXISTS (SELECT trigger_id FROM sx_trigger_router WHERE trigger_id LIKE 'tg_dn_%_'+@table_name AND router_id LIKE 'rt_%_'+@from)
			SELECT @sync_cascade = 1
		IF NOT EXISTS (SELECT * FROM sx_trigger WHERE trigger_id = @trigger_id_from)
			INSERT INTO sx_trigger (trigger_id, source_table_name, channel_id, excluded_column_names, sync_on_incoming_batch, create_time, last_update_time)
			VALUES (@trigger_id_from, @table_name, @channel, @ignore_fields, @sync_cascade, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
		ELSE
			UPDATE sx_trigger SET sync_on_update = 1, sync_on_insert = 1, sync_on_delete = 1, channel_id = @channel, excluded_column_names = @ignore_fields, sync_on_incoming_batch = @sync_cascade WHERE trigger_id = @trigger_id_from
		IF NOT EXISTS (SELECT * FROM sx_trigger_router WHERE trigger_id = @trigger_id_from AND router_id = @router_id_from)
			INSERT INTO sx_trigger_router (trigger_id, router_id, initial_load_order, create_time, last_update_time)
			VALUES (@trigger_id_from, @router_id_from, @load_order, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
	END
END
GO
--#endregion

--#region sxDisableTrigger
if exists (select * from sysobjects where id = object_id('dbo.sxDisableTrigger') and type = 'P') drop procedure dbo.sxDisableTrigger
GO             
CREATE PROCEDURE sxDisableTrigger
	@table_name VARCHAR(50),
	@from VARCHAR(10),
	@to VARCHAR(10)
AS
BEGIN
	DECLARE @trigger_id_from VARCHAR(50), @trigger_id_to VARCHAR(50)
	SELECT @trigger_id_from = 'tg_dn_'+@from+'_'+@table_name
	SELECT @trigger_id_to = 'tg_up'+@to+'_'+@table_name

	UPDATE sx_trigger SET sync_on_update = 0, sync_on_insert = 0, sync_on_delete = 0 WHERE trigger_id = @trigger_id_from OR trigger_id = @trigger_id_to
END
GO
--#endregion

--#region sxEnableTrigger
if exists (select * from sysobjects where id = object_id('dbo.sxEnableTrigger') and type = 'P') drop procedure dbo.sxEnableTrigger
GO             
CREATE PROCEDURE sxEnableTrigger
	@table_name VARCHAR(50),
	@from VARCHAR(10),
	@to VARCHAR(10)
AS
BEGIN
	DECLARE @trigger_id_from VARCHAR(50), @trigger_id_to VARCHAR(50)
	SELECT @trigger_id_from = 'tg_dn_'+@from+'_'+@table_name
	SELECT @trigger_id_to = 'tg_up_'+@to+'_'+@table_name

	UPDATE sx_trigger SET sync_on_update = 1, sync_on_insert = 1, sync_on_delete = 1 WHERE trigger_id = @trigger_id_from OR trigger_id = @trigger_id_to
END
GO
--#endregion

--#region sxDeleteTrigger
if exists (select * from sysobjects where id = object_id('dbo.sxDeleteTrigger') and type = 'P') drop procedure dbo.sxDeleteTrigger
GO             
CREATE PROCEDURE sxDeleteTrigger
	@table_name VARCHAR(50),
	@from VARCHAR(10),
	@to VARCHAR(10)
AS
BEGIN
	DECLARE @trigger_id_from VARCHAR(50), @trigger_id_to VARCHAR(50)
	SELECT @trigger_id_from = 'tg_dn_'+@from+'_'+@table_name
	SELECT @trigger_id_to = 'tg_up_'+@to+'_'+@table_name

	-- TODO: Agregar validacion de table_group
	-- Esto solo checa que ya no se necesiten los triggers para el from y prefix
	-- hay que checar que se esten borrando solo los triggers del grupo de donde se borro}
	DELETE FROM sx_trigger WHERE trigger_id = @trigger_id_from
	DELETE FROM sx_trigger_router WHERE trigger_id = @trigger_id_from

	DELETE FROM sx_trigger WHERE trigger_id = @trigger_id_to
	DELETE FROM sx_trigger_router WHERE trigger_id = @trigger_id_to 
END
GO
--#endregion

--#region sxAddTriggerByID
if exists (select * from sysobjects where id = object_id('dbo.sxAddTriggerByID') and type = 'P') drop procedure dbo.sxAddTriggerByID
GO             
CREATE PROCEDURE sxAddTriggerByID
	@trigger_id VARCHAR(50),
	@router_id VARCHAR(50),
	@table_name VARCHAR(50),
	@sync_cascade SMALLINT = 1,
	@load_order INT = 200,
	@channel VARCHAR(20) = 'normal',
	@update_condition VARCHAR(max) = '',
	@insert_condition VARCHAR(max) = '',
	@delete_condition VARCHAR(max) = ''
	
AS
BEGIN
	IF NOT EXISTS (SELECT * FROM sx_trigger WHERE trigger_id = @trigger_id)
		INSERT INTO sx_trigger (trigger_id, source_table_name, channel_id, sync_on_incoming_batch, create_time, last_update_time, sync_on_update_condition, sync_on_insert_condition, sync_on_delete_condition)
		VALUES (@trigger_id, @table_name, @channel, @sync_cascade, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, @update_condition, @insert_condition, @delete_condition)
	ELSE
		UPDATE sx_trigger SET sync_on_update = 1, sync_on_insert = 1, sync_on_delete = 1, sync_on_update_condition = @update_condition,
		sync_on_insert_condition = @insert_condition, sync_on_delete_condition = @delete_condition
		WHERE trigger_id = @trigger_id
	IF NOT EXISTS (SELECT * FROM sx_trigger_router WHERE trigger_id = @trigger_id AND router_id = @router_id)
		INSERT INTO sx_trigger_router (trigger_id, router_id, initial_load_order, create_time, last_update_time)
		VALUES (@trigger_id, @router_id, @load_order, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
END
GO
--#endregion

--#region	sxAddHost
if exists (select * from sysobjects where id = object_id('dbo.sxAddHost') and type = 'P') drop procedure dbo.sxAddHost
GO             
CREATE PROCEDURE sxAddHost
	@external_id VARCHAR(50),
	@group_id VARCHAR(50),
	@is_registration smallint = 0,
	@this_node varchar(50) = NULL
AS
BEGIN
	IF @is_registration = 1 AND @this_node IS NULL
	BEGIN
		RAISERROR('Debe de indicar @this_node cuando @is_registration = 1', 16, 1)
		RETURN
	END

	IF NOT EXISTS(SELECT * FROM sx_node_group WHERE node_group_id = @group_id)
		INSERT INTO sx_node_group (node_group_id, description) VALUES (@group_id, 'Grupo '+@group_id)

	--Ya podemos abrir registro desde aqui
	--IF @external_id = (SELECT TOP 1 node_id FROM sx_node_identity)
		IF NOT EXISTS(SELECT * FROM sx_node WHERE node_id = @external_id)
			INSERT INTO sx_node (node_id, node_group_id, external_id, sync_enabled) VALUES (@external_id, @group_id, @external_id, 1)

	IF NOT EXISTS (SELECT * FROM sx_node_security WHERE node_id = @external_id) AND (@is_registration = 1)
		INSERT INTO sx_node_security (node_id, node_password, registration_enabled, registration_time, initial_load_enabled, initial_load_time, created_at_node_id)
		VALUES (@external_id, '4d186321c1a7f0f354b297e8914ab240', 1, current_timestamp, 0, current_timestamp, @this_node)

END
GO

--#endregion

--#region	sxDeleteHost
if exists (select * from sysobjects where id = object_id('dbo.sxDeleteHost') and type = 'P') drop procedure dbo.sxDeleteHost
GO             
CREATE PROCEDURE sxDeleteHost
	@external_id VARCHAR(50),
	@group_id VARCHAR(50)
AS
BEGIN
	DELETE FROM sx_node WHERE node_id = @external_id
	DELETE FROM sx_node_host WHERE node_id = @external_id
	DELETE FROM sx_node_security WHERE node_id = @external_id

	IF NOT EXISTS(SELECT node_id FROM sx_node WHERE node_group_id = @group_id)
		DELETE FROM sx_node_group WHERE node_group_id = @group_id
END
GO
--#endregion

--#region sxCreateChannels
if exists (select * from sysobjects where id = object_id('dbo.sxCreateChannels') and type = 'P') drop procedure dbo.sxCreateChannels
GO             
CREATE PROCEDURE sxCreateChannels
AS
BEGIN
IF NOT EXISTS (SELECT * FROM sx_channel WHERE channel_id = 'config')
	INSERT INTO sx_channel (channel_id, processing_order, max_batch_size, max_batch_to_send, max_data_to_route, enabled, description)
	VALUES('config', 0, 100, 100, 10000, 1, 'Canal de configuracion')

IF NOT EXISTS (SELECT * FROM sx_channel WHERE channel_id = 'reload')
	INSERT INTO sx_channel (channel_id, processing_order, max_batch_size, max_batch_to_send, max_data_to_route, enabled, description)
	VALUES('reload', 1, 1, 10, 10000, 1, 'Canal de reloads')

IF NOT EXISTS (SELECT * FROM sx_channel WHERE channel_id = 'schema_channel')
	INSERT INTO sx_channel (channel_id, processing_order, max_batch_size, enabled, description)
	VALUES('schema_channel', 0, 1, 1, 'Canal de cambios en schema')

IF NOT EXISTS (SELECT * FROM sx_channel WHERE channel_id = 'alta')
	INSERT INTO sx_channel (channel_id, processing_order, max_batch_size, enabled, description)
	VALUES('alta', 2, 1500, 1, 'Canal Alta Prioridad')

IF NOT EXISTS (SELECT * FROM sx_channel WHERE channel_id = 'normal')
	INSERT INTO sx_channel (channel_id, processing_order, max_batch_size, enabled, description)
	VALUES('normal', 3, 1000, 1, 'Canal Prioridad Normal')

IF NOT EXISTS (SELECT * FROM sx_channel WHERE channel_id = 'baja')
	INSERT INTO sx_channel (channel_id, processing_order, max_batch_size, enabled, description)
	VALUES('baja', 4, 500, 1, 'Canal Baja Prioridad')
END
GO	
--#endregion

--#region sxAddIdentity
if exists (select * from sysobjects where id = object_id('dbo.sxAddIdentity') and type = 'P') drop procedure dbo.sxAddIdentity
GO             
CREATE PROCEDURE sxAddIdentity
	@external_id VARCHAR(50),
	@group_id VARCHAR(50)
	
AS
BEGIN
	IF EXISTS (SELECT node_id FROM sx_node_identity)
		DELETE FROM sx_node_identity
	INSERT INTO sx_node_identity (node_id) VALUES (@external_id)
	EXEC sxAddHost @external_id, @group_id
	EXEC sxCreateChannels
END
GO
--#endregion

--#region sxAddTableGroup
if exists (select * from sysobjects where id = object_id('dbo.sxAddTableGroup') and type = 'P') drop procedure dbo.sxAddTableGroup
GO             
CREATE PROCEDURE sxAddTableGroup
	@table_group varchar(20),
	@sync_cascade smallint,
	@load_order int = 200,
	@channel varchar(50) = 'normal'
AS 
BEGIN
	IF NOT EXISTS (SELECT table_group FROM sx_table_group WHERE table_group = @table_group)
		INSERT INTO sx_table_group (table_group, sync_cascade, load_order, channel) VALUES (@table_group, @sync_cascade, @load_order, @channel)
END
GO
--#endregion

--#region sxDeleteTableGroup
if exists (select * from sysobjects where id = object_id('dbo.sxDeleteTableGroup') and type = 'P') drop procedure dbo.sxDeleteTableGroup
GO             
CREATE PROCEDURE sxDeleteTableGroup
	@table_group VARCHAR(20)
AS 
BEGIN
	DECLARE @table_name VARCHAR(50), @from VARCHAR(10), @to VARCHAR(10)

	DECLARE crTables CURSOR LOCAL FOR
	SELECT t.table_name, r.group_id_from, r.group_id_to
	FROM sx_relations r
	JOIN sx_table t ON (r.table_group = t.table_group)
	WHERE r.table_group = @table_group
	OPEN crTables 
	FETCH NEXT FROM crTables INTO @table_name, @from, @to
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC sxDeleteTrigger @table_name, @from, @to

		FETCH NEXT FROM crTables INTO @table_name, @from, @to
	END
	CLOSE crTables
	DEALLOCATE crTables

	DELETE FROM sx_table WHERE table_group = @table_group
	DELETE FROM sx_table_group WHERE table_group = @table_group
END
GO
--#endregion

--#region	sxAddTable
if exists (select * from sysobjects where id = object_id('dbo.sxAddTable') and type = 'P') drop procedure dbo.sxAddTable
GO             
CREATE PROCEDURE sxAddTable
	@table_name varchar(50),
	@table_group VARCHAR(20),
	@ignore_fields text = '',
	@sync_cascade_override smallint = NULL,
	@channel_override VARCHAR(20) = ''
AS 
BEGIN
	DECLARE @from VARCHAR(10), @to VARCHAR(10), @sync_cascade_group INT, @sync_cascade_relation INT, @relation CHAR(4), @channel VARCHAR(20), @load_order INT

	IF EXISTS (SELECT table_group FROM sx_table_group WHERE table_group = @table_group)
		SELECT @sync_cascade_group = sync_cascade, @channel = channel, @load_order = load_order FROM sx_table_group WHERE table_group = @table_group
	ELSE
	BEGIN
		RAISERROR('El Grupo de Tablas no existe', 16, 1)
		RETURN
	END
	
	IF @channel_override != '' SELECT @channel = @channel_override

	DECLARE crMasterEntries CURSOR LOCAL FOR
	SELECT group_id_from, group_id_to, sync_cascade_override, relation_type
	FROM sx_relations
	WHERE table_group = @table_group
	OPEN crMasterEntries
	FETCH NEXT FROM crMasterEntries INTO @from, @to, @sync_cascade_relation, @relation
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @sync_cascade_relation IS NOT NULL SELECT @sync_cascade_group = @sync_cascade_relation
		IF @sync_cascade_override IS NOT NULL SELECT @sync_cascade_group = @sync_cascade_override
		EXEC sxAddTrigger @table_name, @from, @to, @table_group, @relation, @ignore_fields, @sync_cascade_group, @load_order, @channel

		FETCH NEXT FROM crMasterEntries INTO @from, @to, @sync_cascade_group, @relation
	END -- WHILE crMasterEntries
	CLOSE crMasterEntries
	DEALLOCATE crMasterEntries

	IF NOT EXISTS (SELECT table_name FROM sx_table WHERE table_group = @table_group AND table_name = @table_name)
		INSERT INTO sx_table (table_group, table_name, ignore_fields, sync_cascade_override, channel_override)
		VALUES (@table_group, @table_name, @ignore_fields, @sync_cascade_override, @channel)
	ELSE UPDATE sx_table SET ignore_fields = @ignore_fields, sync_cascade_override = @sync_cascade_override, channel_override = @channel
		WHERE table_group = @table_group AND table_name = @table_name
END
GO
--#endregion

--#region	sxDeleteTable
if exists (select * from sysobjects where id = object_id('dbo.sxDeleteTable') and type = 'P') drop procedure dbo.sxDeleteTable
GO             
CREATE PROCEDURE sxDeleteTable
	@table_name VARCHAR(50),
	@table_group VARCHAR(20)
AS 
BEGIN
	DECLARE @from VARCHAR(10), @to VARCHAR(10), @relation CHAR(4), @channel VARCHAR(20), @load_order INT

	SELECT @channel = channel, @load_order = load_order FROM sx_table_group WHERE table_group = @table_group

	DECLARE crMasterEntries CURSOR LOCAL FOR
	SELECT group_id_from, group_id_to, relation_type
	FROM sx_relations WHERE table_group = @table_group
	OPEN crMasterEntries 
	FETCH NEXT FROM crMasterEntries INTO @from, @to, @relation
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC sxDeleteTrigger @table_name, @from, @to

		FETCH NEXT FROM crMasterEntries INTO @from, @to, @relation
	END
	CLOSE crMasterEntries
	DEALLOCATE crMasterEntries

	DELETE FROM sx_table WHERE table_group = @table_group AND table_name = @table_name
END
GO
--#endregion

--#region sxAddRelation
if exists (select * from sysobjects where id = object_id('dbo.sxAddRelation') and type = 'P') drop procedure dbo.sxAddRelation
GO             
CREATE PROCEDURE sxAddRelation
	@from VARCHAR(50),
	@to VARCHAR(50),
	@table_group VARCHAR(50),
	@relation_type char(4),
	@sync_cascade_override smallint = NULL,
	@type VARCHAR(50) = NULL,
	@expression varchar(255) = NULL
AS
BEGIN
	DECLARE @temp VARCHAR(10), @sync_cascade_final smallint
	DECLARE	@table_name VARCHAR(50), @channel VARCHAR(20), @load_order INT, @sync_cascade_group smallint, @sync_cascade_table smallint,
		@schema_router varchar(32), @schema_trigger varchar(21), @ignore_fields varchar(max), @channel_override VARCHAR(20)

	SELECT @sync_cascade_group = sync_cascade, @channel = channel, @load_order = load_order FROM sx_table_group WHERE table_group = @table_group

	EXEC sxAddGroupLink @from, @to
	IF NOT EXISTS (SELECT table_group FROM sx_relations WHERE group_id_from = @from AND group_id_to = @to AND table_group = @table_group)
	INSERT INTO sx_relations (group_id_from, group_id_to, table_group, relation_type, sync_cascade_override)
	VALUES  (@from, @to, @table_group, @relation_type, @sync_cascade_override)
	
	IF @relation_type IN ('both', 'pull') EXEC sxAddRouter @from, @to, @table_group, @type, @expression
	IF @relation_type IN ('both', 'push') EXEC sxAddRouter @to, @from, @table_group, @type, @expression

	IF (@sync_cascade_override IS NULL OR @sync_cascade_override = 0) SELECT @sync_cascade_override = @sync_cascade_group

	IF @relation_type IN ('both', 'push') EXEC sxAddRouter @from, @to, @table_group, @type, @expression
	
	DECLARE crTables CURSOR LOCAL FOR
	SELECT table_name, ignore_fields, sync_cascade_override, channel_override FROM sx_table WHERE table_group = @table_group
	OPEN crTABLES
	FETCH NEXT FROM crTables INTO @table_name, @ignore_fields, @sync_cascade_table, @channel_override
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF (@sync_cascade_table IS NOT NULL OR @sync_cascade_table = 1) SELECT @sync_cascade_override = @sync_cascade_table
		IF (@channel_override IS NOT NULL OR @channel_override != '') SELECT @channel = @channel_override
		
		IF @sync_cascade_group IS NOT NULL SELECT @sync_cascade_final = @sync_cascade_group
		IF @sync_cascade_table IS NOT NULL SELECT @sync_cascade_final = @sync_cascade_table
		IF @sync_cascade_override IS NOT NULL SELECT @sync_cascade_final = @sync_cascade_override
		IF @sync_cascade_final IS NULL SELECT @sync_cascade_final = 0

		EXEC sxAddTrigger @table_name, @from, @to, @table_group, @relation_type, @ignore_fields, @sync_cascade_final, @load_order, @channel
	FETCH NEXT FROM crTables INTO @table_name, @ignore_fields, @sync_cascade_table, @channel_override
	END -- while
	CLOSE crTables
	DEALLOCATE crTables

	IF NOT EXISTS (SELECT table_group FROM sx_Relations WHERE group_id_from = @from AND group_id_to = @to AND table_group = @table_group)
	INSERT INTO sx_relations (group_id_from, group_id_to, table_group, relation_type, sync_cascade_override)
	VALUES  (@from, @to, @table_group, @relation_type, @sync_cascade_override)
END
GO
--#endregion

--#region sxDeleteRelation
if exists (select * from sysobjects where id = object_id('dbo.sxDeleteRelation') and type = 'P') drop procedure dbo.sxDeleteRelation
GO             
CREATE PROCEDURE sxDeleteRelation
	@from VARCHAR(50),
	@to VARCHAR(50),
	@table_group VARCHAR(50)
AS 
BEGIN
	DECLARE	@name VARCHAR(50)

	DECLARE crTables CURSOR LOCAL FOR
	SELECT table_name FROM sx_table WHERE table_group = @table_group
	OPEN crTables
	FETCH NEXT FROM crTables INTO @name
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC sxDeleteTrigger @name, @from, @to
		FETCH NEXT FROM crTables INTO @name
	END

	EXEC sxDeleteRouter @from, @to
	EXEC sxDeleteGroupLink @from, @to

	DELETE FROM sx_relations WHERE group_id_from = @from AND group_id_to = @to AND table_group = @table_group
END
GO
--#endregion

if exists (select * from sysobjects where id = object_id('dbo.sxGetFieldsList') and type = 'FN') drop function dbo.sxGetFieldsList
GO
CREATE FUNCTION sxGetFieldsList (@list varchar(20), @search_table varchar(50), @origin_table varchar(50), @target_table varchar(50), @separator varchar(10), @asign smallint/*, @replace smallint*/)
RETURNS varchar(max)
AS
BEGIN
DECLARE @campo nvarchar(128), @sql_fields nvarchar(max), @asignator varchar(150)
set @asignator = ''

IF (@list = 'NonIdentity')
	DECLARE crFields CURSOR LOCAL FOR
	SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS
	WHERE TABLE_NAME = @search_table AND TABLE_CATALOG = DB_NAME()
	AND COLUMNPROPERTY(OBJECT_ID(TABLE_NAME), COLUMN_NAME,'IsIdentity') = 0
ELSE IF (@list = 'PrimaryKey')
	DECLARE crFields CURSOR LOCAL FOR
	SELECT cu.COLUMN_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
	INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE cu ON (tc.CONSTRAINT_NAME = cu.CONSTRAINT_NAME)
	WHERE tc.TABLE_CATALOG = DB_NAME()
	AND tc.TABLE_NAME = @search_table AND tc.CONSTRAINT_TYPE = 'PRIMARY KEY'
OPEN crFields
FETCH NEXT FROM crFields INTO @campo
--IF @replace = 1 SELECT @origin_table = @target_table
IF @asign = 1 SELECT @asignator = ' = ' + @target_table + '.' + @campo
SELECT @sql_fields = @origin_table + '.' + @campo + @asignator
FETCH NEXT FROM crFields INTO @campo
WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @asign = 1 SELECT @asignator = ' = ' + @target_table + '.' + @campo
		SELECT @sql_fields = @sql_fields + @separator + @origin_table + '.' + @campo + @asignator

		FETCH NEXT FROM crFields INTO @campo
	END
CLOSE crFields
DEALLOCATE crFields

RETURN @sql_fields
END
GO

--#region sxReplicateTables
if exists (select * from sysobjects where id = object_id('dbo.sxReplicateTables') and type = 'P') drop procedure dbo.sxReplicateTables
GO             
CREATE PROCEDURE sxReplicateTables
	@origin_table varchar(50),
	@target_table varchar(50),
	@overwrite smallint = 0
AS
BEGIN
	IF @overwrite = 1 OR NOT EXISTS (SELECT table_group FROM sx_relations WHERE relation_type = 'tabl' AND group_id_from = @origin_table AND group_id_to = @target_table)
	BEGIN
		IF NOT EXISTS (SELECT table_group FROM sx_relations WHERE relation_type = 'tabl' AND group_id_from = @origin_table AND group_id_to = @target_table)
			INSERT INTO sx_relations (group_id_from, group_id_to, table_group, relation_type)
			VALUES (@origin_table, @target_table, @origin_table, 'tabl')
		
		DECLARE @trigger_id varchar(100), @drop_sql varchar(max), @trigger_sql varchar(max), @to varchar(50)

		-- Begin trigger for Insert
		SELECT @trigger_id = 'tgi_rpl_'+@origin_table
		SELECT @drop_sql = 'if exists (select * from sysobjects where id = object_id(''dbo.'+@trigger_id+''') and type = ''TR'') drop trigger dbo.'+@trigger_id
		EXEC(@drop_sql)
		
		SELECT @trigger_sql = 'CREATE TRIGGER '+@trigger_id+' ON '+@origin_table+' FOR INSERT AS
		BEGIN
		DECLARE @insert_sql varchar(max)

		SELECT * INTO #tempTable FROM INSERTED '

		DECLARE crRelations CURSOR LOCAL FOR
		SELECT group_id_to FROM sx_relations WHERE relation_type = 'tabl' AND group_id_from = @origin_table
		OPEN crRelations
		FETCH NEXT FROM crRelations INTO @to
		WHILE @@FETCH_STATUS = 0
			BEGIN
				select @trigger_sql = @trigger_sql + 'SELECT @insert_sql = ''
				INSERT INTO '+@to+' (''+dbo.sxGetFieldsList(''NonIdentity'', '''+@origin_table+''', '''+@to+''', ''#tempTable'', '', '', 0)+'')
				SELECT ''+dbo.sxGetFieldsList(''NonIdentity'', '''+@origin_table+''', ''#tempTable'', ''#tempTable'', '', '', 0)+'' FROM #tempTable''
				EXEC(@insert_sql) '			
			
			FETCH NEXT FROM crRelations INTO @to
			END
		CLOSE crRelations
		DEALLOCATE crRelations
		
		SELECT @trigger_sql = @trigger_sql + 'DROP TABLE #tempTable
		END'
		--select @trigger_sql
		EXEC(@trigger_sql)
		-- End trigger for Insert

		-- Begin trigger for Delete
		SELECT @trigger_id = 'tgd_rpl_'+@origin_table
		SELECT @drop_sql = 'if exists (select * from sysobjects where id = object_id(''dbo.'+@trigger_id+''') and type = ''TR'') drop trigger dbo.'+@trigger_id
		EXEC(@drop_sql)
		
		SELECT @trigger_sql = 'CREATE TRIGGER '+@trigger_id+' ON '+@origin_table+' FOR DELETE AS
		BEGIN
		DECLARE @sql_campos varchar(max), @delete_sql varchar(max), @campo nvarchar(128)

		SELECT * INTO #tempTable FROM DELETED '

		DECLARE crRelations CURSOR LOCAL FOR
		SELECT group_id_to FROM sx_relations WHERE relation_type = 'tabl' AND group_id_from = @origin_table
		OPEN crRelations
		FETCH NEXT FROM crRelations INTO @to
		WHILE @@FETCH_STATUS = 0
			BEGIN
				select @trigger_sql = @trigger_sql + 'SELECT @delete_sql = ''DELETE '+@to+'
				FROM '+@to+'
				INNER JOIN #tempTable
				ON (''+dbo.sxGetFieldsList(''PrimaryKey'', '''+@origin_table+''', '''+@to+''', ''#tempTable'', '' AND '', 1)+'')''
				EXEC(@delete_sql) '			
			
			FETCH NEXT FROM crRelations INTO @to
			END
		CLOSE crRelations
		DEALLOCATE crRelations
		
		SELECT @trigger_sql = @trigger_sql + 'DROP TABLE #tempTable
		END'
		--select @trigger_sql
		EXEC(@trigger_sql)
		-- End trigger for Delete

		-- Begin trigger for Update
		SELECT @trigger_id = 'tgu_rpl_'+@origin_table
		SELECT @drop_sql = 'if exists (select * from sysobjects where id = object_id(''dbo.'+@trigger_id+''') and type = ''TR'') drop trigger dbo.'+@trigger_id
		EXEC(@drop_sql)
		
		SELECT @trigger_sql = 'CREATE TRIGGER '+@trigger_id+' ON '+@origin_table+' FOR UPDATE AS
		BEGIN
		DECLARE @update_sql varchar(max)

		SELECT * INTO #tempTable FROM INSERTED '

		DECLARE crRelations CURSOR LOCAL FOR
		SELECT group_id_to FROM sx_relations WHERE relation_type = 'tabl' AND group_id_from = @origin_table
		OPEN crRelations
		FETCH NEXT FROM crRelations INTO @to
		WHILE @@FETCH_STATUS = 0
			BEGIN
				select @trigger_sql = @trigger_sql + 'SELECT @update_sql = ''UPDATE '+@to+'
				SET ''+dbo.sxGetFieldsList(''NonIdentity'', '''+@origin_table+''', '''+@to+''', ''#tempTable'', '', '', 1)+''
				FROM '+@to+'
				JOIN #tempTable ON (''+dbo.sxGetFieldsList(''PrimaryKey'', '''+@origin_table+''', '''+@to+''', ''#tempTable'', '' AND '', 1)+'')''
				EXEC(@update_sql) '		
			
			FETCH NEXT FROM crRelations INTO @to
			END
		CLOSE crRelations
		DEALLOCATE crRelations
		
		SELECT @trigger_sql = @trigger_sql + 'DROP TABLE #tempTable
		END'
		--select @trigger_sql
		EXEC(@trigger_sql)
		-- End trigger for Update
	END
END
GO
--#endregion

--#region sxEnableSchema
if exists (select * from sysobjects where id = object_id('dbo.sxEnableSchema') and type = 'P') drop procedure dbo.sxEnableSchema
GO             
CREATE PROCEDURE sxEnableSchema
	@from VARCHAR(50),
	@to VARCHAR(50)
AS
BEGIN
	DECLARE @schema_router varchar(50), @schema_trigger varchar(50)
	SELECT @schema_router = 'rt_schema_'+@from+'_'+@to, @schema_trigger = 'tg_schema_'+@from

	EXEC sxAddGroupLink @from, @to

	EXEC sxAddRouterByID @schema_router, @from, @to, NULL, NULL
	EXEC sxAddTriggerByID @schema_trigger, @schema_router, 'sx_schema', 0, 1, 'schema_channel'
END
GO
--#endregion

--#region sxDisableSchema
if exists (select * from sysobjects where id = object_id('dbo.sxDisableSchema') and type = 'P') drop procedure dbo.sxDisableSchema
GO             
CREATE PROCEDURE sxDisableSchema
	@from VARCHAR(50),
	@to VARCHAR(50)
AS
BEGIN
	DECLARE @schema_router varchar(32), @schema_trigger varchar(21)
	SELECT @schema_router = 'rt_schema_'+@from+'_'+@to, @schema_trigger = 'tg_schema_'+@from

	--DELETE FROM sx_trigger_router WHERE router_id = @schema_router AND trigger_id = @schema_trigger

	UPDATE sx_router SET sync_on_update = 0, sync_on_insert = 0, sync_on_delete = 0 WHERE router_id = @schema_router
	UPDATE sx_trigger SET sync_on_update = 0, sync_on_insert = 0, sync_on_delete = 0 WHERE trigger_id = @schema_trigger
/*
	IF NOT EXISTS (SELECT router_id FROM sx_trigger_router WHERE router_id = @schema_router)
		DELETE FROM sx_router WHERE router_id = @schema_router
	IF NOT EXISTS (SELECT trigger_id FROM sx_trigger_router WHERE trigger_id = @schema_trigger)
		DELETE FROM sx_trigger WHERE trigger_id = @schema_trigger
*/
	IF NOT EXISTS (SELECT router_id FROM sx_router WHERE source_node_group_id = @from AND target_node_group_id = @to)
		EXEC sxDeleteGroupLink @from, @to
END
GO
--#endregion


SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF
SET ANSI_WARNINGS OFF
GO


IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[POSIsyncMonitor]'))
DROP VIEW POSIsyncMonitor
GO
CREATE VIEW POSIsyncMonitor
WITH ENCRYPTION
AS
SELECT 
batch_id as Batch,
node_id as Nodo,
channel_id as Canal,
status as Estatus,
extract_count as ContExtraccion,
sent_count as ContEnvio,
load_count as ContCarga,
sql_state as EstadoSQL,
sql_code as CodigoSQL,
CONVERT(varchar(100),sql_message) as MensajeSQL,
failed_data_id as DataFallido,
last_update_time as UltimaActualizacion,
create_time as FechaCreacion
FROM sx_outgoing_batch

GO