import matplotlib.pyplot as plt
import numpy as np

m_0 = 9.109e-31  # kg
m_star = 0.5 * m_0 # kg

hbar = 6.582119e-16  # in eV·s

e_min = 0 # eV
e_max = 5 # eV

def g_2d(e):
    g_arr = np.zeros(e.shape)

    for i in range(e.shape[0]):
        g_arr[i] = m_star / (np.pi * hbar**2)
    
    return g_arr

def g_3d(e):
    g_arr = np.zeros(e.shape)

    for i in range(e.shape[0]):
        top = m_star * np.sqrt(2 * m_star * e[i])
        bottom = np.pi**2 * hbar**3
        g_arr[i] = top/bottom
    
    return g_arr

# plot g 2d and 3d on same plot
e = np.linspace(e_min, e_max, 100)
g_2d_arr = g_2d(e)
g_3d_arr = g_3d(e)

plt.plot(e, g_2d_arr, label='2D')
plt.plot(e, g_3d_arr, label='3D')
plt.xlabel('Energy (eV)')
plt.ylabel('Density of States')
plt.legend()
plt.title('Density of States for 2D and 3D')
plt.show()
