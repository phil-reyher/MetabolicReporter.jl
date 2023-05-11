using(ExcelReaders)
using(DataFrames)

include("functions.jl")

home = pwd()
dataPath = home*"\\data\\single\\"

dfs = import_excel_files(dataPath)

df = dfs[1]

nameCol = string.(df[:,1])

nameCol = replace.(nameCol, r"\s+" => "")

index = findfirst(x -> x == "TIME",nameCol)

demographicsData = df[1:index-1,:]


function find_var(df,var)
    for i in CartesianIndices(df)
        if typeof(df[i]) <: AbstractString && occursin(var, df[i])
            i = CartesianIndex(i[1],i[2]+1)
            out = df[i]
            return (out)
        end
    end
end

name = find_var(demographicsData,"Name")
