<cfscript>
	alarm1 = createObject("component","org.iotashan.CFiCalLib.Alarm").init();
	alarm1.setaction("AUDIO");
	alarm1.settrigger(alarm1.createDuration(negative=true,hours=2));
	
	alarm2 = createObject("component","org.iotashan.CFiCalLib.Alarm").init();
	alarm2.setaction("AUDIO");
	alarm2.settrigger(alarm1.createDuration(negative=true,days=1));
	
	aAlarms = arrayNew(1);
	arrayAppend(aAlarms,alarm1);
	arrayAppend(aAlarms,alarm2);
	
	myEvent = createObject("component","org.iotashan.CFiCalLib.Event").init();
	myEvent.settzid("America/Chicago");
	myEvent.setuid(createUUID());
	myEvent.setdtstamp(now());
	myEvent.setsequence(0);
	myEvent.setdtstart(dateAdd("d",1,now()));
	myEvent.setdtend(dateAdd("d",1,myEvent.getdtstart()));
	myEvent.seturl("http://www.pintley.com/");
	myEvent.setsummary("Time to Sign Up for Pintley");
	myEvent.setdescription("Pintley is a new kind of beer website-one that only recommends beer you're sure to love.");
	myEvent.setalarms(aAlarms);
	
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