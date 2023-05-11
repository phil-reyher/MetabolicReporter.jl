function import_excel_files(dir)
    files = readdir(dir)
    files = map(lowercase,files)
    excelFiles = filter(file -> endswith(file,".xls"), files)
    dfs = []
    for excelFile in excelFiles
        xlsheet = readxlsheet(dir*excelFile,1)
        df = Matrix(xlsheet)
        push!(dfs, df)
    end
    
    return dfs
end