<cfcomponent hint="I am a VALARM iCal Component" extends="iCalComponent" output="false">
	<!--- time fields --->
	<cfproperty name="trigger" type="string" required="yes" hint="Timespan when the alarm will be triggered, relative to dtstart" />
	<cfproperty name="repeat" type="number" required="no" hint="Number of times the alarm should be repeated, after the initial trigger." />
	<cfproperty name="duration" type="string" required="no" hint="Duration of this component. Cannot be used in combination with dtend. Build using createDuration()" />
	<!--- informational fields --->
	<cfproperty name="action" type="string" required="yes" hint="Action for this alarm. (AUDIO|DISPLAY|EMAIL)" />
	<cfproperty name="summary" type="string" required="no" hint="short summary of this component" />
	<cfproperty name="description" type="string" required="no" hint="description of this component" />
	
	<cffunction name="init" returntype="iCalComponent">
		<cfreturn super.init("VALARM") />
	</cffunction>
	
	<!--- getters/setters --->
	<cffunction name="settrigger">
		<cfargument name="trigger" type="string" />
	
		<cfset THIS.trigger = ARGUMENTS.trigger />
	</cffunction>

	<cffunction name="gettrigger">
		<cfreturn THIS.trigger />
	</cffunction>

	<cffunction name="setrepeat">
		<cfargument name="repeat" type="numeric" />
	
		<cfset THIS.repeat = ARGUMENTS.repeat />
	</cffunction>

	<cffunction name="getrepeat">
		<cfreturn THIS.repeat />
	</cffunction>

	<cffunction name="setduration">
		<cfargument name="duration" type="string" />
	
		<cfset THIS.duration = ARGUMENTS.duration />
	</cffunction>

	<cffunction name="getduration">
		<cfreturn THIS.duration />
	</cffunction>

	<cffunction name="setaction">
		<cfargument name="action" type="string" />
	
		<cfset THIS.action = ARGUMENTS.action />
	</cffunction>

	<cffunction name="getaction">
		<cfreturn THIS.action />
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
	
	<!--- build functions --->
	<cffunction name="buildcomponent" returntype="string">
		<cfset ret = "" />
		
		<!--- required fields --->
		<cfif isDefined("THIS.trigger")>
			<cfset ret = ret & "TRIGGER:" & THIS.trigger & crlf />
		</cfif>
		<cfif isDefined("THIS.action")>
			<cfset ret = ret & "ACTION:" & THIS.action & crlf />
		</cfif>
		<!--- optional fields --->
		<cfif isDefined("THIS.repeat")>
			<cfset ret = ret & "REPEAT:" & THIS.repeat & crlf />
		</cfif>
		<cfif isDefined("THIS.duration")>
			<cfset ret = ret & "DURATION:" & THIS.duration & crlf />
		</cfif>
		<cfif isDefined("THIS.summary")>
			<cfset ret = ret & "SUMMARY:" & icalSafeString(THIS.summary) & crlf />
		</cfif>
		<cfif isDefined("THIS.description")>
			<cfset ret = ret & "DESCRIPTION:" & icalSafeString(THIS.description) & crlf />
		</cfif>
		
		<cfreturn SUPER.buildComponent(ret) />
	</cffunction>
	
</cfcomponent>