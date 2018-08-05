// Define simple hdb and save on exit q session

// HDB file path
hdb:@[value;`hdb;"../hdb/"]

savetables:`quote
//TODO: give option ot save multiple tables

savehdb:{[t]
	.Q.dpft[hsym`$hdb;.z.D;`sym;t]
	}

.z.exit:{
	.log.info"Saving down tables...";
	savehdb'[savetables];
	.log.info"Done";
	}
