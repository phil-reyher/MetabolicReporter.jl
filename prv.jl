using(ExcelReaders)
using(DataFrames)

include("functions.jl")

home = pwd()
dataPath = home*"\\data\\single\\"

dfs = import_excel_files(dataPath)

df = dfs[1]

firstColumn = names(df)[1]
nameCol = string.(df[:,firstColumn])

nameCol = replace.(nameCol, r"\s+" => "")

index = findfirst(x -> x == "TIME",namecol)

demographicsData = df[1:index-1,:]


function find_var(df,var)
    for i in CartesianIndices(Matrix(df))
        if typeof(df[i]) <: AbstractString && occursin(var, df[i])
            return (i)
        end
    end
end

nameIdx = find_var(demographicsData,"Name")

name = demographicsData[nameIdx]