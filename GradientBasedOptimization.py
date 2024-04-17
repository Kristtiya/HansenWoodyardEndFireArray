#Import Packages
import numpy as np
import matplotlib
import matplotlib.pyplot as plt
import sklearn.datasets as dt
from sklearn.model_selection import train_test_split
from scipy.optimize import minimize_scalar
from Functions_AntOpt import Array_factor
from Functions_AntOpt import Array_factor_HW


# Parameters of the Array System:
N = 10                                  #Number of elements
theta = np.linspace(0,2*np.pi,num = 10000)
wavelength = 0.15                       #Wavelength (m)
k = 2*np.pi/wavelength
d = wavelength/4
beta = k*d + np.pi/N
beta_ord = k*d

d_min, d_max = wavelength/10, wavelength/2
inputs = np.arange(d_min, d_max+0.1, 0.2)

AF_HW = Array_factor(beta,theta,k,d,N)
AF_Ord = Array_factor(beta_ord, theta, k, inputs, N)
AF_Ord_norm = AF_Ord/max(AF_Ord)
print(np.shape(inputs))
Directivity = np.abs(AF_Ord_norm)**2
plt.plot(inputs, Directivity)
plt.show()

res = minimize_scalar(Array_factor_HW(d))
# Polar Plot of the Hansen Woodyard Array
plt.axes(projection = 'polar')
for i in theta:
    plt.polar(theta,AF_HW)
plt.show()


