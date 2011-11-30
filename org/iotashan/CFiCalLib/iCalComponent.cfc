<cfcomponent hint="I am an iCal component" output="false">
	<cfproperty name="type" type="string" hint="Component Type (VEVENT|VTODO|VALARM)" />
	<cfproperty name="tzid" type="string" required="no" default="" hint="I am the timzeone ID, e.g. America/New_York. Cannot be used with UTC times." />
	<cfproperty name="isUTC" type="boolean" required="no" default="false" hint="Is this UTC time? Cannot be used with tzid." />

	<cfset crlf = chr(13) & chr(10) />
	
	<cffunction name="init" returntype="iCalComponent">
		<cfargument name="type">
		
		<cfset THIS.type = ARGUMENTS.type />
		<cfset THIS.tzid = "" />
		<cfset THIS.isUTC = false />
		
		<cfreturn this />
	</cffunction>

	<!--- getter/setter functions --->
	<cffunction name="settzid">
		<cfargument name="tzid" type="string" />

		<cfset THIS.tzid = ARGUMENTS.tzid />
	</cffunction>

	<cffunction name="gettzid">
		<cfreturn THIS.tzid />
	</cffunction>

	<cffunction name="setisUTC">
		<cfargument name="isUTC" type="boolean" />

		<cfset THIS.isUTC = ARGUMENTS.isUTC />
	</cffunction>

	<cffunction name="getisUTC">
		<cfreturn THIS.isUTC />
	</cffunction>
	
	<!--- build functions --->
	<cffunction name="buildcomponent" returntype="string">
		<cfargument name="innerContent" />
		
		<cfset ret = "" />
		
		<cfset ret = ret & "BEGIN:" & THIS.type & crlf />
		<cfset ret = ret & innerContent /> <!--- innerContent already has a crlf at the end --->
		<cfset ret = ret & "END:" & THIS.type & crlf />
		
		<cfreturn ret />
	</cffunction>
	
	<!--- utility functions --->
	<cffunction name="createDuration" returntype="string" hint="I create iCal formatted durations">
		<cfargument name="weeks" type="numeric" default="0" />
		<cfargument name="days" type="numeric" default="0" />
		<cfargument name="hours" type="numeric" default="0" />
		<cfargument name="minutes" type="numeric" default="0" />
		<cfargument name="seconds" type="numeric" default="0" />
		<cfargument name="negative" type="boolean" default="false" hint="Negative durations are generally only used for alarms." />
		
		<cfset ret = "P" />
		
		<cfif ARGUMENTS.negative>
			<cfset ret = "-" & ret />
		</cfif>
		
		<cfif ARGUMENTS.weeks>
			<cfset ret = ret & "#weeks#W" />
		</cfif>
		<cfif ARGUMENTS.days>
			<cfset ret = ret & "#days#D" />
		</cfif>
		<cfif ARGUMENTS.hours OR ARGUMENTS.minutes OR ARGUMENTS.seconds>
			<cfset ret = ret & "T" />
		</cfif>
		<cfif ARGUMENTS.hours>
			<cfset ret = ret & "#hours#H" />
		</cfif>
		<cfif ARGUMENTS.minutes>
			<cfset ret = ret & "#minutes#M" />
		</cfif>
		<cfif ARGUMENTS.seconds>
			<cfset ret = ret & "#seconds#S" />
		</cfif>
		
		<cfreturn ret />
	</cffunction>
	
	<cffunction name="icalBoolean" returntype="string">
		<cfargument name="bol" type="boolean"/>
		
		<cfif ARGUMENTS.bol>
			<cfreturn "TRUE" />
		<cfelse>
			<cfreturn "FALSE" />
		</cfif>
	</cffunction>
	
	<cffunction name="tzidParam" returntype="string" hint="I return a parameterized tzid if needed">
		<cfset ret = "" />
		
		<cfif len(THIS.tzid)>
			<cfset ret = ";TZID=#THIS.tzid#" />
		</cfif>
		
		<cfreturn ret />
	</cffunction>
	
	<cffunction name="icalDateFormat" returntype="string" hint="I format dates for iCal components">
		<cfargument name="date" type="date" />
		
		<cfreturn dateFormat(ARGUMENTS.date,"yyyymmdd") />
	</cffunction>
	
	<cffunction name="icalTimeFormat" returntype="string" hint="I format dates for iCal components">
		<cfargument name="time" type="date" />
		
		<cfset ret = "" />
		
		<cfset ret = ret & timeFormat(ARGUMENTS.datetime,"HHmmss") />
		<cfif THIS.isUTC>
			<cfset ret = ret & "Z" />
		</cfif>
		
		<cfreturn ret />
	</cffunction>
	
	<cffunction name="icalDateTimeFormat" returntype="string" hint="I format dates for iCal components. Leave out tzid and isUTC for local timezones.">
		<cfargument name="datetime" type="date" />
		
		<cfset ret = "" />
		
		<cfset ret = ret & dateFormat(ARGUMENTS.datetime,"yyyymmdd") & "T" & timeFormat(ARGUMENTS.datetime,"HHmmss") />
		<cfif THIS.isUTC>
			<cfset ret = ret & "Z" />
		</cfif>
		
		<cfreturn ret />
	</cffunction>
	
	<cffunction name="icalSafeString" returntype="string" hint="I format strings">
		<cfargument name="str" type="string" />
		
		<cfset ret = replace(ARGUMENTS.str,"\","\\","ALL") />
		<cfset ret = replace(ret,";","\;","ALL") />
		<cfset ret = replace(ret,",","\,","ALL") />
		<cfset ret = replace(ret,"#chr(10)##chr(13)#","\n","ALL") />
		
		<cfreturn ret />
	</cffunction>
</cfcomponent>