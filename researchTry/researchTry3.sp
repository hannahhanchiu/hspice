*researchTry3.sp
.protect
.lib 'rf018.l' TT
.unprotect
.option post acout=0 accurate dcon=1 CONVERGE=1 GMINDC= 1.0000E-12  unwrap = 1
+captab = 1
***OP***
.subckt	OP	vdd	vss	vinn	vinp	vop	b0	b1
Mb	b	b0		vdd	vdd	pch	W = 10u  L = 1u	  m = 2
M1	1	Vinn	b		b		pch	W = 30u L = 0.4u m = 2
M2	2	Vinp	b		b		pch	W = 30u L = 0.4u m = 2
M5	1	b1		vss	vss	nch	W = 13u L = 0.4u m = 1
M6	2	b1		vss	vss	nch	W = 13u L = 0.4u m = 1
m3	von	1		vdd	vdd	pch	w = 18u    l = 1u m = 1
m4	vop	2		vdd	vdd	pch w = 17.83u l = 1u m = 1
m7	von	von	vss	vss	nch	w = 3.8u   l = 1u m = 1
m8	vop	von	vss	vss	nch	w = 3.7u   l = 1u m = 1
C1	z1		von 400f
Rz1	z1		1   350k
C2	2			vop 900f
.ends

***netlist***
*Mp	inx	vb	vdd	vdd pch	w = 11u l = 0.2u
Ibi vdd	inx dc = 86.0773n ac = 1  pulse(50u 1u 1ms 1ms 1ms 1s 2s)
Mnw	inx	vg	vss	vss nch	w = 2.5u l = 0.2u

XOPf	vdd	vss	vinn	vinp	vop	b0	b1	OP
*Vop		vg	gnd dc = 299.8361m

*** BandPass***
*XOP1	vdd	vss	vinn1	vinp1	vop1		b0	b1	OP
*Ci	vinn1 	vop1   2.2p
*Cd	vop1		vinn2  220p
*
*XOP2	vdd	vss	vinn2	vinp2	vout	b0	b1	OP
*Cfd	vinn2	vout  2.2p
*Rd	vinn2	vout  47k
*v1		vinp1	gnd dc = 0.5
*v2		vinp2	gnd dc = 0.5
*

***filter***
*E2	o2	gnd	OPAMP	gnd	i2
*Clf	i2	o2 1p
*Rlf	i2	o2 1k

***loading***
cL	inx	i2 100p
*Cl2	vg	inx 20u
Rdly vop vg 10k
Cdly vg gnd 3u
*Cl3	vg	vop 20u
.param RR = 1x
rL	vop 	gnd rr	*the Rhand Pole can be diminished by it
* it might because the gain is lowered
*	And the co is needed. refer to Transfer function

***param***
.param
+bias			= 0.6
+bias2		= 0.3

***connection source***
Vw vinn1	inx dc = 0v			*Bandpass and inx
vx		vinp	inx dc = 0		*OPf input and inx
*vy		vop		vg  dc = 0		*Opf output and NW_Vg

***source***
Vd		vdd	gnd dc = 1v
Vs		vss	gnd dc = 0v
Vbias	vb	gnd dc = 0.7v		*Pmos for bias current
vb 		b0		gnd dc bias		*OP bias1
vb1		b1		gnd dc bias2	*Op bias2
vref	vinn	gnd dc = 0.5
.param f = 100k
*Iin	gnd inx dc = 50n ac = 1 sin(20n 10n f 1ns)

***loop gain testing***
*vlf	vinp	gnd dc = 499.9686m ac = 1
*vlf	vg	gnd dc = 0.3171173 ac = 1

***loop gain test with copy***
*L1		vop		vg  1t
*vyc		vop		vgc dc = 0
*Mpc		inxc	vb	vdd	vdd pch	w = 11u  l = 0.2u
*Mnwc	inxc	vgc	vss	vss nch	w = 2.5u l = 0.2u
*cLc		inxc	gnd 100p
*Cl2c	inxc		gnd 100p


***
.op
*.dc iin 1n	100n	0.1n
*.ac dec 100 0.1	1000g *sweep rr poi 3 1x 10x 1g
*.probe ac vdb(inx) vdb(vg) i(cL) vdb(o2) vdb(vop) i(e2) i(mnw) i(mp)
*+ vdb(inxc)
*.pz	v(vop) vlf
*.pz v(inxc) ibi
.tran 1m 3s *sweep f 310k 330k 10k
.probe tran I(ibi) I(mnw)

*.noise v(vg)	iin 10

*.alter
*.param rr = 10x
*
*.alter
*.param rr = 1g




.end
