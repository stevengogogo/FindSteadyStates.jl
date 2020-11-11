using FindSteadyStates
using Documenter

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
        "Home" => "front.md",
        "Grid Search" => "gridsearch.md",
        "API" => "index.md"
    ],
)

deploydocs(;
    repo="github.com/stevengogogo/FindSteadyStates.jl.git",
)
