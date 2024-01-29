import shutil
import os

def set_time(sim_time):
    return ["sim-time-limit={}s".format(sim_time)]

def setup_folders(project_name, scenario):
    folder_path = "./" + project_name
    if os.path.isdir(folder_path):
        shutil.rmtree(folder_path)

    shutil.copytree("./templates/", folder_path)

    if(scenario.lower() == "urban"):
        os.remove(folder_path+"/rural.ini")
        os.rename(folder_path+"/urban.ini",folder_path+"/omnetpp.ini")
    elif(scenario.lower() == "rural"):
        os.remove(folder_path+"/urban.ini")
        os.rename(folder_path+"/rural.ini",folder_path+"/omnetpp.ini")
