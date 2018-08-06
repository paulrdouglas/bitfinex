// calc last value cache

lvc:{[t;x]
	t:`$raze"lvc",string[t];
	t	upsert x;
	}


