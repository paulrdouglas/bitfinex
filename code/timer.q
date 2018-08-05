// implement timer/cron table

\d .cron

id:0
events:([id:`int$()] cmd:();start:`timestamp$();interval:`timestamp$();lastrun:`timestamp())

add:{[cmd;start;end]
	.log.info"Adding cronjob";
	`events upsert (id;cmd;start;end);
	}

remove:{
	.log.info"Deleting cronjob";
	delete from `events where id=x;
	}


//TODO: Iterate over events table
checktimer:{
	if[x[`interval]>.z.P-x`lastrun;
		value x`cmd;
		update lastrun:.z.P from `events;
		];
	}

