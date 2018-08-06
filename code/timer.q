// implement timer/cron table

\d .cron

id:0
events:([id:`int$()] cmd:();start:`timestamp$();interval:`time$();lastrun:`timestamp$())

add:{[cmd;start;interval]
	.log.info"Adding cronjob";
	`.cron.events upsert (id;cmd;start;interval;.z.P);
	.cron.id+:1;
	}

remove:{
	.log.info"Deleting cronjob";
	delete from `events where id=x;
	}

checktimer:{
	if[x[`interval]<.z.P-x`lastrun;
		value x`cmd;
		update lastrun:.z.P from `.cron.events;
		];
	}

\l ../config/cronevents.q

.z.ts:{.cron.checktimer each .cron.events}
\t 200

\d .
