<cfscript>
	myEvent = createObject("component","org.iotashan.CFiCalLib.ToDo").init();
	myEvent.settzid("America/Chicago");
	myEvent.setuid(createUUID());
	myEvent.setdtstamp(now());
	myEvent.setsequence(0);
	myEvent.setdue(dateAdd("d",13,now()));
	myEvent.seturl("http://www.pintley.com/");
	myEvent.setsummary("Don't forget to try a beer from my recommendations page");
	writeDump(myEvent);
	
	thisICS = createObject("component","org.iotashan.CFiCalLib.iCal").init(prodid="-//iotashan//iotashan.com v1.0//EN");
	aEvents = arrayNew(1);
	arrayAppend(aEvents,myEvent);
	thisICS.setcomponents(aEvents);
	fileOutput = thisICS.build();
</cfscript>

<cfif isDefined("URL.download")>
	<!--- let's create a file for download --->
	<cffile action="write" file="#GetTempDirectory()##myEvent.getuid()#.ics" output="#fileOutput#"/>
	<cfheader name="Content-Disposition" value="attachment;filename=#myEvent.getuid()#.ics">
	<cfcontent type="text/calendar" file="#GetTempDirectory()##myEvent.getuid()#.ics" deletefile="true" />
</cfif>

<cfoutput>
<pre>#fileOutput#</pre>

<p><a href="?download=1">Download this as a .ics file</a></p>
</cfoutput>