# FindSteadyStates.jl


[![codecov](https://codecov.io/gh/stevengogogo/FindSteadyStates.jl/branch/master/graph/badge.svg?token=eNsRLcRA69)](https://codecov.io/gh/stevengogogo/FindSteadyStates.jl)



## Introduction 

Differential equations-based model is a theoretical approach to explore the phenomenon in real world with mathematical expressions. By integrating theory and empirical knowledge, this approach has been applied to multiple fields including economics, mechanics, electronic circits epidemics and biological systems to provide explanation of the dynamic process and make prediction. For instance, as pandemic COVID-19 arose, the SIR model and its derivatives, which are differential equations-based models,  are essential for the decision of disease control policy (i.e. lockdown and social distancing). Another example is the biological modelling of cell-differentiation which is a transition process of cell expression. When applying these model on the real world problems, it is critical to know the stability of the model, to say, whether a model can approach to a steady point and remain there as time goes to infinity. This is a typical question when dealing with the pandemic: the policy maker needs to how strong the policy is needed to distancing individuals to decrease the transmission rate and further reach to the steady point of the infected people. Hence


Exploring the steady states of ODE in given domain.




!!! tip "Latest news"
    This model is currently under construction [2020/11/11].

## Features
1. Find steady states
2. Classify stability: stable and saddle point.


## Installation 

```sh
] add https://github.com/stevengogogo/FindSteadyStates.jl
```



