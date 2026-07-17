class(X,'dermason') :- convexarea(X,N6), N6=<40165.0, not ab10(X), not ab12(X), not ab14(X), not ab15(X), not ab17(X), not ab18(X). 
class(X,'sira') :- majoraxislength(X,N2), N2=<343.84, sf1_sf3_ratio(X,N18), N18>0.009, not ab21(X), not ab24(X), not ab25(X), not ab30(X), not ab31(X), not ab33(X), not ab34(X). 
class(X,'horoz') :- sf1_sf3_ratio(X,N18), N18>0.011, not ab35(X), not ab40(X), not ab41(X), not ab42(X). 
class(X,'seker') :- shapefactor2(X,N13), N13>0.002, not ab43(X), not ab45(X), not ab48(X), not ab49(X), not ab50(X), not ab51(X). 
class(X,'cali') :- roundness_compact_gap(X,N17), N17>0.054, not ab52(X), not ab62(X), not ab66(X), not ab71(X), not ab72(X). 
class(X,'barbunya') :- roundness_compact_gap(X,N17), N17=<0.038, not ab74(X), not ab75(X), not ab76(X), not ab78(X), not ab79(X), not ab80(X). 
class(X,'bombay') :- area(X,N0), N0>94904.0. 
class(X,'barbunya') :- area(X,N0), N0>58074.0, not ab82(X), not ab83(X), not ab84(X), not ab85(X), not ab87(X), not ab88(X). 
class(X,'sira') :- perimeter(X,N1), N1>769.398, shapefactor1(X,N12), N12>0.006, not ab89(X), not ab90(X), not ab93(X), not ab94(X). 
class(X,'dermason') :- minoraxislength(X,N3), N3=<196.581, not ab95(X), not ab98(X). 
class(X,'cali') :- minoraxislength(X,N3), N3>218.057, roundness_compact_gap(X,N17), N17=<0.054, not ab100(X). 
class(X,'seker') :- aspectration(X,N4), N4=<1.432, not ab102(X). 
class(X,'sira') :- area(X,N0), N0=<43678.0. 
class(X,'horoz') :- shapefactor4(X,N15), N15=<0.994. 
class(X,'barbunya') :- aspectration(X,N4), N4>1.442, not ab103(X). 
class(X,'cali') :- area(X,N0), N0=<51643.0. 
class(X,'sira') :- area(X,N0), N0=<55563.0. 
class(X,'horoz') :- area(X,N0), N0=<73451.0. 
ab1(X) :- perimeter(X,N1), N1=<682.216, shapefactor4(X,N15), N15=<0.998, sf1_sf3_ratio(X,N18), N18>0.008. 
ab2(X) :- perimeter(X,N1), N1>724.99. 
ab3(X) :- extent(X,N8), N8>0.791, shapefactor4(X,N15), N15=<0.998, ecc_roundness_gap(X,N20), N20>-0.323, not ab2(X). 
ab4(X) :- aspectration(X,N4), N4=<1.308, compactness(X,N11), N11=<0.876, shapefactor4(X,N15), N15>0.998. 
ab5(X) :- area(X,N0), N0=<35845.0. 
ab6(X) :- area(X,N0), N0=<36461.0, not ab5(X). 
ab7(X) :- minoraxislength(X,N3), N3=<195.082, shapefactor4(X,N15), N15=<0.997, roundness_compact_gap(X,N17), N17>0.039, not ab6(X). 
ab8(X) :- area(X,N0), N0=<34349.0. 
ab9(X) :- aspectration(X,N4), N4=<1.32, sf1_sf3_ratio(X,N18), N18>0.009, not ab8(X). 
ab10(X) :- sf1_sf3_ratio(X,N18), N18=<0.009, not ab1(X), not ab3(X), not ab4(X), not ab7(X), not ab9(X). 
ab11(X) :- majoraxislength(X,N2), N2>293.688, N2=<298.088, shapefactor4(X,N15), N15>0.995. 
ab12(X) :- perimeter(X,N1), N1>704.877, majoraxislength(X,N2), N2>290.258, perimeter_per_axis(X,N21), N21>1.613, not ab11(X). 
ab13(X) :- majoraxislength(X,N2), N2>286.384. 
ab14(X) :- perimeter(X,N1), N1>687.953, convexarea(X,N6), N6>37545.0, extent_solidity_prod(X,N19), N19>0.79, perimeter_per_axis(X,N21), N21>1.612, not ab13(X). 
ab15(X) :- perimeter(X,N1), N1>687.953, majoraxislength(X,N2), N2>285.665, N2=<287.849, convexarea(X,N6), N6>35831.0, perimeter_per_axis(X,N21), N21>1.617. 
ab16(X) :- minoraxislength(X,N3), N3>187.28. 
ab17(X) :- perimeter(X,N1), N1>730.356, majoraxislength(X,N2), N2=<284.85, convexarea(X,N6), N6>35831.0, shapefactor4(X,N15), N15=<0.997, perimeter_per_axis(X,N21), N21>1.617, not ab16(X). 
ab18(X) :- perimeter(X,N1), N1>687.953, N1=<704.877, shapefactor4(X,N15), N15>0.999, ecc_roundness_gap(X,N20), N20=<-0.234. 
ab19(X) :- majoraxislength(X,N2), N2=<268.897. 
ab20(X) :- area(X,N0), N0>36500.0, solidity(X,N9), N9=<0.985, shapefactor1(X,N12), N12>0.006, shapefactor4(X,N15), N15>0.977, N15=<0.997, ecc_roundness_gap(X,N20), N20=<-0.019, not ab19(X). 
ab21(X) :- roundness(X,N10), N10=<0.835, not ab20(X). 
ab22(X) :- aspectration(X,N4), N4=<1.371. 
ab23(X) :- minoraxislength(X,N3), N3>187.916, roundness(X,N10), N10>0.93, N10=<0.935, not ab22(X). 
ab24(X) :- perimeter(X,N1), N1=<764.163, roundness(X,N10), N10>0.927, not ab23(X). 
ab25(X) :- convexarea(X,N6), N6=<42673.0, roundness_compact_gap(X,N17), N17>0.108. 
ab26(X) :- extent_solidity_prod(X,N19), N19>0.8. 
ab27(X) :- extent(X,N8), N8>0.778, not ab26(X). 
ab28(X) :- area(X,N0), N0>42158.0. 
ab29(X) :- perimeter(X,N1), N1=<756.289, aspectration(X,N4), N4>1.449. 
ab30(X) :- perimeter(X,N1), N1=<764.43, shapefactor4(X,N15), N15>0.997, roundness_compact_gap(X,N17), N17=<0.078, not ab27(X), not ab28(X), not ab29(X). 
ab31(X) :- perimeter(X,N1), N1=<764.43, roundness_compact_gap(X,N17), N17=<0.034. 
ab32(X) :- area(X,N0), N0=<36457.0. 
ab33(X) :- perimeter(X,N1), N1=<764.43, convexarea(X,N6), N6=<37447.0, roundness_compact_gap(X,N17), N17=<0.082, not ab32(X). 
ab34(X) :- perimeter(X,N1), N1>765.942, N1=<766.159, roundness_compact_gap(X,N17), N17=<0.082. 
ab35(X) :- roundness(X,N10), N10>0.843, sf1_sf3_ratio(X,N18), N18=<0.013. 
ab36(X) :- majoraxislength(X,N2), N2>432.429. 
ab37(X) :- sf1_sf3_ratio(X,N18), N18=<0.011. 
ab38(X) :- extent(X,N8), N8=<0.618. 
ab39(X) :- roundness(X,N10), N10>0.819. 
ab40(X) :- shapefactor1(X,N12), N12=<0.006, sf1_sf3_ratio(X,N18), N18=<0.013, not ab36(X), not ab37(X), not ab38(X), not ab39(X). 
ab41(X) :- solidity(X,N9), N9=<0.984, compactness(X,N11), N11>0.724, shapefactor4(X,N15), N15>0.995. 
ab42(X) :- area(X,N0), N0>61089.0, compactness(X,N11), N11>0.724, shapefactor4(X,N15), N15=<0.978. 
ab43(X) :- shapefactor2(X,N13), N13=<0.002, shapefactor4(X,N15), N15=<0.996, ecc_roundness_gap(X,N20), N20>-0.274. 
ab44(X) :- area(X,N0), N0>45645.0. 
ab45(X) :- aspectration(X,N4), N4>1.378, extent(X,N8), N8=<0.731, ecc_roundness_gap(X,N20), N20>-0.274, not ab44(X). 
ab46(X) :- area(X,N0), N0>42012.0. 
ab47(X) :- area(X,N0), N0>36876.0, N0=<39263.0. 
ab48(X) :- shapefactor4(X,N15), N15=<0.994, ecc_roundness_gap(X,N20), N20>-0.274, not ab46(X), not ab47(X). 
ab49(X) :- majoraxislength(X,N2), N2=<273.509, shapefactor2(X,N13), N13=<0.002, ecc_roundness_gap(X,N20), N20>-0.274. 
ab50(X) :- solidity(X,N9), N9=<0.988, shapefactor2(X,N13), N13=<0.002, ecc_roundness_gap(X,N20), N20>-0.287. 
ab51(X) :- majoraxislength(X,N2), N2>258.916, minoraxislength(X,N3), N3>227.997, roundness(X,N10), N10=<0.936, roundness_compact_gap(X,N17), N17=<-0.026. 
ab52(X) :- area(X,N0), N0>116272.0. 
ab53(X) :- extent(X,N8), N8>0.771, shapefactor1(X,N12), N12=<0.005. 
ab54(X) :- perimeter(X,N1), N1>898.194, shapefactor4(X,N15), N15=<0.997, ecc_roundness_gap(X,N20), N20=<-0.106, not ab53(X). 
ab55(X) :- perimeter(X,N1), N1>898.194, shapefactor2(X,N13), N13>0.001, shapefactor4(X,N15), N15=<0.993. 
ab56(X) :- perimeter(X,N1), N1>898.194, minoraxislength(X,N3), N3=<203.046. 
ab57(X) :- area(X,N0), N0>57853.0. 
ab58(X) :- area(X,N0), N0>56214.0, ecc_roundness_gap(X,N20), N20>-0.029, not ab57(X). 
ab59(X) :- solidity(X,N9), N9=<0.989. 
ab60(X) :- area(X,N0), N0>56642.0, extent(X,N8), N8>0.705, N8=<0.754, ecc_roundness_gap(X,N20), N20=<-0.085, not ab59(X). 
ab61(X) :- area(X,N0), N0>61959.0, N0=<62326.0. 
ab62(X) :- majoraxislength(X,N2), N2=<360.623, not ab54(X), not ab55(X), not ab56(X), not ab58(X), not ab60(X), not ab61(X). 
ab63(X) :- area(X,N0), N0=<60493.0. 
ab64(X) :- roundness(X,N10), N10>0.865, not ab63(X). 
ab65(X) :- aspectration(X,N4), N4>1.748, solidity(X,N9), N9>0.986. 
ab66(X) :- solidity(X,N9), N9=<0.988, shapefactor4(X,N15), N15>0.995, not ab64(X), not ab65(X). 
ab67(X) :- roundness_compact_gap(X,N17), N17=<0.064. 
ab68(X) :- roundness_compact_gap(X,N17), N17>0.096. 
ab69(X) :- area(X,N0), N0>69623.0, N0=<71606.0. 
ab70(X) :- extent(X,N8), N8=<0.789, roundness_compact_gap(X,N17), N17=<0.075, not ab69(X). 
ab71(X) :- area(X,N0), N0>64652.0, solidity(X,N9), N9=<0.991, shapefactor2(X,N13), N13>0.001, shapefactor4(X,N15), N15>0.996, not ab67(X), not ab68(X), not ab70(X). 
ab72(X) :- majoraxislength(X,N2), N2=<399.904, minoraxislength(X,N3), N3>242.595, extent(X,N8), N8=<0.745, solidity(X,N9), N9>0.987. 
ab73(X) :- area(X,N0), N0=<102015.0, shapefactor2(X,N13), N13>0.001. 
ab74(X) :- majoraxislength(X,N2), N2>439.644, perimeter_per_axis(X,N21), N21=<1.711, not ab73(X). 
ab75(X) :- area(X,N0), N0=<40740.0. 
ab76(X) :- area(X,N0), N0>68859.0, shapefactor4(X,N15), N15=<0.989, roundness_compact_gap(X,N17), N17>0.01. 
ab77(X) :- area(X,N0), N0=<44027.0. 
ab78(X) :- convexarea(X,N6), N6=<56736.0, solidity(X,N9), N9>0.986, not ab77(X). 
ab79(X) :- perimeter_per_axis(X,N21), N21=<1.65. 
ab80(X) :- extent(X,N8), N8>0.736, shapefactor4(X,N15), N15=<0.994, sf1_sf3_ratio(X,N18), N18>0.01. 
ab81(X) :- majoraxislength(X,N2), N2=<361.678. 
ab82(X) :- shapefactor4(X,N15), N15=<0.991, not ab81(X). 
ab83(X) :- perimeter(X,N1), N1>1149.98. 
ab84(X) :- extent(X,N8), N8=<0.656. 
ab85(X) :- extent(X,N8), N8>0.722, shapefactor1(X,N12), N12>0.006. 
ab86(X) :- area(X,N0), N0=<61843.0. 
ab87(X) :- solidity(X,N9), N9>0.988, roundness_compact_gap(X,N17), N17=<0.051, not ab86(X). 
ab88(X) :- area(X,N0), N0>61731.0, solidity(X,N9), N9=<0.981. 
ab89(X) :- shapefactor4(X,N15), N15=<0.986. 
ab90(X) :- shapefactor4(X,N15), N15>0.998. 
ab91(X) :- area(X,N0), N0>54815.0. 
ab92(X) :- extent_solidity_prod(X,N19), N19>0.756, not ab91(X). 
ab93(X) :- area(X,N0), N0>45893.0, shapefactor4(X,N15), N15>0.993, perimeter_per_axis(X,N21), N21>1.627, not ab92(X). 
ab94(X) :- solidity(X,N9), N9=<0.987, roundness_compact_gap(X,N17), N17>0.112. 
ab95(X) :- majoraxislength(X,N2), N2=<261.745. 
ab96(X) :- roundness_compact_gap(X,N17), N17>0.113. 
ab97(X) :- area(X,N0), N0>39852.0, majoraxislength(X,N2), N2=<284.432. 
ab98(X) :- majoraxislength(X,N2), N2>277.267, N2=<292.369, shapefactor4(X,N15), N15=<0.997, not ab96(X), not ab97(X). 
ab99(X) :- solidity(X,N9), N9>0.987. 
ab100(X) :- extent(X,N8), N8=<0.738, solidity(X,N9), N9>0.977, not ab99(X). 
ab101(X) :- area(X,N0), N0>55563.0. 
ab102(X) :- shapefactor4(X,N15), N15=<0.996, not ab101(X). 
ab103(X) :- area(X,N0), N0>57187.0.