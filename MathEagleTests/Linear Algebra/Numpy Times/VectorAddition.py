import numpy as np
import time

for i in range(1,8):
    
    n = 10 ** i
    
    left = np.random.rand(n)
    right = np.random.rand(n)

    start = time.time()
    left + right
    t = time.time() - start

    print t