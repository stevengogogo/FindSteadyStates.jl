using FindSteadyStates
using Test
using Parameters
using DifferentialEquations
using LabelledArrays
using Random
using Plots
using NLsolve

@testset "FindSteadyStates.jl" begin

    @testset "Solve ODE" begin
         #include("solveODE.jl")
    end

    @testset "Multi-thread for steady states" begin
         #include("multithread_SteadyStateProblem.jl")
    end

    @testset "Sampling vector" begin
        #include("sampling_vector.jl")
    end

    @testset "Search functions" begin
        #include("search.jl")
    end

    @testset "Solve with grid search" begin
        #include("solve_with_grid_search.jl")        
    end 

    @testset "Jacobian and Stability" begin
        #include("jacobian.jl")
    end

    @testset "Solve roots for unstabe system" begin
        #include("steadystates_unstable_model.jl")
    end

    @testset "Rootfinding with boundaries" begin
        include("rootfinding_bounded.jl")
    end
end



