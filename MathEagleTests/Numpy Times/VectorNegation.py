import numpy as np
import time

for i in range(1,9):
    
    n = 10 ** i
    
    a = np.random.rand(n)
    
    start = time.time()
    -a
    t = time.time() - start
    
    print t