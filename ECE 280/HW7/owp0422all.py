"""
OW 4.22 skeleton
mrg@duke.edu
3/17/2024
"""
import numpy as np

def x_a(t):
    # in case you need a unit step function:
    u = lambda t: (t>0)*1.0
    
    return u(t+3)*np.exp(1j*t*2*np.pi) - u(t-3)*np.exp(1j*t*2*np.pi)

# b has impulses - not done

def x_c(t):
    return 1/np.pi*(np.sin(t-3)/(t-3)+(np.cos(t-3)-1)/(t-3)**2)

def x_d(t):
    one = ((2j) / np.pi) * np.sin(t)
    two = (3/np.pi) * np.cos(2 * np.pi * t)
    return one + two

def x_e(t):
    return np.cos(3*t)/1j/np.pi/t + (np.sin(t)-np.sin(2*t))/1j/np.pi/t**2