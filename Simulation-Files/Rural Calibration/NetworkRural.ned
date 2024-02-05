//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

package simu5g.simulations.Custom.calibration_rural;

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.networklayer.ipv4.RoutingTableRecorder;
import inet.node.ethernet.Eth10G;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import simu5g.common.binder.Binder;
import simu5g.common.carrierAggregation.CarrierAggregation;
import simu5g.nodes.Upf;
import simu5g.nodes.NR.gNodeB;
import simu5g.nodes.NR.NRUe;
import simu5g.nodes.backgroundCell.BackgroundCell;
import simu5g.world.radio.LteChannelControl;


network NetworkRural
{
    parameters:
        int numUe = default(1);
        int numBgCells = default(0);
        @display("i=block/network2;bgb=4247.108,2397.2341;bgi=background/pisa");
    submodules:
        channelControl: LteChannelControl {
            @display("p=50,25;is=s");
        }
        routingRecorder: RoutingTableRecorder {
            @display("p=50,75;is=s");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=50,125");
        }
        binder: Binder {
            @display("p=50,175;is=s");
        }
        carrierAggregation: CarrierAggregation {
            @display("p=50.993748,258.7;is=s");
        }
        server: StandardHost {
            @display("p=0,0;is=n;i=device/server");
        }
        router: Router {
            @display("p=10,10;i=device/smallrouter");
        }
        upf: Upf {
            @display("p=20,20");
        }
        iUpf: Upf {
            @display("p=30,30");
        }
        gnb1: gNodeB {
            @display("p=752.9584,359.2095;is=vl");
        }
        gnb2: gNodeB {
            @display("p=108.9039,380.45197;is=vl"; );
        }
        gnb3: gNodeB {
            @display("p=149.7982,421.32697;is=vl"; );
        }
        gnb4: gNodeB {
            @display("p=752.9584,359.2095;is=vl");
        }
        gnb5: gNodeB {
            @display("p=108.9039,380.45197;is=vl"; );
        }
        gnb6: gNodeB {
            @display("p=149.7982,421.32697;is=vl"; );
        }
        gnb7: gNodeB {
            @display("p=752.9584,359.2095;is=vl");
        }
        gnb8: gNodeB {
            @display("p=108.9039,380.45197;is=vl"; );
        }
        gnb9: gNodeB {
            @display("p=149.7982,421.32697;is=vl"; );
        }
        gnb10: gNodeB {
            @display("p=752.9584,359.2095;is=vl");
        }
        gnb11: gNodeB {
            @display("p=108.9039,380.45197;is=vl"; );
        }
        gnb12: gNodeB {
            @display("p=149.7982,421.32697;is=vl"; );
        }
        gnb13: gNodeB {
            @display("p=752.9584,359.2095;is=vl");
        }
        gnb14: gNodeB {
            @display("p=108.9039,380.45197;is=vl"; );
        }
        gnb15: gNodeB {
            @display("p=149.7982,421.32697;is=vl"; );
        }
        gnb16: gNodeB {
            @display("p=752.9584,359.2095;is=vl");
        }
        gnb17: gNodeB {
            @display("p=108.9039,380.45197;is=vl"; );
        }
        gnb18: gNodeB {
            @display("p=149.7982,421.32697;is=vl"; );
        }
        gnb19: gNodeB {
            @display("p=752.9584,359.2095;is=vl");
        }
        gnb20: gNodeB {
            @display("p=108.9039,380.45197;is=vl"; );
        }
        gnb21: gNodeB {
            @display("p=149.7982,421.32697;is=vl"; );
        }
        
        ue[numUe]: NRUe {
            @display("p=100,100");
        }
        bgCell[numBgCells]: BackgroundCell {
            @display("p=400,50;is=vl");
        }

    connections:

        //# Data Network connections
        server.pppg++ <--> Eth10G <--> router.pppg++;
        router.pppg++ <--> Eth10G <--> upf.filterGate;

        //# 5G Core Network connections
        upf.pppg++ <--> Eth10G <--> iUpf.pppg++;
        iUpf.pppg++ <--> Eth10G <--> gnb10.ppp;
		iUpf.pppg++ <--> Eth10G <--> gnb12.ppp;
		
		//iUpf2.pppg++ <--> Eth10G <--> gnb1.ppp;
		//iUpf2.pppg++ <--> Eth10G <--> gnb4.ppp;
		
		
        //# X2 connections 
//        gnb1.x2++ <--> Eth10G <--> gnb2.x2++; 
//        gnb1.x2++ <--> Eth10G <--> gnb3.x2++; 
//        gnb2.x2++ <--> Eth10G <--> gnb3.x2++;
//        
//        gnb4.x2++ <--> Eth10G <--> gnb5.x2++; 
//        gnb4.x2++ <--> Eth10G <--> gnb6.x2++; 
//        gnb5.x2++ <--> Eth10G <--> gnb6.x2++; 
//        
//        gnb7.x2++ <--> Eth10G <--> gnb8.x2++; 
//        gnb7.x2++ <--> Eth10G <--> gnb9.x2++; 
//        gnb8.x2++ <--> Eth10G <--> gnb9.x2++; 
//        
//        gnb10.x2++ <--> Eth10G <--> gnb11.x2++; 
//        gnb10.x2++ <--> Eth10G <--> gnb12.x2++; 
//        gnb11.x2++ <--> Eth10G <--> gnb12.x2++; 
//        
//        gnb13.x2++ <--> Eth10G <--> gnb14.x2++; 
//        gnb13.x2++ <--> Eth10G <--> gnb15.x2++; 
//        gnb14.x2++ <--> Eth10G <--> gnb15.x2++; 
//        
//        gnb16.x2++ <--> Eth10G <--> gnb17.x2++; 
//        gnb16.x2++ <--> Eth10G <--> gnb18.x2++; 
//        gnb17.x2++ <--> Eth10G <--> gnb18.x2++; 
//        
//        gnb19.x2++ <--> Eth10G <--> gnb20.x2++; 
//        gnb19.x2++ <--> Eth10G <--> gnb21.x2++; 
//        gnb20.x2++ <--> Eth10G <--> gnb21.x2++; 
//
//
//        gnb10.x2++ <--> Eth10G <--> gnb1.x2++; 
//        gnb10.x2++ <--> Eth10G <--> gnb4.x2++; 
//        gnb10.x2++ <--> Eth10G <--> gnb7.x2++; 
//        gnb10.x2++ <--> Eth10G <--> gnb13.x2++; 
//        gnb10.x2++ <--> Eth10G <--> gnb16.x2++; 
//        gnb10.x2++ <--> Eth10G <--> gnb19.x2++; 
//        
//        gnb1.x2++ <--> Eth10G <--> gnb4.x2++; 
//        gnb4.x2++ <--> Eth10G <--> gnb13.x2++; 
//        gnb13.x2++ <--> Eth10G <--> gnb19.x2++; 
//        gnb19.x2++ <--> Eth10G <--> gnb16.x2++; 
//        gnb16.x2++ <--> Eth10G <--> gnb7.x2++; 
//        gnb7.x2++ <--> Eth10G <--> gnb1.x2++; 
		gnb1.x2++ <--> Eth10G <--> gnb2.x2++;
        gnb1.x2++ <--> Eth10G <--> gnb3.x2++;
        gnb1.x2++ <--> Eth10G <--> gnb4.x2++;
        gnb1.x2++ <--> Eth10G <--> gnb5.x2++;
        gnb1.x2++ <--> Eth10G <--> gnb6.x2++;
        gnb1.x2++ <--> Eth10G <--> gnb7.x2++;
        gnb1.x2++ <--> Eth10G <--> gnb8.x2++;
        gnb1.x2++ <--> Eth10G <--> gnb9.x2++;
        gnb1.x2++ <--> Eth10G <--> gnb10.x2++;
        gnb1.x2++ <--> Eth10G <--> gnb11.x2++;
        gnb1.x2++ <--> Eth10G <--> gnb12.x2++;
        gnb1.x2++ <--> Eth10G <--> gnb13.x2++;
        gnb1.x2++ <--> Eth10G <--> gnb14.x2++;
        gnb1.x2++ <--> Eth10G <--> gnb15.x2++;
        gnb1.x2++ <--> Eth10G <--> gnb16.x2++;
        gnb1.x2++ <--> Eth10G <--> gnb17.x2++;
        gnb1.x2++ <--> Eth10G <--> gnb18.x2++;
        gnb1.x2++ <--> Eth10G <--> gnb19.x2++;
        gnb1.x2++ <--> Eth10G <--> gnb20.x2++;
        gnb1.x2++ <--> Eth10G <--> gnb21.x2++;
        gnb2.x2++ <--> Eth10G <--> gnb3.x2++;
        gnb2.x2++ <--> Eth10G <--> gnb4.x2++;
        gnb2.x2++ <--> Eth10G <--> gnb5.x2++;
        gnb2.x2++ <--> Eth10G <--> gnb6.x2++;
        gnb2.x2++ <--> Eth10G <--> gnb7.x2++;
        gnb2.x2++ <--> Eth10G <--> gnb8.x2++;
        gnb2.x2++ <--> Eth10G <--> gnb9.x2++;
        gnb2.x2++ <--> Eth10G <--> gnb10.x2++;
        gnb2.x2++ <--> Eth10G <--> gnb11.x2++;
        gnb2.x2++ <--> Eth10G <--> gnb12.x2++;
        gnb2.x2++ <--> Eth10G <--> gnb13.x2++;
        gnb2.x2++ <--> Eth10G <--> gnb14.x2++;
        gnb2.x2++ <--> Eth10G <--> gnb15.x2++;
        gnb2.x2++ <--> Eth10G <--> gnb16.x2++;
        gnb2.x2++ <--> Eth10G <--> gnb17.x2++;
        gnb2.x2++ <--> Eth10G <--> gnb18.x2++;
        gnb2.x2++ <--> Eth10G <--> gnb19.x2++;
        gnb2.x2++ <--> Eth10G <--> gnb20.x2++;
        gnb2.x2++ <--> Eth10G <--> gnb21.x2++;
        gnb3.x2++ <--> Eth10G <--> gnb4.x2++;
        gnb3.x2++ <--> Eth10G <--> gnb5.x2++;
        gnb3.x2++ <--> Eth10G <--> gnb6.x2++;
        gnb3.x2++ <--> Eth10G <--> gnb7.x2++;
        gnb3.x2++ <--> Eth10G <--> gnb8.x2++;
        gnb3.x2++ <--> Eth10G <--> gnb9.x2++;
        gnb3.x2++ <--> Eth10G <--> gnb10.x2++;
        gnb3.x2++ <--> Eth10G <--> gnb11.x2++;
        gnb3.x2++ <--> Eth10G <--> gnb12.x2++;
        gnb3.x2++ <--> Eth10G <--> gnb13.x2++;
        gnb3.x2++ <--> Eth10G <--> gnb14.x2++;
        gnb3.x2++ <--> Eth10G <--> gnb15.x2++;
        gnb3.x2++ <--> Eth10G <--> gnb16.x2++;
        gnb3.x2++ <--> Eth10G <--> gnb17.x2++;
        gnb3.x2++ <--> Eth10G <--> gnb18.x2++;
        gnb3.x2++ <--> Eth10G <--> gnb19.x2++;
        gnb3.x2++ <--> Eth10G <--> gnb20.x2++;
        gnb3.x2++ <--> Eth10G <--> gnb21.x2++;
        gnb4.x2++ <--> Eth10G <--> gnb5.x2++;
        gnb4.x2++ <--> Eth10G <--> gnb6.x2++;
        gnb4.x2++ <--> Eth10G <--> gnb7.x2++;
        gnb4.x2++ <--> Eth10G <--> gnb8.x2++;
        gnb4.x2++ <--> Eth10G <--> gnb9.x2++;
        gnb4.x2++ <--> Eth10G <--> gnb10.x2++;
        gnb4.x2++ <--> Eth10G <--> gnb11.x2++;
        gnb4.x2++ <--> Eth10G <--> gnb12.x2++;
        gnb4.x2++ <--> Eth10G <--> gnb13.x2++;
        gnb4.x2++ <--> Eth10G <--> gnb14.x2++;
        gnb4.x2++ <--> Eth10G <--> gnb15.x2++;
        gnb4.x2++ <--> Eth10G <--> gnb16.x2++;
        gnb4.x2++ <--> Eth10G <--> gnb17.x2++;
        gnb4.x2++ <--> Eth10G <--> gnb18.x2++;
        gnb4.x2++ <--> Eth10G <--> gnb19.x2++;
        gnb4.x2++ <--> Eth10G <--> gnb20.x2++;
        gnb4.x2++ <--> Eth10G <--> gnb21.x2++;
        gnb5.x2++ <--> Eth10G <--> gnb6.x2++;
        gnb5.x2++ <--> Eth10G <--> gnb7.x2++;
        gnb5.x2++ <--> Eth10G <--> gnb8.x2++;
        gnb5.x2++ <--> Eth10G <--> gnb9.x2++;
        gnb5.x2++ <--> Eth10G <--> gnb10.x2++;
        gnb5.x2++ <--> Eth10G <--> gnb11.x2++;
        gnb5.x2++ <--> Eth10G <--> gnb12.x2++;
        gnb5.x2++ <--> Eth10G <--> gnb13.x2++;
        gnb5.x2++ <--> Eth10G <--> gnb14.x2++;
        gnb5.x2++ <--> Eth10G <--> gnb15.x2++;
        gnb5.x2++ <--> Eth10G <--> gnb16.x2++;
        gnb5.x2++ <--> Eth10G <--> gnb17.x2++;
        gnb5.x2++ <--> Eth10G <--> gnb18.x2++;
        gnb5.x2++ <--> Eth10G <--> gnb19.x2++;
        gnb5.x2++ <--> Eth10G <--> gnb20.x2++;
        gnb5.x2++ <--> Eth10G <--> gnb21.x2++;
        gnb6.x2++ <--> Eth10G <--> gnb7.x2++;
        gnb6.x2++ <--> Eth10G <--> gnb8.x2++;
        gnb6.x2++ <--> Eth10G <--> gnb9.x2++;
        gnb6.x2++ <--> Eth10G <--> gnb10.x2++;
        gnb6.x2++ <--> Eth10G <--> gnb11.x2++;
        gnb6.x2++ <--> Eth10G <--> gnb12.x2++;
        gnb6.x2++ <--> Eth10G <--> gnb13.x2++;
        gnb6.x2++ <--> Eth10G <--> gnb14.x2++;
        gnb6.x2++ <--> Eth10G <--> gnb15.x2++;
        gnb6.x2++ <--> Eth10G <--> gnb16.x2++;
        gnb6.x2++ <--> Eth10G <--> gnb17.x2++;
        gnb6.x2++ <--> Eth10G <--> gnb18.x2++;
        gnb6.x2++ <--> Eth10G <--> gnb19.x2++;
        gnb6.x2++ <--> Eth10G <--> gnb20.x2++;
        gnb6.x2++ <--> Eth10G <--> gnb21.x2++;
        gnb7.x2++ <--> Eth10G <--> gnb8.x2++;
        gnb7.x2++ <--> Eth10G <--> gnb9.x2++;
        gnb7.x2++ <--> Eth10G <--> gnb10.x2++;
        gnb7.x2++ <--> Eth10G <--> gnb11.x2++;
        gnb7.x2++ <--> Eth10G <--> gnb12.x2++;
        gnb7.x2++ <--> Eth10G <--> gnb13.x2++;
        gnb7.x2++ <--> Eth10G <--> gnb14.x2++;
        gnb7.x2++ <--> Eth10G <--> gnb15.x2++;
        gnb7.x2++ <--> Eth10G <--> gnb16.x2++;
        gnb7.x2++ <--> Eth10G <--> gnb17.x2++;
        gnb7.x2++ <--> Eth10G <--> gnb18.x2++;
        gnb7.x2++ <--> Eth10G <--> gnb19.x2++;
        gnb7.x2++ <--> Eth10G <--> gnb20.x2++;
        gnb7.x2++ <--> Eth10G <--> gnb21.x2++;
        gnb8.x2++ <--> Eth10G <--> gnb9.x2++;
        gnb8.x2++ <--> Eth10G <--> gnb10.x2++;
        gnb8.x2++ <--> Eth10G <--> gnb11.x2++;
        gnb8.x2++ <--> Eth10G <--> gnb12.x2++;
        gnb8.x2++ <--> Eth10G <--> gnb13.x2++;
        gnb8.x2++ <--> Eth10G <--> gnb14.x2++;
        gnb8.x2++ <--> Eth10G <--> gnb15.x2++;
        gnb8.x2++ <--> Eth10G <--> gnb16.x2++;
        gnb8.x2++ <--> Eth10G <--> gnb17.x2++;
        gnb8.x2++ <--> Eth10G <--> gnb18.x2++;
        gnb8.x2++ <--> Eth10G <--> gnb19.x2++;
        gnb8.x2++ <--> Eth10G <--> gnb20.x2++;
        gnb8.x2++ <--> Eth10G <--> gnb21.x2++;
        gnb9.x2++ <--> Eth10G <--> gnb10.x2++;
        gnb9.x2++ <--> Eth10G <--> gnb11.x2++;
        gnb9.x2++ <--> Eth10G <--> gnb12.x2++;
        gnb9.x2++ <--> Eth10G <--> gnb13.x2++;
        gnb9.x2++ <--> Eth10G <--> gnb14.x2++;
        gnb9.x2++ <--> Eth10G <--> gnb15.x2++;
        gnb9.x2++ <--> Eth10G <--> gnb16.x2++;
        gnb9.x2++ <--> Eth10G <--> gnb17.x2++;
        gnb9.x2++ <--> Eth10G <--> gnb18.x2++;
        gnb9.x2++ <--> Eth10G <--> gnb19.x2++;
        gnb9.x2++ <--> Eth10G <--> gnb20.x2++;
        gnb9.x2++ <--> Eth10G <--> gnb21.x2++;
        gnb10.x2++ <--> Eth10G <--> gnb11.x2++;
        gnb10.x2++ <--> Eth10G <--> gnb12.x2++;
        gnb10.x2++ <--> Eth10G <--> gnb13.x2++;
        gnb10.x2++ <--> Eth10G <--> gnb14.x2++;
        gnb10.x2++ <--> Eth10G <--> gnb15.x2++;
        gnb10.x2++ <--> Eth10G <--> gnb16.x2++;
        gnb10.x2++ <--> Eth10G <--> gnb17.x2++;
        gnb10.x2++ <--> Eth10G <--> gnb18.x2++;
        gnb10.x2++ <--> Eth10G <--> gnb19.x2++;
        gnb10.x2++ <--> Eth10G <--> gnb20.x2++;
        gnb10.x2++ <--> Eth10G <--> gnb21.x2++;
        gnb11.x2++ <--> Eth10G <--> gnb12.x2++;
        gnb11.x2++ <--> Eth10G <--> gnb13.x2++;
        gnb11.x2++ <--> Eth10G <--> gnb14.x2++;
        gnb11.x2++ <--> Eth10G <--> gnb15.x2++;
        gnb11.x2++ <--> Eth10G <--> gnb16.x2++;
        gnb11.x2++ <--> Eth10G <--> gnb17.x2++;
        gnb11.x2++ <--> Eth10G <--> gnb18.x2++;
        gnb11.x2++ <--> Eth10G <--> gnb19.x2++;
        gnb11.x2++ <--> Eth10G <--> gnb20.x2++;
        gnb11.x2++ <--> Eth10G <--> gnb21.x2++;
        gnb12.x2++ <--> Eth10G <--> gnb13.x2++;
        gnb12.x2++ <--> Eth10G <--> gnb14.x2++;
        gnb12.x2++ <--> Eth10G <--> gnb15.x2++;
        gnb12.x2++ <--> Eth10G <--> gnb16.x2++;
        gnb12.x2++ <--> Eth10G <--> gnb17.x2++;
        gnb12.x2++ <--> Eth10G <--> gnb18.x2++;
        gnb12.x2++ <--> Eth10G <--> gnb19.x2++;
        gnb12.x2++ <--> Eth10G <--> gnb20.x2++;
        gnb12.x2++ <--> Eth10G <--> gnb21.x2++;
        gnb13.x2++ <--> Eth10G <--> gnb14.x2++;
        gnb13.x2++ <--> Eth10G <--> gnb15.x2++;
        gnb13.x2++ <--> Eth10G <--> gnb16.x2++;
        gnb13.x2++ <--> Eth10G <--> gnb17.x2++;
        gnb13.x2++ <--> Eth10G <--> gnb18.x2++;
        gnb13.x2++ <--> Eth10G <--> gnb19.x2++;
        gnb13.x2++ <--> Eth10G <--> gnb20.x2++;
        gnb13.x2++ <--> Eth10G <--> gnb21.x2++;
        gnb14.x2++ <--> Eth10G <--> gnb15.x2++;
        gnb14.x2++ <--> Eth10G <--> gnb16.x2++;
        gnb14.x2++ <--> Eth10G <--> gnb17.x2++;
        gnb14.x2++ <--> Eth10G <--> gnb18.x2++;
        gnb14.x2++ <--> Eth10G <--> gnb19.x2++;
        gnb14.x2++ <--> Eth10G <--> gnb20.x2++;
        gnb14.x2++ <--> Eth10G <--> gnb21.x2++;
        gnb15.x2++ <--> Eth10G <--> gnb16.x2++;
        gnb15.x2++ <--> Eth10G <--> gnb17.x2++;
        gnb15.x2++ <--> Eth10G <--> gnb18.x2++;
        gnb15.x2++ <--> Eth10G <--> gnb19.x2++;
        gnb15.x2++ <--> Eth10G <--> gnb20.x2++;
        gnb15.x2++ <--> Eth10G <--> gnb21.x2++;
        gnb16.x2++ <--> Eth10G <--> gnb17.x2++;
        gnb16.x2++ <--> Eth10G <--> gnb18.x2++;
        gnb16.x2++ <--> Eth10G <--> gnb19.x2++;
        gnb16.x2++ <--> Eth10G <--> gnb20.x2++;
        gnb16.x2++ <--> Eth10G <--> gnb21.x2++;
        gnb17.x2++ <--> Eth10G <--> gnb18.x2++;
        gnb17.x2++ <--> Eth10G <--> gnb19.x2++;
        gnb17.x2++ <--> Eth10G <--> gnb20.x2++;
        gnb17.x2++ <--> Eth10G <--> gnb21.x2++;
        gnb18.x2++ <--> Eth10G <--> gnb19.x2++;
        gnb18.x2++ <--> Eth10G <--> gnb20.x2++;
        gnb18.x2++ <--> Eth10G <--> gnb21.x2++;
        gnb19.x2++ <--> Eth10G <--> gnb20.x2++;
        gnb19.x2++ <--> Eth10G <--> gnb21.x2++;
        gnb20.x2++ <--> Eth10G <--> gnb21.x2++;

}
