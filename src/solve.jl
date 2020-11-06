export solve_SSODE


const Default_SSMETHOD = AutoTsit5(Rosenbrock23())




function solve_SSODE(func, u, p; method= Default_SSMETHOD)
    #= ODE solver =#

    prob = SteadyStateProblem(func, u, p)
    sol = solve(prob, method)
    return sol
end

function solve_SSODE(odefunc::DEsteady)
    sol = solve_SSODE(odefunc.func, odefunc.u0, odefunc.p; method= odefunc.SteadyStateMethod)
    return sol
end


"Multi-thread version of steady-state solver

# Arguements
- `func`: DE function
- `us`: Vector of vectors of initial variables
- `p`: parameter constant
"
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
    sim = solve_SSODE_threads(ode_func.func, ode_func.u0, ode_func.p; method=ode_func.SteadyStateMethod)

    return sim
end
