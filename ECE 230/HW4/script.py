mu_n_0 = 1350 # cm^2/Vs
v_sat = 1.8*(10**7) # cm/s
N_d = 2*(10**16) # cm^-3
N_a = 0 # cm^-3

import numpy as np

# linspace of E from 0 to 10^6 V/cm
E = np.linspace(0, 10**6, 1000)

def v_d():

    top = mu_n_0*E

    bottom = np.sqrt(1+ (mu_n_0*E/v_sat)**2)

    return top/bottom

# plot on a log log plot
import matplotlib.pyplot as plt

plt.plot(E, v_d())
plt.yscale('log')
plt.xscale('log')
plt.xlabel('E (V/cm)')
plt.ylabel('v_d (cm/s)')
plt.title('Drift Velocity vs Electric Field')
plt.show()
