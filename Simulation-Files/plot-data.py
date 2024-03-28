import numpy as np
import sys
import os
import shutil
from matplotlib import pyplot as plt
from scipy import stats
import pandas as pd
from matplotlib.pyplot import cm

f = sys.argv[1]
num_users = int(sys.argv[2])
num_bins = int(sys.argv[3])
results_folder = f[:-5]+"_results"
results_file = results_folder+"/results.txt"
if os.path.isdir(results_folder):
    shutil.rmtree(results_folder)
os.mkdir(results_folder)
results = eval(open(f).read())

g = sys.argv[4]
df = pd.read_csv(g)
df = df.loc[:, ~df.columns.str.contains('^Unnamed')]
df = df.loc[:, ~df.columns.str.contains('^0')]
df = df.loc[:, ~df.columns.str.contains('^Source')]
df = df.dropna()

#Linestyles
linestyles = [
     ('dotted', 'dotted'),    # Same as (0, (1, 1)) or ':'
     ('dashed', 'dashed'),    # Same as '--'
     ('dashdot', 'dashdot'),  # Same as '-.'
     ('loosely dotted',        (0, (1, 10))),
     ('dotted',                (0, (1, 1))),
     ('densely dotted',        (0, (1, 1))),
     ('long dash with offset', (5, (10, 3))),
     ('loosely dashed',        (0, (5, 10))),
     ('dashed',                (0, (5, 5))),
     ('densely dashed',        (0, (5, 1))),

     ('loosely dashdotted',    (0, (3, 10, 1, 10))),
     ('dashdotted',            (0, (3, 5, 1, 5))),
     ('densely dashdotted',    (0, (3, 1, 1, 1))),

     ('dashdotdotted',         (0, (3, 5, 1, 5, 1, 5))),
     ('loosely dashdotdotted', (0, (3, 10, 1, 10, 1, 10))),
     ('densely dashdotdotted', (0, (3, 1, 1, 1, 1, 1)))]



plt.rcParams["figure.figsize"] = (20,8)
plt.rcParams.update({'font.size': 20})

for experiment_name in list(results.keys()):
    users_sinr = {}
    users_gain = {}
    time_sinr = {}
    time_gain = {}
    users_cells = {}
    users_dist = {}
    print(experiment_name)
    name = results[experiment_name]["attributes"]["iterationvars"]
    name += "-runnumber:" + results[experiment_name]["attributes"]["runnumber"]
    print(name)

    for vec in results[experiment_name]["vectors"]:
        user = int(vec["module"].split(".")[1][3:-1])
        measurement = vec["name"]
        time = vec["time"]
        if("SINR" in measurement):
            users_sinr[user] = vec["value"]
            time_sinr[user] = time
        elif("Coupling" in measurement):
            users_gain[user] = vec["value"]
            time_gain[user] = time
        elif("Cell" in measurement):
            users_cells[user] = vec["value"]
        elif("Distance" in measurement):
            users_dist[user] = vec["value"]

    final_gain = []
    final_sinr = []

    cellIds = [10.]
    #print(len(users_sinr[0]))
    #print(len(users_gain[0]))
    #print(len(users_cells[0]))

    for u in range(num_users):
        if(not u in users_gain or u not in users_sinr ): continue
        #if(len(users_gain[u]) < 100 or len(users_sinr[u]) <100): continue
        for i in range(len(users_gain[u])):
            #if(i < len(users_dist[u]) and users_dist[u][i] < 10): continue
            if(int(time_gain[u][i]) < 5): continue
            final_gain.append(users_gain[u][i])
        for i in range(len(users_sinr[u])):
            #if(i < len(users_dist[u]) and users_dist[u][i] < 10): continue
            if(int(time_sinr[u][i]) < 5): continue
            '''
            if(users_sinr[u][i] > 50): 
                print("{} - User: {} - Time: {} - Dist: {} - Cell: {}".format(
                    users_sinr[u][i], u, time_sinr[u][i], users_dist[u][i], users_cells[u][i]))
            '''
            final_sinr.append(users_sinr[u][i])

    '''
    for u in range(num_users):
        if(u not in users_sinr): continue
        for i in range(len(users_sinr[u])):
            if(int(time_sinr[u][i]) < 5): continue
            print(max(users_sinr[u]))
            if(users_sinr[u][i] > 45): 
                print("{} - User: {} - Time: {}".format(users_sinr[u][i], u, time_sinr[u][i]))
            final_sinr.append(users_sinr[u][i])
    '''

    print(len(final_sinr))
    if(len(final_sinr) < 1): continue

    colors = cm.rainbow(np.linspace(0, 1, 20))
    fig, (ax1, ax2) = plt.subplots(1, 2)
    ########################
    ## COUPLING GAIN PLOT ##
    ########################

    count, bins_count = np.histogram(final_gain, bins=num_bins)
    pdf = count / sum(count)
    cdf = np.cumsum(pdf)
    print(cdf)
    ax1.plot(bins_count[1:], cdf,linestyle="solid",linewidth=4.5, label="Simu5G", color="red")

    idx = 0
    ln_idx = 0

    for column in list(df.columns.values):
        if(".1" in column): continue
        if("Mean" in column): continue
        count, bins_count = np.histogram(list(df[column]), bins=num_bins)
        pdf = count / sum(count)
        cdf = np.cumsum(pdf)

        _,line_s = linestyles[ln_idx%len(linestyles)]
        ax1.plot(bins_count[1:], cdf, linestyle=line_s,linewidth=4, label=column, color= colors[idx])
        idx += 1
        ln_idx += 1

    with open(results_file, 'a') as rf:
        rf.write("----------{}----------\n".format(name))
        vals = stats.ks_2samp(final_gain,list(df["Mean"]))
        rf.write("CGAIN\n")
        rf.write("statistic: {}   pvalue: {}\n".format(vals.statistic,vals.pvalue))

    #ax1.legend(loc='center left', fontsize=14, bbox_to_anchor=(1.05, 0.71), borderaxespad=0)
    #ax1.subplots_adjust(right=0.7)
    ax1.set_xlabel("Coupling Gain [dB]", fontsize=26)
    ax1.set_ylabel("CDF", fontsize=26)
    ax1.set_xlim([-180, -40])
    ax1.set_ylim([0, 1])
    #plt.savefig("{}/{}-CGAIN.png".format(results_folder,name), dpi=100)

    #plt.clf()


    count, bins_count = np.histogram(final_sinr, bins=num_bins)
    pdf = count / sum(count)
    cdf = np.cumsum(pdf)
    print(cdf)
    ax2.plot(bins_count[1:], cdf,linestyle="solid",linewidth=4.5, color="red")

    idx = 0
    ln_idx = 0
    for column in list(df.columns.values):
        if(not ".1" in column): continue
        if("Mean" in column): continue
        count, bins_count = np.histogram(list(map(float, list(df[column]))), bins=num_bins)
        pdf = count / sum(count)
        cdf = np.cumsum(pdf)

        _,line_s = linestyles[ln_idx%len(linestyles)]
        #ax2.plot(bins_count[1:], cdf, linestyle=line_s,linewidth=4,label=column[:-2], color=colors[idx])
        ax2.plot(bins_count[1:], cdf, linestyle=line_s,linewidth=4,color=colors[idx])

        ln_idx += 1
        idx += 1


    with open(results_file, 'a') as rf:
        rf.write("SINR\n")
        vals = stats.ks_2samp(final_sinr,list(df["Mean.1"]))
        rf.write("statistic: {}   pvalue: {}\n".format(vals.statistic,vals.pvalue))

    #plt.legend(loc='center left', fontsize=14, bbox_to_anchor=(1.05, 0.71), borderaxespad=0)
    #plt.legend(loc='upper center', bbox_to_anchor=(0.5, 1.2), fontsize=14, ncol=5, fancybox=True, shadow=True)
    #plt.legend(bbox_to_anchor=(0, 1.02, 1, 0.2), loc="lower left", ncol=5, fontsize=14)
    #ax2.subplots_adjust(right=0.7)
    ax2.set_xlabel("SINR [dB]", fontsize=26)
    ax2.set_ylabel("CDF", fontsize=26)
    ax2.set_xlim([-40, 80])
    ax2.set_ylim([0, 1])

    fig.legend(loc=9, fontsize=22, ncol=7,fancybox=True, columnspacing=0.8, shadow=True)
    fig.tight_layout()
    fig.subplots_adjust(top=0.75)

    plt.savefig("{}/{}-Vals-SINR.pdf".format(results_folder,name),format="pdf", dpi=100)
    plt.clf()

