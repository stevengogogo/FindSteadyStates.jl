var documenterSearchIndex = {"docs":
[{"location":"gridsearch/#Grid-Search","page":"Grid Search","title":"Grid Search","text":"","category":"section"},{"location":"gridsearch/","page":"Grid Search","title":"Grid Search","text":"using FindSteadyStates","category":"page"},{"location":"gridsearch/#Method","page":"Grid Search","title":"Method","text":"","category":"section"},{"location":"gridsearch/","page":"Grid Search","title":"Grid Search","text":"The grid search algorithm provides a greedy search method to exploring all the parameter set. To use grid search method in FindSteadyStates.jl, the range of each agents can be assigned with the list of ranges. ","category":"page"},{"location":"gridsearch/#Usage","page":"Grid Search","title":"Usage","text":"","category":"section"},{"location":"gridsearch/","page":"Grid Search","title":"Grid Search","text":"The ranges are specified in ParameterGrid in the following way:","category":"page"},{"location":"gridsearch/","page":"Grid Search","title":"Grid Search","text":"\nranges = [(1.,10.,10), (1.,10.,20)] # (start, end, grid numer)\nparam_range = ParameterGrid(ranges)\n","category":"page"},{"location":"gridsearch/","page":"Grid Search","title":"Grid Search","text":"julia> param_gen = ParameterGrid([(1.,10.,3), (4., 10., 2.)])\n6-element ParameterGrid:\n [1.0, 4.0]\n [4.0, 4.0]\n [7.0, 4.0]\n [1.0, 7.0]\n [4.0, 7.0]\n [7.0, 7.0]","category":"page"},{"location":"gridsearch/#Reference","page":"Grid Search","title":"Reference","text":"","category":"section"},{"location":"gridsearch/","page":"Grid Search","title":"Grid Search","text":"gridsearch.jl of ScikitLearn.jl . ([link](https://github.com/cstjean/ScikitLearn.jl/blob/master/src/gridsearch.jl))","category":"page"},{"location":"api/","page":"API","title":"API","text":"CurrentModule = FindSteadyStates\nDocTestSetup  = quote\n    using MyPackage\nend","category":"page"},{"location":"api/#FindSteadyStates","page":"API","title":"FindSteadyStates","text":"","category":"section"},{"location":"api/","page":"API","title":"API","text":"","category":"page"},{"location":"api/#Searching-generator","page":"API","title":"Searching generator","text":"","category":"section"},{"location":"api/","page":"API","title":"API","text":"ParameterGrid\nParameterRandom","category":"page"},{"location":"api/#FindSteadyStates.ParameterGrid","page":"API","title":"FindSteadyStates.ParameterGrid","text":"Grid search iterator for parameters. The sequence of ranges defines the grids to search.\n\nParameters\n\nParameterGrid: Contain list of ranges. The range is in (start, end, points) order.\n\nExamples\n\njulia> ranges = [ (1.,10.,10.), (1.,10.,10.) ] # list of ranges (start_num, stop_num, number of grids`{int}`)\njulia> param_range = ParameterRange(ranges)\n\n\njulia> ParameterGrid([ [1,1000,5], [1,3,1]]; method=LogGrid())\n5-element ParameterGrid:\n [1.0999, 3.0]\n [1.999, 3.0]\n [10.99, 3.0]\n [100.9, 3.0]\n [1000.0, 3.0]\n\n\n\n\n\n","category":"type"},{"location":"api/#FindSteadyStates.ParameterRandom","page":"API","title":"FindSteadyStates.ParameterRandom","text":"Set all the variables with same method with defined ranges\n\n\n\n\n\nParameter Random sampling with range.\n\n\n\n\n\nReset one specified method\n\n\n\n\n\n","category":"type"},{"location":"api/#Meta-data-of-Differential-Equations","page":"API","title":"Meta data of Differential Equations","text":"","category":"section"},{"location":"api/","page":"API","title":"API","text":"DEsteady\nODEtime\nFindSteadyStates.DEmeta","category":"page"},{"location":"api/#FindSteadyStates.DEsteady","page":"API","title":"FindSteadyStates.DEsteady","text":"DEsteady(func, p u0, method)\n(self::DEsteady)(u0; key=:u0)\n\nStruct for solving steady state of an differential equation model.\nUpdate steady state meta, and return another DEsteady object.\n\nArgument\n\nfunc: ODE function. \nu0: initial values\np: parameters\nmethod: Method for solving steady-states. (i.e. DifferentialEqiations.Tsit5(), DifferentialEquations.AutoTsit5(Rosenbrock23())) \n\nReference\n\nODE solvers of DifferentialEquations.jl\n\nExample\n\njulia> using LabelledArrays, DifferentialEqiations\njulia> deS = DEsteady(func=x->x, u0= LVector(s1=1.0,s2=2.0), p=1.0)\nDEsteady\n  func: #17 (function of type var\"#17#18\")\n  p: Float64 1.0\n  u0: LArray{Float64,1,Array{Float64,1},(:s1, :s2)}\n  method: Tsit5 Tsit5()\n\njulia> deS_new = deS([1000.0,200.0];key=:u0)\nDEsteady\n  func: #17 (function of type var\"#17#18\")\n  p: Float64 1.0\n  u0: LArray{Float64,1,Array{Float64,1},(:s1, :s2)}\n  method: Tsit5 Tsit5()\n\njulia> deS_new.u0\n2-element LArray{Float64,1,Array{Float64,1},(:s1, :s2)}:\n :s1 => 1000.0\n :s2 => 200.0\n\n\n\n\n\n","category":"type"},{"location":"api/#FindSteadyStates.ODEtime","page":"API","title":"FindSteadyStates.ODEtime","text":"ODEtime(func, u0, p, tspan)\n\nStruct for solveing time-series of differential-equations. The data type of ode function is referenced to DifferentialEquations.jl.\n\nArgument\n\nfunc: ODE function. \nu0: initial values\np: parameters\ntspan: time span \n\nReferences\n\nDifferentialEquations.jl\n\nReset method\n\nReset a field of ODEtime struct with broadcast method. \n\nUsage\n\nWhen using the LabelledArray.jl to define function and subtypes of DEmeta. Use this method to update the values of named arrays without changing the type of the field. \n\nPurpose\n\nThis feature is to solve the LabelledArray problem. when using the field vector to define function, the initial values or parameters need to be Named vectors. However, the grid search iterator returns vector which gets error when apply with the funtion of name vector. \n\n!!! compat ModelingToolkit     When using 'jacobian', should not use LabelledArray or name tuples for model function.\n\nArguement\n\nu0: should be vector or types that can be broadcast. The length of u0 should be same as ODEtime.u0\nkey: field name of the stuct (default: :u0). \n\nExample\n\njulia> using LabelledArrays, DifferentialEqiations\njulia> u = LVector(s1=1.0,s2=0.2)\n2-element LArray{Float64,1,Array{Float64,1},(:s1, :s2)}:\n :s1 => 1.0\n :s2 => 0.2\n\njulia> de = ODEtime(func=x->x, u0=u, p=1.0, tspan=(0.0,1.0))\nODEtime\n  func: #9 (function of type var\"#9#10\")\n  u0: LArray{Float64,1,Array{Float64,1},(:s1, :s2)}\n  p: Float64 1.0\n  tspan: Tuple{Float64,Float64}\n  method: CompositeAlgorithm{Tuple{Tsit5,Rosenbrock23{0,true,DefaultLinSolve,DataType}},AutoSwitch{Tsit5,Rosenbrock23{0,true,DefaultLinSolve,DataType},Rational{Int64},Int64}}\n\njulia> de_new = de([1.3,1.4];key=:u0)\nODEtime\n  func: #9 (function of type var\"#9#10\")\n  u0: LArray{Float64,1,Array{Float64,1},(:s1, :s2)}\n  p: Float64 1.0\n  tspan: Tuple{Float64,Float64}\n  method: CompositeAlgorithm{Tuple{Tsit5,Rosenbrock23{0,true,DefaultLinSolve,DataType}},AutoSwitch{Tsit5,Rosenbrock23{0,true,DefaultLinSolve,DataType},Rational{Int64},Int64}}\n\njulia> de_new.u0 # The updated u0 is the struct of LArray\n2-element LArray{Float64,1,Array{Float64,1},(:s1, :s2)}:\n :s1 => 1.3\n :s2 => 1.4\n\njulia> de.u0\n2-element LArray{Float64,1,Array{Float64,1},(:s1, :s2)}:\n :s1 => 1.0\n :s2 => 0.2\n\n\n\n\n\n","category":"type"},{"location":"api/#FindSteadyStates.DEmeta","page":"API","title":"FindSteadyStates.DEmeta","text":"DEmeta\n\nMeta inofmration of differential equation. The family of 'DEmeta' \n\n\n\n\n\n","category":"type"},{"location":"api/#Solvers","page":"API","title":"Solvers","text":"","category":"section"},{"location":"api/","page":"API","title":"API","text":"The 'solve' function is extended from the DifferentialEquations.solve.","category":"page"},{"location":"api/","page":"API","title":"API","text":"solve","category":"page"},{"location":"api/#DiffEqBase.solve","page":"API","title":"DiffEqBase.solve","text":"solve(ode_func::DEsteady, us; ensemble_method=EnsembleThreads())\nsolve(ode_func::DEsteady) \nsolve(ode_func::ODEtime)\nsolve(ode_func::ODEtime, us; ensemble_method=EnsembleThreads())\n\nExtanded solver for steady state and time-series. The 'DEmeta' type provides the information of differential equations ('func'), initial variables ('u') and parameters ('p'). With DEsteady and 'ODEtime'\n\nArguements\n\nfunc: DE function\nus: Vector of vectors of initial variables\np: parameter constant\n\nSee also\n\nDEsteady, 'ODEtime'\n\n\n\n\n\n","category":"function"},{"location":"api/#Stability-and-Jacobian","page":"API","title":"Stability and Jacobian","text":"","category":"section"},{"location":"api/","page":"API","title":"API","text":"jacobian\nStabilityType","category":"page"},{"location":"api/#FindSteadyStates.jacobian","page":"API","title":"FindSteadyStates.jacobian","text":"Construct the jacobian struct type\n\nArgument\n\node {ODE function}: with the form f(du,u,p,t)\nu {Array}: initial values\np {Array}: parameters\n\nReturn\n\nJacobian {struct}\n\nWarning\n\nNameTuple definition of ode function is unrecommended. Due to the incompatibility with ModelingToolkit.modelingtoolkitize\n\n\n\n\n\nUse DEmeta for jacobian generation\n\n\n\n\n\nCalculate the jacobian of given initial valuables and parameters.\n\n\n\n\n\nGet jacobian from state variable with default paramter set\n\n\n\n\n\nGet jacobian from default state.\n\n\n\n\n\n","category":"type"},{"location":"api/#FindSteadyStates.StabilityType","page":"API","title":"FindSteadyStates.StabilityType","text":"StabilityType\n\nStore the information about stability.\n\n\n\n\n\n","category":"type"},{"location":"getstarted/","page":"Get started","title":"Get started","text":"    using FindSteadyStates\n    using DifferentialEquations","category":"page"},{"location":"getstarted/#Get-Started","page":"Get started","title":"Get Started","text":"","category":"section"},{"location":"getstarted/","page":"Get started","title":"Get started","text":"using FindSteadyStates\nusing DifferentialEquations","category":"page"},{"location":"getstarted/#Create-Differential-Equation-System","page":"Get started","title":"Create Differential Equation System","text":"","category":"section"},{"location":"getstarted/","page":"Get started","title":"Get started","text":"The standard way to create DE system is to create a derivative function in the form of f(du,u,p,t) with preallocated derivatives (du), initial variables ('u'), parameters (p) and time ('t')","category":"page"},{"location":"getstarted/","page":"Get started","title":"Get started","text":"\nfunction bistable_ode!(du, u, p ,t)\n\ts1, s2 = u\n\tK1, K2, k1, k2, k3, k4, n1 , n2  = p\n\tdu[1] = k1 / (1 + (s2/K2)^n1) - k3*s1\n\tdu[2] = k2/  (1 + (s1/K1)^n2) - k4*s2 \nend\n\nnothing # hide","category":"page"},{"location":"getstarted/","page":"Get started","title":"Get started","text":"tips: NameTuple may cause error\nOne may want to use NameTuple like LabelledArrays to create Tuple array and apply to the ode function. However, this may cause getindex undefined error for Jacobian Calculation via ModelingToolkit, but still safe with solving steady states with NameTuple as returns.","category":"page"},{"location":"getstarted/#Create-DE-Problem-for-Solving","page":"Get started","title":"Create DE Problem for Solving","text":"","category":"section"},{"location":"getstarted/","page":"Get started","title":"Get started","text":"\nde = DEsteady(func = bistable_ode!,\n         p =  [1.,1.,20.,20.,5.,5.,4.,4.],\n         u0 = [3.,1.],\n         method = SSRootfind()\n         )\nnothing # hide","category":"page"},{"location":"getstarted/","page":"Get started","title":"Get started","text":"tips: Method for solving steady state\nThe DEsteady.method will further be used for DifferentialEquation.solve. Both dynamic solver (Dynamicss which reaches steady states by solving DE) and root finding (SSRootfind) can get the stable point. However, only SSRootfind can find the saddle point if the initial values is near by.","category":"page"},{"location":"getstarted/","page":"Get started","title":"Get started","text":"The system is now well organized and ready to be solved.","category":"page"},{"location":"getstarted/","page":"Get started","title":"Get started","text":"\nsol = solve(de)\n","category":"page"},{"location":"getstarted/#Exploring-the-initial-states","page":"Get started","title":"Exploring the initial states","text":"","category":"section"},{"location":"getstarted/","page":"Get started","title":"Get started","text":"To find all the steady states, one needs to sample the initial state by grid or random search. To begin with, the ParameterGrid (grid search) and ParameterRandom (random search) are useful generator for iterating and returning the parameter set.","category":"page"},{"location":"getstarted/","page":"Get started","title":"Get started","text":"\n    param_rand = ParameterRandom(\n        methods= [\n            Uniform(0.,100.),\n            Log_uniform(0.001,100.)\n        ],\n        len= 100\n    )","category":"page"},{"location":"getstarted/","page":"Get started","title":"Get started","text":"     param_grid = ParameterGrid([\n            [0.,100.,100],\n            [0.,100.,100]\n        ])\n","category":"page"},{"location":"getstarted/#Solve-solutions-with-multi-threading","page":"Get started","title":"Solve solutions with multi-threading","text":"","category":"section"},{"location":"getstarted/","page":"Get started","title":"Get started","text":"Random Search","category":"page"},{"location":"getstarted/","page":"Get started","title":"Get started","text":"\n    sols_rand = solve(de, param_rand)\n","category":"page"},{"location":"getstarted/","page":"Get started","title":"Get started","text":"Grid Search","category":"page"},{"location":"getstarted/","page":"Get started","title":"Get started","text":"    sols_grid = solve(de, param_grid)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"    using FindSteadyStates \n    using DifferentialEquations \n    using PyPlot","category":"page"},{"location":"examples/#Prerequisite","page":"Examples","title":"Prerequisite","text":"","category":"section"},{"location":"examples/","page":"Examples","title":"Examples","text":"In this section, classicial ordinary differetnaial equations are used to demonstrate the function of FindSteadyStates.jl. Before entering the following sections, one needs to make sure that FindSteadyState.jl and DifferentialEquations.jl are successfully installed and precompiled. ","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"using FindSteadyStates\nusing DifferentialEquations\nusing LabelledArrays","category":"page"},{"location":"examples/#Exponential-Decay","page":"Examples","title":"Exponential Decay","text":"","category":"section"},{"location":"examples/","page":"Examples","title":"Examples","text":"    deS = DEsteady(func=x->x, u0= [1.0,2.0], p=1.0)\n","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"    deS = DEsteady(func=x->x, u0= [1.0,2.0], p=1.0)\n","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"    fig, ax = subplots()\n    ax = plot([1,2],[3,4])\n    fig.savefig(\"test.svg\") # hide\n    @info pwd()","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"(Image: )","category":"page"},{"location":"examples/#Bistable-Model","page":"Examples","title":"Bistable Model","text":"","category":"section"},{"location":"examples/","page":"Examples","title":"Examples","text":"There are two stable nodes and one saddle nodes in balanced bistable model.","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"\n# Model\nfunction bistable_ode!(du, u, p ,t)\n    s1, s2 = u\n    K1, K2, k1, k2, k3, k4, n1 , n2  = p\n    du[1] = k1 / (1 + (s2/K2)^n1) - k3*s1\n    du[2] = k2/  (1 + (s1/K1)^n2) - k4*s2 \nend\n\n# Parameters\np_ = [1., 1., 20., 20., 5., 5.,  4., 4.]\nu_1 = [3., 1.]\n\n\n# Define a problem\nde = DEsteady(func=bistable_ode!, p=p_, u0= u_1, method=SSRootfind())\n\nj_gen = jacobian(de) # jacobian generator\n\n# Searching method and domain\nparam_gen = ParameterGrid([\n            (0.1,5.,100), \n            (0.1,5.,100)\n            ])\n\n# Solve\nsols = solve(de, param_gen)\n\n# Remove redundancy\nsteadies = unique(sols)\n\n# Jacobian\njac_ms = j_gen.(steadies)\n\n# Stability\nstab_modes = StabilityType.(jac_ms)\n\n\n# Testing and validation\nnum_stable = sum(getfield.(stab_modes, :stable))\nnum_saddle = sum(getfield.(stab_modes, :saddle))\n\nprintln(\"num_stable=$(num_stable)\") # hide\nprintln(\"num_saddle=$(num_saddle)\") # hide","category":"page"},{"location":"examples/#References","page":"Examples","title":"References","text":"","category":"section"},{"location":"examples/#Unstable","page":"Examples","title":"Unstable","text":"","category":"section"},{"location":"#FindSteadyStates.jl","page":"Home","title":"FindSteadyStates.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"(Image: codecov)","category":"page"},{"location":"#Introduction","page":"Home","title":"Introduction","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Differential equations-based model is a theoretical approach to explore the phenomenon in real world with mathematical expressions. By integrating theory and empirical knowledge, this approach has been applied to multiple fields including economics, mechanics, electronic circits epidemics and biological systems to provide explanation of the dynamic process and make prediction. For instance, as pandemic COVID-19 arose, the SIR model and its derivatives, which are differential equations-based models,  are essential for the decision of disease control policy (i.e. lockdown and social distancing). Another example is the biological modelling of cell-differentiation which is a transition process of cell expression. When applying these model on the real world problems, it is critical to know the stability of the model, to say, whether a model can approach to a steady point and remain there as time goes to infinity. This is a typical question when dealing with the pandemic: the policy maker needs to how strong the policy is needed to distancing individuals to decrease the transmission rate and further reach to the steady point of the infected people. Hence","category":"page"},{"location":"","page":"Home","title":"Home","text":"Exploring the steady states of ODE in given domain.","category":"page"},{"location":"","page":"Home","title":"Home","text":"tip: Latest news\nThis model is currently under construction [2020/11/11].","category":"page"},{"location":"#Features","page":"Home","title":"Features","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Find steady states\nClassify stability: stable and saddle point.","category":"page"},{"location":"#Installation","page":"Home","title":"Installation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"] add https://github.com/stevengogogo/FindSteadyStates.jl","category":"page"}]
}