using FindSteadyStates
using Documenter
using DifferentialEquations
using LabelledArrays

makedocs(;
    modules=[FindSteadyStates],
    authors="Shao-Ting Steven Chiu",
    repo="https://github.com/stevengogogo/FindSteadyStates.jl/blob/{commit}{path}#L{line}",
    sitename="FindSteadyStates.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://stevengogogo.github.io/FindSteadyStates.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "home.md",
        "examples" => "examples.md",
        "Grid Search" => "gridsearch.md",
        "API" => "api.md"
    ],
)

deploydocs(;
    branch = "gh-pages",
    repo="github.com/stevengogogo/FindSteadyStates.jl.git",
)
