import yaml
import sys
import shutil
import os
import argparse
import scenario_parser
import base_station_parser
import background_parser
import user_parser

def parse_config(config_file):
    configs = {}
    with open(config_file) as f:
        configs = yaml.safe_load(f)
    return configs

def write_conf(conf_file, label, configs):
    with open(conf_file, "r") as f:
        lines = f.readlines()

    idx = 0 
    for idx in range(len(lines)):
        if(label in lines[idx]):
            break

    result_lines = lines[:idx+1]
    for config in configs:
        result_lines.append(config)
    result_lines.extend(lines[idx+1:])


    with open(conf_file, "w") as f:
        for line in result_lines:
            f.write(line)

def set_topology(topo_conf,scenario,args):
    sim_time = topo_conf["simulation-time"]
    bs_conf = topo_conf["base-stations"]
    ue_conf = topo_conf["users"]
    bg_conf = topo_conf["background"]

    # Write simulation time
    time_config = scenario_parser.set_time(sim_time)
    write_conf("./{}/omnetpp.ini".format(args.output_directory), "*time config", time_config)

    # parse base stations sectors 
    parsed_bs_conf, sectors_config = base_station_parser.set_sectors(bs_conf)
    write_conf("./{}/omnetpp.ini".format(args.output_directory), "*sectors direction", sectors_config)

    # parse base stations positions
    bs_pos_conf = base_station_parser.set_positions_bs(parsed_bs_conf)
    write_conf("./{}/Network.ned".format(args.output_directory), "*gnb location", bs_pos_conf)

    # parse x2 config
    x2_ini_conf, x2_ned_conf = base_station_parser.set_x2(parsed_bs_conf)
    write_conf("./{}/omnetpp.ini".format(args.output_directory), "*x2 configuration", x2_ini_conf)
    write_conf("./{}/Network.ned".format(args.output_directory), "*x2 configuration", x2_ned_conf)

    # parse users positions
    ue_pos_conf = user_parser.set_positions_ue(ue_conf, parsed_bs_conf, scenario)
    write_conf("./{}/omnetpp.ini".format(args.output_directory), "*ue location", ue_pos_conf)

    # parse background config
    bg_bs_conf, bg_ue_conf = background_parser.set_bg(bg_conf)
    write_conf("./{}/omnetpp.ini".format(args.output_directory), "*bg bs configuration", bg_bs_conf)
    write_conf("./{}/omnetpp.ini".format(args.output_directory), "*bg ue configuration", bg_ue_conf)

def main():
    args = parse_arguments()
    configs = parse_config(args.conf)
    scenario = configs["topology"]["scenario"]
    scenario_parser.setup_folders(args.output_directory, scenario)
    set_topology(configs["topology"],scenario,args)


def parse_arguments():
    parser = argparse.ArgumentParser(description='Create Simu5G simulations.')
    parser.add_argument('conf', type=str, 
            help='YAML file containing the parameters to configure the simulation with')
    parser.add_argument('-od', '--output_directory', type=str, default="test",
            help='Directory where to put all the output configuration files created')

    args = parser.parse_args()
    return args

if __name__ == "__main__":
    #config_file = sys.argv[1]
    main()
