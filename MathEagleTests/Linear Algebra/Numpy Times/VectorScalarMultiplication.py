import numpy as np
import random
import time

for i in range(1,8):
    
    n = 10 ** i
    
    a = np.random.rand(n)
    sc = random.uniform(-10.0, 10.0)
    
    start = time.time()
    sc*a
    t = time.time() - start
    
    print t