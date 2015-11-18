
.param supplyp=1.8 * Your positive supply voltage
.param supplyn=0 * Your negative supply voltage
.param comon=0.9 * Your output common mode voltage
.SUBCKT op 3 4 von vop Vcm vss b2 vocm vinp vinn cmfb vdd
M1 3 Vinp 5 vdd pch W=10u L=0.18u m=9
M2 4 Vinn 5 vdd pch W=10u L=0.18u m=9
M3 3 b2 vss vss nch W=9u L=0.18u
M4 4 b2 vss vss nch W=9u L=0.18u
M5 5 cmfb vdd vdd pch W=18u L=0.18u 
M6 von 4 vss vss nch W=9u L=0.18u m=4
M7 von b1 vdd vdd pch W=9u L=0.18u m=4
M8 vop 3 vss vss nch W=9u L=0.18u m=4 
M9 vop b1 vdd vdd pch W=9u L=0.18u m=4


RZ1 7 vop 500
*MZ1 7 b1 vop vss nch w=10u L=0.18u 
CC1 7 3 3p
RZ2 10 von 500
*MZ2 10 b1 von vss nch w=10u L=0.18u 
CC2 10 4 3p



RCM1 vop vcm 50K
RCM2 von vcm 50K
MCM1 cmfb vcm 36 vss nch W=9U L=0.18U 
MCM2 35 vocm 36 vss nch W=9U L=0.18U
MCM3 cmfb cmfb vdd vdd pch W=9U L=0.18U
MCM4 35 35 vdd vdd pch W=9U L=0.18U
MCM5 36 b2 vss vss nch W=9U L=0.18U m=2

MB1 b2 b2 vss vss nch W=9u L=0.18u 
MB2 b1 b2 vss vss nch W=9u L=0.18u
MB3 b1 b1 vdd vdd pch W=9u L=0.18u m=4

MB4 vocm b2 vss vss nch W=9u L=0.18u
MB5 vocm vocm vdd vdd pch W=4u L=0.18u 


.ENDS
