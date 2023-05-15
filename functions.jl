function import_excel_files(dir)
    files = readdir(dir)
    files = map(lowercase,files)
    excelFiles = filter(file -> endswith(file,".xls"), files)
    dfs = []
    for excelFile in excelFiles
        xlsheet = readxlsheet(dir*excelFile,1)
        df = Matrix(xlsheet)
        for i in CartesianIndices(df)
            if isa(df[i],DataValue{Union{}})
                df[i] = missing
            end
        end
        push!(dfs, df)
    end
    
    return dfs
end




function find_var(df,var)
    for i in CartesianIndices(df)
        if typeof(df[i]) <: AbstractString && occursin(Regex("(?i)$var"), df[i])
            i = CartesianIndex(i[1],i[2]+1)
            out = df[i]
            return (out)
        end
    end
end