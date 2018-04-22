// q api for bitfinex crypto exchange

// make generic request functions
args:`a`url!(0;"https://api.bitfinex.com/v1/"); 

addsym:{[sym] enlist[`sym]!enlist sym};

//get all symbols
getsyms:{
  :`$.j.k .Q.hg `$args[`url],"symbols";
  };

getquote:{[syms]
  :{[sym]
    :addsym[sym],.j.k .Q.hg `$args[`url],"pubticker/",string sym;
    }'[syms];
  };

gettrade:{[syms]
  :raze{[sym]
    :addsym[sym],.j.k .Q.hg `$args[`url],"trades/",string sym;
    }'[syms];
  };
