

CREATE TABLE [events] (

	[event_id] [int] IDENTITY (1, 1) NOT NULL ,

	[second] [varchar] (64) NULL ,

	[minute] [varchar] (64) NULL ,

	[hour] [varchar] (64) NULL ,

	[dayofmonth] [varchar] (64) NULL ,

	[month] [varchar] (64) NULL ,

	[dayofweek] [varchar] (64) NULL ,

	[year] [varchar] (64) NULL ,

	[task] [varchar] (255) NULL ,

	[extrainfo] [varchar] (255) NULL ,

	[businessDays] [varchar] (6) NULL ,

	[enabled] [bit] NULL ,

	[entered] [datetime] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [events_log] (

	[log_id] [int] IDENTITY (1, 1) NOT NULL ,

	[event_id] [int] NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[status] [int] NULL ,

	[message] [text] NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [sites] (

	[site_id] [int] IDENTITY (1, 1) NOT NULL ,

	[sitecode] [varchar] (255) NOT NULL ,

	[vhost] [varchar] (255) NOT NULL ,

	[dbhost] [varchar] (255) NOT NULL ,

	[dbname] [varchar] (255) NOT NULL ,

	[dbport] [int] NOT NULL ,

	[dbuser] [varchar] (255) NOT NULL ,

	[dbpw] [varchar] (255) NOT NULL ,

	[driver] [varchar] (255) NOT NULL ,

	[code] [varchar] (255) NULL ,

	[enabled] [bit] NOT NULL 

) ON [PRIMARY]

GO



ALTER TABLE [events] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[event_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [sites] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[site_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [events_log] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[log_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [events] WITH NOCHECK ADD 

	CONSTRAINT [DF__events__second__014935CB] DEFAULT ('0') FOR [second],

	CONSTRAINT [DF__events__minute__023D5A04] DEFAULT ('*') FOR [minute],

	CONSTRAINT [DF__events__hour__03317E3D] DEFAULT ('*') FOR [hour],

	CONSTRAINT [DF__events__dayofmon__0425A276] DEFAULT ('*') FOR [dayofmonth],

	CONSTRAINT [DF__events__month__0519C6AF] DEFAULT ('*') FOR [month],

	CONSTRAINT [DF__events__dayofwee__060DEAE8] DEFAULT ('*') FOR [dayofweek],

	CONSTRAINT [DF__events__year__07020F21] DEFAULT ('*') FOR [year],

	CONSTRAINT [DF__events__business__07F6335A] DEFAULT ('true') FOR [businessDays],

	CONSTRAINT [DF__events__enabled__08EA5793] DEFAULT (0) FOR [enabled],

	CONSTRAINT [DF__events__entered__09DE7BCC] DEFAULT (getdate()) FOR [entered]

GO



ALTER TABLE [sites] WITH NOCHECK ADD 

	CONSTRAINT [DF__sites__vhost__77BFCB91] DEFAULT ('') FOR [vhost],

	CONSTRAINT [DF__sites__dbhost__78B3EFCA] DEFAULT ('') FOR [dbhost],

	CONSTRAINT [DF__sites__dbname__79A81403] DEFAULT ('') FOR [dbname],

	CONSTRAINT [DF__sites__dbport__7A9C383C] DEFAULT (1433) FOR [dbport],

	CONSTRAINT [DF__sites__dbuser__7B905C75] DEFAULT ('') FOR [dbuser],

	CONSTRAINT [DF__sites__dbpw__7C8480AE] DEFAULT ('') FOR [dbpw],

	CONSTRAINT [DF__sites__driver__7D78A4E7] DEFAULT ('') FOR [driver],

	CONSTRAINT [DF__sites__enabled__7E6CC920] DEFAULT (0) FOR [enabled]

GO



ALTER TABLE [events_log] WITH NOCHECK ADD 

	CONSTRAINT [DF__events_lo__enter__0DAF0CB0] DEFAULT (getdate()) FOR [entered]

GO



ALTER TABLE [events_log] ADD 

	 FOREIGN KEY 

	(

		[event_id]

	) REFERENCES [events] (

		[event_id]

	)

GO





CREATE TABLE [access] (

	[user_id] [int] IDENTITY (0, 1) NOT NULL ,

	[username] [varchar] (80) NOT NULL ,

	[password] [varchar] (80) NULL ,

	[contact_id] [int] NULL ,

	[role_id] [int] NULL ,

	[manager_id] [int] NULL ,

	[startofday] [int] NULL ,

	[endofday] [int] NULL ,

	[locale] [varchar] (255) NULL ,

	[timezone] [varchar] (255) NULL ,

	[last_ip] [varchar] (15) NULL ,

	[last_login] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[expires] [datetime] NULL ,

	[alias] [int] NULL ,

	[assistant] [int] NULL ,

	[enabled] [bit] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [access_log] (

	[id] [int] IDENTITY (1, 1) NOT NULL ,

	[user_id] [int] NOT NULL ,

	[username] [varchar] (80) NOT NULL ,

	[ip] [varchar] (15) NULL ,

	[entered] [datetime] NOT NULL ,

	[browser] [varchar] (255) NULL 

) ON [PRIMARY]

GO



CREATE TABLE [account_type_levels] (

	[org_id] [int] NOT NULL ,

	[type_id] [int] NOT NULL ,

	[level] [int] NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[modified] [datetime] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [action_item] (

	[item_id] [int] IDENTITY (1, 1) NOT NULL ,

	[action_id] [int] NOT NULL ,

	[link_item_id] [int] NOT NULL ,

	[completedate] [datetime] NULL ,

	[enteredby] [int] NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[enabled] [bit] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [action_item_log] (

	[log_id] [int] IDENTITY (1, 1) NOT NULL ,

	[item_id] [int] NOT NULL ,

	[link_item_id] [int] NULL ,

	[type] [int] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [action_list] (

	[action_id] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (255) NOT NULL ,

	[owner] [int] NOT NULL ,

	[completedate] [datetime] NULL ,

	[link_module_id] [int] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[enabled] [bit] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [active_campaign_groups] (

	[id] [int] IDENTITY (1, 1) NOT NULL ,

	[campaign_id] [int] NOT NULL ,

	[groupname] [varchar] (80) NOT NULL ,

	[groupcriteria] [text] NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [active_survey] (

	[active_survey_id] [int] IDENTITY (1, 1) NOT NULL ,

	[campaign_id] [int] NOT NULL ,

	[name] [varchar] (80) NOT NULL ,

	[description] [varchar] (255) NULL ,

	[intro] [text] NULL ,

	[outro] [text] NULL ,

	[itemLength] [int] NULL ,

	[type] [int] NOT NULL ,

	[enabled] [bit] NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [active_survey_answer_avg] (

	[id] [int] IDENTITY (1, 1) NOT NULL ,

	[question_id] [int] NOT NULL ,

	[item_id] [int] NOT NULL ,

	[total] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [active_survey_answer_items] (

	[id] [int] IDENTITY (1, 1) NOT NULL ,

	[item_id] [int] NOT NULL ,

	[answer_id] [int] NOT NULL ,

	[comments] [text] NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [active_survey_answers] (

	[answer_id] [int] IDENTITY (1, 1) NOT NULL ,

	[response_id] [int] NOT NULL ,

	[question_id] [int] NOT NULL ,

	[comments] [text] NULL ,

	[quant_ans] [int] NULL ,

	[text_ans] [text] NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [active_survey_items] (

	[item_id] [int] IDENTITY (1, 1) NOT NULL ,

	[question_id] [int] NOT NULL ,

	[type] [int] NULL ,

	[description] [varchar] (255) NULL 

) ON [PRIMARY]

GO



CREATE TABLE [active_survey_questions] (

	[question_id] [int] IDENTITY (1, 1) NOT NULL ,

	[active_survey_id] [int] NULL ,

	[type] [int] NOT NULL ,

	[description] [varchar] (255) NULL ,

	[required] [bit] NOT NULL ,

	[position] [int] NOT NULL ,

	[average] [float] NULL ,

	[total1] [int] NULL ,

	[total2] [int] NULL ,

	[total3] [int] NULL ,

	[total4] [int] NULL ,

	[total5] [int] NULL ,

	[total6] [int] NULL ,

	[total7] [int] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [active_survey_responses] (

	[response_id] [int] IDENTITY (1, 1) NOT NULL ,

	[active_survey_id] [int] NOT NULL ,

	[contact_id] [int] NOT NULL ,

	[unique_code] [varchar] (255) NULL ,

	[ip_address] [varchar] (15) NOT NULL ,

	[entered] [datetime] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [autoguide_ad_run] (

	[ad_run_id] [int] IDENTITY (1, 1) NOT NULL ,

	[inventory_id] [int] NOT NULL ,

	[run_date] [datetime] NOT NULL ,

	[ad_type] [varchar] (20) NULL ,

	[include_photo] [bit] NULL ,

	[complete_date] [datetime] NULL ,

	[completedby] [int] NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [autoguide_ad_run_types] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (20) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL ,

	[entered] [datetime] NOT NULL ,

	[modified] [datetime] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [autoguide_inventory] (

	[inventory_id] [int] IDENTITY (1, 1) NOT NULL ,

	[vehicle_id] [int] NOT NULL ,

	[account_id] [int] NULL ,

	[vin] [varchar] (20) NULL ,

	[mileage] [varchar] (20) NULL ,

	[is_new] [bit] NULL ,

	[condition] [varchar] (20) NULL ,

	[comments] [varchar] (255) NULL ,

	[stock_no] [varchar] (20) NULL ,

	[ext_color] [varchar] (20) NULL ,

	[int_color] [varchar] (20) NULL ,

	[style] [varchar] (40) NULL ,

	[invoice_price] [float] NULL ,

	[selling_price] [float] NULL ,

	[selling_price_text] [varchar] (100) NULL ,

	[sold] [bit] NULL ,

	[status] [varchar] (20) NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [autoguide_inventory_options] (

	[inventory_id] [int] NOT NULL ,

	[option_id] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [autoguide_make] (

	[make_id] [int] IDENTITY (1, 1) NOT NULL ,

	[make_name] [varchar] (30) NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [autoguide_model] (

	[model_id] [int] IDENTITY (1, 1) NOT NULL ,

	[make_id] [int] NOT NULL ,

	[model_name] [varchar] (50) NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [autoguide_options] (

	[option_id] [int] IDENTITY (1, 1) NOT NULL ,

	[option_name] [varchar] (20) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL ,

	[entered] [datetime] NOT NULL ,

	[modified] [datetime] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [autoguide_vehicle] (

	[vehicle_id] [int] IDENTITY (1, 1) NOT NULL ,

	[year] [varchar] (4) NOT NULL ,

	[make_id] [int] NOT NULL ,

	[model_id] [int] NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [business_process] (

	[process_id] [int] IDENTITY (1, 1) NOT NULL ,

	[process_name] [varchar] (255) NOT NULL ,

	[description] [varchar] (510) NULL ,

	[type_id] [int] NOT NULL ,

	[link_module_id] [int] NOT NULL ,

	[component_start_id] [int] NULL ,

	[enabled] [bit] NOT NULL ,

	[entered] [datetime] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [business_process_component] (

	[id] [int] IDENTITY (1, 1) NOT NULL ,

	[process_id] [int] NOT NULL ,

	[component_id] [int] NOT NULL ,

	[parent_id] [int] NULL ,

	[parent_result_id] [int] NULL ,

	[enabled] [bit] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [business_process_component_library] (

	[component_id] [int] IDENTITY (1, 1) NOT NULL ,

	[component_name] [varchar] (255) NOT NULL ,

	[type_id] [int] NOT NULL ,

	[class_name] [varchar] (255) NOT NULL ,

	[description] [varchar] (510) NULL ,

	[enabled] [bit] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [business_process_component_parameter] (

	[id] [int] IDENTITY (1, 1) NOT NULL ,

	[component_id] [int] NOT NULL ,

	[parameter_id] [int] NOT NULL ,

	[param_value] [varchar] (4000) NULL ,

	[enabled] [bit] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [business_process_component_result_lookup] (

	[result_id] [int] IDENTITY (1, 1) NOT NULL ,

	[component_id] [int] NOT NULL ,

	[return_id] [int] NOT NULL ,

	[description] [varchar] (255) NULL ,

	[level] [int] NOT NULL ,

	[enabled] [bit] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [business_process_events] (

	[event_id] [int] IDENTITY (1, 1) NOT NULL ,

	[second] [varchar] (64) NULL ,

	[minute] [varchar] (64) NULL ,

	[hour] [varchar] (64) NULL ,

	[dayofmonth] [varchar] (64) NULL ,

	[month] [varchar] (64) NULL ,

	[dayofweek] [varchar] (64) NULL ,

	[year] [varchar] (64) NULL ,

	[task] [varchar] (255) NULL ,

	[extrainfo] [varchar] (255) NULL ,

	[businessDays] [varchar] (6) NULL ,

	[enabled] [bit] NULL ,

	[entered] [datetime] NOT NULL ,

	[process_id] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [business_process_hook] (

	[id] [int] IDENTITY (1, 1) NOT NULL ,

	[trigger_id] [int] NOT NULL ,

	[process_id] [int] NOT NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [business_process_hook_library] (

	[hook_id] [int] IDENTITY (1, 1) NOT NULL ,

	[link_module_id] [int] NOT NULL ,

	[hook_class] [varchar] (255) NOT NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [business_process_hook_triggers] (

	[trigger_id] [int] IDENTITY (1, 1) NOT NULL ,

	[action_type_id] [int] NOT NULL ,

	[hook_id] [int] NOT NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [business_process_log] (

	[process_name] [varchar] (255) NOT NULL ,

	[anchor] [datetime] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [business_process_parameter] (

	[id] [int] IDENTITY (1, 1) NOT NULL ,

	[process_id] [int] NOT NULL ,

	[param_name] [varchar] (255) NULL ,

	[param_value] [varchar] (4000) NULL ,

	[enabled] [bit] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [business_process_parameter_library] (

	[parameter_id] [int] IDENTITY (1, 1) NOT NULL ,

	[component_id] [int] NULL ,

	[param_name] [varchar] (255) NULL ,

	[description] [varchar] (510) NULL ,

	[default_value] [varchar] (4000) NULL ,

	[enabled] [bit] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [call_log] (

	[call_id] [int] IDENTITY (1, 1) NOT NULL ,

	[org_id] [int] NULL ,

	[contact_id] [int] NULL ,

	[opp_id] [int] NULL ,

	[call_type_id] [int] NULL ,

	[length] [int] NULL ,

	[subject] [varchar] (255) NULL ,

	[notes] [text] NULL ,

	[followup_date] [datetime] NULL ,

	[alertdate] [datetime] NULL ,

	[followup_notes] [text] NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL ,

	[alert] [varchar] (100) NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [campaign] (

	[campaign_id] [int] IDENTITY (1, 1) NOT NULL ,

	[name] [varchar] (80) NOT NULL ,

	[description] [varchar] (255) NULL ,

	[list_id] [int] NULL ,

	[message_id] [int] NULL ,

	[reply_addr] [varchar] (255) NULL ,

	[subject] [varchar] (255) NULL ,

	[message] [text] NULL ,

	[status_id] [int] NULL ,

	[status] [varchar] (255) NULL ,

	[active] [bit] NULL ,

	[active_date] [datetime] NULL ,

	[send_method_id] [int] NOT NULL ,

	[inactive_date] [datetime] NULL ,

	[approval_date] [datetime] NULL ,

	[approvedby] [int] NULL ,

	[enabled] [bit] NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL ,

	[type] [int] NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [campaign_list_groups] (

	[campaign_id] [int] NOT NULL ,

	[group_id] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [campaign_run] (

	[id] [int] IDENTITY (1, 1) NOT NULL ,

	[campaign_id] [int] NOT NULL ,

	[status] [int] NOT NULL ,

	[run_date] [datetime] NOT NULL ,

	[total_contacts] [int] NULL ,

	[total_sent] [int] NULL ,

	[total_replied] [int] NULL ,

	[total_bounced] [int] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [campaign_survey_link] (

	[campaign_id] [int] NULL ,

	[survey_id] [int] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [cfsinbox_message] (

	[id] [int] IDENTITY (1, 1) NOT NULL ,

	[subject] [varchar] (255) NULL ,

	[body] [text] NOT NULL ,

	[reply_id] [int] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[sent] [datetime] NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[type] [int] NOT NULL ,

	[modifiedby] [int] NOT NULL ,

	[delete_flag] [bit] NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [cfsinbox_messagelink] (

	[id] [int] NOT NULL ,

	[sent_to] [int] NOT NULL ,

	[status] [int] NOT NULL ,

	[viewed] [datetime] NULL ,

	[enabled] [bit] NOT NULL ,

	[sent_from] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [contact] (

	[contact_id] [int] IDENTITY (1, 1) NOT NULL ,

	[user_id] [int] NULL ,

	[org_id] [int] NULL ,

	[company] [varchar] (255) NULL ,

	[title] [varchar] (80) NULL ,

	[department] [int] NULL ,

	[super] [int] NULL ,

	[namesalutation] [varchar] (80) NULL ,

	[namelast] [varchar] (80) NOT NULL ,

	[namefirst] [varchar] (80) NOT NULL ,

	[namemiddle] [varchar] (80) NULL ,

	[namesuffix] [varchar] (80) NULL ,

	[assistant] [int] NULL ,

	[birthdate] [datetime] NULL ,

	[notes] [text] NULL ,

	[site] [int] NULL ,

	[imname] [varchar] (30) NULL ,

	[imservice] [int] NULL ,

	[locale] [int] NULL ,

	[employee_id] [varchar] (80) NULL ,

	[employmenttype] [int] NULL ,

	[startofday] [varchar] (10) NULL ,

	[endofday] [varchar] (10) NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL ,

	[enabled] [bit] NULL ,

	[owner] [int] NULL ,

	[custom1] [int] NULL ,

	[url] [varchar] (100) NULL ,

	[primary_contact] [bit] NULL ,

	[employee] [bit] NULL ,

	[org_name] [varchar] (255) NULL ,

	[access_type] [int] NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [contact_address] (

	[address_id] [int] IDENTITY (1, 1) NOT NULL ,

	[contact_id] [int] NULL ,

	[address_type] [int] NULL ,

	[addrline1] [varchar] (80) NULL ,

	[addrline2] [varchar] (80) NULL ,

	[addrline3] [varchar] (80) NULL ,

	[city] [varchar] (80) NULL ,

	[state] [varchar] (80) NULL ,

	[country] [varchar] (80) NULL ,

	[postalcode] [varchar] (12) NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [contact_emailaddress] (

	[emailaddress_id] [int] IDENTITY (1, 1) NOT NULL ,

	[contact_id] [int] NULL ,

	[emailaddress_type] [int] NULL ,

	[email] [varchar] (256) NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [contact_phone] (

	[phone_id] [int] IDENTITY (1, 1) NOT NULL ,

	[contact_id] [int] NULL ,

	[phone_type] [int] NULL ,

	[number] [varchar] (30) NULL ,

	[extension] [varchar] (10) NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [contact_type_levels] (

	[contact_id] [int] NOT NULL ,

	[type_id] [int] NOT NULL ,

	[level] [int] NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[modified] [datetime] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [custom_field_category] (

	[module_id] [int] NOT NULL ,

	[category_id] [int] IDENTITY (1, 1) NOT NULL ,

	[category_name] [varchar] (255) NOT NULL ,

	[level] [int] NULL ,

	[description] [text] NULL ,

	[start_date] [datetime] NULL ,

	[end_date] [datetime] NULL ,

	[default_item] [bit] NULL ,

	[entered] [datetime] NOT NULL ,

	[enabled] [bit] NULL ,

	[multiple_records] [bit] NULL ,

	[read_only] [bit] NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [custom_field_data] (

	[record_id] [int] NOT NULL ,

	[field_id] [int] NOT NULL ,

	[selected_item_id] [int] NULL ,

	[entered_value] [text] NULL ,

	[entered_number] [int] NULL ,

	[entered_float] [float] NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [custom_field_group] (

	[category_id] [int] NOT NULL ,

	[group_id] [int] IDENTITY (1, 1) NOT NULL ,

	[group_name] [varchar] (255) NOT NULL ,

	[level] [int] NULL ,

	[description] [text] NULL ,

	[start_date] [datetime] NULL ,

	[end_date] [datetime] NULL ,

	[entered] [datetime] NOT NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [custom_field_info] (

	[group_id] [int] NOT NULL ,

	[field_id] [int] IDENTITY (1, 1) NOT NULL ,

	[field_name] [varchar] (255) NOT NULL ,

	[level] [int] NULL ,

	[field_type] [int] NOT NULL ,

	[validation_type] [int] NULL ,

	[required] [bit] NULL ,

	[parameters] [text] NULL ,

	[start_date] [datetime] NULL ,

	[end_date] [datetime] NULL ,

	[entered] [datetime] NOT NULL ,

	[enabled] [bit] NULL ,

	[additional_text] [varchar] (255) NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [custom_field_lookup] (

	[field_id] [int] NOT NULL ,

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (255) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[start_date] [datetime] NULL ,

	[end_date] [datetime] NULL ,

	[entered] [datetime] NOT NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [custom_field_record] (

	[link_module_id] [int] NOT NULL ,

	[link_item_id] [int] NOT NULL ,

	[category_id] [int] NOT NULL ,

	[record_id] [int] IDENTITY (1, 1) NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [database_version] (

	[version_id] [int] IDENTITY (1, 1) NOT NULL ,

	[script_filename] [varchar] (255) NOT NULL ,

	[script_version] [varchar] (255) NOT NULL ,

	[entered] [datetime] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [excluded_recipient] (

	[id] [int] IDENTITY (1, 1) NOT NULL ,

	[campaign_id] [int] NOT NULL ,

	[contact_id] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [field_types] (

	[id] [int] IDENTITY (1, 1) NOT NULL ,

	[data_typeid] [int] NOT NULL ,

	[data_type] [varchar] (20) NULL ,

	[operator] [varchar] (50) NULL ,

	[display_text] [varchar] (50) NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [help_business_rules] (

	[rule_id] [int] IDENTITY (1, 1) NOT NULL ,

	[link_help_id] [int] NOT NULL ,

	[description] [varchar] (1000) NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[completedate] [datetime] NULL ,

	[completedby] [int] NULL ,

	[enabled] [bit] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [help_contents] (

	[help_id] [int] IDENTITY (1, 1) NOT NULL ,

	[category_id] [int] NULL ,

	[link_module_id] [int] NULL ,

	[module] [varchar] (255) NULL ,

	[section] [varchar] (255) NULL ,

	[subsection] [varchar] (255) NULL ,

	[title] [varchar] (255) NULL ,

	[description] [text] NULL ,

	[nextcontent] [int] NULL ,

	[prevcontent] [int] NULL ,

	[upcontent] [int] NULL ,

	[enteredby] [int] NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [help_faqs] (

	[faq_id] [int] IDENTITY (1, 1) NOT NULL ,

	[owning_module_id] [int] NOT NULL ,

	[question] [varchar] (1000) NOT NULL ,

	[answer] [varchar] (1000) NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[completedate] [datetime] NULL ,

	[completedby] [int] NULL ,

	[enabled] [bit] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [help_features] (

	[feature_id] [int] IDENTITY (1, 1) NOT NULL ,

	[link_help_id] [int] NOT NULL ,

	[link_feature_id] [int] NULL ,

	[description] [varchar] (1000) NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[completedate] [datetime] NULL ,

	[completedby] [int] NULL ,

	[enabled] [bit] NOT NULL ,

	[level] [int] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [help_module] (

	[module_id] [int] IDENTITY (1, 1) NOT NULL ,

	[category_id] [int] NULL ,

	[module_brief_description] [text] NULL ,

	[module_detail_description] [text] NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [help_notes] (

	[note_id] [int] IDENTITY (1, 1) NOT NULL ,

	[link_help_id] [int] NOT NULL ,

	[description] [varchar] (1000) NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[completedate] [datetime] NULL ,

	[completedby] [int] NULL ,

	[enabled] [bit] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [help_related_links] (

	[relatedlink_id] [int] IDENTITY (1, 1) NOT NULL ,

	[owning_module_id] [int] NULL ,

	[linkto_content_id] [int] NULL ,

	[displaytext] [varchar] (255) NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[enabled] [bit] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [help_tableof_contents] (

	[content_id] [int] IDENTITY (1, 1) NOT NULL ,

	[displaytext] [varchar] (255) NULL ,

	[firstchild] [int] NULL ,

	[nextsibling] [int] NULL ,

	[parent] [int] NULL ,

	[category_id] [int] NULL ,

	[contentlevel] [int] NOT NULL ,

	[contentorder] [int] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [help_tableofcontentitem_links] (

	[link_id] [int] IDENTITY (1, 1) NOT NULL ,

	[global_link_id] [int] NOT NULL ,

	[linkto_content_id] [int] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [help_tips] (

	[tip_id] [int] IDENTITY (1, 1) NOT NULL ,

	[link_help_id] [int] NOT NULL ,

	[description] [varchar] (1000) NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[enabled] [bit] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [lookup_access_types] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[link_module_id] [int] NOT NULL ,

	[description] [varchar] (50) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL ,

	[rule_id] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [lookup_account_types] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (50) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [lookup_call_types] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (50) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [lookup_contact_types] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (50) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL ,

	[user_id] [int] NULL ,

	[category] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [lookup_contactaddress_types] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (50) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [lookup_contactemail_types] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (50) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [lookup_contactphone_types] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (50) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [lookup_delivery_options] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (50) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [lookup_department] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (50) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [lookup_employment_types] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (50) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [lookup_help_features] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (1000) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [lookup_industry] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[order_id] [int] NULL ,

	[description] [varchar] (50) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [lookup_instantmessenger_types] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (50) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [lookup_lists_lookup] (

	[id] [int] IDENTITY (1, 1) NOT NULL ,

	[module_id] [int] NOT NULL ,

	[lookup_id] [int] NOT NULL ,

	[class_name] [varchar] (20) NULL ,

	[table_name] [varchar] (60) NULL ,

	[level] [int] NULL ,

	[description] [text] NULL ,

	[entered] [datetime] NULL ,

	[category_id] [int] NOT NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [lookup_locale] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (50) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [lookup_opportunity_types] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[order_id] [int] NULL ,

	[description] [varchar] (50) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [lookup_orgaddress_types] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (50) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [lookup_orgemail_types] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (50) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [lookup_orgphone_types] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (50) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [lookup_project_activity] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (50) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL ,

	[group_id] [int] NOT NULL ,

	[template_id] [int] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [lookup_project_issues] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (50) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL ,

	[group_id] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [lookup_project_loe] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (50) NOT NULL ,

	[base_value] [int] NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL ,

	[group_id] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [lookup_project_priority] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (50) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL ,

	[group_id] [int] NOT NULL ,

	[graphic] [varchar] (75) NULL ,

	[type] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [lookup_project_status] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (50) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL ,

	[group_id] [int] NOT NULL ,

	[graphic] [varchar] (75) NULL ,

	[type] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [lookup_revenue_types] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (50) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [lookup_revenuedetail_types] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (50) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [lookup_stage] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[order_id] [int] NULL ,

	[description] [varchar] (50) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [lookup_survey_types] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (50) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [lookup_task_category] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (50) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [lookup_task_loe] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (50) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [lookup_task_priority] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (50) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [lookup_ticketsource] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (300) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [message] (

	[id] [int] IDENTITY (1, 1) NOT NULL ,

	[name] [varchar] (80) NOT NULL ,

	[description] [varchar] (255) NULL ,

	[template_id] [int] NULL ,

	[subject] [varchar] (255) NULL ,

	[body] [text] NULL ,

	[reply_addr] [varchar] (100) NULL ,

	[url] [varchar] (255) NULL ,

	[img] [varchar] (80) NULL ,

	[enabled] [bit] NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL ,

	[access_type] [int] NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [message_template] (

	[id] [int] IDENTITY (1, 1) NOT NULL ,

	[name] [varchar] (80) NOT NULL ,

	[description] [varchar] (255) NULL ,

	[template_file] [varchar] (80) NULL ,

	[num_imgs] [int] NULL ,

	[num_urls] [int] NULL ,

	[enabled] [bit] NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [module_field_categorylink] (

	[id] [int] IDENTITY (1, 1) NOT NULL ,

	[module_id] [int] NOT NULL ,

	[category_id] [int] NOT NULL ,

	[level] [int] NULL ,

	[description] [text] NULL ,

	[entered] [datetime] NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [news] (

	[rec_id] [int] IDENTITY (1, 1) NOT NULL ,

	[org_id] [int] NULL ,

	[url] [text] NULL ,

	[base] [text] NULL ,

	[headline] [text] NULL ,

	[body] [text] NULL ,

	[dateEntered] [datetime] NULL ,

	[type] [char] (1) NULL ,

	[created] [datetime] NOT NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [notification] (

	[notification_id] [int] IDENTITY (1, 1) NOT NULL ,

	[notify_user] [int] NOT NULL ,

	[module] [varchar] (255) NOT NULL ,

	[item_id] [int] NOT NULL ,

	[item_modified] [datetime] NOT NULL ,

	[attempt] [datetime] NOT NULL ,

	[notify_type] [varchar] (30) NULL ,

	[subject] [text] NULL ,

	[message] [text] NULL ,

	[result] [int] NOT NULL ,

	[errorMessage] [text] NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [opportunity_component] (

	[id] [int] IDENTITY (1, 1) NOT NULL ,

	[opp_id] [int] NULL ,

	[owner] [int] NOT NULL ,

	[description] [varchar] (80) NULL ,

	[closedate] [datetime] NOT NULL ,

	[closeprob] [float] NULL ,

	[terms] [float] NULL ,

	[units] [char] (1) NULL ,

	[lowvalue] [float] NULL ,

	[guessvalue] [float] NULL ,

	[highvalue] [float] NULL ,

	[stage] [int] NULL ,

	[stagedate] [datetime] NOT NULL ,

	[commission] [float] NULL ,

	[type] [char] (1) NULL ,

	[alertdate] [datetime] NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL ,

	[closed] [datetime] NULL ,

	[alert] [varchar] (100) NULL ,

	[enabled] [bit] NOT NULL ,

	[notes] [text] NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [opportunity_component_levels] (

	[opp_id] [int] NOT NULL ,

	[type_id] [int] NOT NULL ,

	[level] [int] NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[modified] [datetime] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [opportunity_header] (

	[opp_id] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (80) NULL ,

	[acctlink] [int] NULL ,

	[contactlink] [int] NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [organization] (

	[org_id] [int] IDENTITY (0, 1) NOT NULL ,

	[name] [varchar] (80) NOT NULL ,

	[account_number] [varchar] (50) NULL ,

	[account_group] [int] NULL ,

	[url] [text] NULL ,

	[revenue] [float] NULL ,

	[employees] [int] NULL ,

	[notes] [text] NULL ,

	[sic_code] [varchar] (40) NULL ,

	[ticker_symbol] [varchar] (10) NULL ,

	[taxid] [char] (80) NULL ,

	[lead] [varchar] (40) NULL ,

	[sales_rep] [int] NOT NULL ,

	[miner_only] [bit] NOT NULL ,

	[defaultlocale] [int] NULL ,

	[fiscalmonth] [int] NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL ,

	[enabled] [bit] NULL ,

	[industry_temp_code] [smallint] NULL ,

	[owner] [int] NULL ,

	[duplicate_id] [int] NULL ,

	[custom1] [int] NULL ,

	[custom2] [int] NULL ,

	[contract_end] [datetime] NULL ,

	[alertdate] [datetime] NULL ,

	[alert] [varchar] (100) NULL ,

	[custom_data] [text] NULL ,

	[namesalutation] [varchar] (80) NULL ,

	[namelast] [varchar] (80) NULL ,

	[namefirst] [varchar] (80) NULL ,

	[namemiddle] [varchar] (80) NULL ,

	[namesuffix] [varchar] (80) NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [organization_address] (

	[address_id] [int] IDENTITY (1, 1) NOT NULL ,

	[org_id] [int] NULL ,

	[address_type] [int] NULL ,

	[addrline1] [varchar] (80) NULL ,

	[addrline2] [varchar] (80) NULL ,

	[addrline3] [varchar] (80) NULL ,

	[city] [varchar] (80) NULL ,

	[state] [varchar] (80) NULL ,

	[country] [varchar] (80) NULL ,

	[postalcode] [varchar] (12) NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [organization_emailaddress] (

	[emailaddress_id] [int] IDENTITY (1, 1) NOT NULL ,

	[org_id] [int] NULL ,

	[emailaddress_type] [int] NULL ,

	[email] [varchar] (256) NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [organization_phone] (

	[phone_id] [int] IDENTITY (1, 1) NOT NULL ,

	[org_id] [int] NULL ,

	[phone_type] [int] NULL ,

	[number] [varchar] (30) NULL ,

	[extension] [varchar] (10) NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [permission] (

	[permission_id] [int] IDENTITY (1, 1) NOT NULL ,

	[category_id] [int] NOT NULL ,

	[permission] [varchar] (80) NOT NULL ,

	[permission_view] [bit] NOT NULL ,

	[permission_add] [bit] NOT NULL ,

	[permission_edit] [bit] NOT NULL ,

	[permission_delete] [bit] NOT NULL ,

	[description] [varchar] (255) NOT NULL ,

	[level] [int] NOT NULL ,

	[enabled] [bit] NOT NULL ,

	[active] [bit] NOT NULL ,

	[viewpoints] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [permission_category] (

	[category_id] [int] IDENTITY (1, 1) NOT NULL ,

	[category] [varchar] (80) NULL ,

	[description] [varchar] (255) NULL ,

	[level] [int] NOT NULL ,

	[enabled] [bit] NOT NULL ,

	[active] [bit] NOT NULL ,

	[folders] [bit] NOT NULL ,

	[lookups] [bit] NOT NULL ,

	[viewpoints] [bit] NULL ,

	[categories] [bit] NULL ,

	[scheduled_events] [bit] NULL ,

	[object_events] [bit] NULL ,

	[reports] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [process_log] (

	[process_id] [int] IDENTITY (1, 1) NOT NULL ,

	[system_id] [int] NOT NULL ,

	[client_id] [int] NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[process_name] [varchar] (255) NULL ,

	[process_version] [varchar] (20) NULL ,

	[status] [int] NULL ,

	[message] [text] NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [project_assignments] (

	[assignment_id] [int] IDENTITY (1, 1) NOT NULL ,

	[project_id] [int] NOT NULL ,

	[requirement_id] [int] NULL ,

	[assignedBy] [int] NULL ,

	[user_assign_id] [int] NULL ,

	[activity_id] [int] NULL ,

	[technology] [varchar] (50) NULL ,

	[role] [varchar] (255) NULL ,

	[estimated_loevalue] [int] NULL ,

	[estimated_loetype] [int] NULL ,

	[actual_loevalue] [int] NULL ,

	[actual_loetype] [int] NULL ,

	[priority_id] [int] NULL ,

	[assign_date] [datetime] NULL ,

	[est_start_date] [datetime] NULL ,

	[start_date] [datetime] NULL ,

	[due_date] [datetime] NULL ,

	[status_id] [int] NULL ,

	[status_date] [datetime] NOT NULL ,

	[complete_date] [datetime] NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredBy] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedBy] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [project_assignments_status] (

	[status_id] [int] IDENTITY (1, 1) NOT NULL ,

	[assignment_id] [int] NOT NULL ,

	[user_id] [int] NOT NULL ,

	[description] [text] NOT NULL ,

	[status_date] [datetime] NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [project_files] (

	[item_id] [int] IDENTITY (1, 1) NOT NULL ,

	[link_module_id] [int] NOT NULL ,

	[link_item_id] [int] NOT NULL ,

	[folder_id] [int] NULL ,

	[client_filename] [varchar] (255) NOT NULL ,

	[filename] [varchar] (255) NOT NULL ,

	[subject] [varchar] (500) NOT NULL ,

	[size] [int] NULL ,

	[version] [float] NULL ,

	[enabled] [bit] NULL ,

	[downloads] [int] NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredBy] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedBy] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [project_files_download] (

	[item_id] [int] NOT NULL ,

	[version] [float] NULL ,

	[user_download_id] [int] NULL ,

	[download_date] [datetime] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [project_files_version] (

	[item_id] [int] NULL ,

	[client_filename] [varchar] (255) NOT NULL ,

	[filename] [varchar] (255) NOT NULL ,

	[subject] [varchar] (500) NOT NULL ,

	[size] [int] NULL ,

	[version] [float] NULL ,

	[enabled] [bit] NULL ,

	[downloads] [int] NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredBy] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedBy] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [project_folders] (

	[folder_id] [int] IDENTITY (1, 1) NOT NULL ,

	[link_module_id] [int] NOT NULL ,

	[link_item_id] [int] NOT NULL ,

	[subject] [varchar] (255) NOT NULL ,

	[description] [text] NULL ,

	[parent] [int] NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [project_issue_replies] (

	[reply_id] [int] IDENTITY (1, 1) NOT NULL ,

	[issue_id] [int] NOT NULL ,

	[reply_to] [int] NULL ,

	[subject] [varchar] (50) NOT NULL ,

	[message] [text] NOT NULL ,

	[importance] [int] NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredBy] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedBy] [int] NOT NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [project_issues] (

	[issue_id] [int] IDENTITY (1, 1) NOT NULL ,

	[project_id] [int] NOT NULL ,

	[type_id] [int] NULL ,

	[subject] [varchar] (255) NOT NULL ,

	[message] [text] NOT NULL ,

	[importance] [int] NULL ,

	[enabled] [bit] NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredBy] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedBy] [int] NOT NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [project_requirements] (

	[requirement_id] [int] IDENTITY (1, 1) NOT NULL ,

	[project_id] [int] NOT NULL ,

	[submittedBy] [varchar] (50) NULL ,

	[departmentBy] [varchar] (30) NULL ,

	[shortDescription] [varchar] (255) NOT NULL ,

	[description] [text] NOT NULL ,

	[dateReceived] [datetime] NULL ,

	[estimated_loevalue] [int] NULL ,

	[estimated_loetype] [int] NULL ,

	[actual_loevalue] [int] NULL ,

	[actual_loetype] [int] NULL ,

	[deadline] [datetime] NULL ,

	[approvedBy] [int] NULL ,

	[approvalDate] [datetime] NULL ,

	[closedBy] [int] NULL ,

	[closeDate] [datetime] NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredBy] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedBy] [int] NOT NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [project_team] (

	[project_id] [int] NOT NULL ,

	[user_id] [int] NOT NULL ,

	[userLevel] [int] NULL ,

	[entered] [datetime] NULL ,

	[enteredby] [int] NOT NULL ,

	[modified] [datetime] NULL ,

	[modifiedby] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [projects] (

	[project_id] [int] IDENTITY (1, 1) NOT NULL ,

	[group_id] [int] NULL ,

	[department_id] [int] NULL ,

	[template_id] [int] NULL ,

	[title] [varchar] (100) NOT NULL ,

	[shortDescription] [varchar] (200) NOT NULL ,

	[requestedBy] [varchar] (50) NULL ,

	[requestedDept] [varchar] (50) NULL ,

	[requestDate] [datetime] NULL ,

	[approvalDate] [datetime] NULL ,

	[closeDate] [datetime] NULL ,

	[owner] [int] NULL ,

	[entered] [datetime] NULL ,

	[enteredBy] [int] NOT NULL ,

	[modified] [datetime] NULL ,

	[modifiedBy] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [report] (

	[report_id] [int] IDENTITY (1, 1) NOT NULL ,

	[category_id] [int] NOT NULL ,

	[permission_id] [int] NULL ,

	[filename] [varchar] (300) NOT NULL ,

	[type] [int] NOT NULL ,

	[title] [varchar] (300) NOT NULL ,

	[description] [varchar] (1024) NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL ,

	[enabled] [bit] NOT NULL ,

	[custom] [bit] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [report_criteria] (

	[criteria_id] [int] IDENTITY (1, 1) NOT NULL ,

	[report_id] [int] NOT NULL ,

	[owner] [int] NOT NULL ,

	[subject] [varchar] (512) NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [report_criteria_parameter] (

	[parameter_id] [int] IDENTITY (1, 1) NOT NULL ,

	[criteria_id] [int] NOT NULL ,

	[parameter] [varchar] (255) NOT NULL ,

	[value] [text] NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [report_queue] (

	[queue_id] [int] IDENTITY (1, 1) NOT NULL ,

	[report_id] [int] NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[processed] [datetime] NULL ,

	[status] [int] NOT NULL ,

	[filename] [varchar] (256) NULL ,

	[filesize] [int] NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [report_queue_criteria] (

	[criteria_id] [int] IDENTITY (1, 1) NOT NULL ,

	[queue_id] [int] NOT NULL ,

	[parameter] [varchar] (255) NOT NULL ,

	[value] [text] NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [revenue] (

	[id] [int] IDENTITY (1, 1) NOT NULL ,

	[org_id] [int] NULL ,

	[transaction_id] [int] NULL ,

	[month] [int] NULL ,

	[year] [int] NULL ,

	[amount] [float] NULL ,

	[type] [int] NULL ,

	[owner] [int] NULL ,

	[description] [varchar] (255) NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [revenue_detail] (

	[id] [int] IDENTITY (1, 1) NOT NULL ,

	[revenue_id] [int] NULL ,

	[amount] [float] NULL ,

	[type] [int] NULL ,

	[owner] [int] NULL ,

	[description] [varchar] (255) NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [role] (

	[role_id] [int] IDENTITY (1, 1) NOT NULL ,

	[role] [varchar] (80) NOT NULL ,

	[description] [varchar] (255) NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[enabled] [bit] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [role_permission] (

	[id] [int] IDENTITY (1, 1) NOT NULL ,

	[role_id] [int] NOT NULL ,

	[permission_id] [int] NOT NULL ,

	[role_view] [bit] NOT NULL ,

	[role_add] [bit] NOT NULL ,

	[role_edit] [bit] NOT NULL ,

	[role_delete] [bit] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [saved_criteriaelement] (

	[id] [int] NOT NULL ,

	[field] [int] NOT NULL ,

	[operator] [varchar] (50) NOT NULL ,

	[operatorid] [int] NOT NULL ,

	[value] [varchar] (80) NOT NULL ,

	[source] [int] NOT NULL ,

	[value_id] [int] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [saved_criterialist] (

	[id] [int] IDENTITY (1, 1) NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL ,

	[owner] [int] NOT NULL ,

	[name] [varchar] (80) NOT NULL ,

	[contact_source] [int] NULL ,

	[enabled] [bit] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [scheduled_recipient] (

	[id] [int] IDENTITY (1, 1) NOT NULL ,

	[campaign_id] [int] NOT NULL ,

	[contact_id] [int] NOT NULL ,

	[run_id] [int] NULL ,

	[status_id] [int] NULL ,

	[status] [varchar] (255) NULL ,

	[status_date] [datetime] NULL ,

	[scheduled_date] [datetime] NULL ,

	[sent_date] [datetime] NULL ,

	[reply_date] [datetime] NULL ,

	[bounce_date] [datetime] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [search_fields] (

	[id] [int] IDENTITY (1, 1) NOT NULL ,

	[field] [varchar] (80) NULL ,

	[description] [varchar] (255) NULL ,

	[searchable] [bit] NOT NULL ,

	[field_typeid] [int] NOT NULL ,

	[table_name] [varchar] (80) NULL ,

	[object_class] [varchar] (80) NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [state] (

	[state_code] [char] (2) NOT NULL ,

	[state] [varchar] (80) NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [survey] (

	[survey_id] [int] IDENTITY (1, 1) NOT NULL ,

	[name] [varchar] (80) NOT NULL ,

	[description] [varchar] (255) NULL ,

	[intro] [text] NULL ,

	[outro] [text] NULL ,

	[itemLength] [int] NULL ,

	[type] [int] NULL ,

	[enabled] [bit] NOT NULL ,

	[status] [int] NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [survey_items] (

	[item_id] [int] IDENTITY (1, 1) NOT NULL ,

	[question_id] [int] NOT NULL ,

	[type] [int] NULL ,

	[description] [varchar] (255) NULL 

) ON [PRIMARY]

GO



CREATE TABLE [survey_questions] (

	[question_id] [int] IDENTITY (1, 1) NOT NULL ,

	[survey_id] [int] NOT NULL ,

	[type] [int] NOT NULL ,

	[description] [varchar] (255) NULL ,

	[required] [bit] NOT NULL ,

	[position] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [sync_client] (

	[client_id] [int] IDENTITY (1, 1) NOT NULL ,

	[type] [varchar] (100) NULL ,

	[version] [varchar] (50) NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL ,

	[anchor] [datetime] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [sync_conflict_log] (

	[client_id] [int] NOT NULL ,

	[table_id] [int] NOT NULL ,

	[record_id] [int] NOT NULL ,

	[status_date] [datetime] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [sync_log] (

	[log_id] [int] IDENTITY (1, 1) NOT NULL ,

	[system_id] [int] NOT NULL ,

	[client_id] [int] NOT NULL ,

	[ip] [varchar] (15) NULL ,

	[entered] [datetime] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [sync_map] (

	[client_id] [int] NOT NULL ,

	[table_id] [int] NOT NULL ,

	[record_id] [int] NOT NULL ,

	[cuid] [int] NOT NULL ,

	[complete] [bit] NULL ,

	[status_date] [datetime] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [sync_system] (

	[system_id] [int] IDENTITY (1, 1) NOT NULL ,

	[application_name] [varchar] (255) NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [sync_table] (

	[table_id] [int] IDENTITY (1, 1) NOT NULL ,

	[system_id] [int] NOT NULL ,

	[element_name] [varchar] (255) NULL ,

	[mapped_class_name] [varchar] (255) NULL ,

	[entered] [datetime] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[create_statement] [text] NULL ,

	[order_id] [int] NULL ,

	[sync_item] [bit] NULL ,

	[object_key] [varchar] (50) NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [sync_transaction_log] (

	[transaction_id] [int] IDENTITY (1, 1) NOT NULL ,

	[log_id] [int] NOT NULL ,

	[reference_id] [varchar] (50) NULL ,

	[element_name] [varchar] (255) NULL ,

	[action] [varchar] (20) NULL ,

	[link_item_id] [int] NULL ,

	[status_code] [int] NULL ,

	[record_count] [int] NULL ,

	[message] [text] NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [task] (

	[task_id] [int] IDENTITY (1, 1) NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[priority] [int] NOT NULL ,

	[description] [varchar] (80) NULL ,

	[duedate] [datetime] NULL ,

	[reminderid] [int] NULL ,

	[notes] [text] NULL ,

	[sharing] [int] NOT NULL ,

	[complete] [bit] NOT NULL ,

	[enabled] [bit] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedby] [int] NULL ,

	[estimatedloe] [float] NULL ,

	[estimatedloetype] [int] NULL ,

	[type] [int] NULL ,

	[owner] [int] NULL ,

	[completedate] [datetime] NULL ,

	[category_id] [int] NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [taskcategory_project] (

	[category_id] [int] NOT NULL ,

	[project_id] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [tasklink_contact] (

	[task_id] [int] NOT NULL ,

	[contact_id] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [tasklink_project] (

	[task_id] [int] NOT NULL ,

	[project_id] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [tasklink_ticket] (

	[task_id] [int] NOT NULL ,

	[ticket_id] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [ticket] (

	[ticketid] [int] IDENTITY (1, 1) NOT NULL ,

	[org_id] [int] NULL ,

	[contact_id] [int] NULL ,

	[problem] [text] NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL ,

	[closed] [datetime] NULL ,

	[pri_code] [int] NULL ,

	[level_code] [int] NULL ,

	[department_code] [int] NULL ,

	[source_code] [int] NULL ,

	[cat_code] [int] NULL ,

	[subcat_code1] [int] NULL ,

	[subcat_code2] [int] NULL ,

	[subcat_code3] [int] NULL ,

	[assigned_to] [int] NULL ,

	[comment] [text] NULL ,

	[solution] [text] NULL ,

	[scode] [int] NULL ,

	[critical] [datetime] NULL ,

	[notified] [datetime] NULL ,

	[custom_data] [text] NULL ,

	[location] [varchar] (256) NULL ,

	[assigned_date] [datetime] NULL ,

	[est_resolution_date] [datetime] NULL ,

	[resolution_date] [datetime] NULL ,

	[cause] [text] NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [ticket_category] (

	[id] [int] IDENTITY (1, 1) NOT NULL ,

	[cat_level] [int] NOT NULL ,

	[parent_cat_code] [int] NOT NULL ,

	[description] [varchar] (300) NOT NULL ,

	[full_description] [text] NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [ticket_category_draft] (

	[id] [int] IDENTITY (1, 1) NOT NULL ,

	[link_id] [int] NULL ,

	[cat_level] [int] NOT NULL ,

	[parent_cat_code] [int] NOT NULL ,

	[description] [varchar] (300) NOT NULL ,

	[full_description] [text] NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [ticket_level] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (300) NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [ticket_priority] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (300) NOT NULL ,

	[style] [text] NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [ticket_severity] (

	[code] [int] IDENTITY (1, 1) NOT NULL ,

	[description] [varchar] (300) NOT NULL ,

	[style] [text] NOT NULL ,

	[default_item] [bit] NULL ,

	[level] [int] NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [ticketlog] (

	[id] [int] IDENTITY (1, 1) NOT NULL ,

	[ticketid] [int] NULL ,

	[assigned_to] [int] NULL ,

	[comment] [text] NULL ,

	[closed] [bit] NULL ,

	[pri_code] [int] NULL ,

	[level_code] [int] NULL ,

	[department_code] [int] NULL ,

	[cat_code] [int] NULL ,

	[scode] [int] NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [usage_log] (

	[usage_id] [int] IDENTITY (1, 1) NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NULL ,

	[action] [int] NOT NULL ,

	[record_id] [int] NULL ,

	[record_size] [int] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [viewpoint] (

	[viewpoint_id] [int] IDENTITY (1, 1) NOT NULL ,

	[user_id] [int] NOT NULL ,

	[vp_user_id] [int] NOT NULL ,

	[entered] [datetime] NOT NULL ,

	[enteredby] [int] NOT NULL ,

	[modified] [datetime] NOT NULL ,

	[modifiedby] [int] NOT NULL ,

	[enabled] [bit] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [viewpoint_permission] (

	[vp_permission_id] [int] IDENTITY (1, 1) NOT NULL ,

	[viewpoint_id] [int] NOT NULL ,

	[permission_id] [int] NOT NULL ,

	[viewpoint_view] [bit] NOT NULL ,

	[viewpoint_add] [bit] NOT NULL ,

	[viewpoint_edit] [bit] NOT NULL ,

	[viewpoint_delete] [bit] NOT NULL 

) ON [PRIMARY]

GO



ALTER TABLE [access] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[user_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [access_log] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [action_item] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[item_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [action_item_log] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[log_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [action_list] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[action_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [active_campaign_groups] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [active_survey] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[active_survey_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [active_survey_answer_avg] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [active_survey_answer_items] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [active_survey_answers] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[answer_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [active_survey_items] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[item_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [active_survey_questions] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[question_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [active_survey_responses] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[response_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [autoguide_ad_run] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[ad_run_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [autoguide_ad_run_types] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [autoguide_inventory] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[inventory_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [autoguide_make] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[make_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [autoguide_model] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[model_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [autoguide_options] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[option_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [autoguide_vehicle] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[vehicle_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [business_process] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[process_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [business_process_component] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [business_process_component_library] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[component_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [business_process_component_parameter] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [business_process_component_result_lookup] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[result_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [business_process_events] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[event_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [business_process_hook] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [business_process_hook_library] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[hook_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [business_process_hook_triggers] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[trigger_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [business_process_parameter] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [business_process_parameter_library] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[parameter_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [call_log] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[call_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [campaign] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[campaign_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [campaign_run] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [cfsinbox_message] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [contact] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[contact_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [contact_address] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[address_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [contact_emailaddress] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[emailaddress_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [contact_phone] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[phone_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [custom_field_category] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[category_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [custom_field_group] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[group_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [custom_field_info] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[field_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [custom_field_lookup] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [custom_field_record] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[record_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [database_version] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[version_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [excluded_recipient] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [field_types] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [help_business_rules] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[rule_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [help_contents] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[help_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [help_faqs] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[faq_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [help_features] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[feature_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [help_module] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[module_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [help_notes] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[note_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [help_related_links] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[relatedlink_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [help_tableof_contents] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[content_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [help_tableofcontentitem_links] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[link_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [help_tips] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[tip_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [lookup_access_types] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [lookup_account_types] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [lookup_call_types] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [lookup_contact_types] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [lookup_contactaddress_types] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [lookup_contactemail_types] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [lookup_contactphone_types] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [lookup_delivery_options] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [lookup_department] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [lookup_employment_types] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [lookup_help_features] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [lookup_industry] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [lookup_instantmessenger_types] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [lookup_lists_lookup] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [lookup_locale] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [lookup_opportunity_types] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [lookup_orgaddress_types] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [lookup_orgemail_types] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [lookup_orgphone_types] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [lookup_project_activity] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [lookup_project_issues] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [lookup_project_loe] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [lookup_project_priority] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [lookup_project_status] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [lookup_revenue_types] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [lookup_revenuedetail_types] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [lookup_stage] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [lookup_survey_types] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [lookup_task_category] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [lookup_task_loe] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [lookup_task_priority] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [lookup_ticketsource] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [message] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [message_template] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [module_field_categorylink] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [news] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[rec_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [notification] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[notification_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [opportunity_component] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [opportunity_header] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[opp_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [organization] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[org_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [organization_address] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[address_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [organization_emailaddress] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[emailaddress_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [organization_phone] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[phone_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [permission] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[permission_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [permission_category] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[category_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [process_log] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[process_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [project_assignments] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[assignment_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [project_assignments_status] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[status_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [project_files] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[item_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [project_folders] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[folder_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [project_issue_replies] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[reply_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [project_issues] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[issue_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [project_requirements] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[requirement_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [projects] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[project_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [report] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[report_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [report_criteria] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[criteria_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [report_criteria_parameter] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[parameter_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [report_queue] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[queue_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [report_queue_criteria] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[criteria_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [revenue] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [revenue_detail] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [role] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[role_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [role_permission] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [saved_criterialist] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [scheduled_recipient] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [search_fields] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [state] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[state_code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [survey] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[survey_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [survey_items] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[item_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [survey_questions] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[question_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [sync_client] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[client_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [sync_log] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[log_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [sync_system] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[system_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [sync_table] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[table_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [sync_transaction_log] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[transaction_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [task] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[task_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [ticket] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[ticketid]

	)  ON [PRIMARY] 

GO



ALTER TABLE [ticket_category] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [ticket_category_draft] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [ticket_level] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [ticket_priority] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [ticket_severity] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[code]

	)  ON [PRIMARY] 

GO



ALTER TABLE [ticketlog] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [usage_log] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[usage_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [viewpoint] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[viewpoint_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [viewpoint_permission] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[vp_permission_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [access] WITH NOCHECK ADD 

	CONSTRAINT [DF__access__contact___77BFCB91] DEFAULT ((-1)) FOR [contact_id],

	CONSTRAINT [DF__access__role_id__78B3EFCA] DEFAULT ((-1)) FOR [role_id],

	CONSTRAINT [DF__access__manager___79A81403] DEFAULT ((-1)) FOR [manager_id],

	CONSTRAINT [DF__access__startofd__7A9C383C] DEFAULT (8) FOR [startofday],

	CONSTRAINT [DF__access__endofday__7B905C75] DEFAULT (18) FOR [endofday],

	CONSTRAINT [DF__access__timezone__7C8480AE] DEFAULT ('America/New_York') FOR [timezone],

	CONSTRAINT [DF__access__last_log__7D78A4E7] DEFAULT (getdate()) FOR [last_login],

	CONSTRAINT [DF__access__entered__7E6CC920] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__access__modified__7F60ED59] DEFAULT (getdate()) FOR [modified],

	CONSTRAINT [DF__access__expires__00551192] DEFAULT (null) FOR [expires],

	CONSTRAINT [DF__access__alias__014935CB] DEFAULT ((-1)) FOR [alias],

	CONSTRAINT [DF__access__assistan__023D5A04] DEFAULT ((-1)) FOR [assistant],

	CONSTRAINT [DF__access__enabled__03317E3D] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [access_log] WITH NOCHECK ADD 

	CONSTRAINT [DF__access_lo__enter__0BC6C43E] DEFAULT (getdate()) FOR [entered]

GO



ALTER TABLE [account_type_levels] WITH NOCHECK ADD 

	CONSTRAINT [DF__account_t__enter__690797E6] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__account_t__modif__69FBBC1F] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [action_item] WITH NOCHECK ADD 

	CONSTRAINT [DF__action_it__enter__318258D2] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__action_it__modif__336AA144] DEFAULT (getdate()) FOR [modified],

	CONSTRAINT [DF__action_it__enabl__345EC57D] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [action_item_log] WITH NOCHECK ADD 

	CONSTRAINT [DF__action_it__link___382F5661] DEFAULT ((-1)) FOR [link_item_id],

	CONSTRAINT [DF__action_it__enter__3A179ED3] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__action_it__modif__3BFFE745] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [action_list] WITH NOCHECK ADD 

	CONSTRAINT [DF__action_li__enter__29E1370A] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__action_li__modif__2BC97F7C] DEFAULT (getdate()) FOR [modified],

	CONSTRAINT [DF__action_li__enabl__2CBDA3B5] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [active_campaign_groups] WITH NOCHECK ADD 

	CONSTRAINT [DF__active_ca__group__02284B6B] DEFAULT (null) FOR [groupcriteria]

GO



ALTER TABLE [active_survey] WITH NOCHECK ADD 

	CONSTRAINT [DF__active_su__itemL__2B2A60FE] DEFAULT ((-1)) FOR [itemLength],

	CONSTRAINT [DF__active_su__enabl__2D12A970] DEFAULT (1) FOR [enabled],

	CONSTRAINT [DF__active_su__enter__2E06CDA9] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__active_su__modif__2FEF161B] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [active_survey_answer_avg] WITH NOCHECK ADD 

	CONSTRAINT [DF__active_su__total__542C7691] DEFAULT (0) FOR [total]

GO



ALTER TABLE [active_survey_answers] WITH NOCHECK ADD 

	CONSTRAINT [DF__active_su__quant__4B973090] DEFAULT ((-1)) FOR [quant_ans]

GO



ALTER TABLE [active_survey_items] WITH NOCHECK ADD 

	CONSTRAINT [DF__active_sur__type__420DC656] DEFAULT ((-1)) FOR [type]

GO



ALTER TABLE [active_survey_questions] WITH NOCHECK ADD 

	CONSTRAINT [DF__active_su__requi__35A7EF71] DEFAULT (0) FOR [required],

	CONSTRAINT [DF__active_su__posit__369C13AA] DEFAULT (0) FOR [position],

	CONSTRAINT [DF__active_su__avera__379037E3] DEFAULT (0.00) FOR [average],

	CONSTRAINT [DF__active_su__total__38845C1C] DEFAULT (0) FOR [total1],

	CONSTRAINT [DF__active_su__total__39788055] DEFAULT (0) FOR [total2],

	CONSTRAINT [DF__active_su__total__3A6CA48E] DEFAULT (0) FOR [total3],

	CONSTRAINT [DF__active_su__total__3B60C8C7] DEFAULT (0) FOR [total4],

	CONSTRAINT [DF__active_su__total__3C54ED00] DEFAULT (0) FOR [total5],

	CONSTRAINT [DF__active_su__total__3D491139] DEFAULT (0) FOR [total6],

	CONSTRAINT [DF__active_su__total__3E3D3572] DEFAULT (0) FOR [total7]

GO



ALTER TABLE [active_survey_responses] WITH NOCHECK ADD 

	CONSTRAINT [DF__active_su__conta__45DE573A] DEFAULT ((-1)) FOR [contact_id],

	CONSTRAINT [DF__active_su__enter__46D27B73] DEFAULT (getdate()) FOR [entered]

GO



ALTER TABLE [autoguide_ad_run] WITH NOCHECK ADD 

	CONSTRAINT [DF__autoguide__inclu__100C566E] DEFAULT (0) FOR [include_photo],

	CONSTRAINT [DF__autoguide__compl__11007AA7] DEFAULT ((-1)) FOR [completedby],

	CONSTRAINT [DF__autoguide__enter__11F49EE0] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__autoguide__modif__12E8C319] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [autoguide_ad_run_types] WITH NOCHECK ADD 

	CONSTRAINT [DF__autoguide__defau__15C52FC4] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__autoguide__level__16B953FD] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__autoguide__enabl__17AD7836] DEFAULT (0) FOR [enabled],

	CONSTRAINT [DF__autoguide__enter__18A19C6F] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__autoguide__modif__1995C0A8] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [autoguide_inventory] WITH NOCHECK ADD 

	CONSTRAINT [DF__autoguide__is_ne__00CA12DE] DEFAULT (0) FOR [is_new],

	CONSTRAINT [DF__autoguide___sold__01BE3717] DEFAULT (0) FOR [sold],

	CONSTRAINT [DF__autoguide__enter__02B25B50] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__autoguide__modif__03A67F89] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [autoguide_make] WITH NOCHECK ADD 

	CONSTRAINT [DF__autoguide__enter__7093AB15] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__autoguide__modif__7187CF4E] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [autoguide_model] WITH NOCHECK ADD 

	CONSTRAINT [DF__autoguide__enter__75586032] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__autoguide__modif__764C846B] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [autoguide_options] WITH NOCHECK ADD 

	CONSTRAINT [DF__autoguide__defau__0682EC34] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__autoguide__level__0777106D] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__autoguide__enabl__086B34A6] DEFAULT (0) FOR [enabled],

	CONSTRAINT [DF__autoguide__enter__095F58DF] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__autoguide__modif__0A537D18] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [autoguide_vehicle] WITH NOCHECK ADD 

	CONSTRAINT [DF__autoguide__enter__7B113988] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__autoguide__modif__7C055DC1] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [business_process] WITH NOCHECK ADD 

	CONSTRAINT [DF__business___enabl__6E765879] DEFAULT (1) FOR [enabled],

	CONSTRAINT [DF__business___enter__6F6A7CB2] DEFAULT (getdate()) FOR [entered],

	 UNIQUE  NONCLUSTERED 

	(

		[process_name]

	)  ON [PRIMARY] 

GO



ALTER TABLE [business_process_component] WITH NOCHECK ADD 

	CONSTRAINT [DF__business___enabl__75235608] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [business_process_component_library] WITH NOCHECK ADD 

	CONSTRAINT [DF__business___enabl__62108194] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [business_process_component_parameter] WITH NOCHECK ADD 

	CONSTRAINT [DF__business___enabl__7DB89C09] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [business_process_component_result_lookup] WITH NOCHECK ADD 

	CONSTRAINT [DF__business___level__65E11278] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__business___enabl__66D536B1] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [business_process_events] WITH NOCHECK ADD 

	CONSTRAINT [DF__business___secon__009508B4] DEFAULT ('0') FOR [second],

	CONSTRAINT [DF__business___minut__01892CED] DEFAULT ('*') FOR [minute],

	CONSTRAINT [DF__business_p__hour__027D5126] DEFAULT ('*') FOR [hour],

	CONSTRAINT [DF__business___dayof__0371755F] DEFAULT ('*') FOR [dayofmonth],

	CONSTRAINT [DF__business___month__04659998] DEFAULT ('*') FOR [month],

	CONSTRAINT [DF__business___dayof__0559BDD1] DEFAULT ('*') FOR [dayofweek],

	CONSTRAINT [DF__business_p__year__064DE20A] DEFAULT ('*') FOR [year],

	CONSTRAINT [DF__business___busin__07420643] DEFAULT ('true') FOR [businessDays],

	CONSTRAINT [DF__business___enabl__08362A7C] DEFAULT (0) FOR [enabled],

	CONSTRAINT [DF__business___enter__092A4EB5] DEFAULT (getdate()) FOR [entered]

GO



ALTER TABLE [business_process_hook] WITH NOCHECK ADD 

	CONSTRAINT [DF__business___enabl__186C9245] DEFAULT (0) FOR [enabled]

GO



ALTER TABLE [business_process_hook_library] WITH NOCHECK ADD 

	CONSTRAINT [DF__business___enabl__0FD74C44] DEFAULT (0) FOR [enabled]

GO



ALTER TABLE [business_process_hook_triggers] WITH NOCHECK ADD 

	CONSTRAINT [DF__business___enabl__13A7DD28] DEFAULT (0) FOR [enabled]

GO



ALTER TABLE [business_process_log] WITH NOCHECK ADD 

	 UNIQUE  NONCLUSTERED 

	(

		[process_name]

	)  ON [PRIMARY] 

GO



ALTER TABLE [business_process_parameter] WITH NOCHECK ADD 

	CONSTRAINT [DF__business___enabl__78F3E6EC] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [business_process_parameter_library] WITH NOCHECK ADD 

	CONSTRAINT [DF__business___enabl__69B1A35C] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [call_log] WITH NOCHECK ADD 

	CONSTRAINT [DF__call_log__entere__66EA454A] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__call_log__modifi__68D28DBC] DEFAULT (getdate()) FOR [modified],

	CONSTRAINT [DF__call_log__alert__6ABAD62E] DEFAULT (null) FOR [alert]

GO



ALTER TABLE [campaign] WITH NOCHECK ADD 

	CONSTRAINT [DF__campaign__messag__5FD33367] DEFAULT ((-1)) FOR [message_id],

	CONSTRAINT [DF__campaign__reply___60C757A0] DEFAULT (null) FOR [reply_addr],

	CONSTRAINT [DF__campaign__subjec__61BB7BD9] DEFAULT (null) FOR [subject],

	CONSTRAINT [DF__campaign__messag__62AFA012] DEFAULT (null) FOR [message],

	CONSTRAINT [DF__campaign__status__63A3C44B] DEFAULT (0) FOR [status_id],

	CONSTRAINT [DF__campaign__active__6497E884] DEFAULT (0) FOR [active],

	CONSTRAINT [DF__campaign__active__658C0CBD] DEFAULT (null) FOR [active_date],

	CONSTRAINT [DF__campaign__send_m__668030F6] DEFAULT ((-1)) FOR [send_method_id],

	CONSTRAINT [DF__campaign__inacti__6774552F] DEFAULT (null) FOR [inactive_date],

	CONSTRAINT [DF__campaign__approv__68687968] DEFAULT (null) FOR [approval_date],

	CONSTRAINT [DF__campaign__enable__6A50C1DA] DEFAULT (1) FOR [enabled],

	CONSTRAINT [DF__campaign__entere__6B44E613] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__campaign__modifi__6D2D2E85] DEFAULT (getdate()) FOR [modified],

	CONSTRAINT [DF__campaign__type__6F1576F7] DEFAULT (1) FOR [type]

GO



ALTER TABLE [campaign_run] WITH NOCHECK ADD 

	CONSTRAINT [DF__campaign___statu__72E607DB] DEFAULT (0) FOR [status],

	CONSTRAINT [DF__campaign___run_d__73DA2C14] DEFAULT (getdate()) FOR [run_date],

	CONSTRAINT [DF__campaign___total__74CE504D] DEFAULT (0) FOR [total_contacts],

	CONSTRAINT [DF__campaign___total__75C27486] DEFAULT (0) FOR [total_sent],

	CONSTRAINT [DF__campaign___total__76B698BF] DEFAULT (0) FOR [total_replied],

	CONSTRAINT [DF__campaign___total__77AABCF8] DEFAULT (0) FOR [total_bounced]

GO



ALTER TABLE [cfsinbox_message] WITH NOCHECK ADD 

	CONSTRAINT [DF__cfsinbox___subje__57DD0BE4] DEFAULT (null) FOR [subject],

	CONSTRAINT [DF__cfsinbox_m__sent__59C55456] DEFAULT (getdate()) FOR [sent],

	CONSTRAINT [DF__cfsinbox___enter__5AB9788F] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__cfsinbox___modif__5BAD9CC8] DEFAULT (getdate()) FOR [modified],

	CONSTRAINT [DF__cfsinbox_m__type__5CA1C101] DEFAULT ((-1)) FOR [type],

	CONSTRAINT [DF__cfsinbox___delet__5E8A0973] DEFAULT (0) FOR [delete_flag]

GO



ALTER TABLE [cfsinbox_messagelink] WITH NOCHECK ADD 

	CONSTRAINT [DF__cfsinbox___statu__625A9A57] DEFAULT (0) FOR [status],

	CONSTRAINT [DF__cfsinbox___viewe__634EBE90] DEFAULT (null) FOR [viewed],

	CONSTRAINT [DF__cfsinbox___enabl__6442E2C9] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [contact] WITH NOCHECK ADD 

	CONSTRAINT [DF__contact__entered__6754599E] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__contact__modifie__693CA210] DEFAULT (getdate()) FOR [modified],

	CONSTRAINT [DF__contact__enabled__6B24EA82] DEFAULT (1) FOR [enabled],

	CONSTRAINT [DF__contact__custom1__6D0D32F4] DEFAULT ((-1)) FOR [custom1],

	CONSTRAINT [DF__contact__primary__6E01572D] DEFAULT (0) FOR [primary_contact],

	CONSTRAINT [DF__contact__employe__6EF57B66] DEFAULT (0) FOR [employee]

GO



ALTER TABLE [contact_address] WITH NOCHECK ADD 

	CONSTRAINT [DF__contact_a__enter__3F115E1A] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__contact_a__modif__40F9A68C] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [contact_emailaddress] WITH NOCHECK ADD 

	CONSTRAINT [DF__contact_e__enter__46B27FE2] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__contact_e__modif__489AC854] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [contact_phone] WITH NOCHECK ADD 

	CONSTRAINT [DF__contact_p__enter__4E53A1AA] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__contact_p__modif__503BEA1C] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [contact_type_levels] WITH NOCHECK ADD 

	CONSTRAINT [DF__contact_t__enter__6DCC4D03] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__contact_t__modif__6EC0713C] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [custom_field_category] WITH NOCHECK ADD 

	CONSTRAINT [DF__custom_fi__level__3335971A] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__custom_fi__start__3429BB53] DEFAULT (getdate()) FOR [start_date],

	CONSTRAINT [DF__custom_fi__defau__351DDF8C] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__custom_fi__enter__361203C5] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__custom_fi__enabl__370627FE] DEFAULT (1) FOR [enabled],

	CONSTRAINT [DF__custom_fi__multi__37FA4C37] DEFAULT (0) FOR [multiple_records],

	CONSTRAINT [DF__custom_fi__read___38EE7070] DEFAULT (0) FOR [read_only]

GO



ALTER TABLE [custom_field_data] WITH NOCHECK ADD 

	CONSTRAINT [DF__custom_fi__selec__5C37ACAD] DEFAULT (0) FOR [selected_item_id]

GO



ALTER TABLE [custom_field_group] WITH NOCHECK ADD 

	CONSTRAINT [DF__custom_fi__level__3CBF0154] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__custom_fi__start__3DB3258D] DEFAULT (getdate()) FOR [start_date],

	CONSTRAINT [DF__custom_fi__enter__3EA749C6] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__custom_fi__enabl__3F9B6DFF] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [custom_field_info] WITH NOCHECK ADD 

	CONSTRAINT [DF__custom_fi__level__436BFEE3] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__custom_fi__valid__4460231C] DEFAULT (0) FOR [validation_type],

	CONSTRAINT [DF__custom_fi__requi__45544755] DEFAULT (0) FOR [required],

	CONSTRAINT [DF__custom_fi__start__46486B8E] DEFAULT (getdate()) FOR [start_date],

	CONSTRAINT [DF__custom_fi__end_d__473C8FC7] DEFAULT (null) FOR [end_date],

	CONSTRAINT [DF__custom_fi__enter__4830B400] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__custom_fi__enabl__4924D839] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [custom_field_lookup] WITH NOCHECK ADD 

	CONSTRAINT [DF__custom_fi__defau__4CF5691D] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__custom_fi__level__4DE98D56] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__custom_fi__start__4EDDB18F] DEFAULT (getdate()) FOR [start_date],

	CONSTRAINT [DF__custom_fi__enter__4FD1D5C8] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__custom_fi__enabl__50C5FA01] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [custom_field_record] WITH NOCHECK ADD 

	CONSTRAINT [DF__custom_fi__enter__54968AE5] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__custom_fi__modif__567ED357] DEFAULT (getdate()) FOR [modified],

	CONSTRAINT [DF__custom_fi__enabl__58671BC9] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [database_version] WITH NOCHECK ADD 

	CONSTRAINT [DF__database___enter__3EDC53F0] DEFAULT (getdate()) FOR [entered]

GO



ALTER TABLE [field_types] WITH NOCHECK ADD 

	CONSTRAINT [DF__field_typ__data___5708E33C] DEFAULT ((-1)) FOR [data_typeid],

	CONSTRAINT [DF__field_typ__enabl__57FD0775] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [help_business_rules] WITH NOCHECK ADD 

	CONSTRAINT [DF__help_busi__enter__375B2DB9] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__help_busi__modif__3943762B] DEFAULT (getdate()) FOR [modified],

	CONSTRAINT [DF__help_busi__enabl__3B2BBE9D] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [help_contents] WITH NOCHECK ADD 

	CONSTRAINT [DF__help_cont__enter__7C3A67EB] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__help_cont__modif__7E22B05D] DEFAULT (getdate()) FOR [modified],

	CONSTRAINT [DF__help_cont__enabl__7F16D496] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [help_faqs] WITH NOCHECK ADD 

	CONSTRAINT [DF__help_faqs__enter__2EC5E7B8] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__help_faqs__modif__30AE302A] DEFAULT (getdate()) FOR [modified],

	CONSTRAINT [DF__help_faqs__enabl__3296789C] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [help_features] WITH NOCHECK ADD 

	CONSTRAINT [DF__help_feat__enter__1CA7377D] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__help_feat__modif__1E8F7FEF] DEFAULT (getdate()) FOR [modified],

	CONSTRAINT [DF__help_feat__enabl__2077C861] DEFAULT (1) FOR [enabled],

	CONSTRAINT [DF__help_feat__level__216BEC9A] DEFAULT (0) FOR [level]

GO



ALTER TABLE [help_notes] WITH NOCHECK ADD 

	CONSTRAINT [DF__help_note__enter__3FF073BA] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__help_note__modif__41D8BC2C] DEFAULT (getdate()) FOR [modified],

	CONSTRAINT [DF__help_note__enabl__43C1049E] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [help_related_links] WITH NOCHECK ADD 

	CONSTRAINT [DF__help_rela__enter__2724C5F0] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__help_rela__modif__290D0E62] DEFAULT (getdate()) FOR [modified],

	CONSTRAINT [DF__help_rela__enabl__2A01329B] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [help_tableof_contents] WITH NOCHECK ADD 

	CONSTRAINT [DF__help_tabl__enter__06B7F65E] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__help_tabl__modif__08A03ED0] DEFAULT (getdate()) FOR [modified],

	CONSTRAINT [DF__help_tabl__enabl__09946309] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [help_tableofcontentitem_links] WITH NOCHECK ADD 

	CONSTRAINT [DF__help_tabl__enter__0F4D3C5F] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__help_tabl__modif__113584D1] DEFAULT (getdate()) FOR [modified],

	CONSTRAINT [DF__help_tabl__enabl__1229A90A] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [help_tips] WITH NOCHECK ADD 

	CONSTRAINT [DF__help_tips__enter__4885B9BB] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__help_tips__modif__4A6E022D] DEFAULT (getdate()) FOR [modified],

	CONSTRAINT [DF__help_tips__enabl__4B622666] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [lookup_access_types] WITH NOCHECK ADD 

	CONSTRAINT [DF__lookup_ac__defau__4E88ABD4] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__lookup_ac__enabl__4F7CD00D] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [lookup_account_types] WITH NOCHECK ADD 

	CONSTRAINT [DF__lookup_ac__defau__182C9B23] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__lookup_ac__level__1920BF5C] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__lookup_ac__enabl__1A14E395] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [lookup_call_types] WITH NOCHECK ADD 

	CONSTRAINT [DF__lookup_ca__defau__41B8C09B] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__lookup_ca__level__42ACE4D4] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__lookup_ca__enabl__43A1090D] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [lookup_contact_types] WITH NOCHECK ADD 

	CONSTRAINT [DF__lookup_co__defau__117F9D94] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__lookup_co__level__1273C1CD] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__lookup_co__enabl__1367E606] DEFAULT (1) FOR [enabled],

	CONSTRAINT [DF__lookup_co__categ__15502E78] DEFAULT (0) FOR [category]

GO



ALTER TABLE [lookup_contactaddress_types] WITH NOCHECK ADD 

	CONSTRAINT [DF__lookup_co__defau__403A8C7D] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__lookup_co__level__412EB0B6] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__lookup_co__enabl__4222D4EF] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [lookup_contactemail_types] WITH NOCHECK ADD 

	CONSTRAINT [DF__lookup_co__defau__44FF419A] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__lookup_co__level__45F365D3] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__lookup_co__enabl__46E78A0C] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [lookup_contactphone_types] WITH NOCHECK ADD 

	CONSTRAINT [DF__lookup_co__defau__49C3F6B7] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__lookup_co__level__4AB81AF0] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__lookup_co__enabl__4BAC3F29] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [lookup_delivery_options] WITH NOCHECK ADD 

	CONSTRAINT [DF__lookup_de__defau__1DB06A4F] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__lookup_de__level__1EA48E88] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__lookup_de__enabl__1F98B2C1] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [lookup_department] WITH NOCHECK ADD 

	CONSTRAINT [DF__lookup_de__defau__1ED998B2] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__lookup_de__level__1FCDBCEB] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__lookup_de__enabl__20C1E124] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [lookup_employment_types] WITH NOCHECK ADD 

	CONSTRAINT [DF__lookup_em__defau__36B12243] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__lookup_em__level__37A5467C] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__lookup_em__enabl__38996AB5] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [lookup_help_features] WITH NOCHECK ADD 

	CONSTRAINT [DF__lookup_he__defau__150615B5] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__lookup_he__level__15FA39EE] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__lookup_he__enabl__16EE5E27] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [lookup_industry] WITH NOCHECK ADD 

	CONSTRAINT [DF__lookup_in__defau__060DEAE8] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__lookup_in__level__07020F21] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__lookup_in__enabl__07F6335A] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [lookup_instantmessenger_types] WITH NOCHECK ADD 

	CONSTRAINT [DF__lookup_in__defau__31EC6D26] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__lookup_in__level__32E0915F] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__lookup_in__enabl__33D4B598] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [lookup_lists_lookup] WITH NOCHECK ADD 

	CONSTRAINT [DF__lookup_li__level__72910220] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__lookup_li__enter__73852659] DEFAULT (getdate()) FOR [entered]

GO



ALTER TABLE [lookup_locale] WITH NOCHECK ADD 

	CONSTRAINT [DF__lookup_lo__defau__3B75D760] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__lookup_lo__level__3C69FB99] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__lookup_lo__enabl__3D5E1FD2] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [lookup_opportunity_types] WITH NOCHECK ADD 

	CONSTRAINT [DF__lookup_op__defau__467D75B8] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__lookup_op__level__477199F1] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__lookup_op__enabl__4865BE2A] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [lookup_orgaddress_types] WITH NOCHECK ADD 

	CONSTRAINT [DF__lookup_or__defau__239E4DCF] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__lookup_or__level__24927208] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__lookup_or__enabl__25869641] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [lookup_orgemail_types] WITH NOCHECK ADD 

	CONSTRAINT [DF__lookup_or__defau__286302EC] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__lookup_or__level__29572725] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__lookup_or__enabl__2A4B4B5E] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [lookup_orgphone_types] WITH NOCHECK ADD 

	CONSTRAINT [DF__lookup_or__defau__2D27B809] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__lookup_or__level__2E1BDC42] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__lookup_or__enabl__2F10007B] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [lookup_project_activity] WITH NOCHECK ADD 

	CONSTRAINT [DF__lookup_pr__defau__5F141958] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__lookup_pr__level__60083D91] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__lookup_pr__enabl__60FC61CA] DEFAULT (1) FOR [enabled],

	CONSTRAINT [DF__lookup_pr__group__61F08603] DEFAULT (0) FOR [group_id],

	CONSTRAINT [DF__lookup_pr__templ__62E4AA3C] DEFAULT (0) FOR [template_id]

GO



ALTER TABLE [lookup_project_issues] WITH NOCHECK ADD 

	CONSTRAINT [DF__lookup_pr__defau__6B79F03D] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__lookup_pr__level__6C6E1476] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__lookup_pr__enabl__6D6238AF] DEFAULT (1) FOR [enabled],

	CONSTRAINT [DF__lookup_pr__group__6E565CE8] DEFAULT (0) FOR [group_id]

GO



ALTER TABLE [lookup_project_loe] WITH NOCHECK ADD 

	CONSTRAINT [DF__lookup_pr__base___76EBA2E9] DEFAULT (0) FOR [base_value],

	CONSTRAINT [DF__lookup_pr__defau__77DFC722] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__lookup_pr__level__78D3EB5B] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__lookup_pr__enabl__79C80F94] DEFAULT (1) FOR [enabled],

	CONSTRAINT [DF__lookup_pr__group__7ABC33CD] DEFAULT (0) FOR [group_id]

GO



ALTER TABLE [lookup_project_priority] WITH NOCHECK ADD 

	CONSTRAINT [DF__lookup_pr__defau__65C116E7] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__lookup_pr__level__66B53B20] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__lookup_pr__enabl__67A95F59] DEFAULT (1) FOR [enabled],

	CONSTRAINT [DF__lookup_pr__group__689D8392] DEFAULT (0) FOR [group_id]

GO



ALTER TABLE [lookup_project_status] WITH NOCHECK ADD 

	CONSTRAINT [DF__lookup_pr__defau__7132C993] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__lookup_pr__level__7226EDCC] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__lookup_pr__enabl__731B1205] DEFAULT (1) FOR [enabled],

	CONSTRAINT [DF__lookup_pr__group__740F363E] DEFAULT (0) FOR [group_id]

GO



ALTER TABLE [lookup_revenue_types] WITH NOCHECK ADD 

	CONSTRAINT [DF__lookup_re__defau__1C722D53] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__lookup_re__level__1D66518C] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__lookup_re__enabl__1E5A75C5] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [lookup_revenuedetail_types] WITH NOCHECK ADD 

	CONSTRAINT [DF__lookup_re__defau__2136E270] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__lookup_re__level__222B06A9] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__lookup_re__enabl__231F2AE2] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [lookup_stage] WITH NOCHECK ADD 

	CONSTRAINT [DF__lookup_st__defau__18EBB532] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__lookup_st__level__19DFD96B] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__lookup_st__enabl__1AD3FDA4] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [lookup_survey_types] WITH NOCHECK ADD 

	CONSTRAINT [DF__lookup_su__defau__0F824689] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__lookup_su__level__10766AC2] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__lookup_su__enabl__116A8EFB] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [lookup_task_category] WITH NOCHECK ADD 

	CONSTRAINT [DF__lookup_ta__defau__457442E6] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__lookup_ta__level__4668671F] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__lookup_ta__enabl__475C8B58] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [lookup_task_loe] WITH NOCHECK ADD 

	CONSTRAINT [DF__lookup_ta__defau__40AF8DC9] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__lookup_ta__level__41A3B202] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__lookup_ta__enabl__4297D63B] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [lookup_task_priority] WITH NOCHECK ADD 

	CONSTRAINT [DF__lookup_ta__defau__3BEAD8AC] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__lookup_ta__level__3CDEFCE5] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__lookup_ta__enabl__3DD3211E] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [lookup_ticketsource] WITH NOCHECK ADD 

	CONSTRAINT [DF__lookup_ti__defau__7AF13DF7] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__lookup_ti__level__7BE56230] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__lookup_ti__enabl__7CD98669] DEFAULT (1) FOR [enabled],

	 UNIQUE  NONCLUSTERED 

	(

		[description]

	)  ON [PRIMARY] 

GO



ALTER TABLE [message] WITH NOCHECK ADD 

	CONSTRAINT [DF__message__subject__5F9E293D] DEFAULT (null) FOR [subject],

	CONSTRAINT [DF__message__enabled__60924D76] DEFAULT (1) FOR [enabled],

	CONSTRAINT [DF__message__entered__618671AF] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__message__modifie__636EBA21] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [message_template] WITH NOCHECK ADD 

	CONSTRAINT [DF__message_t__enabl__68336F3E] DEFAULT (1) FOR [enabled],

	CONSTRAINT [DF__message_t__enter__69279377] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__message_t__modif__6B0FDBE9] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [module_field_categorylink] WITH NOCHECK ADD 

	CONSTRAINT [DF__module_fi__level__2E70E1FD] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__module_fi__enter__2F650636] DEFAULT (getdate()) FOR [entered],

	 UNIQUE  NONCLUSTERED 

	(

		[category_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [news] WITH NOCHECK ADD 

	CONSTRAINT [DF__news__created__236943A5] DEFAULT (getdate()) FOR [created]

GO



ALTER TABLE [notification] WITH NOCHECK ADD 

	CONSTRAINT [DF__notificat__item___540C7B00] DEFAULT (getdate()) FOR [item_modified],

	CONSTRAINT [DF__notificat__attem__55009F39] DEFAULT (getdate()) FOR [attempt]

GO



ALTER TABLE [opportunity_component] WITH NOCHECK ADD 

	CONSTRAINT [DF__opportuni__stage__55BFB948] DEFAULT (getdate()) FOR [stagedate],

	CONSTRAINT [DF__opportuni__enter__56B3DD81] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__opportuni__modif__589C25F3] DEFAULT (getdate()) FOR [modified],

	CONSTRAINT [DF__opportuni__alert__5A846E65] DEFAULT (null) FOR [alert],

	CONSTRAINT [DF__opportuni__enabl__5B78929E] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [opportunity_component_levels] WITH NOCHECK ADD 

	CONSTRAINT [DF__opportuni__enter__5F492382] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__opportuni__modif__603D47BB] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [opportunity_header] WITH NOCHECK ADD 

	CONSTRAINT [DF__opportuni__enter__4D2A7347] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__opportuni__modif__4F12BBB9] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [organization] WITH NOCHECK ADD 

	CONSTRAINT [DF__organizat__ticke__52593CB8] DEFAULT (null) FOR [ticker_symbol],

	CONSTRAINT [DF__organizat__sales__534D60F1] DEFAULT (0) FOR [sales_rep],

	CONSTRAINT [DF__organizat__miner__5441852A] DEFAULT (0) FOR [miner_only],

	CONSTRAINT [DF__organizat__enter__5535A963] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__organizat__modif__571DF1D5] DEFAULT (getdate()) FOR [modified],

	CONSTRAINT [DF__organizat__enabl__59063A47] DEFAULT (1) FOR [enabled],

	CONSTRAINT [DF__organizat__dupli__5AEE82B9] DEFAULT ((-1)) FOR [duplicate_id],

	CONSTRAINT [DF__organizat__custo__5BE2A6F2] DEFAULT ((-1)) FOR [custom1],

	CONSTRAINT [DF__organizat__custo__5CD6CB2B] DEFAULT ((-1)) FOR [custom2],

	CONSTRAINT [DF__organizat__contr__5DCAEF64] DEFAULT (null) FOR [contract_end],

	CONSTRAINT [DF__organizat__alert__5EBF139D] DEFAULT (null) FOR [alertdate],

	CONSTRAINT [DF__organizat__alert__5FB337D6] DEFAULT (null) FOR [alert]

GO



ALTER TABLE [organization_address] WITH NOCHECK ADD 

	CONSTRAINT [DF__organizat__enter__282DF8C2] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__organizat__modif__2A164134] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [organization_emailaddress] WITH NOCHECK ADD 

	CONSTRAINT [DF__organizat__enter__2FCF1A8A] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__organizat__modif__31B762FC] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [organization_phone] WITH NOCHECK ADD 

	CONSTRAINT [DF__organizat__enter__37703C52] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__organizat__modif__395884C4] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [permission] WITH NOCHECK ADD 

	CONSTRAINT [DF__permissio__permi__06CD04F7] DEFAULT (0) FOR [permission_view],

	CONSTRAINT [DF__permissio__permi__07C12930] DEFAULT (0) FOR [permission_add],

	CONSTRAINT [DF__permissio__permi__08B54D69] DEFAULT (0) FOR [permission_edit],

	CONSTRAINT [DF__permissio__permi__09A971A2] DEFAULT (0) FOR [permission_delete],

	CONSTRAINT [DF__permissio__descr__0A9D95DB] DEFAULT ('') FOR [description],

	CONSTRAINT [DF__permissio__level__0B91BA14] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__permissio__enabl__0C85DE4D] DEFAULT (1) FOR [enabled],

	CONSTRAINT [DF__permissio__activ__0D7A0286] DEFAULT (1) FOR [active],

	CONSTRAINT [DF__permissio__viewp__0E6E26BF] DEFAULT (0) FOR [viewpoints]

GO



ALTER TABLE [permission_category] WITH NOCHECK ADD 

	CONSTRAINT [DF__permissio__level__7A672E12] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__permissio__enabl__7B5B524B] DEFAULT (1) FOR [enabled],

	CONSTRAINT [DF__permissio__activ__7C4F7684] DEFAULT (1) FOR [active],

	CONSTRAINT [DF__permissio__folde__7D439ABD] DEFAULT (0) FOR [folders],

	CONSTRAINT [DF__permissio__looku__7E37BEF6] DEFAULT (0) FOR [lookups],

	CONSTRAINT [DF__permissio__viewp__7F2BE32F] DEFAULT (0) FOR [viewpoints],

	CONSTRAINT [DF__permissio__categ__00200768] DEFAULT (0) FOR [categories],

	CONSTRAINT [DF__permissio__sched__01142BA1] DEFAULT (0) FOR [scheduled_events],

	CONSTRAINT [DF__permissio__objec__02084FDA] DEFAULT (0) FOR [object_events],

	CONSTRAINT [DF__permissio__repor__02FC7413] DEFAULT (0) FOR [reports]

GO



ALTER TABLE [process_log] WITH NOCHECK ADD 

	CONSTRAINT [DF__process_l__enter__6DB73E6A] DEFAULT (getdate()) FOR [entered]

GO



ALTER TABLE [project_assignments] WITH NOCHECK ADD 

	CONSTRAINT [DF__project_a__assig__1758727B] DEFAULT (getdate()) FOR [assign_date],

	CONSTRAINT [DF__project_a__statu__1940BAED] DEFAULT (getdate()) FOR [status_date],

	CONSTRAINT [DF__project_a__enter__1A34DF26] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__project_a__modif__1C1D2798] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [project_assignments_status] WITH NOCHECK ADD 

	CONSTRAINT [DF__project_a__statu__21D600EE] DEFAULT (getdate()) FOR [status_date]

GO



ALTER TABLE [project_files] WITH NOCHECK ADD 

	CONSTRAINT [DF__project_fi__size__38B96646] DEFAULT (0) FOR [size],

	CONSTRAINT [DF__project_f__versi__39AD8A7F] DEFAULT (0) FOR [version],

	CONSTRAINT [DF__project_f__enabl__3AA1AEB8] DEFAULT (1) FOR [enabled],

	CONSTRAINT [DF__project_f__downl__3B95D2F1] DEFAULT (0) FOR [downloads],

	CONSTRAINT [DF__project_f__enter__3C89F72A] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__project_f__modif__3E723F9C] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [project_files_download] WITH NOCHECK ADD 

	CONSTRAINT [DF__project_f__versi__4BCC3ABA] DEFAULT (0) FOR [version],

	CONSTRAINT [DF__project_f__downl__4DB4832C] DEFAULT (getdate()) FOR [download_date]

GO



ALTER TABLE [project_files_version] WITH NOCHECK ADD 

	CONSTRAINT [DF__project_fi__size__4242D080] DEFAULT (0) FOR [size],

	CONSTRAINT [DF__project_f__versi__4336F4B9] DEFAULT (0) FOR [version],

	CONSTRAINT [DF__project_f__enabl__442B18F2] DEFAULT (1) FOR [enabled],

	CONSTRAINT [DF__project_f__downl__451F3D2B] DEFAULT (0) FOR [downloads],

	CONSTRAINT [DF__project_f__enter__46136164] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__project_f__modif__47FBA9D6] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [project_issue_replies] WITH NOCHECK ADD 

	CONSTRAINT [DF__project_i__reply__2F2FFC0C] DEFAULT (0) FOR [reply_to],

	CONSTRAINT [DF__project_i__enter__30242045] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__project_i__modif__320C68B7] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [project_issues] WITH NOCHECK ADD 

	CONSTRAINT [DF__project_i__impor__269AB60B] DEFAULT (0) FOR [importance],

	CONSTRAINT [DF__project_i__enabl__278EDA44] DEFAULT (1) FOR [enabled],

	CONSTRAINT [DF__project_i__enter__2882FE7D] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__project_i__modif__2A6B46EF] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [project_requirements] WITH NOCHECK ADD 

	CONSTRAINT [DF__project_r__enter__09FE775D] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__project_r__modif__0BE6BFCF] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [project_team] WITH NOCHECK ADD 

	CONSTRAINT [DF__project_t__enter__51851410] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__project_t__modif__536D5C82] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [projects] WITH NOCHECK ADD 

	CONSTRAINT [DF__projects__reques__7E8CC4B1] DEFAULT (getdate()) FOR [requestDate],

	CONSTRAINT [DF__projects__entere__7F80E8EA] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__projects__modifi__0169315C] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [report] WITH NOCHECK ADD 

	CONSTRAINT [DF__report__type__0880433F] DEFAULT (1) FOR [type],

	CONSTRAINT [DF__report__entered__09746778] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__report__modified__0B5CAFEA] DEFAULT (getdate()) FOR [modified],

	CONSTRAINT [DF__report__enabled__0D44F85C] DEFAULT (1) FOR [enabled],

	CONSTRAINT [DF__report__custom__0E391C95] DEFAULT (0) FOR [custom]

GO



ALTER TABLE [report_criteria] WITH NOCHECK ADD 

	CONSTRAINT [DF__report_cr__enter__12FDD1B2] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__report_cr__modif__14E61A24] DEFAULT (getdate()) FOR [modified],

	CONSTRAINT [DF__report_cr__enabl__16CE6296] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [report_queue] WITH NOCHECK ADD 

	CONSTRAINT [DF__report_qu__enter__1D7B6025] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__report_qu__proce__1F63A897] DEFAULT (null) FOR [processed],

	CONSTRAINT [DF__report_qu__statu__2057CCD0] DEFAULT (0) FOR [status],

	CONSTRAINT [DF__report_qu__files__214BF109] DEFAULT ((-1)) FOR [filesize],

	CONSTRAINT [DF__report_qu__enabl__22401542] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [revenue] WITH NOCHECK ADD 

	CONSTRAINT [DF__revenue__transac__26EFBBC6] DEFAULT ((-1)) FOR [transaction_id],

	CONSTRAINT [DF__revenue__month__27E3DFFF] DEFAULT ((-1)) FOR [month],

	CONSTRAINT [DF__revenue__year__28D80438] DEFAULT ((-1)) FOR [year],

	CONSTRAINT [DF__revenue__amount__29CC2871] DEFAULT (0) FOR [amount],

	CONSTRAINT [DF__revenue__entered__2CA8951C] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__revenue__modifie__2E90DD8E] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [revenue_detail] WITH NOCHECK ADD 

	CONSTRAINT [DF__revenue_d__amoun__335592AB] DEFAULT (0) FOR [amount],

	CONSTRAINT [DF__revenue_d__enter__3631FF56] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__revenue_d__modif__381A47C8] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [role] WITH NOCHECK ADD 

	CONSTRAINT [DF__role__descriptio__72C60C4A] DEFAULT ('') FOR [description],

	CONSTRAINT [DF__role__entered__74AE54BC] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__role__modified__76969D2E] DEFAULT (getdate()) FOR [modified],

	CONSTRAINT [DF__role__enabled__778AC167] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [role_permission] WITH NOCHECK ADD 

	CONSTRAINT [DF__role_perm__role___1332DBDC] DEFAULT (0) FOR [role_view],

	CONSTRAINT [DF__role_perm__role___14270015] DEFAULT (0) FOR [role_add],

	CONSTRAINT [DF__role_perm__role___151B244E] DEFAULT (0) FOR [role_edit],

	CONSTRAINT [DF__role_perm__role___160F4887] DEFAULT (0) FOR [role_delete]

GO



ALTER TABLE [saved_criteriaelement] WITH NOCHECK ADD 

	CONSTRAINT [DF__saved_cri__sourc__70C8B53F] DEFAULT ((-1)) FOR [source]

GO



ALTER TABLE [saved_criterialist] WITH NOCHECK ADD 

	CONSTRAINT [DF__saved_cri__enter__573DED66] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__saved_cri__modif__592635D8] DEFAULT (getdate()) FOR [modified],

	CONSTRAINT [DF__saved_cri__conta__5C02A283] DEFAULT ((-1)) FOR [contact_source],

	CONSTRAINT [DF__saved_cri__enabl__5CF6C6BC] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [scheduled_recipient] WITH NOCHECK ADD 

	CONSTRAINT [DF__scheduled__run_i__06ED0088] DEFAULT ((-1)) FOR [run_id],

	CONSTRAINT [DF__scheduled__statu__07E124C1] DEFAULT (0) FOR [status_id],

	CONSTRAINT [DF__scheduled__statu__08D548FA] DEFAULT (getdate()) FOR [status_date],

	CONSTRAINT [DF__scheduled__sched__09C96D33] DEFAULT (getdate()) FOR [scheduled_date],

	CONSTRAINT [DF__scheduled__sent___0ABD916C] DEFAULT (null) FOR [sent_date],

	CONSTRAINT [DF__scheduled__reply__0BB1B5A5] DEFAULT (null) FOR [reply_date],

	CONSTRAINT [DF__scheduled__bounc__0CA5D9DE] DEFAULT (null) FOR [bounce_date]

GO



ALTER TABLE [search_fields] WITH NOCHECK ADD 

	CONSTRAINT [DF__search_fi__searc__5AD97420] DEFAULT (1) FOR [searchable],

	CONSTRAINT [DF__search_fi__field__5BCD9859] DEFAULT ((-1)) FOR [field_typeid],

	CONSTRAINT [DF__search_fi__enabl__5CC1BC92] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [survey] WITH NOCHECK ADD 

	CONSTRAINT [DF__survey__itemLeng__1446FBA6] DEFAULT ((-1)) FOR [itemLength],

	CONSTRAINT [DF__survey__type__153B1FDF] DEFAULT ((-1)) FOR [type],

	CONSTRAINT [DF__survey__enabled__162F4418] DEFAULT (1) FOR [enabled],

	CONSTRAINT [DF__survey__status__17236851] DEFAULT ((-1)) FOR [status],

	CONSTRAINT [DF__survey__entered__18178C8A] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__survey__modified__19FFD4FC] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [survey_items] WITH NOCHECK ADD 

	CONSTRAINT [DF__survey_ite__type__2759D01A] DEFAULT ((-1)) FOR [type]

GO



ALTER TABLE [survey_questions] WITH NOCHECK ADD 

	CONSTRAINT [DF__survey_qu__requi__22951AFD] DEFAULT (0) FOR [required],

	CONSTRAINT [DF__survey_qu__posit__23893F36] DEFAULT (0) FOR [position]

GO



ALTER TABLE [sync_client] WITH NOCHECK ADD 

	CONSTRAINT [DF__sync_clie__enter__4E3E9311] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__sync_clie__modif__4F32B74A] DEFAULT (getdate()) FOR [modified],

	CONSTRAINT [DF__sync_clie__ancho__5026DB83] DEFAULT (null) FOR [anchor]

GO



ALTER TABLE [sync_conflict_log] WITH NOCHECK ADD 

	CONSTRAINT [DF__sync_conf__statu__61516785] DEFAULT (getdate()) FOR [status_date]

GO



ALTER TABLE [sync_log] WITH NOCHECK ADD 

	CONSTRAINT [DF__sync_log__entere__66161CA2] DEFAULT (getdate()) FOR [entered]

GO



ALTER TABLE [sync_map] WITH NOCHECK ADD 

	CONSTRAINT [DF__sync_map__comple__5D80D6A1] DEFAULT (0) FOR [complete]

GO



ALTER TABLE [sync_system] WITH NOCHECK ADD 

	CONSTRAINT [DF__sync_syst__enabl__5303482E] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [sync_table] WITH NOCHECK ADD 

	CONSTRAINT [DF__sync_tabl__enter__56D3D912] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__sync_tabl__modif__57C7FD4B] DEFAULT (getdate()) FOR [modified],

	CONSTRAINT [DF__sync_tabl__order__58BC2184] DEFAULT ((-1)) FOR [order_id],

	CONSTRAINT [DF__sync_tabl__sync___59B045BD] DEFAULT (0) FOR [sync_item]

GO



ALTER TABLE [task] WITH NOCHECK ADD 

	CONSTRAINT [DF__task__entered__4A38F803] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__task__complete__4D1564AE] DEFAULT (0) FOR [complete],

	CONSTRAINT [DF__task__enabled__4E0988E7] DEFAULT (0) FOR [enabled],

	CONSTRAINT [DF__task__modified__4EFDAD20] DEFAULT (getdate()) FOR [modified],

	CONSTRAINT [DF__task__type__51DA19CB] DEFAULT (1) FOR [type]

GO



ALTER TABLE [ticket] WITH NOCHECK ADD 

	CONSTRAINT [DF__ticket__entered__1699586C] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__ticket__modified__1881A0DE] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [ticket_category] WITH NOCHECK ADD 

	CONSTRAINT [DF__ticket_ca__cat_l__0662F0A3] DEFAULT (0) FOR [cat_level],

	CONSTRAINT [DF__ticket_ca__full___075714DC] DEFAULT ('') FOR [full_description],

	CONSTRAINT [DF__ticket_ca__defau__084B3915] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__ticket_ca__level__093F5D4E] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__ticket_ca__enabl__0A338187] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [ticket_category_draft] WITH NOCHECK ADD 

	CONSTRAINT [DF__ticket_ca__link___0D0FEE32] DEFAULT ((-1)) FOR [link_id],

	CONSTRAINT [DF__ticket_ca__cat_l__0E04126B] DEFAULT (0) FOR [cat_level],

	CONSTRAINT [DF__ticket_ca__full___0EF836A4] DEFAULT ('') FOR [full_description],

	CONSTRAINT [DF__ticket_ca__defau__0FEC5ADD] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__ticket_ca__level__10E07F16] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__ticket_ca__enabl__11D4A34F] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [ticket_level] WITH NOCHECK ADD 

	CONSTRAINT [DF__ticket_le__defau__6E8B6712] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__ticket_le__level__6F7F8B4B] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__ticket_le__enabl__7073AF84] DEFAULT (1) FOR [enabled],

	 UNIQUE  NONCLUSTERED 

	(

		[description]

	)  ON [PRIMARY] 

GO



ALTER TABLE [ticket_priority] WITH NOCHECK ADD 

	CONSTRAINT [DF__ticket_pr__style__00AA174D] DEFAULT ('') FOR [style],

	CONSTRAINT [DF__ticket_pr__defau__019E3B86] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__ticket_pr__level__02925FBF] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__ticket_pr__enabl__038683F8] DEFAULT (1) FOR [enabled],

	 UNIQUE  NONCLUSTERED 

	(

		[description]

	)  ON [PRIMARY] 

GO



ALTER TABLE [ticket_severity] WITH NOCHECK ADD 

	CONSTRAINT [DF__ticket_se__style__74444068] DEFAULT ('') FOR [style],

	CONSTRAINT [DF__ticket_se__defau__753864A1] DEFAULT (0) FOR [default_item],

	CONSTRAINT [DF__ticket_se__level__762C88DA] DEFAULT (0) FOR [level],

	CONSTRAINT [DF__ticket_se__enabl__7720AD13] DEFAULT (1) FOR [enabled],

	 UNIQUE  NONCLUSTERED 

	(

		[description]

	)  ON [PRIMARY] 

GO



ALTER TABLE [ticketlog] WITH NOCHECK ADD 

	CONSTRAINT [DF__ticketlog__enter__26CFC035] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__ticketlog__modif__28B808A7] DEFAULT (getdate()) FOR [modified]

GO



ALTER TABLE [usage_log] WITH NOCHECK ADD 

	CONSTRAINT [DF__usage_log__enter__0EA330E9] DEFAULT (getdate()) FOR [entered]

GO



ALTER TABLE [viewpoint] WITH NOCHECK ADD 

	CONSTRAINT [DF__viewpoint__enter__7849DB76] DEFAULT (getdate()) FOR [entered],

	CONSTRAINT [DF__viewpoint__modif__7A3223E8] DEFAULT (getdate()) FOR [modified],

	CONSTRAINT [DF__viewpoint__enabl__7C1A6C5A] DEFAULT (1) FOR [enabled]

GO



ALTER TABLE [viewpoint_permission] WITH NOCHECK ADD 

	CONSTRAINT [DF__viewpoint__viewp__00DF2177] DEFAULT (0) FOR [viewpoint_view],

	CONSTRAINT [DF__viewpoint__viewp__01D345B0] DEFAULT (0) FOR [viewpoint_add],

	CONSTRAINT [DF__viewpoint__viewp__02C769E9] DEFAULT (0) FOR [viewpoint_edit],

	CONSTRAINT [DF__viewpoint__viewp__03BB8E22] DEFAULT (0) FOR [viewpoint_delete]

GO



 CREATE  UNIQUE  INDEX [idx_autog_inv_opt] ON [autoguide_inventory_options]([inventory_id], [option_id]) ON [PRIMARY]

GO



 CREATE  INDEX [call_log_cidx] ON [call_log]([alertdate], [enteredby]) ON [PRIMARY]

GO



 CREATE  INDEX [contact_user_id_idx] ON [contact]([user_id]) ON [PRIMARY]

GO



 CREATE  INDEX [contactlist_namecompany] ON [contact]([namelast], [namefirst], [company]) ON [PRIMARY]

GO



 CREATE  INDEX [contactlist_company] ON [contact]([company], [namelast], [namefirst]) ON [PRIMARY]

GO



 CREATE  INDEX [custom_field_cat_idx] ON [custom_field_category]([module_id]) ON [PRIMARY]

GO



 CREATE  INDEX [custom_field_dat_idx] ON [custom_field_data]([record_id], [field_id]) ON [PRIMARY]

GO



 CREATE  INDEX [custom_field_grp_idx] ON [custom_field_group]([category_id]) ON [PRIMARY]

GO



 CREATE  INDEX [custom_field_inf_idx] ON [custom_field_info]([group_id]) ON [PRIMARY]

GO



 CREATE  INDEX [custom_field_rec_idx] ON [custom_field_record]([link_module_id], [link_item_id], [category_id]) ON [PRIMARY]

GO



 CREATE  INDEX [oppcomplist_closedate] ON [opportunity_component]([closedate]) ON [PRIMARY]

GO



 CREATE  INDEX [oppcomplist_description] ON [opportunity_component]([description]) ON [PRIMARY]

GO



 CREATE  INDEX [orglist_name] ON [organization]([name]) ON [PRIMARY]

GO



 CREATE  INDEX [project_assignments_idx] ON [project_assignments]([activity_id]) ON [PRIMARY]

GO



 CREATE  INDEX [project_assignments_cidx] ON [project_assignments]([complete_date], [user_assign_id]) ON [PRIMARY]

GO



 CREATE  INDEX [project_files_cidx] ON [project_files]([link_module_id], [link_item_id]) ON [PRIMARY]

GO



 CREATE  INDEX [project_issues_limit_idx] ON [project_issues]([type_id], [project_id], [enteredBy]) ON [PRIMARY]

GO



 CREATE  INDEX [project_issues_idx] ON [project_issues]([issue_id]) ON [PRIMARY]

GO



 CREATE  INDEX [projects_idx] ON [projects]([group_id], [project_id]) ON [PRIMARY]

GO



 CREATE  UNIQUE  INDEX [idx_sync_map] ON [sync_map]([client_id], [table_id], [record_id]) ON [PRIMARY]

GO



 CREATE  INDEX [ticket_cidx] ON [ticket]([assigned_to], [closed]) ON [PRIMARY]

GO



 CREATE  INDEX [ticketlist_entered] ON [ticket]([entered]) ON [PRIMARY]

GO



ALTER TABLE [access_log] ADD 

	 FOREIGN KEY 

	(

		[user_id]

	) REFERENCES [access] (

		[user_id]

	)

GO



ALTER TABLE [account_type_levels] ADD 

	 FOREIGN KEY 

	(

		[org_id]

	) REFERENCES [organization] (

		[org_id]

	),

	 FOREIGN KEY 

	(

		[type_id]

	) REFERENCES [lookup_account_types] (

		[code]

	)

GO



ALTER TABLE [action_item] ADD 

	 FOREIGN KEY 

	(

		[action_id]

	) REFERENCES [action_list] (

		[action_id]

	),

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	)

GO



ALTER TABLE [action_item_log] ADD 

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[item_id]

	) REFERENCES [action_item] (

		[item_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	)

GO



ALTER TABLE [action_list] ADD 

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[owner]

	) REFERENCES [access] (

		[user_id]

	)

GO



ALTER TABLE [active_campaign_groups] ADD 

	 FOREIGN KEY 

	(

		[campaign_id]

	) REFERENCES [campaign] (

		[campaign_id]

	)

GO



ALTER TABLE [active_survey] ADD 

	 FOREIGN KEY 

	(

		[campaign_id]

	) REFERENCES [campaign] (

		[campaign_id]

	),

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[type]

	) REFERENCES [lookup_survey_types] (

		[code]

	)

GO



ALTER TABLE [active_survey_answer_avg] ADD 

	 FOREIGN KEY 

	(

		[item_id]

	) REFERENCES [active_survey_items] (

		[item_id]

	),

	 FOREIGN KEY 

	(

		[question_id]

	) REFERENCES [active_survey_questions] (

		[question_id]

	)

GO



ALTER TABLE [active_survey_answer_items] ADD 

	 FOREIGN KEY 

	(

		[answer_id]

	) REFERENCES [active_survey_answers] (

		[answer_id]

	),

	 FOREIGN KEY 

	(

		[item_id]

	) REFERENCES [active_survey_items] (

		[item_id]

	)

GO



ALTER TABLE [active_survey_answers] ADD 

	 FOREIGN KEY 

	(

		[question_id]

	) REFERENCES [active_survey_questions] (

		[question_id]

	),

	 FOREIGN KEY 

	(

		[response_id]

	) REFERENCES [active_survey_responses] (

		[response_id]

	)

GO



ALTER TABLE [active_survey_items] ADD 

	 FOREIGN KEY 

	(

		[question_id]

	) REFERENCES [active_survey_questions] (

		[question_id]

	)

GO



ALTER TABLE [active_survey_questions] ADD 

	 FOREIGN KEY 

	(

		[active_survey_id]

	) REFERENCES [active_survey] (

		[active_survey_id]

	),

	 FOREIGN KEY 

	(

		[type]

	) REFERENCES [lookup_survey_types] (

		[code]

	)

GO



ALTER TABLE [active_survey_responses] ADD 

	 FOREIGN KEY 

	(

		[active_survey_id]

	) REFERENCES [active_survey] (

		[active_survey_id]

	)

GO



ALTER TABLE [autoguide_ad_run] ADD 

	 FOREIGN KEY 

	(

		[inventory_id]

	) REFERENCES [autoguide_inventory] (

		[inventory_id]

	)

GO



ALTER TABLE [autoguide_inventory] ADD 

	 FOREIGN KEY 

	(

		[account_id]

	) REFERENCES [organization] (

		[org_id]

	),

	 FOREIGN KEY 

	(

		[vehicle_id]

	) REFERENCES [autoguide_vehicle] (

		[vehicle_id]

	)

GO



ALTER TABLE [autoguide_inventory_options] ADD 

	 FOREIGN KEY 

	(

		[inventory_id]

	) REFERENCES [autoguide_inventory] (

		[inventory_id]

	)

GO



ALTER TABLE [autoguide_model] ADD 

	 FOREIGN KEY 

	(

		[make_id]

	) REFERENCES [autoguide_make] (

		[make_id]

	)

GO



ALTER TABLE [autoguide_vehicle] ADD 

	 FOREIGN KEY 

	(

		[make_id]

	) REFERENCES [autoguide_make] (

		[make_id]

	),

	 FOREIGN KEY 

	(

		[model_id]

	) REFERENCES [autoguide_model] (

		[model_id]

	)

GO



ALTER TABLE [business_process] ADD 

	 FOREIGN KEY 

	(

		[link_module_id]

	) REFERENCES [permission_category] (

		[category_id]

	)

GO



ALTER TABLE [business_process_component] ADD 

	 FOREIGN KEY 

	(

		[component_id]

	) REFERENCES [business_process_component_library] (

		[component_id]

	),

	 FOREIGN KEY 

	(

		[parent_id]

	) REFERENCES [business_process_component] (

		[id]

	),

	 FOREIGN KEY 

	(

		[process_id]

	) REFERENCES [business_process] (

		[process_id]

	)

GO



ALTER TABLE [business_process_component_parameter] ADD 

	 FOREIGN KEY 

	(

		[component_id]

	) REFERENCES [business_process_component] (

		[id]

	),

	 FOREIGN KEY 

	(

		[parameter_id]

	) REFERENCES [business_process_parameter_library] (

		[parameter_id]

	)

GO



ALTER TABLE [business_process_component_result_lookup] ADD 

	 FOREIGN KEY 

	(

		[component_id]

	) REFERENCES [business_process_component_library] (

		[component_id]

	)

GO



ALTER TABLE [business_process_events] ADD 

	 FOREIGN KEY 

	(

		[process_id]

	) REFERENCES [business_process] (

		[process_id]

	)

GO



ALTER TABLE [business_process_hook] ADD 

	 FOREIGN KEY 

	(

		[process_id]

	) REFERENCES [business_process] (

		[process_id]

	),

	 FOREIGN KEY 

	(

		[trigger_id]

	) REFERENCES [business_process_hook_triggers] (

		[trigger_id]

	)

GO



ALTER TABLE [business_process_hook_library] ADD 

	 FOREIGN KEY 

	(

		[link_module_id]

	) REFERENCES [permission_category] (

		[category_id]

	)

GO



ALTER TABLE [business_process_hook_triggers] ADD 

	 FOREIGN KEY 

	(

		[hook_id]

	) REFERENCES [business_process_hook_library] (

		[hook_id]

	)

GO



ALTER TABLE [business_process_parameter] ADD 

	 FOREIGN KEY 

	(

		[process_id]

	) REFERENCES [business_process] (

		[process_id]

	)

GO



ALTER TABLE [call_log] ADD 

	 FOREIGN KEY 

	(

		[call_type_id]

	) REFERENCES [lookup_call_types] (

		[code]

	),

	 FOREIGN KEY 

	(

		[contact_id]

	) REFERENCES [contact] (

		[contact_id]

	),

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[opp_id]

	) REFERENCES [opportunity_header] (

		[opp_id]

	),

	 FOREIGN KEY 

	(

		[org_id]

	) REFERENCES [organization] (

		[org_id]

	)

GO



ALTER TABLE [campaign] ADD 

	 FOREIGN KEY 

	(

		[approvedby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	)

GO



ALTER TABLE [campaign_list_groups] ADD 

	 FOREIGN KEY 

	(

		[campaign_id]

	) REFERENCES [campaign] (

		[campaign_id]

	),

	 FOREIGN KEY 

	(

		[group_id]

	) REFERENCES [saved_criterialist] (

		[id]

	)

GO



ALTER TABLE [campaign_run] ADD 

	 FOREIGN KEY 

	(

		[campaign_id]

	) REFERENCES [campaign] (

		[campaign_id]

	)

GO



ALTER TABLE [campaign_survey_link] ADD 

	 FOREIGN KEY 

	(

		[campaign_id]

	) REFERENCES [campaign] (

		[campaign_id]

	),

	 FOREIGN KEY 

	(

		[survey_id]

	) REFERENCES [survey] (

		[survey_id]

	)

GO



ALTER TABLE [cfsinbox_message] ADD 

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	)

GO



ALTER TABLE [cfsinbox_messagelink] ADD 

	 FOREIGN KEY 

	(

		[sent_to]

	) REFERENCES [contact] (

		[contact_id]

	),

	 FOREIGN KEY 

	(

		[sent_from]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[id]

	) REFERENCES [cfsinbox_message] (

		[id]

	)

GO



ALTER TABLE [contact] ADD 

	 FOREIGN KEY 

	(

		[access_type]

	) REFERENCES [lookup_access_types] (

		[code]

	),

	 FOREIGN KEY 

	(

		[assistant]

	) REFERENCES [contact] (

		[contact_id]

	),

	 FOREIGN KEY 

	(

		[department]

	) REFERENCES [lookup_department] (

		[code]

	),

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[org_id]

	) REFERENCES [organization] (

		[org_id]

	),

	 FOREIGN KEY 

	(

		[owner]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[super]

	) REFERENCES [contact] (

		[contact_id]

	),

	 FOREIGN KEY 

	(

		[user_id]

	) REFERENCES [access] (

		[user_id]

	)

GO



ALTER TABLE [contact_address] ADD 

	 FOREIGN KEY 

	(

		[address_type]

	) REFERENCES [lookup_contactaddress_types] (

		[code]

	),

	 FOREIGN KEY 

	(

		[contact_id]

	) REFERENCES [contact] (

		[contact_id]

	),

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	)

GO



ALTER TABLE [contact_emailaddress] ADD 

	 FOREIGN KEY 

	(

		[contact_id]

	) REFERENCES [contact] (

		[contact_id]

	),

	 FOREIGN KEY 

	(

		[emailaddress_type]

	) REFERENCES [lookup_contactemail_types] (

		[code]

	),

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	)

GO



ALTER TABLE [contact_phone] ADD 

	 FOREIGN KEY 

	(

		[contact_id]

	) REFERENCES [contact] (

		[contact_id]

	),

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[phone_type]

	) REFERENCES [lookup_contactphone_types] (

		[code]

	)

GO



ALTER TABLE [contact_type_levels] ADD 

	 FOREIGN KEY 

	(

		[contact_id]

	) REFERENCES [contact] (

		[contact_id]

	),

	 FOREIGN KEY 

	(

		[type_id]

	) REFERENCES [lookup_contact_types] (

		[code]

	)

GO



ALTER TABLE [custom_field_category] ADD 

	 FOREIGN KEY 

	(

		[module_id]

	) REFERENCES [module_field_categorylink] (

		[category_id]

	)

GO



ALTER TABLE [custom_field_data] ADD 

	 FOREIGN KEY 

	(

		[field_id]

	) REFERENCES [custom_field_info] (

		[field_id]

	),

	 FOREIGN KEY 

	(

		[record_id]

	) REFERENCES [custom_field_record] (

		[record_id]

	)

GO



ALTER TABLE [custom_field_group] ADD 

	 FOREIGN KEY 

	(

		[category_id]

	) REFERENCES [custom_field_category] (

		[category_id]

	)

GO



ALTER TABLE [custom_field_info] ADD 

	 FOREIGN KEY 

	(

		[group_id]

	) REFERENCES [custom_field_group] (

		[group_id]

	)

GO



ALTER TABLE [custom_field_lookup] ADD 

	 FOREIGN KEY 

	(

		[field_id]

	) REFERENCES [custom_field_info] (

		[field_id]

	)

GO



ALTER TABLE [custom_field_record] ADD 

	 FOREIGN KEY 

	(

		[category_id]

	) REFERENCES [custom_field_category] (

		[category_id]

	),

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	)

GO



ALTER TABLE [excluded_recipient] ADD 

	 FOREIGN KEY 

	(

		[campaign_id]

	) REFERENCES [campaign] (

		[campaign_id]

	),

	 FOREIGN KEY 

	(

		[contact_id]

	) REFERENCES [contact] (

		[contact_id]

	)

GO



ALTER TABLE [help_business_rules] ADD 

	 FOREIGN KEY 

	(

		[completedby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[link_help_id]

	) REFERENCES [help_contents] (

		[help_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	)

GO



ALTER TABLE [help_contents] ADD 

	 FOREIGN KEY 

	(

		[category_id]

	) REFERENCES [permission_category] (

		[category_id]

	),

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[link_module_id]

	) REFERENCES [help_module] (

		[module_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[nextcontent]

	) REFERENCES [help_contents] (

		[help_id]

	),

	 FOREIGN KEY 

	(

		[prevcontent]

	) REFERENCES [help_contents] (

		[help_id]

	),

	 FOREIGN KEY 

	(

		[upcontent]

	) REFERENCES [help_contents] (

		[help_id]

	)

GO



ALTER TABLE [help_faqs] ADD 

	 FOREIGN KEY 

	(

		[completedby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[owning_module_id]

	) REFERENCES [help_module] (

		[module_id]

	)

GO



ALTER TABLE [help_features] ADD 

	 FOREIGN KEY 

	(

		[completedby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[link_help_id]

	) REFERENCES [help_contents] (

		[help_id]

	),

	 FOREIGN KEY 

	(

		[link_feature_id]

	) REFERENCES [lookup_help_features] (

		[code]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	)

GO



ALTER TABLE [help_module] ADD 

	 FOREIGN KEY 

	(

		[category_id]

	) REFERENCES [permission_category] (

		[category_id]

	)

GO



ALTER TABLE [help_notes] ADD 

	 FOREIGN KEY 

	(

		[completedby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[link_help_id]

	) REFERENCES [help_contents] (

		[help_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	)

GO



ALTER TABLE [help_related_links] ADD 

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[linkto_content_id]

	) REFERENCES [help_contents] (

		[help_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[owning_module_id]

	) REFERENCES [help_module] (

		[module_id]

	)

GO



ALTER TABLE [help_tableof_contents] ADD 

	 FOREIGN KEY 

	(

		[category_id]

	) REFERENCES [permission_category] (

		[category_id]

	),

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[firstchild]

	) REFERENCES [help_tableof_contents] (

		[content_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[nextsibling]

	) REFERENCES [help_tableof_contents] (

		[content_id]

	),

	 FOREIGN KEY 

	(

		[parent]

	) REFERENCES [help_tableof_contents] (

		[content_id]

	)

GO



ALTER TABLE [help_tableofcontentitem_links] ADD 

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[global_link_id]

	) REFERENCES [help_tableof_contents] (

		[content_id]

	),

	 FOREIGN KEY 

	(

		[linkto_content_id]

	) REFERENCES [help_contents] (

		[help_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	)

GO



ALTER TABLE [help_tips] ADD 

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[link_help_id]

	) REFERENCES [help_contents] (

		[help_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	)

GO



ALTER TABLE [lookup_contact_types] ADD 

	 FOREIGN KEY 

	(

		[user_id]

	) REFERENCES [access] (

		[user_id]

	)

GO



ALTER TABLE [lookup_lists_lookup] ADD 

	 FOREIGN KEY 

	(

		[module_id]

	) REFERENCES [permission_category] (

		[category_id]

	)

GO



ALTER TABLE [message] ADD 

	 FOREIGN KEY 

	(

		[access_type]

	) REFERENCES [lookup_access_types] (

		[code]

	),

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	)

GO



ALTER TABLE [message_template] ADD 

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	)

GO



ALTER TABLE [module_field_categorylink] ADD 

	 FOREIGN KEY 

	(

		[module_id]

	) REFERENCES [permission_category] (

		[category_id]

	)

GO



ALTER TABLE [news] ADD 

	 FOREIGN KEY 

	(

		[org_id]

	) REFERENCES [organization] (

		[org_id]

	)

GO



ALTER TABLE [opportunity_component] ADD 

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[opp_id]

	) REFERENCES [opportunity_header] (

		[opp_id]

	),

	 FOREIGN KEY 

	(

		[owner]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[stage]

	) REFERENCES [lookup_stage] (

		[code]

	)

GO



ALTER TABLE [opportunity_component_levels] ADD 

	 FOREIGN KEY 

	(

		[opp_id]

	) REFERENCES [opportunity_component] (

		[id]

	),

	 FOREIGN KEY 

	(

		[type_id]

	) REFERENCES [lookup_opportunity_types] (

		[code]

	)

GO



ALTER TABLE [opportunity_header] ADD 

	 FOREIGN KEY 

	(

		[acctlink]

	) REFERENCES [organization] (

		[org_id]

	),

	 FOREIGN KEY 

	(

		[contactlink]

	) REFERENCES [contact] (

		[contact_id]

	),

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	)

GO



ALTER TABLE [organization] ADD 

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[owner]

	) REFERENCES [access] (

		[user_id]

	)

GO



ALTER TABLE [organization_address] ADD 

	 FOREIGN KEY 

	(

		[address_type]

	) REFERENCES [lookup_orgaddress_types] (

		[code]

	),

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[org_id]

	) REFERENCES [organization] (

		[org_id]

	)

GO



ALTER TABLE [organization_emailaddress] ADD 

	 FOREIGN KEY 

	(

		[emailaddress_type]

	) REFERENCES [lookup_orgemail_types] (

		[code]

	),

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[org_id]

	) REFERENCES [organization] (

		[org_id]

	)

GO



ALTER TABLE [organization_phone] ADD 

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[org_id]

	) REFERENCES [organization] (

		[org_id]

	),

	 FOREIGN KEY 

	(

		[phone_type]

	) REFERENCES [lookup_orgphone_types] (

		[code]

	)

GO



ALTER TABLE [permission] ADD 

	 FOREIGN KEY 

	(

		[category_id]

	) REFERENCES [permission_category] (

		[category_id]

	)

GO



ALTER TABLE [process_log] ADD 

	 FOREIGN KEY 

	(

		[client_id]

	) REFERENCES [sync_client] (

		[client_id]

	),

	 FOREIGN KEY 

	(

		[system_id]

	) REFERENCES [sync_system] (

		[system_id]

	)

GO



ALTER TABLE [project_assignments] ADD 

	 FOREIGN KEY 

	(

		[activity_id]

	) REFERENCES [lookup_project_activity] (

		[code]

	),

	 FOREIGN KEY 

	(

		[actual_loetype]

	) REFERENCES [lookup_project_loe] (

		[code]

	),

	 FOREIGN KEY 

	(

		[assignedBy]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[enteredBy]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[estimated_loetype]

	) REFERENCES [lookup_project_loe] (

		[code]

	),

	 FOREIGN KEY 

	(

		[modifiedBy]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[priority_id]

	) REFERENCES [lookup_project_priority] (

		[code]

	),

	 FOREIGN KEY 

	(

		[project_id]

	) REFERENCES [projects] (

		[project_id]

	),

	 FOREIGN KEY 

	(

		[requirement_id]

	) REFERENCES [project_requirements] (

		[requirement_id]

	),

	 FOREIGN KEY 

	(

		[status_id]

	) REFERENCES [lookup_project_status] (

		[code]

	),

	 FOREIGN KEY 

	(

		[user_assign_id]

	) REFERENCES [access] (

		[user_id]

	)

GO



ALTER TABLE [project_assignments_status] ADD 

	 FOREIGN KEY 

	(

		[assignment_id]

	) REFERENCES [project_assignments] (

		[assignment_id]

	),

	 FOREIGN KEY 

	(

		[user_id]

	) REFERENCES [access] (

		[user_id]

	)

GO



ALTER TABLE [project_files] ADD 

	 FOREIGN KEY 

	(

		[enteredBy]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[folder_id]

	) REFERENCES [project_folders] (

		[folder_id]

	),

	 FOREIGN KEY 

	(

		[modifiedBy]

	) REFERENCES [access] (

		[user_id]

	)

GO



ALTER TABLE [project_files_download] ADD 

	 FOREIGN KEY 

	(

		[item_id]

	) REFERENCES [project_files] (

		[item_id]

	),

	 FOREIGN KEY 

	(

		[user_download_id]

	) REFERENCES [access] (

		[user_id]

	)

GO



ALTER TABLE [project_files_version] ADD 

	 FOREIGN KEY 

	(

		[enteredBy]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[item_id]

	) REFERENCES [project_files] (

		[item_id]

	),

	 FOREIGN KEY 

	(

		[modifiedBy]

	) REFERENCES [access] (

		[user_id]

	)

GO



ALTER TABLE [project_issue_replies] ADD 

	 FOREIGN KEY 

	(

		[enteredBy]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[issue_id]

	) REFERENCES [project_issues] (

		[issue_id]

	),

	 FOREIGN KEY 

	(

		[modifiedBy]

	) REFERENCES [access] (

		[user_id]

	)

GO



ALTER TABLE [project_issues] ADD 

	 FOREIGN KEY 

	(

		[enteredBy]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[modifiedBy]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[project_id]

	) REFERENCES [projects] (

		[project_id]

	),

	 FOREIGN KEY 

	(

		[type_id]

	) REFERENCES [lookup_project_issues] (

		[code]

	)

GO



ALTER TABLE [project_requirements] ADD 

	 FOREIGN KEY 

	(

		[actual_loetype]

	) REFERENCES [lookup_project_loe] (

		[code]

	),

	 FOREIGN KEY 

	(

		[approvedBy]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[closedBy]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[enteredBy]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[estimated_loetype]

	) REFERENCES [lookup_project_loe] (

		[code]

	),

	 FOREIGN KEY 

	(

		[modifiedBy]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[project_id]

	) REFERENCES [projects] (

		[project_id]

	)

GO



ALTER TABLE [project_team] ADD 

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[project_id]

	) REFERENCES [projects] (

		[project_id]

	),

	 FOREIGN KEY 

	(

		[user_id]

	) REFERENCES [access] (

		[user_id]

	)

GO



ALTER TABLE [projects] ADD 

	 FOREIGN KEY 

	(

		[department_id]

	) REFERENCES [lookup_department] (

		[code]

	),

	 FOREIGN KEY 

	(

		[enteredBy]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[modifiedBy]

	) REFERENCES [access] (

		[user_id]

	)

GO



ALTER TABLE [report] ADD 

	 FOREIGN KEY 

	(

		[category_id]

	) REFERENCES [permission_category] (

		[category_id]

	),

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[permission_id]

	) REFERENCES [permission] (

		[permission_id]

	)

GO



ALTER TABLE [report_criteria] ADD 

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[owner]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[report_id]

	) REFERENCES [report] (

		[report_id]

	)

GO



ALTER TABLE [report_criteria_parameter] ADD 

	 FOREIGN KEY 

	(

		[criteria_id]

	) REFERENCES [report_criteria] (

		[criteria_id]

	)

GO



ALTER TABLE [report_queue] ADD 

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[report_id]

	) REFERENCES [report] (

		[report_id]

	)

GO



ALTER TABLE [report_queue_criteria] ADD 

	 FOREIGN KEY 

	(

		[queue_id]

	) REFERENCES [report_queue] (

		[queue_id]

	)

GO



ALTER TABLE [revenue] ADD 

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[org_id]

	) REFERENCES [organization] (

		[org_id]

	),

	 FOREIGN KEY 

	(

		[owner]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[type]

	) REFERENCES [lookup_revenue_types] (

		[code]

	)

GO



ALTER TABLE [revenue_detail] ADD 

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[owner]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[revenue_id]

	) REFERENCES [revenue] (

		[id]

	),

	 FOREIGN KEY 

	(

		[type]

	) REFERENCES [lookup_revenue_types] (

		[code]

	)

GO



ALTER TABLE [role] ADD 

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	)

GO



ALTER TABLE [role_permission] ADD 

	 FOREIGN KEY 

	(

		[permission_id]

	) REFERENCES [permission] (

		[permission_id]

	),

	 FOREIGN KEY 

	(

		[role_id]

	) REFERENCES [role] (

		[role_id]

	)

GO



ALTER TABLE [saved_criteriaelement] ADD 

	 FOREIGN KEY 

	(

		[field]

	) REFERENCES [search_fields] (

		[id]

	),

	 FOREIGN KEY 

	(

		[operatorid]

	) REFERENCES [field_types] (

		[id]

	),

	 FOREIGN KEY 

	(

		[id]

	) REFERENCES [saved_criterialist] (

		[id]

	)

GO



ALTER TABLE [saved_criterialist] ADD 

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[owner]

	) REFERENCES [access] (

		[user_id]

	)

GO



ALTER TABLE [scheduled_recipient] ADD 

	 FOREIGN KEY 

	(

		[campaign_id]

	) REFERENCES [campaign] (

		[campaign_id]

	),

	 FOREIGN KEY 

	(

		[contact_id]

	) REFERENCES [contact] (

		[contact_id]

	)

GO



ALTER TABLE [survey] ADD 

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	)

GO



ALTER TABLE [survey_items] ADD 

	 FOREIGN KEY 

	(

		[question_id]

	) REFERENCES [survey_questions] (

		[question_id]

	)

GO



ALTER TABLE [survey_questions] ADD 

	 FOREIGN KEY 

	(

		[survey_id]

	) REFERENCES [survey] (

		[survey_id]

	),

	 FOREIGN KEY 

	(

		[type]

	) REFERENCES [lookup_survey_types] (

		[code]

	)

GO



ALTER TABLE [sync_conflict_log] ADD 

	 FOREIGN KEY 

	(

		[client_id]

	) REFERENCES [sync_client] (

		[client_id]

	),

	 FOREIGN KEY 

	(

		[table_id]

	) REFERENCES [sync_table] (

		[table_id]

	)

GO



ALTER TABLE [sync_log] ADD 

	 FOREIGN KEY 

	(

		[client_id]

	) REFERENCES [sync_client] (

		[client_id]

	),

	 FOREIGN KEY 

	(

		[system_id]

	) REFERENCES [sync_system] (

		[system_id]

	)

GO



ALTER TABLE [sync_map] ADD 

	 FOREIGN KEY 

	(

		[client_id]

	) REFERENCES [sync_client] (

		[client_id]

	),

	 FOREIGN KEY 

	(

		[table_id]

	) REFERENCES [sync_table] (

		[table_id]

	)

GO



ALTER TABLE [sync_table] ADD 

	 FOREIGN KEY 

	(

		[system_id]

	) REFERENCES [sync_system] (

		[system_id]

	)

GO



ALTER TABLE [sync_transaction_log] ADD 

	 FOREIGN KEY 

	(

		[log_id]

	) REFERENCES [sync_log] (

		[log_id]

	)

GO



ALTER TABLE [task] ADD 

	 FOREIGN KEY 

	(

		[category_id]

	) REFERENCES [lookup_task_category] (

		[code]

	),

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[estimatedloetype]

	) REFERENCES [lookup_task_loe] (

		[code]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[owner]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[priority]

	) REFERENCES [lookup_task_priority] (

		[code]

	)

GO



ALTER TABLE [taskcategory_project] ADD 

	 FOREIGN KEY 

	(

		[category_id]

	) REFERENCES [lookup_task_category] (

		[code]

	),

	 FOREIGN KEY 

	(

		[project_id]

	) REFERENCES [projects] (

		[project_id]

	)

GO



ALTER TABLE [tasklink_contact] ADD 

	 FOREIGN KEY 

	(

		[contact_id]

	) REFERENCES [contact] (

		[contact_id]

	),

	 FOREIGN KEY 

	(

		[task_id]

	) REFERENCES [task] (

		[task_id]

	)

GO



ALTER TABLE [tasklink_project] ADD 

	 FOREIGN KEY 

	(

		[project_id]

	) REFERENCES [projects] (

		[project_id]

	),

	 FOREIGN KEY 

	(

		[task_id]

	) REFERENCES [task] (

		[task_id]

	)

GO



ALTER TABLE [tasklink_ticket] ADD 

	 FOREIGN KEY 

	(

		[task_id]

	) REFERENCES [task] (

		[task_id]

	),

	 FOREIGN KEY 

	(

		[ticket_id]

	) REFERENCES [ticket] (

		[ticketid]

	)

GO



ALTER TABLE [ticket] ADD 

	 FOREIGN KEY 

	(

		[assigned_to]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[contact_id]

	) REFERENCES [contact] (

		[contact_id]

	),

	 FOREIGN KEY 

	(

		[department_code]

	) REFERENCES [lookup_department] (

		[code]

	),

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[level_code]

	) REFERENCES [ticket_level] (

		[code]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[org_id]

	) REFERENCES [organization] (

		[org_id]

	),

	 FOREIGN KEY 

	(

		[pri_code]

	) REFERENCES [ticket_priority] (

		[code]

	),

	 FOREIGN KEY 

	(

		[scode]

	) REFERENCES [ticket_severity] (

		[code]

	),

	 FOREIGN KEY 

	(

		[source_code]

	) REFERENCES [lookup_ticketsource] (

		[code]

	)

GO



ALTER TABLE [ticketlog] ADD 

	 FOREIGN KEY 

	(

		[assigned_to]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[department_code]

	) REFERENCES [lookup_department] (

		[code]

	),

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[pri_code]

	) REFERENCES [ticket_priority] (

		[code]

	),

	 FOREIGN KEY 

	(

		[scode]

	) REFERENCES [ticket_severity] (

		[code]

	),

	 FOREIGN KEY 

	(

		[ticketid]

	) REFERENCES [ticket] (

		[ticketid]

	)

GO



ALTER TABLE [viewpoint] ADD 

	 FOREIGN KEY 

	(

		[enteredby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[modifiedby]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[user_id]

	) REFERENCES [access] (

		[user_id]

	),

	 FOREIGN KEY 

	(

		[vp_user_id]

	) REFERENCES [access] (

		[user_id]

	)

GO



ALTER TABLE [viewpoint_permission] ADD 

	 FOREIGN KEY 

	(

		[permission_id]

	) REFERENCES [permission] (

		[permission_id]

	),

	 FOREIGN KEY 

	(

		[viewpoint_id]

	) REFERENCES [viewpoint] (

		[viewpoint_id]

	)

GO



-- Insert default events

-- Insert default access

-- Insert default lookup_industry

-- Insert default lookup_contact_types

-- Insert default lookup_account_types

-- Insert default state

-- Insert default lookup_department

-- Insert default lookup_orgaddress_types

-- Insert default lookup_orgemail_types

-- Insert default lookup_orgphone_types

-- Insert default lookup_contactaddress_types

-- Insert default lookup_contactemail_types

-- Insert default lookup_contactphone_types

-- Insert default lookup_access_types

-- Insert default organization

-- Insert default role

-- Insert default permission_category

-- Insert default permission

-- Insert default role_permission

-- Insert default lookup_stage

-- Insert default lookup_delivery_options

-- Insert default lookup_lists_lookup

-- Insert default report

-- Insert default database_version

-- Insert default lookup_call_types

-- Insert default lookup_opportunity_types

-- Insert default ticket_level

-- Insert default ticket_severity

-- Insert default lookup_ticketsource

-- Insert default ticket_priority

-- Insert default ticket_category

-- Insert default module_field_categorylink

-- Insert default lookup_project_activity

-- Insert default lookup_project_priority

-- Insert default lookup_project_issues

-- Insert default lookup_project_status

-- Insert default lookup_project_loe

-- Insert default lookup_survey_types

-- Insert default field_types

-- Insert default search_fields

-- Insert default help_module

-- Insert default help_contents

-- Insert default help_tableof_contents

-- Insert default help_tableofcontentitem_links

-- Insert default help_features

-- Insert default help_business_rules

-- Insert default help_tips

-- Insert default sync_system

-- Insert default sync_table

-- Insert default autoguide_options

-- Insert default autoguide_ad_run_types

-- Insert default lookup_revenue_types

-- Insert default lookup_task_priority

-- Insert default lookup_task_loe

-- Insert default business_process_component_library

-- Insert default business_process_component_result_lookup

-- Insert default business_process_parameter_library

-- Insert default business_process

-- Insert default business_process_component

-- Insert default business_process_component_parameter

-- Insert default business_process_hook_library

-- Insert default business_process_hook_triggers

-- Insert default business_process_hook





