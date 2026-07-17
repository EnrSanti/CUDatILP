class(X,'dermason') :- convexarea(X,N6), N6=<40675.0, not ab2(X), not ab5(X), not ab7(X), not ab8(X), not ab12(X). 
class(X,'sira') :- majoraxislength(X,N2), N2=<343.84, sf1_sf3_ratio(X,N18), N18>0.009, not ab13(X), not ab14(X), not ab20(X), not ab24(X). 
class(X,'seker') :- shapefactor2(X,N13), N13>0.002, not ab29(X), not ab30(X), not ab33(X), not ab36(X), not ab37(X). 
class(X,'horoz') :- sf1_sf3_ratio(X,N18), N18>0.011, not ab38(X), not ab40(X), not ab43(X). 
class(X,'cali') :- roundness_compact_gap(X,N17), N17>0.054, not ab44(X), not ab53(X), not ab57(X), not ab60(X), not ab62(X), not ab63(X). 
class(X,'barbunya') :- area(X,N0), N0=<115967.0, not ab73(X), not ab76(X), not ab78(X), not ab79(X), not ab81(X), not ab82(X), not ab83(X). 
class(X,'bombay') :- area(X,N0), N0>94904.0. 
class(X,'sira') :- convexarea(X,N6), N6=<59041.0, perimeter_per_axis(X,N21), N21>1.611, not ab84(X), not ab85(X), not ab86(X), not ab89(X), not ab90(X), not ab91(X). 
class(X,'dermason') :- area(X,N0), N0=<42097.0, not ab93(X). 
class(X,'cali') :- roundness_compact_gap(X,N17), N17=<0.054, not ab94(X), not ab95(X), not ab96(X). 
class(X,'horoz') :- majoraxislength(X,N2), N2>323.547. 
class(X,'seker') :- shapefactor2(X,N13), N13=<0.002. 
class(X,'sira') :- area(X,N0), N0=<49699.0. 
class(X,'seker') :- area(X,N0), N0=<50695.0. 
ab1(X) :- extent(X,N8), N8>0.791, shapefactor4(X,N15), N15=<0.998, sf1_sf3_ratio(X,N18), N18>0.008. 
ab2(X) :- sf1_sf3_ratio(X,N18), N18=<0.009, not ab1(X). 
ab3(X) :- solidity(X,N9), N9>0.989, N9=<0.989. 
ab4(X) :- perimeter(X,N1), N1>736.997, N1=<739.41. 
ab5(X) :- perimeter(X,N1), N1>704.877, majoraxislength(X,N2), N2>290.431, perimeter_per_axis(X,N21), N21>1.612, not ab3(X), not ab4(X). 
ab6(X) :- area(X,N0), N0>39981.0, extent(X,N8), N8>0.799. 
ab7(X) :- perimeter(X,N1), N1>730.356, convexarea(X,N6), N6>36713.0, roundness_compact_gap(X,N17), N17=<0.092, perimeter_per_axis(X,N21), N21>1.612, not ab6(X). 
ab8(X) :- area(X,N0), N0=<34146.0, perimeter(X,N1), N1>704.877, convexarea(X,N6), N6>33891.0, extent(X,N8), N8>0.743. 
ab9(X) :- area(X,N0), N0=<36534.0, perimeter(X,N1), N1=<715.984, solidity(X,N9), N9=<0.987. 
ab10(X) :- solidity(X,N9), N9>0.988, N9=<0.989. 
ab11(X) :- area(X,N0), N0>36067.0, extent(X,N8), N8=<0.733. 
ab12(X) :- area(X,N0), N0=<36651.0, perimeter(X,N1), N1>704.877, convexarea(X,N6), N6>34000.0, compactness(X,N11), N11>0.829, not ab9(X), not ab10(X), not ab11(X). 
ab13(X) :- roundness(X,N10), N10=<0.835. 
ab14(X) :- convexarea(X,N6), N6=<42673.0, roundness(X,N10), N10>0.934. 
ab15(X) :- extent(X,N8), N8>0.806, shapefactor1(X,N12), N12=<0.007. 
ab16(X) :- roundness_compact_gap(X,N17), N17>0.109, N17=<0.115, extent_solidity_prod(X,N19), N19>0.78. 
ab17(X) :- area(X,N0), N0>41549.0. 
ab18(X) :- area(X,N0), N0>40517.0, solidity(X,N9), N9=<0.99, not ab17(X). 
ab19(X) :- minoraxislength(X,N3), N3=<185.221, shapefactor1(X,N12), N12=<0.007, roundness_compact_gap(X,N17), N17>0.109, N17=<0.115, not ab18(X). 
ab20(X) :- convexarea(X,N6), N6=<42673.0, roundness_compact_gap(X,N17), N17>0.108, not ab15(X), not ab16(X), not ab19(X). 
ab21(X) :- minoraxislength(X,N3), N3=<188.537, shapefactor4(X,N15), N15=<0.998. 
ab22(X) :- solidity(X,N9), N9=<0.987, perimeter_per_axis(X,N21), N21=<1.621. 
ab23(X) :- solidity(X,N9), N9>0.988, sf1_sf3_ratio(X,N18), N18=<0.009. 
ab24(X) :- perimeter(X,N1), N1=<766.264, compactness(X,N11), N11>0.847, not ab21(X), not ab22(X), not ab23(X). 
ab25(X) :- area(X,N0), N0>45347.0. 
ab26(X) :- perimeter(X,N1), N1=<716.9. 
ab27(X) :- compactness(X,N11), N11>0.867, not ab25(X), not ab26(X). 
ab28(X) :- area(X,N0), N0>38024.0, convexarea(X,N6), N6=<39768.0. 
ab29(X) :- shapefactor4(X,N15), N15=<0.996, ecc_roundness_gap(X,N20), N20>-0.274, not ab27(X), not ab28(X). 
ab30(X) :- sf1_sf3_ratio(X,N18), N18>0.01, ecc_roundness_gap(X,N20), N20>-0.249. 
ab31(X) :- minoraxislength(X,N3), N3=<228.016. 
ab32(X) :- area(X,N0), N0>52341.0, convexarea(X,N6), N6=<57737.0, not ab31(X). 
ab33(X) :- minoraxislength(X,N3), N3>227.61, ecc_roundness_gap(X,N20), N20>-0.326, not ab32(X). 
ab34(X) :- majoraxislength(X,N2), N2>297.87. 
ab35(X) :- area(X,N0), N0>47719.0, not ab34(X). 
ab36(X) :- perimeter(X,N1), N1>786.993, shapefactor4(X,N15), N15=<0.998, sf1_sf3_ratio(X,N18), N18>0.009, not ab35(X). 
ab37(X) :- area(X,N0), N0>28395.0, majoraxislength(X,N2), N2=<234.004, extent(X,N8), N8=<0.765, shapefactor2(X,N13), N13>0.002, sf1_sf3_ratio(X,N18), N18>0.009. 
ab38(X) :- shapefactor2(X,N13), N13>0.001, sf1_sf3_ratio(X,N18), N18=<0.013. 
ab39(X) :- roundness_compact_gap(X,N17), N17>0.116. 
ab40(X) :- roundness(X,N10), N10>0.843, sf1_sf3_ratio(X,N18), N18=<0.013, not ab39(X). 
ab41(X) :- area(X,N0), N0>73623.0. 
ab42(X) :- shapefactor4(X,N15), N15=<0.99, sf1_sf3_ratio(X,N18), N18=<0.011. 
ab43(X) :- extent(X,N8), N8>0.708, shapefactor1(X,N12), N12=<0.006, sf1_sf3_ratio(X,N18), N18=<0.013, not ab41(X), not ab42(X). 
ab44(X) :- area(X,N0), N0>116272.0. 
ab45(X) :- extent(X,N8), N8>0.819. 
ab46(X) :- aspectration(X,N4), N4>1.669, ecc_roundness_gap(X,N20), N20=<-0.032. 
ab47(X) :- perimeter(X,N1), N1>932.813, extent(X,N8), N8>0.799, shapefactor4(X,N15), N15>0.993. 
ab48(X) :- area(X,N0), N0=<63406.0, perimeter(X,N1), N1>932.813, majoraxislength(X,N2), N2>358.257. 
ab49(X) :- perimeter(X,N1), N1>897.669, extent(X,N8), N8>0.704, shapefactor4(X,N15), N15=<0.997, not ab45(X), not ab46(X), not ab47(X), not ab48(X). 
ab50(X) :- area(X,N0), N0>65383.0. 
ab51(X) :- majoraxislength(X,N2), N2>350.632, shapefactor2(X,N13), N13>0.001, not ab50(X). 
ab52(X) :- majoraxislength(X,N2), N2>350.154, shapefactor4(X,N15), N15>0.994, ecc_roundness_gap(X,N20), N20>-0.028. 
ab53(X) :- majoraxislength(X,N2), N2=<360.623, not ab49(X), not ab51(X), not ab52(X). 
ab54(X) :- perimeter(X,N1), N1=<961.198. 
ab55(X) :- extent(X,N8), N8=<0.741, shapefactor4(X,N15), N15=<0.996, sf1_sf3_ratio(X,N18), N18>0.009. 
ab56(X) :- area(X,N0), N0=<79236.0, perimeter(X,N1), N1>1088.437. 
ab57(X) :- solidity(X,N9), N9=<0.989, shapefactor4(X,N15), N15>0.996, not ab54(X), not ab55(X), not ab56(X). 
ab58(X) :- aspectration(X,N4), N4>1.636. 
ab59(X) :- area(X,N0), N0=<81817.0, shapefactor4(X,N15), N15>0.997. 
ab60(X) :- roundness(X,N10), N10=<0.868, shapefactor4(X,N15), N15>0.992, roundness_compact_gap(X,N17), N17=<0.079, sf1_sf3_ratio(X,N18), N18=<0.008, not ab58(X), not ab59(X). 
ab61(X) :- minoraxislength(X,N3), N3>250.584. 
ab62(X) :- solidity(X,N9), N9=<0.985, shapefactor4(X,N15), N15>0.993, perimeter_per_axis(X,N21), N21>1.66, not ab61(X). 
ab63(X) :- area(X,N0), N0>79004.0, solidity(X,N9), N9>0.991, shapefactor4(X,N15), N15>0.995, perimeter_per_axis(X,N21), N21=<1.614. 
ab64(X) :- area(X,N0), N0>41487.0, extent(X,N8), N8=<0.723. 
ab65(X) :- area(X,N0), N0>39949.0, majoraxislength(X,N2), N2=<300.63, not ab64(X). 
ab66(X) :- area(X,N0), N0>34783.0, shapefactor4(X,N15), N15>0.998. 
ab67(X) :- convexarea(X,N6), N6=<47992.0, not ab65(X), not ab66(X). 
ab68(X) :- perimeter_per_axis(X,N21), N21>1.663, not ab67(X). 
ab69(X) :- solidity(X,N9), N9=<0.976. 
ab70(X) :- minoraxislength(X,N3), N3>210.486, aspectration(X,N4), N4>1.442, shapefactor1(X,N12), N12=<0.006, not ab69(X). 
ab71(X) :- area(X,N0), N0>57103.0. 
ab72(X) :- perimeter(X,N1), N1>900.96, shapefactor4(X,N15), N15>0.997, not ab71(X). 
ab73(X) :- perimeter(X,N1), N1=<921.449, not ab68(X), not ab70(X), not ab72(X). 
ab74(X) :- perimeter(X,N1), N1=<1002.774. 
ab75(X) :- area(X,N0), N0=<68859.0, roundness_compact_gap(X,N17), N17=<0.035, not ab74(X). 
ab76(X) :- shapefactor4(X,N15), N15=<0.988, roundness_compact_gap(X,N17), N17>0.01, not ab75(X). 
ab77(X) :- shapefactor4(X,N15), N15>0.997. 
ab78(X) :- solidity(X,N9), N9>0.985, compactness(X,N11), N11=<0.751, roundness_compact_gap(X,N17), N17>0.031, not ab77(X). 
ab79(X) :- solidity(X,N9), N9>0.989, roundness_compact_gap(X,N17), N17>0.044, perimeter_per_axis(X,N21), N21>1.661. 
ab80(X) :- perimeter(X,N1), N1=<995.08. 
ab81(X) :- solidity(X,N9), N9=<0.985, shapefactor2(X,N13), N13=<0.001, shapefactor4(X,N15), N15=<0.995, roundness_compact_gap(X,N17), N17>0.043, not ab80(X). 
ab82(X) :- majoraxislength(X,N2), N2>428.965, extent(X,N8), N8=<0.749, solidity(X,N9), N9>0.984. 
ab83(X) :- minoraxislength(X,N3), N3>198.619, shapefactor1(X,N12), N12>0.006. 
ab84(X) :- shapefactor4(X,N15), N15=<0.986. 
ab85(X) :- shapefactor2(X,N13), N13>0.001, roundness_compact_gap(X,N17), N17>0.081. 
ab86(X) :- minoraxislength(X,N3), N3>224.729, shapefactor2(X,N13), N13>0.002. 
ab87(X) :- area(X,N0), N0>39654.0. 
ab88(X) :- area(X,N0), N0>38980.0, not ab87(X). 
ab89(X) :- convexarea(X,N6), N6=<41318.0, extent(X,N8), N8=<0.757, not ab88(X). 
ab90(X) :- area(X,N0), N0=<51643.0, shapefactor1(X,N12), N12=<0.006. 
ab91(X) :- area(X,N0), N0>36876.0, N0=<39127.0. 
ab92(X) :- area(X,N0), N0=<41443.0. 
ab93(X) :- perimeter(X,N1), N1=<756.279, shapefactor4(X,N15), N15>0.998, not ab92(X). 
ab94(X) :- minoraxislength(X,N3), N3=<237.9, shapefactor4(X,N15), N15=<0.978. 
ab95(X) :- area(X,N0), N0=<72012.0, extent(X,N8), N8=<0.738, solidity(X,N9), N9>0.977. 
ab96(X) :- aspectration(X,N4), N4>1.849.