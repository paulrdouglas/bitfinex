#python client for bitfinex api - uses pyq

import numpy as np
import pandas as pd

# open connections
qport = 7800
q.h = q.hopen(qport)

#request quote table
def getquote(sym):
     return pd.DataFrame(np.array(q.h['.api.getquote',sym]))


