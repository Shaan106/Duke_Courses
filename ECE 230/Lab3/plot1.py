
# V vs I plot
import numpy as np
import matplotlib.pyplot as plt

# Data
V = np.linspace(0, 1, 11)

#I is measuerd
I = [0,
     0,
     0.15*(10**-6),
     1.174*(10**-6),
     9.30*(10**-6),
     65.5*(10**-6),
     0.250*(10**-3),
     0.556*(10**-3),
     0.930*(10**-3),
     2.337*(10**-3),
     3.150*(10**-3)]

# Plot
plt.plot(V, I, 'o-')
plt.xlabel('Voltage (V)')
plt.ylabel('Current (A)')
plt.title('Current vs Voltage')
plt.grid()
plt.show()
