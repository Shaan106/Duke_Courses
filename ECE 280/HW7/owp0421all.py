"""
OW 4.21 solutions - skeleton
mrg@duke.edu
3/17/2024
"""
import numpy as np

def X_a(w, a, w0):
    top = (1j * w + a)
    bot = (1j * w + a) ** 2 + w0 ** 2
    return top / bot

def X_b(w):
    return -12*1j*w/(w**4+16*w**2+100)

def X_c(w):
    return ( (2*(np.pi)** 2 * np.sin (w)) /(w* (np.pi**2 - w**2) ))

def X_d(w, a, T):
    return ((1)/(1-a*(np.cos(w*T) - 1j*np.sin (w*T) ) ))

def X_e(w):
    top = 8 * (1j * w + 2)
    bot = ( (1j * w + 2)**2  +16)**2
    return top / bot
 
def X_f(w):
    return (
        ((-3*np.pi < w) & (w < -np.pi)) * 
        (-1j*(np.exp(-1j*w)+1)/2/np.pi) + 
        ((np.pi < w) & (w < 3*np.pi)) * 
        (1j*(np.exp(-1j*w)+1)/2/np.pi)
        )
 
def X_g(w):
    return 2j*((np.cos (2*w)/w) - (np.sin (w) /w**2))
 
# h has impulses
 
def X_i(w):
    return (1 / (1j * w)) - (2/((1j * w)**3)) + ( (2 * np.exp(-1j*w)) / (1j * w)**3 ) + ((2 * np.exp(-1j * w))/(1j * w)**2)

# j not done 