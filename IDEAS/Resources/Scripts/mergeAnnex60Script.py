import buildingspy.development.merger as m
import os
import json

fileName = "Resources/Scripts/mergePaths.txt"
if os.path.isfile(fileName):
    with open(fileName, 'r') as dataFile:
        data = json.loads(dataFile.read())
        annex60_dir = data['annex60_dir']
        dest_dir = data['dest_dir']
        
else:
    print(fileName + " could not be found in your current working directory. Please check the path and file name.")

mer = m.IBPSA(annex60_dir, dest_dir) 
mer.set_excluded_directories(["Experimental", "Obsolete"])
mer.merge(overwrite_reference_results=True)
