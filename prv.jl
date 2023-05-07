using(ExcelReaders)
using(DataFrames)

include("functions.jl")

home = pwd()
dataPath = home*"\\data\\single\\"

dfs = import_excel_files(dataPath)

df = dfs[1]

firstcolumn = names(df)[1]
namecol = string.(df[:,firstcolumn])

namecol = strip.(namecol, r"\s+")

index = findfirst(x -> x == "TIME",namecol)

