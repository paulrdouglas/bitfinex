// q api for bitfinex crypto exchange
// use v2 of api
// make generic request functions
args:`url`timer`qtyps!("https://api.bitfinex.com/v2/";5000;"FFFFFFFP"); 

addsym:{[sym] enlist[`sym]!enlist sym};

//get all symbols
getsyms:{
  :`$.j.k .Q.hg `$args[`url],"symbols";
  };
getquotes:{[syms]
        :.j.k .Q.hg `$args[`url],"tickers?symbols=",","sv"t",'string upper syms;
 };
// calls outdated
getquote:{[syms]
  :{[sym]
          :addsym[sym],args[`qtyps]$.j.k .Q.hg `$args[`url],"pubticker/",string sym;
    }'[syms];
  };

gettrade:{[syms]
  :$[1<count syms;raze;]{[sym]
    :(count[t]#enlist addsym[sym]),'t:.j.k .Q.hg `$args[`url],"trades/",string sym;
    }'[syms];
  };

// set timer
\t args`timer

\
To do:
#add type cast for trade table
#allow single trade request
#set-up timer // TorQ timer??
#filter out duplicate trade/quote

sample requests

getquote[`xrpusd`btcusd]
