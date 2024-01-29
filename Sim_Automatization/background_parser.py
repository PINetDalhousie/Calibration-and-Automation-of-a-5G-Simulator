
def set_bg(bg_conf):
    bs_conf = bg_conf["base-stations"]
    ue_conf = bg_conf["users"]
    bs_configs = []
    ue_configs = []

    # Parse bg base station
    bs_configs.append("*.numBgCells = {}\n".format(bs_conf["number"]))
    bs_configs.append("*.bgCell[*].mobility.initialX = uniform({}m,{}m)\n".format(
        bs_conf["min-x"],bs_conf["max-x"]))
    bs_configs.append("*.bgCell[*].mobility.initialY = uniform({}m,{}m)\n".format(
        bs_conf["min-y"],bs_conf["max-y"]))

    # Parse bg users
    ue_configs.append("*.bgCell[*].bgTrafficGenerator.numBgUes = {}\n".format(ue_conf["number"]))
    ue_configs.append("*.bgCell[*].bgTrafficGenerator.bgUE[*].mobility.initialX = uniform({}m,{}m)\n".format(
        ue_conf["min-x"],ue_conf["max-x"]))
    ue_configs.append("*.bgCell[*].bgTrafficGenerator.bgUE[*].mobility.initialY = uniform({}m,{}m)\n".format(
        ue_conf["min-y"],ue_conf["max-y"]))

    return bs_configs, ue_configs
