export solve_SSODE

const Default_SSMETHOD = AutoTsit5(Rosenbrock23())
const ODEfunc = FindSteadyStates.ODEfunc

function solve_SSODE(func, u, p; method= Default_SSMETHOD)
    #= ODE solver =#

    prob = SteadyStateProblem(func, u, p)
    sol = solve(prob, method)
    return sol
end

function solve_SSODE(odefunc::ODEfunc, u; method= Default_SSMETHOD)

    prob = SteadyStateProblem(odefunc.func, u, odefunc.p)
    sol = solve(prob, method)
    return sol
end
