
def set_positions_bs(bs_conf):
    ini_configs = []
    ned_configs = []
    for bs in bs_conf["positions"]:
        bs_x = bs_conf["positions"][bs]["x"]
        bs_y = bs_conf["positions"][bs]["y"]
        ned_configs.append('        {}: gNodeB {{\n'.format(bs))
        ned_configs.append('            @display("p={},{};is=vl");\n'.format(bs_x,bs_y))
        ned_configs.append('        }\n')
        ned_configs.append('\n')

        ini_configs.append("*.{}.mobility.initialX = {}m\n".format(bs,bs_x))
        ini_configs.append("*.{}.mobility.initialY = {}m\n".format(bs,bs_y))
        ini_configs.append("\n")
    return (ini_configs, ned_configs)

def sectors_parse_bs(bs_conf,num_sectors):
    bss = bs_conf["positions"]
    bs_parsed = {} 
    for bs in bss:
        x = bss[bs]["x"]
        y = bss[bs]["y"]

        for i in range(num_sectors):
            bs_num = bs + str(i)
            bs_parsed[bs_num] = {}
            bs_parsed[bs_num]["x"] = x
            bs_parsed[bs_num]["y"] = y
    return bs_parsed


def sectors_parse_direction(bs_conf,num_sectors):
    angle_diff = int(360/num_sectors)
    starting_angle = 30

    sectors_config = []

    sectors_config.append('*.gnb*.cellularNic.phy.txDirection = "ANISOTROPIC"\n')
    sectors_config.append('\n')
    bss = bs_conf["positions"]
    direction_parsed = {} 
    for bs in bss:
        for i in range(num_sectors):
            bs_num = bs + str(i)
            angle = starting_angle + i*angle_diff
            sectors_config.append("*.{}.cellularNic.phy.txAngle = {}\n".format(bs_num,angle))
        sectors_config.append('\n')

    return sectors_config

def set_sectors(bs_conf):
    num_sectors = bs_conf["sectors"]

    # single sector, default configuratio, no change needed
    if(num_sectors < 2 ):
        sectors_config = ['*.gnb*.cellularNic.phy.txDirection = "OMNI"\n']
        return bs_conf,sectors_config

    else:
        bs_parsed = sectors_parse_bs(bs_conf,num_sectors)
        x2_parsed = sectors_parse_x2(bs_conf,num_sectors)
        sectors_configs = sectors_parse_direction(bs_conf,num_sectors)

        parsed_bs_conf = {}
        parsed_bs_conf["positions"] = bs_parsed
        parsed_bs_conf["x2"] = x2_parsed
        return parsed_bs_conf,sectors_configs

def set_x2(bs_conf):
    ini_configs = []
    ned_configs = []
    # initialize dictionary to store which ports have been used per gnb
    used_ports = {}
    for bs in bs_conf["positions"]:
        used_ports["{}".format(bs)] = 0

    x2_connections = []
    for connection in bs_conf["x2"]:
        bs_1,bs_2 = connection.split("-")
        if(bs_1 == "all" and bs_2 == "all"):
            bs_list = list(bs_conf["positions"].keys())
            for i in range(len(bs_list)):
                for j in range(i+1,len(bs_list)):
                    if(i==j):continue
                    x2_connections.append("{}-{}".format(bs_list[i],bs_list[j]))
        elif(bs_2 == "all"): 
            bs_list = list(bs_conf["positions"].keys())
            for i in range(len(bs_list)):
                bs_2 = bs_list[i]
                if(bs_2 == bs_1): continue
                x2_connections.append("{}-{}".format(bs_1,bs_2))
        else: x2_connections.append(connection)

    for connection in x2_connections:
        bs_1,bs_2 = connection.split("-")
        
        ini_configs.append('*.{}.x2App[{}].client.connectAddress = "{}%x2ppp{}"\n'.format(
            bs_1, used_ports[bs_1], bs_2, used_ports[bs_2]))
        ini_configs.append('*.{}.x2App[{}].client.connectAddress = "{}%x2ppp{}"\n'.format(
            bs_2, used_ports[bs_2], bs_1, used_ports[bs_1]))
        ini_configs.append('\n')

        ned_configs.append('        {}.x2++ <--> Eth10G <--> {}.x2++;\n'.format(bs_1,bs_2))

        used_ports[bs_1] += 1
        used_ports[bs_2] += 1

    ports_conf = []
    for bs in used_ports:
        ports_conf.append('*.{}.numX2Apps = {}\n'.format(bs,used_ports[bs]))
    ports_conf.append('\n')
    
    ini_configs = ports_conf + ini_configs
    return (ini_configs,ned_configs)

def sectors_parse_x2(bs_conf,num_sectors):
    x2 = bs_conf["x2"]
    bss = bs_conf["positions"]
    x2_parsed = []

    for bs in bss:
        bs_id = []
        for i in range(num_sectors):
            bs_id.append(bs+str(i))
        for i in range(len(bs_id)):
            for j in range(i+1,len(bs_id)):
                x2_parsed.append("{}-{}".format(bs_id[i],bs_id[j]))

    for connection in x2:
        bs1,bs2 = connection.strip().split("-")

        for i in range(num_sectors):
            for j in range(num_sectors):
                if(bs1 == "all" and bs2 == "all"):
                    x2_parsed.append("all-all")
                    break
                elif(bs1 == "all"):
                    x2_parsed.append("all-{}".format(bs2+str(j)))
                elif(bs2 == "all"):
                    x2_parsed.append("{}-all".format(bs1+str(i)))
                    break
                else:
                    x2_parsed.append("{}-{}".format(bs1+str(i),bs2+str(j)))
            if(bs1 == "all"):
                break

    return x2_parsed
