import numpy as np
import matplotlib
import matplotlib.pyplot as plt
import sklearn.datasets as dt
from sklearn.model_selection import train_test_split
from scipy.optimize import minimize_scalar

def Array_factor(beta, theta,k,d,N):
    psi = k*d*np.cos(theta)+beta
    num = np.sin(N*psi/2)
    den = np.sin(psi/2) 
    AF = abs(num/den)
    return AF

def Array_factor_HW(d):
    theta = np.linspace(0,2*np.pi,num = 10000)
    N = 10
    k = 2*np.pi/.15
    beta = k*d + np.pi/N
    psi = k*d*np.cos(theta)+beta
    num = np.sin(N*psi/2)
    den = np.sin(psi/2) 
    AF = abs(num/den)
    return AF
