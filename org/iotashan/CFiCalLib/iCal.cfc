<cfcomponent hint="I help you create iCal files. See http://tools.ietf.org/html/rfc5545" output="false">
	<cfproperty name="version" type="string" hint="iCalendar format version" />
	<cfproperty name="prodID" type="string" hint="Your Product ID and language" />
	<!--- components --->
	<cfproperty name="components" type="array" required="yes" hint="An array of iCalComponents">
	
	<cfset crlf = chr(13) & chr(10) />
	<cfset lineLimit = 50 />
	
	<cffunction name="init" hint="Let's get it started">
		<cfargument name="version" type="string" default="2.0">
		<cfargument name="prodID" type="string" default="-//my company//my product v1.0//EN">
		
		<cfif isDefined("ARGUMENTS.version")>
			<cfset THIS.version = ARGUMENTS.version />
		</cfif>
		<cfif isDefined("ARGUMENTS.prodID")>
			<cfset THIS.prodID = ARGUMENTS.prodID />
		</cfif>
		
		<cfreturn THIS />
	</cffunction>
	
	<!--- getter/setter functions --->
	<cffunction name="setversion">
		<cfargument name="version" type="string" />
	
		<cfset THIS.version = ARGUMENTS.version />
	</cffunction>

	<cffunction name="getversion">
		<cfreturn THIS.version />
	</cffunction>

	<cffunction name="setprodID">
		<cfargument name="prodID" type="string" />
	
		<cfset THIS.prodID = ARGUMENTS.prodID />
	</cffunction>

	<cffunction name="getprodID">
		<cfreturn THIS.prodID />
	</cffunction>

	<cffunction name="setcomponents">
		<cfargument name="components" type="array" />
	
		<cfset THIS.components = ARGUMENTS.components />
	</cffunction>

	<cffunction name="getcomponents">
		<cfreturn THIS.components />
	</cffunction>
	
	<!--- build --->
	<cffunction name="build" returntype="string" hint="I return the actual text for an iCalendar (ics) file">
		<cfset ret = "BEGIN:VCALENDAR" & crlf />

		<cfset ret = ret & "PRODID:" & THIS.prodID & crlf />
		<cfset ret = ret & "VERSION:" & THIS.version & crlf />
		
		<cfloop array="#THIS.components#" index="thisComponent">
			<cfset ret = ret & thisComponent.buildcomponent() />
		</cfloop>
		
		<cfset ret = ret & "END:VCALENDAR" />
		
		<cfreturn foldLongLines(ret) />
	</cffunction>
	
	<!--- utility functions --->
	<cffunction name="foldLongLines" hint="I take a bunch of lines, and fold any of them that are too long.">
		<cfargument name="str"/>
		
		<cfset ret = "" />
		
		<cfloop list="#str#" delimiters="#crlf#" index="thisLine">
			<cfif len(thisLine) GT lineLimit>
				<cfloop from="1" to="#len(thisLine)#" step="#lineLimit#" index="i">
					<cfif i EQ 1>
						<cfset tempLine = "" />
					<cfelse>
						<!--- this is a folded line, start it with a whitespace character --->
						<cfset tempLine = " " />
					</cfif>
					
					<cfset tempLine = templine & mid(thisLine,i,lineLimit) />
					
					<cfset ret = ret & tempLine & crlf />
				</cfloop>
			<cfelse>
				<cfset ret = ret & thisLine & crlf />
			</cfif>
		</cfloop>
		
		<cfreturn ret />
	</cffunction>
</cfcomponent>