// Basic api for client interface

// query for quote data
.api.getquote:{[x] 
	.log.info "Querying quote table";
	:?[`quote;enlist(in;`sym;enlist x);0b;()];
  };



