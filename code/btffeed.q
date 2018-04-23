// q api for bitfinex crypto exchange
// use v2 of api

// assign args from setting script
btfxhome:@[value;`btfxhome;"../"];
url:@[value;`url;"https://api.bitfinex.com/v2/"];
quotecsv:@[value;`quotecsv;btfxhome,"/config/quotetypes.csv"];
timer:@[value;`timer;5000];

//load csv function
loadtypes:{("SC";enlist",")0:hsym`$x};
qtypes:loadtypes[quotecsv];

createschemas:{
  `quote set flip qtypes[`col]!qtypes[`typ]$count[qtypes]#();
 };

addsym:{[sym] enlist[`sym]!enlist sym};

//get all symbols
getsyms:{
  :`$.j.k .Q.hg `$url,"symbols";
  };

getquote:{[syms]
  :.j.k .Q.hg `$url,"tickers?symbols=",","sv"t",'string upper syms;
 };

gettrade:{[syms]
  :$[1<count syms;raze;]{[sym]
    :(count[t]#enlist addsym[sym]),'t:.j.k .Q.hg `$url,"trades/",string sym;
    }'[syms];
  };

upd:{[t;x]
  t insert qtypes[`typ]$flip .z.p,'x;
 };


.z.ts:{upd[`quote;getquote[`xrpusd`btcusd]]};



init:{
  qtypes:loadtypes[quotecsv];
  createschemas[];
  system"t 2000";
  };



\
To do:
#add type cast for trade table
#allow single trade request
#set-up timer // TorQ timer??
#filter out duplicate trade/quote

sample requests

getquote[`xrpusd`btcusd]
