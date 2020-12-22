"""
The bistable model of mutual antagonism. To perform the bistability, the parameters are defined symmetrically, contributing to a stable system with steady-states determined by the initial state.

In this section, we are going to examine wheter this package can successfully find two steady states by grid searching and predefined ranges.


Reference
---------
1. p.82-p.83, Figure 4.8. Ingalls, B. P. (2013). Mathematical modeling in systems biology: an introduction. MIT press.
"""
function bistable_ode!(du, u, p ,t)
	s1, s2 = u
	K1, K2, k1, k2, k3, k4, n1 , n2  = p
	
	du[1] = k1 / (1 + (s2/K2)^n1) - k3*s1
	du[2] = k2/  (1 + (s1/K1)^n2) - k4*s2 
end

p_ = LVector(K1=1., K2=1., k1=20., k2=20., k3=5., k4=5., n1= 4., n2=4.)

u_1 = LVector(s1=3., s2=1.)
u_2 = LVector(s1=1., s2=3.)