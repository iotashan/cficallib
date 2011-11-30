<cfscript>
	myEvent = createObject("component","org.iotashan.CFiCalLib.Event").init();
	myEvent.settzid("America/Chicago");
	myEvent.setuid(createUUID());
	myEvent.setdtstamp(now());
	myEvent.setsequence(0);
	myEvent.setdtstart(dateAdd("d",3,now()));
	myEvent.setdtend(dateAdd("d",1,myEvent.getdtstart()));
	myEvent.seturl("http://www.iotashan.com/");
	myEvent.setsummary("Party at Ben Nadel's House");
	myEvent.setdescription("Ben is a party animal. Everyone come to his house, bring some beer recommended by http://www.pintley.com/ and we'll rock out for a full day!");
	myEvent.setlocation("Ben Nadel's House");
	
	thisICS = createObject("component","org.iotashan.CFiCalLib.iCal").init(prodid="-//iotashan//iotashan.com v1.0//EN");
	aEvents = arrayNew(1);
	arrayAppend(aEvents,myEvent);
	thisICS.setcomponents(aEvents);
	fileOutput = thisICS.build();

	writeDump(myEvent);
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