// q api for bitfinex crypto exchange
// use v2 of api
// set hardcoded port for now
system"p 7800"

// assign args from setting script
btfxhome:@[value;`btfxhome;"../"];
url:@[value;`url;"https://api.bitfinex.com/v2/"];
urlv1:@[value;`urlv1;"https://api.bitfinex.com/v1/"];
quotecsv:@[value;`quotecsv;btfxhome,"/config/quotetypes.csv"];
timer:@[value;`timer;5000];
insts:@[value;`insts;`xrpusd`btcusd`ethusd`trxusd`ltcusd];

//load csv function
loadtypes:{("SC";enlist",")0:hsym`$x};

qtypes:loadtypes[quotecsv];

createschemas:{
	`quote set flip qtypes[`col]!qtypes[`typ]$count[qtypes]#();
	`lvcquote set `sym xkey flip qtypes[`col]!qtypes[`typ]$count[qtypes]#()
	};

addsym:{[sym] enlist[`sym]!enlist sym};

//get all symbols
getsyms:{
  :`$.j.k .Q.hg `$urlv1,"symbols";
  };

getquote:{[syms]
	r:.j.k .Q.hg`$url,"tickers?symbols=",","sv"t",'string upper syms;
	if[iserror[r];.log.error[r 2];:()];
	rec:checkduplicate r;
	if[count rec;upd[`quote;rec]];
 };

gettrade:{[syms]
  :$[1<count syms;raze;]{[sym]
		:#[count t;enlist addsym sym],'t:.j.k .Q.hg`$url,"trades/",string sym;
    }'[syms];
  };

upd:{[t;x]
	t insert x;
	lvc[t;x];
	}

iserror:{$["error"~x 0;1;0]};

.log.msg:{-2 raze string[.z.P]," | ",x," | ",y};
.log.error:.log.msg["ERROR"];
.log.info:.log.msg["INFO"];
.log.warn:.log.msg["WARN"];

// check for duplicates - edit to work for all tables
checkduplicate:{
	// get most recent records
	q:delete time from select by sym from quote;
	// cast types
	r:(1_qtypes[`typ])$flip x;
	//pass out table
	:{[x;y;q]$[not all(1_y)=value q y 0;x upsert .z.p,y;x]}[;;q]/[0#quote;flip r];
 };

.z.ts:{getquote[insts]};

qtypes:loadtypes[quotecsv];
createschemas[];

init:{
	system"t 5000";
 };

/ There can be errors with .Q.hg first time
/ Run once to stop this
@[getquote;insts;{}];

// load extra files
\l api.q 
\l lastvaluecache.q


\
To do:
#add type cast for trade table
#allow single trade request
