
def set_positions_ue(ue_conf, bs_conf, scenario):
    configs = []
    num_users = 0
    for bs in bs_conf["positions"]:
        bs_x = bs_conf["positions"][bs]["x"]
        bs_y = bs_conf["positions"][bs]["y"]

        configs.append("*.ue[{{{}..{}}}].mobility.initialX = uniform({}m,{}m)\n".format(
                num_users, num_users+ue_conf["users-per-bs"]-1,
                bs_x-ue_conf["user-to-bs-dist"],bs_x+ue_conf["user-to-bs-dist"]))

        configs.append("*.ue[{{{}..{}}}].mobility.initialY = uniform({}m,{}m)\n".format(
                num_users, num_users+ue_conf["users-per-bs"]-1,
                bs_y-ue_conf["user-to-bs-dist"],bs_y+ue_conf["user-to-bs-dist"]))

        configs.append('\n')

        num_users += ue_conf["users-per-bs"]

    if(scenario.lower() == "urban"): 
        indoor_users= int(num_users * 0.8)
        high_loss_users= int(indoor_users* 0.2)
    elif(scenario.lower() == "rural"): 
        indoor_users = int(num_users * 0.5)
        high_loss_users= 0

    configs.append("*.ue[{{0..{}}}].cellularNic.channelModel[*].inside_building = true\n".format(indoor_users))
    configs.append("*.ue[{{0..{}}}].cellularNic.nrChannelModel[*].inside_building = true\n".format(indoor_users))
    configs.append('\n')

    configs.append("*.ue[{{0..{}}}].mobility.speed = 0.8333mps\n".format(indoor_users))
    configs.append("*.ue[{{{}..{}}}].mobility.speed = 2.77778mps\n".format(indoor_users+1,num_users-1))
    configs.append('\n')

    if(high_loss_users > 0):
        configs.append("*.ue[{{0..{}}}].cellularNic.nrChannelModel[*].useBuildingPenetrationHighLossModel = true\n".format(high_loss_users))

    configs.append("*.ue[{{0..{}}}].cellularNic.channelModel[*].ue_height = 3 * (uniform(1,uniform(4,8))-1)+ 1.5\n".format(indoor_users))
    configs.append('\n')

    return configs
