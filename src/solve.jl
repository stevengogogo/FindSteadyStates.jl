export solve_SSODE, solve_SSODE_threads, solve_time, solve


const Default_SSMETHOD = AutoTsit5(Rosenbrock23())




function solveSS(func, u, p; method= Default_SSMETHOD)
    #= ODE solver =#
    prob = SteadyStateProblem(func, u, p)
    return DifferentialEquations.solve(prob, method)
end



function DifferentialEquations.solve(ode_func::DEsteady) 
    @unpack func, u0, method, p = ode_func
    return solveSS(func, u0, p; method= method)
end

function DifferentialEquations.solve(ode_func::ODEtime)
    @unpack func, u0, tspan, p, method = ode_func
    prob = ODEProblem(func, u0, tspan, p)
    return solve(prob; method=method)
end

"Multi-thread version of steady-state solver

# Arguements
- `func`: DE function
- `us`: Vector of vectors of initial variables
- `p`: parameter constant
"
function DifferentialEquations.solve(ode_func::DEsteady, us; ensemble_method=EnsembleThreads()) 
    
    function prob_func(prob,i,repeat)
        ode_new = ode_func(us[i])
        remake(prob,u0 = ode_new.u0)
    end

    @unpack func, u0, method, p = ode_func

    prob = SteadyStateProblem(func, u0, p)

    ensemble_prob = EnsembleProblem(prob,prob_func=prob_func)
    sim = solve(ensemble_prob,method,ensemble_method,trajectories=length(us))

    return sim
end



function DifferentialEquations.solve(ode_func::ODEtime, us; ensemble_method=EnsembleThreads()) 
    
    function prob_func(prob,i,repeat)
        ode_new = ode_func(us[i])
        remake(prob,u0 = ode_new.u0)
    end

    @unpack func, u0, method, p, tspan = ode_func

    prob = ODEProblem(func, u0, tspan, p)

    ensemble_prob = EnsembleProblem(prob,prob_func=prob_func)
    sim = solve(ensemble_prob,method,ensemble_method,trajectories=length(us))

    return sim
end



function solve_SSODE_threads(func, us, p ; method=Default_SSMETHOD)
    function prob_func(prob,i,repeat)
        remake(prob,u0 = us[i])
    end

    prob = SteadyStateProblem(func, us[1], p)

    ensemble_prob = EnsembleProblem(prob,prob_func=prob_func)
    sim = solve(ensemble_prob,method,EnsembleThreads(),trajectories=length(us))

    return sim
end

function solve_SSODE_threads(ode_func::DEmeta)
    sim = solve_SSODE_threads(ode_func.func, ode_func.u0, ode_func.p; method=ode_func.method)

    return sim
end

function solve_SSODE_threads(ode_func::DEmeta, us)

    function prob_func(prob,i,repeat)
        ode_new = ode_func(us[i])
        remake(prob,u0 = ode_new.u0)
    end

    prob = SteadyStateProblem(ode_func.func, ode_func.u0, ode_func.p)

    ensemble_prob = EnsembleProblem(prob,prob_func=prob_func)
    sim = solve(ensemble_prob,ode_func.method,EnsembleThreads(),trajectories=length(us))

    return sim
end


