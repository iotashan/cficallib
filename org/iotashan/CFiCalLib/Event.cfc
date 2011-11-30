<cfcomponent hint="I am a VEVENT iCal Component" extends="iCalComponent" output="false">
	<!--- identifying fields --->
	<cfproperty name="uid" type="string" required="yes" hint="Unique ID of this event" />
	<cfproperty name="dtstamp" type="date" required="yes" hint="The timestamp when this was modified/created" />
	<cfproperty name="created" type="date" required="no" hint="The timestamp when this was created" />
	<cfproperty name="lastModified" type="date" required="no" hint="The timestamp when this was modified" />
	<cfproperty name="sequence" type="number" required="no" hint="Number of revisions, starting with 0" />
	<!--- time fields --->
	<cfproperty name="dtstart" type="date" required="no" hint="The timestamp when this starts" />
	<cfproperty name="dtend" type="date" required="no" hint="The timestamp when this ends. Cannot be used in combination with duration." />
	<cfproperty name="duration" type="string" required="no" hint="Duration of this component. Cannot be used in combination with dtend. Build using createDuration()" />
	<cfproperty name="transp" type="string" required="no" hint="This property defines whether or not this is transparent to busy time searches. (TRANSPARENT|OPAQUE)" />
	<cfproperty name="allDayEvent" type="boolean" required="no" hint="Indicates an all-day event" />
	<!--- recurring fields --->
	<cfproperty name="rdate" type="string" required="no" hint="This property defines the list of DATE-TIME values for recurring components. You must provide the entire RDATE line. See http://tools.ietf.org/html/rfc5545##section-3.8.5.2" />
	<cfproperty name="rrule" type="string" required="no" hint="This property defines a rule or repeating pattern for recurring components. You must provide the entire RRULE line. See http://tools.ietf.org/html/rfc5545##section-3.8.5.3" />
	<cfproperty name="exdate" type="string" required="no" hint="This property defines the list of DATE-TIME exceptions for recurring components. You must provide the entire EXDATE line. See http://tools.ietf.org/html/rfc5545##section-3.8.5.1" />
	<!--- informational fields --->
	<cfproperty name="url" type="string" required="no" hint="URL" />
	<cfproperty name="summary" type="string" required="no" hint="short summary of this component" />
	<cfproperty name="description" type="string" required="no" hint="description of this component" />
	<cfproperty name="location" type="string" required="no" hint="Name of the place this takes place." />
	<cfproperty name="categories" type="array" required="no" hint="Array of categories" />
	<cfproperty name="resources" type="array" required="no" hint="An array of resorces (string)" />
	<cfproperty name="comments" type="array" required="no" hint="An array of comments (string)" />
	<cfproperty name="priority" type="numeric" required="no" hint="Priority 0 (unspecified) to 1 (highest priority) to 9 (lowest priority)" />
	<!--- alarms --->
	<cfproperty name="alarms" type="array" required="no" hint="An array of Alarm objects">
	
	<cffunction name="init" returntype="iCalComponent">
		<cfset THIS.allDayEvent = false />
		
		<cfreturn super.init("VEVENT") />
	</cffunction>
	
	<!--- getters/setters --->
	<cffunction name="setuid">
		<cfargument name="uid" type="string" />
		
		<cfset THIS.uid = ARGUMENTS.uid />
	</cffunction>
	
	<cffunction name="getuid">
		<cfreturn THIS.uid />
	</cffunction>
	
	<cffunction name="setdtstamp">
		<cfargument name="dtstamp" type="date" />
		
		<cfset THIS.dtstamp = ARGUMENTS.dtstamp />
	</cffunction>
	
	<cffunction name="getdtstamp">
		<cfreturn THIS.dtstamp />
	</cffunction>
	
	<cffunction name="setcreated">
		<cfargument name="created" type="date" />
		
		<cfset THIS.created = ARGUMENTS.created />
	</cffunction>
	
	<cffunction name="getcreated">
		<cfreturn THIS.created />
	</cffunction>

	<cffunction name="setlastModified">
		<cfargument name="lastModified" type="date" />
	
		<cfset THIS.lastModified = ARGUMENTS.lastModified />
	</cffunction>

	<cffunction name="getlastModified">
		<cfreturn THIS.lastModified />
	</cffunction>

	<cffunction name="setsequence">
		<cfargument name="sequence" type="numeric" />
	
		<cfset THIS.sequence = ARGUMENTS.sequence />
	</cffunction>

	<cffunction name="getsequence">
		<cfreturn THIS.sequence />
	</cffunction>

	<cffunction name="setdtstart">
		<cfargument name="dtstart" type="date" />
	
		<cfset THIS.dtstart = ARGUMENTS.dtstart />
	</cffunction>

	<cffunction name="getdtstart">
		<cfreturn THIS.dtstart />
	</cffunction>

	<cffunction name="setdtend">
		<cfargument name="dtend" type="date" />
	
		<cfset THIS.dtend = ARGUMENTS.dtend />
	</cffunction>

	<cffunction name="getdtend">
		<cfreturn THIS.dtend />
	</cffunction>

	<cffunction name="setduration">
		<cfargument name="duration" type="string" />
	
		<cfset THIS.duration = ARGUMENTS.duration />
	</cffunction>

	<cffunction name="getduration">
		<cfreturn THIS.duration />
	</cffunction>

	<cffunction name="settransp">
		<cfargument name="transp" type="string" />
	
		<cfset THIS.transp = ARGUMENTS.transp />
	</cffunction>

	<cffunction name="gettransp">
		<cfreturn THIS.transp />
	</cffunction>

	<cffunction name="setallDayEvent">
		<cfargument name="allDayEvent" type="boolean" />
	
		<cfset THIS.allDayEvent = ARGUMENTS.allDayEvent />
	</cffunction>

	<cffunction name="getallDayEvent">
		<cfreturn THIS.allDayEvent />
	</cffunction>

	<cffunction name="setexdate">
		<cfargument name="exdate" type="array" />
	
		<cfset THIS.exdate = ARGUMENTS.exdate />
	</cffunction>

	<cffunction name="getexdate">
		<cfreturn THIS.exdate />
	</cffunction>

	<cffunction name="setrdate">
		<cfargument name="rdate" type="array" />
	
		<cfset THIS.rdate = ARGUMENTS.rdate />
	</cffunction>

	<cffunction name="getrdate">
		<cfreturn THIS.rdate />
	</cffunction>

	<cffunction name="setrrule">
		<cfargument name="rrule" type="string" />
	
		<cfset THIS.rrule = ARGUMENTS.rrule />
	</cffunction>

	<cffunction name="getrrule">
		<cfreturn THIS.rrule />
	</cffunction>

	<cffunction name="seturl">
		<cfargument name="url" type="string" />
	
		<cfset THIS.url = ARGUMENTS.url />
	</cffunction>

	<cffunction name="geturl">
		<cfreturn THIS.url />
	</cffunction>

	<cffunction name="setsummary">
		<cfargument name="summary" type="string" />
	
		<cfset THIS.summary = ARGUMENTS.summary />
	</cffunction>

	<cffunction name="getsummary">
		<cfreturn THIS.summary />
	</cffunction>

	<cffunction name="setdescription">
		<cfargument name="description" type="string" />
	
		<cfset THIS.description = ARGUMENTS.description />
	</cffunction>

	<cffunction name="getdescription">
		<cfreturn THIS.description />
	</cffunction>

	<cffunction name="setlocation">
		<cfargument name="location" type="string" />
	
		<cfset THIS.location = ARGUMENTS.location />
	</cffunction>

	<cffunction name="getlocation">
		<cfreturn THIS.location />
	</cffunction>

	<cffunction name="setcategories">
		<cfargument name="categories" type="array" />
	
		<cfset THIS.categories = ARGUMENTS.categories />
	</cffunction>

	<cffunction name="getcategories">
		<cfreturn THIS.categories />
	</cffunction>

	<cffunction name="setresources">
		<cfargument name="resources" type="array" />
	
		<cfset THIS.resources = ARGUMENTS.resources />
	</cffunction>

	<cffunction name="getresources">
		<cfreturn THIS.resources />
	</cffunction>

	<cffunction name="setcomments">
		<cfargument name="comments" type="array" />
	
		<cfset THIS.comments = ARGUMENTS.comments />
	</cffunction>

	<cffunction name="getcomments">
		<cfreturn THIS.comments />
	</cffunction>

	<cffunction name="setpriority">
		<cfargument name="priority" type="number" />
	
		<cfset THIS.priority = ARGUMENTS.priority />
	</cffunction>

	<cffunction name="getpriority">
		<cfreturn THIS.priority />
	</cffunction>

	<cffunction name="setalarms">
		<cfargument name="alarms" type="array" />
	
		<cfset THIS.alarms = ARGUMENTS.alarms />
	</cffunction>

	<cffunction name="getalarms">
		<cfreturn THIS.alarms />
	</cffunction>
	
	<!--- build functions --->
	<cffunction name="buildcomponent" returntype="string">
		<cfset ret = "" />
		
		<!--- required fields --->
		<cfset ret = ret & "UID:" & THIS.uid & crlf />
		<cfset ret = ret & "DTSTAMP#tzidParam()#:" & icalDateTimeFormat(THIS.dtstamp,THIS.tzid,THIS.isUTC) & crlf />
		<!--- optional fields --->
		<cfif isDefined("THIS.created")>
			<cfset ret = ret & "CREATED#tzidParam()#:" & icalDateTimeFormat(THIS.created,THIS.tzid,THIS.isUTC) & crlf />
		</cfif>
		<cfif isDefined("THIS.lastModified")>
			<cfset ret = ret & "LAST-MODIFIED#tzidParam()#:" & icalDateTimeFormat(THIS.lastModified,THIS.tzid,THIS.isUTC) & crlf />
		</cfif>
		<cfif isDefined("THIS.sequence")>
			<cfset ret = ret & "SEQUENCE:" & THIS.sequence & crlf />
		</cfif>
		<cfif isDefined("THIS.dtstart")>
			<cfif THIS.allDayEvent>
				<cfset ret = ret & "DTSTART;VALUE=DATE:" & icalDateFormat(THIS.dtstart,THIS.tzid,THIS.isUTC) & crlf />
			<cfelse>
				<cfset ret = ret & "DTSTART#tzidParam()#:" & icalDateTimeFormat(THIS.dtstart,THIS.tzid,THIS.isUTC) & crlf />
			</cfif>
		</cfif>
		<cfif isDefined("THIS.dtend")>
			<cfif THIS.allDayEvent>
				<cfset ret = ret & "DTEND;VALUE=DATE:" & icalDateFormat(THIS.dtend,THIS.tzid,THIS.isUTC) & crlf />
			<cfelse>
				<cfset ret = ret & "DTEND#tzidParam()#:" & icalDateTimeFormat(THIS.dtend,THIS.tzid,THIS.isUTC) & crlf />
			</cfif>
		</cfif>
		<cfif isDefined("THIS.duration")>
			<cfset ret = ret & "DURATION:" & THIS.duration & crlf />
		</cfif>
		<cfif isDefined("THIS.transp")>
			<cfset ret = ret & "TRANSP:" & icalBoolean(THIS.transp) & crlf />
		</cfif>
		<cfif isDefined("THIS.exdate")>
			<cfset ret = ret & THIS.exdate & crlf />
		</cfif>
		<cfif isDefined("THIS.rdate")>
			<cfset ret = ret & THIS.rdate & crlf />
		</cfif>
		<cfif isDefined("THIS.rrule")>
			<cfset ret = ret & THIS.rrule & crlf />
		</cfif>
		<cfif isDefined("THIS.url")>
			<cfset ret = ret & "URL:" & THIS.url & crlf />
		</cfif>
		<cfif isDefined("THIS.summary")>
			<cfset ret = ret & "SUMMARY:" & icalSafeString(THIS.summary) & crlf />
		</cfif>
		<cfif isDefined("THIS.description")>
			<cfset ret = ret & "DESCRIPTION:" & icalSafeString(THIS.description) & crlf />
		</cfif>
		<cfif isDefined("THIS.location")>
			<cfset ret = ret & "LOCATION:" & icalSafeString(THIS.location) & crlf />
		</cfif>
		<cfif isDefined("THIS.priority")>
			<cfset ret = ret & "PRIORITY:" & THIS.priority & crlf />
		</cfif>
		<!--- lists --->
		<cfif isDefined("THIS.categories") AND arrayLen(THIS.categories)>
			<cfset thisLine = "CATEGORIES:" />
			<cfloop from="1" to="#arrayLen(THIS.categories)#" index="i">
				<cfif i GT 1>
					<cfset thisLine = thisLine & ", " />
				</cfif>
				<cfset thisLine = thisLine & icalSafeString(THIS.categories[i]) />
			</cfloop>
			<cfset ret = ret & thisLine & crlf />
		</cfif>
		<cfif isDefined("THIS.resources") AND arrayLen(THIS.resources)>
			<cfset thisLine = "RESOURCES:" />
			<cfloop from="1" to="#arrayLen(THIS.resources)#" index="i">
				<cfif i GT 1>
					<cfset thisLine = thisLine & ", " />
				</cfif>
				<cfset thisLine = thisLine & icalSafeString(THIS.resources[i]) />
			</cfloop>
			<cfset ret = ret & thisLine & crlf />
		</cfif>
		<cfif isDefined("THIS.comments") AND arrayLen(THIS.comments)>
			<cfset thisLine = "COMMENTS:" />
			<cfloop from="1" to="#arrayLen(THIS.comments)#" index="i">
				<cfif i GT 1>
					<cfset thisLine = thisLine & ", " />
				</cfif>
				<cfset thisLine = thisLine & icalSafeString(THIS.comments[i]) />
			</cfloop>
			<cfset ret = ret & thisLine & crlf />
		</cfif>
		<!--- alarms --->
		<cfif isDefined("THIS.alarms") AND arrayLen(THIS.alarms)>
			<cfloop from="1" to="#arrayLen(THIS.alarms)#" index="i">
				<cfset ret = ret & THIS.alarms[i].buildcomponent() />
			</cfloop>
		</cfif>
		
		<cfreturn SUPER.buildComponent(ret) />
	</cffunction>
	
</cfcomponent>