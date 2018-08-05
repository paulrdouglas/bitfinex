// calc last value cache

`sym xkey `lvcquote
lvc:{[t;x]
	t:`$raze"lvc",string[t];
	t	upsert x;
	}


