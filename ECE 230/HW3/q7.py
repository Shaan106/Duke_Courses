import numpy as np
import matplotlib.pyplot as plt

# Constants
ni_300K = 1.5e10  # Intrinsic carrier concentration at 300K (cm^-3)
Nd = 1e18  # Doping concentration (cm^-3)
Na = np.linspace(0.9999999e18, Nd, 5000)  # Create an array for Na from a small positive value to Nd

# Calculate n0 using the full expression
def n0_full_expression(Nd, Na, ni):
    return (Nd - Na) / 2 + np.sqrt(((Nd - Na) / 2)**2 + ni**2)

# Calculate n0 using the approximation
def n0_approximation(Nd, Na):
    return Nd - Na

# Calculate n0 for the range of Na at 300K
n0_full = n0_full_expression(Nd, Na, ni_300K)
n0_approx = n0_approximation(Nd, Na)

# Calculate the difference percentage between the full expression and the approximation
difference_percentage = np.abs((n0_full - n0_approx) / n0_full) * 100

# find first point where difference is greater than 10%
index_of_diff = 0
for i in range(len(difference_percentage)):
    if difference_percentage[i] > 10:
        index_of_diff = i
        break

# plot n0 full and approx
plt.plot(Na, n0_full, label='Full Expression')
plt.plot(Na, n0_approx, label='Approximation')
# add vertical line where diff first greater than 10%
plt.axvline(x=Na[index_of_diff], color='r', linestyle='--', label='10% Difference')
# show value of line 
plt.xlabel('Acceptors (cm^-3)')
plt.ylabel('Equilibrium Electron Concentration (cm^-3)')
plt.legend()
plt.title('Equilibrium Electron Concentration vs. Acceptor Concentration')
plt.show()

print(Na[index_of_diff])

# For part (b), analyze how temperature affects the need to use the full expression
# Set Nd - Na = 1e13 cm^-3
Nd_Na_diff = 1e13

# Define a range of temperatures
temperatures = np.linspace(200, 500, 300)  # from 200K to 500K

# Function to calculate ni as a function of temperature
def intrinsic_carrier_concentration(T):
    # Constants
    Eg = 1.12  # Approximate band gap of silicon in eV
    k = 8.617333262145e-5  # Boltzmann constant in eV/K
    NcNv = 2.8e19 * 1.04e19  # Product of Nc and Nv at 300K for simplicity
    return np.sqrt(NcNv) * np.exp(-Eg / (2 * k * T))

# Calculate n0 using the full expression for different temperatures
n0_full_temp = []
n0_approx_temp = []

for T in temperatures:
    ni_T = intrinsic_carrier_concentration(T)
    n0_full_temp.append(n0_full_expression(Nd_Na_diff, 0, ni_T))
    n0_approx_temp.append(Nd_Na_diff)

n0_full_temp = np.array(n0_full_temp)
n0_approx_temp = np.array(n0_approx_temp)

# Calculate the difference percentage
difference_percentage_temp = np.abs((n0_full_temp - n0_approx_temp) / n0_full_temp) * 100

# Find the temperature where the difference exceeds 10%
temp_exceeds_10_percent = temperatures[difference_percentage_temp > 10]
if len(temp_exceeds_10_percent) > 0:
    temp_critical = temp_exceeds_10_percent[0]
else:
    temp_critical = None

# Plot the results
plt.figure(figsize=(10, 6))
plt.plot(temperatures, difference_percentage_temp, label='Difference Percentage')
plt.axhline(10, color='r', linestyle='--', label='10% Threshold')
if temp_critical is not None:
    plt.axvline(temp_critical, color='g', linestyle='--', label=f'Critical Temperature: {temp_critical:.1f} K')
plt.xlabel('Temperature (K)')
plt.ylabel('Difference Percentage (%)')
plt.title('Difference Between Full Expression and Approximation vs Temperature')
plt.legend()
plt.grid(True)
plt.show()

temp_critical, difference_percentage_temp[difference_percentage_temp > 10][0]
