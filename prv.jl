using(ExcelReaders)
using(DataFrames)
using(DataValues)

include("functions.jl")

home = pwd()
dataPath = home*"\\data\\single\\"

dfs = import_excel_files(dataPath)

df = dfs[1]

nameCol = string.(df[:,1])

nameCol = replace.(nameCol, r"\s+" => "")

idxTime = findfirst(x -> x == "TIME" ,nameCol)

idxEvents = findfirst(x -> x == "Events",nameCol[idxTime:end])


demographicsData = df[1:idxTime-1,:]
eventsData = df[idxEvents:end,:]
idxEnd = findfirst(x -> x == 1, ismissing.(df[idxTime:end,1]) )

df = df[idxTime:idxEnd-1,:]


df1 = DataFrame(df,:auto)

name = find_var(demographicsData,"name")
age = find_var(demographicsData,"age")
sex = find_var(demographicsData,"sex")
bodyMass = find_var(demographicsData,"weight")
device = find_var(demographicsData,"device")
barometricPressure = find_var(demographicsData,"^(?=.*baro)(?=.*press).*")
temperature = find_var(demographicsData,"^(?=.*insp)(?=.*temp).*")
relativeHumidity = find_var(demographicsData,"^(?=.*insp)(?=.*hum).*")
startWarmUp = find_var(eventsData,"^(?=.*warm)(?=.*up).*")
startExercise = find_var(eventsData,"^(?=.*start)(?=.*exercise).*")
endExercise = find_var(eventsData,"^(?=.*cool)(?=.*down).*")
