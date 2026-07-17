class(X,'dermason') :- area(X,N0), N0=<42159.0, not ab27(X), not ab33(X), not ab43(X), not ab46(X), not ab48(X), not ab49(X), not ab50(X). 
class(X,'sira') :- majoraxislength(X,N2), N2=<343.84, sf1_sf3_ratio(X,N18), N18>0.009, not ab70(X), not ab77(X), not ab78(X), not ab81(X), not ab82(X), not ab83(X). 
class(X,'seker') :- shapefactor2(X,N13), N13>0.002, not ab92(X), not ab93(X), not ab94(X), not ab99(X), not ab102(X), not ab103(X), not ab104(X), not ab106(X), not ab107(X), not ab108(X). 
class(X,'horoz') :- sf1_sf3_ratio(X,N18), N18>0.011, not ab110(X), not ab115(X), not ab116(X). 
class(X,'cali') :- roundness_compact_gap(X,N17), N17>0.05, not ab117(X), not ab130(X), not ab143(X), not ab145(X), not ab146(X). 
class(X,'barbunya') :- area(X,N0), N0=<115967.0, not ab154(X), not ab157(X), not ab158(X), not ab161(X), not ab162(X), not ab163(X), not ab164(X), not ab166(X), not ab167(X). 
class(X,'bombay') :- area(X,N0), N0>92325.0. 
class(X,'sira') :- perimeter(X,N1), N1=<937.773, not ab171(X), not ab172(X), not ab173(X), not ab174(X), not ab175(X), not ab176(X), not ab177(X). 
class(X,'dermason') :- majoraxislength(X,N2), N2=<280.107. 
class(X,'horoz') :- sf1_sf3_ratio(X,N18), N18>0.01, not ab178(X), not ab179(X). 
class(X,'cali') :- roundness_compact_gap(X,N17), N17=<0.049, not ab180(X), not ab182(X), not ab183(X). 
class(X,'seker') :- perimeter(X,N1), N1=<906.71. 
class(X,'horoz') :- area(X,N0), N0>56290.0. 
class(X,'horoz') :- area(X,N0), N0=<56290.0. 
ab1(X) :- area(X,N0), N0=<39528.0. 
ab2(X) :- extent(X,N8), N8>0.791, not ab1(X). 
ab3(X) :- perimeter(X,N1), N1=<738.594, roundness(X,N10), N10=<0.911. 
ab4(X) :- perimeter(X,N1), N1=<741.904. 
ab5(X) :- area(X,N0), N0>39453.0, not ab4(X). 
ab6(X) :- minoraxislength(X,N3), N3=<187.896, convexarea(X,N6), N6>39885.0, extent(X,N8), N8=<0.776, not ab5(X). 
ab7(X) :- convexarea(X,N6), N6>39580.0, roundness_compact_gap(X,N17), N17=<0.083, not ab2(X), not ab3(X), not ab6(X). 
ab8(X) :- area(X,N0), N0>38760.0. 
ab9(X) :- aspectration(X,N4), N4>1.422, extent(X,N8), N8=<0.735, perimeter_per_axis(X,N21), N21>1.619, not ab8(X). 
ab10(X) :- extent(X,N8), N8=<0.734, shapefactor1(X,N12), N12=<0.007, shapefactor4(X,N15), N15=<0.994. 
ab11(X) :- extent(X,N8), N8=<0.734, shapefactor2(X,N13), N13>0.002, shapefactor4(X,N15), N15>0.998, N15=<0.998. 
ab12(X) :- solidity(X,N9), N9>0.991. 
ab13(X) :- area(X,N0), N0>37832.0, N0=<39058.0, extent(X,N8), N8=<0.734, shapefactor4(X,N15), N15>0.998, not ab12(X). 
ab14(X) :- perimeter(X,N1), N1=<746.911, sf1_sf3_ratio(X,N18), N18>0.009, not ab7(X), not ab9(X), not ab10(X), not ab11(X), not ab13(X). 
ab15(X) :- perimeter(X,N1), N1=<750.442, solidity(X,N9), N9>0.991. 
ab16(X) :- area(X,N0), N0>42097.0. 
ab17(X) :- convexarea(X,N6), N6>42324.0. 
ab18(X) :- majoraxislength(X,N2), N2=<288.941, roundness_compact_gap(X,N17), N17>0.116, not ab17(X). 
ab19(X) :- perimeter(X,N1), N1>746.698, shapefactor4(X,N15), N15>0.997, roundness_compact_gap(X,N17), N17>0.104, sf1_sf3_ratio(X,N18), N18>0.009, not ab15(X), not ab16(X), not ab18(X). 
ab20(X) :- perimeter(X,N1), N1>772.831. 
ab21(X) :- perimeter(X,N1), N1>770.656, not ab20(X). 
ab22(X) :- extent(X,N8), N8>0.774, not ab21(X). 
ab23(X) :- perimeter(X,N1), N1>746.698, majoraxislength(X,N2), N2>289.957, shapefactor4(X,N15), N15>0.997, sf1_sf3_ratio(X,N18), N18>0.009, not ab22(X). 
ab24(X) :- aspectration(X,N4), N4=<1.578. 
ab25(X) :- area(X,N0), N0=<41318.0, not ab24(X). 
ab26(X) :- perimeter(X,N1), N1>746.698, aspectration(X,N4), N4>1.578, solidity(X,N9), N9=<0.989, shapefactor2(X,N13), N13=<0.002, sf1_sf3_ratio(X,N18), N18>0.009, ecc_roundness_gap(X,N20), N20=<-0.109, not ab25(X). 
ab27(X) :- minoraxislength(X,N3), N3>180.769, not ab14(X), not ab19(X), not ab23(X), not ab26(X). 
ab28(X) :- minoraxislength(X,N3), N3>175.356, shapefactor4(X,N15), N15>0.995. 
ab29(X) :- roundness_compact_gap(X,N17), N17>0.112, ecc_roundness_gap(X,N20), N20=<-0.019, not ab28(X). 
ab30(X) :- extent(X,N8), N8>0.716. 
ab31(X) :- majoraxislength(X,N2), N2=<299.465, shapefactor4(X,N15), N15>0.998, not ab30(X). 
ab32(X) :- area(X,N0), N0=<41888.0, minoraxislength(X,N3), N3>179.416. 
ab33(X) :- perimeter(X,N1), N1>702.212, majoraxislength(X,N2), N2>296.058, not ab29(X), not ab31(X), not ab32(X). 
ab34(X) :- area(X,N0), N0>41448.0. 
ab35(X) :- convexarea(X,N6), N6=<40384.0, extent(X,N8), N8=<0.788, roundness_compact_gap(X,N17), N17=<0.062. 
ab36(X) :- minoraxislength(X,N3), N3>177.654. 
ab37(X) :- solidity(X,N9), N9=<0.988, perimeter_per_axis(X,N21), N21=<1.622. 
ab38(X) :- sf1_sf3_ratio(X,N18), N18>0.012, N18=<0.012. 
ab39(X) :- minoraxislength(X,N3), N3=<171.498, shapefactor1(X,N12), N12=<0.008. 
ab40(X) :- solidity(X,N9), N9=<0.981. 
ab41(X) :- shapefactor4(X,N15), N15=<0.993, not ab40(X). 
ab42(X) :- roundness_compact_gap(X,N17), N17>0.092, extent_solidity_prod(X,N19), N19=<0.792, not ab36(X), not ab37(X), not ab38(X), not ab39(X), not ab41(X). 
ab43(X) :- perimeter(X,N1), N1>702.212, majoraxislength(X,N2), N2>275.31, minoraxislength(X,N3), N3=<182.286, perimeter_per_axis(X,N21), N21>1.619, not ab34(X), not ab35(X), not ab42(X). 
ab44(X) :- area(X,N0), N0=<39688.0, solidity(X,N9), N9=<0.988. 
ab45(X) :- minoraxislength(X,N3), N3>180.706. 
ab46(X) :- area(X,N0), N0>33167.0, perimeter(X,N1), N1>748.428, majoraxislength(X,N2), N2=<293.214, shapefactor4(X,N15), N15=<0.997, roundness_compact_gap(X,N17), N17>0.103, not ab44(X), not ab45(X). 
ab47(X) :- majoraxislength(X,N2), N2>248.935. 
ab48(X) :- area(X,N0), N0>33167.0, perimeter(X,N1), N1=<704.877, shapefactor4(X,N15), N15>0.999, roundness_compact_gap(X,N17), N17=<0.084, not ab47(X). 
ab49(X) :- area(X,N0), N0>33167.0, perimeter(X,N1), N1=<704.877, convexarea(X,N6), N6=<33564.0, roundness_compact_gap(X,N17), N17=<0.076. 
ab50(X) :- area(X,N0), N0>30489.0, perimeter(X,N1), N1>748.428, shapefactor2(X,N13), N13>0.002. 
ab51(X) :- aspectration(X,N4), N4=<1.527. 
ab52(X) :- aspectration(X,N4), N4>1.802. 
ab53(X) :- aspectration(X,N4), N4=<1.882, roundness(X,N10), N10>0.835, shapefactor1(X,N12), N12>0.006, not ab51(X), not ab52(X). 
ab54(X) :- minoraxislength(X,N3), N3=<177.081. 
ab55(X) :- minoraxislength(X,N3), N3=<181.747, not ab54(X). 
ab56(X) :- solidity(X,N9), N9>0.984. 
ab57(X) :- shapefactor4(X,N15), N15>0.997, not ab55(X), not ab56(X). 
ab58(X) :- ecc_roundness_gap(X,N20), N20=<-0.112. 
ab59(X) :- aspectration(X,N4), N4>1.787. 
ab60(X) :- aspectration(X,N4), N4>1.617, roundness(X,N10), N10>0.826, not ab59(X). 
ab61(X) :- perimeter(X,N1), N1>951.106. 
ab62(X) :- aspectration(X,N4), N4=<1.726, not ab61(X). 
ab63(X) :- ecc_roundness_gap(X,N20), N20>0.023, not ab62(X). 
ab64(X) :- perimeter(X,N1), N1=<741.988. 
ab65(X) :- area(X,N0), N0>50976.0, N0=<51332.0. 
ab66(X) :- aspectration(X,N4), N4=<1.882, solidity(X,N9), N9=<0.985, shapefactor1(X,N12), N12>0.006, shapefactor4(X,N15), N15>0.988, sf1_sf3_ratio(X,N18), N18=<0.014, not ab57(X), not ab58(X), not ab60(X), not ab63(X), not ab64(X), not ab65(X). 
ab67(X) :- majoraxislength(X,N2), N2>325.483. 
ab68(X) :- roundness(X,N10), N10>0.805, shapefactor4(X,N15), N15=<0.982, not ab67(X). 
ab69(X) :- aspectration(X,N4), N4=<1.867, solidity(X,N9), N9>0.989. 
ab70(X) :- roundness(X,N10), N10=<0.838, not ab53(X), not ab66(X), not ab68(X), not ab69(X). 
ab71(X) :- extent(X,N8), N8>0.783. 
ab72(X) :- roundness(X,N10), N10=<0.9. 
ab73(X) :- shapefactor4(X,N15), N15=<0.995, not ab72(X). 
ab74(X) :- aspectration(X,N4), N4>1.411. 
ab75(X) :- extent(X,N8), N8>0.756, N8=<0.756. 
ab76(X) :- extent(X,N8), N8>0.774, N8=<0.775. 
ab77(X) :- perimeter(X,N1), N1=<764.43, sf1_sf3_ratio(X,N18), N18=<0.009, not ab71(X), not ab73(X), not ab74(X), not ab75(X), not ab76(X). 
ab78(X) :- perimeter(X,N1), N1=<766.264, minoraxislength(X,N3), N3=<161.112. 
ab79(X) :- area(X,N0), N0=<38118.0. 
ab80(X) :- perimeter(X,N1), N1=<748.29, not ab79(X). 
ab81(X) :- perimeter(X,N1), N1=<766.264, solidity(X,N9), N9>0.991, perimeter_per_axis(X,N21), N21=<1.602, not ab80(X). 
ab82(X) :- perimeter(X,N1), N1>765.942, N1=<766.264, majoraxislength(X,N2), N2=<276.303. 
ab83(X) :- minoraxislength(X,N3), N3>207.066, shapefactor4(X,N15), N15>0.998. 
ab84(X) :- area(X,N0), N0>45347.0. 
ab85(X) :- roundness_compact_gap(X,N17), N17=<-0.069, not ab84(X). 
ab86(X) :- perimeter(X,N1), N1=<732.733. 
ab87(X) :- area(X,N0), N0>51268.0. 
ab88(X) :- ecc_roundness_gap(X,N20), N20=<-0.272, not ab86(X), not ab87(X). 
ab89(X) :- area(X,N0), N0>42590.0. 
ab90(X) :- area(X,N0), N0>41572.0, sf1_sf3_ratio(X,N18), N18>0.009, not ab89(X). 
ab91(X) :- area(X,N0), N0>38659.0, convexarea(X,N6), N6=<39768.0. 
ab92(X) :- shapefactor4(X,N15), N15=<0.997, ecc_roundness_gap(X,N20), N20>-0.289, not ab85(X), not ab88(X), not ab90(X), not ab91(X). 
ab93(X) :- area(X,N0), N0>59385.0, roundness(X,N10), N10=<0.936, shapefactor2(X,N13), N13=<0.002, ecc_roundness_gap(X,N20), N20>-0.326. 
ab94(X) :- solidity(X,N9), N9=<0.991, shapefactor2(X,N13), N13=<0.002, shapefactor4(X,N15), N15=<0.999, roundness_compact_gap(X,N17), N17>0.083, ecc_roundness_gap(X,N20), N20>-0.247. 
ab95(X) :- area(X,N0), N0>46373.0, roundness_compact_gap(X,N17), N17=<0.067. 
ab96(X) :- perimeter(X,N1), N1=<757.238. 
ab97(X) :- aspectration(X,N4), N4>1.422. 
ab98(X) :- area(X,N0), N0=<42158.0, not ab96(X), not ab97(X). 
ab99(X) :- aspectration(X,N4), N4>1.381, shapefactor4(X,N15), N15=<0.998, roundness_compact_gap(X,N17), N17=<0.078, ecc_roundness_gap(X,N20), N20>-0.326, not ab95(X), not ab98(X). 
ab100(X) :- shapefactor1(X,N12), N12=<0.005. 
ab101(X) :- solidity(X,N9), N9>0.99. 
ab102(X) :- minoraxislength(X,N3), N3>227.61, ecc_roundness_gap(X,N20), N20>-0.326, not ab100(X), not ab101(X). 
ab103(X) :- area(X,N0), N0>40688.0, majoraxislength(X,N2), N2=<264.545, solidity(X,N9), N9=<0.991, shapefactor4(X,N15), N15>0.999, ecc_roundness_gap(X,N20), N20>-0.33, perimeter_per_axis(X,N21), N21=<1.597. 
ab104(X) :- area(X,N0), N0>35932.0, perimeter(X,N1), N1=<689.826, shapefactor4(X,N15), N15>0.999, ecc_roundness_gap(X,N20), N20>-0.33. 
ab105(X) :- minoraxislength(X,N3), N3>197.324. 
ab106(X) :- extent(X,N8), N8>0.791, solidity(X,N9), N9=<0.99, shapefactor1(X,N12), N12>0.006, shapefactor4(X,N15), N15=<0.999, ecc_roundness_gap(X,N20), N20>-0.326, not ab105(X). 
ab107(X) :- area(X,N0), N0>35608.0, perimeter(X,N1), N1=<693.373, extent(X,N8), N8>0.778, shapefactor4(X,N15), N15=<0.999, ecc_roundness_gap(X,N20), N20>-0.331. 
ab108(X) :- area(X,N0), N0=<50001.0, majoraxislength(X,N2), N2>292.003, extent(X,N8), N8>0.778, shapefactor4(X,N15), N15=<0.999, ecc_roundness_gap(X,N20), N20>-0.331. 
ab109(X) :- area(X,N0), N0>57391.0. 
ab110(X) :- roundness(X,N10), N10>0.843, sf1_sf3_ratio(X,N18), N18=<0.012, not ab109(X). 
ab111(X) :- minoraxislength(X,N3), N3>216.46. 
ab112(X) :- extent(X,N8), N8=<0.708, not ab111(X). 
ab113(X) :- extent(X,N8), N8>0.804. 
ab114(X) :- area(X,N0), N0=<68315.0, sf1_sf3_ratio(X,N18), N18=<0.011. 
ab115(X) :- shapefactor1(X,N12), N12=<0.006, shapefactor2(X,N13), N13>0.001, sf1_sf3_ratio(X,N18), N18=<0.013, not ab112(X), not ab113(X), not ab114(X). 
ab116(X) :- aspectration(X,N4), N4>1.884, compactness(X,N11), N11>0.724, shapefactor4(X,N15), N15>0.995, sf1_sf3_ratio(X,N18), N18=<0.013. 
ab117(X) :- area(X,N0), N0>116272.0. 
ab118(X) :- extent(X,N8), N8>0.82. 
ab119(X) :- solidity(X,N9), N9=<0.988, shapefactor4(X,N15), N15>0.993. 
ab120(X) :- area(X,N0), N0>60153.0. 
ab121(X) :- perimeter_per_axis(X,N21), N21>1.631, N21=<1.637, not ab120(X). 
ab122(X) :- perimeter(X,N1), N1>903.559, N1=<906.065. 
ab123(X) :- perimeter(X,N1), N1>897.669, extent(X,N8), N8>0.744, shapefactor4(X,N15), N15=<0.997, not ab118(X), not ab119(X), not ab121(X), not ab122(X). 
ab124(X) :- majoraxislength(X,N2), N2=<356.039. 
ab125(X) :- extent(X,N8), N8=<0.703, not ab124(X). 
ab126(X) :- convexarea(X,N6), N6>59888.0, extent_solidity_prod(X,N19), N19=<0.707, not ab125(X). 
ab127(X) :- shapefactor4(X,N15), N15>0.999. 
ab128(X) :- area(X,N0), N0>55938.0, N0=<56333.0. 
ab129(X) :- area(X,N0), N0>55912.0, minoraxislength(X,N3), N3=<205.53, sf1_sf3_ratio(X,N18), N18>0.01, N18=<0.011, not ab128(X). 
ab130(X) :- area(X,N0), N0=<60993.0, not ab123(X), not ab126(X), not ab127(X), not ab129(X). 
ab131(X) :- roundness(X,N10), N10=<0.832. 
ab132(X) :- area(X,N0), N0=<81817.0, aspectration(X,N4), N4=<1.677. 
ab133(X) :- area(X,N0), N0>69923.0, shapefactor2(X,N13), N13>0.001, not ab131(X), not ab132(X). 
ab134(X) :- solidity(X,N9), N9>0.989, roundness(X,N10), N10=<0.864, not ab133(X). 
ab135(X) :- aspectration(X,N4), N4>1.848. 
ab136(X) :- minoraxislength(X,N3), N3=<214.483, convexarea(X,N6), N6=<64960.0, not ab135(X). 
ab137(X) :- area(X,N0), N0=<62787.0. 
ab138(X) :- perimeter_per_axis(X,N21), N21=<1.619, not ab137(X). 
ab139(X) :- solidity(X,N9), N9=<0.988, shapefactor4(X,N15), N15=<0.996, perimeter_per_axis(X,N21), N21=<1.642. 
ab140(X) :- majoraxislength(X,N2), N2=<352.161, extent(X,N8), N8=<0.728. 
ab141(X) :- extent(X,N8), N8>0.698. 
ab142(X) :- aspectration(X,N4), N4>1.748, N4=<1.759, not ab141(X). 
ab143(X) :- solidity(X,N9), N9=<0.99, shapefactor4(X,N15), N15>0.996, not ab134(X), not ab136(X), not ab138(X), not ab139(X), not ab140(X), not ab142(X). 
ab144(X) :- minoraxislength(X,N3), N3=<246.115. 
ab145(X) :- majoraxislength(X,N2), N2=<403.174, roundness(X,N10), N10=<0.868, sf1_sf3_ratio(X,N18), N18=<0.008, not ab144(X). 
ab146(X) :- majoraxislength(X,N2), N2=<397.287, compactness(X,N11), N11>0.81, sf1_sf3_ratio(X,N18), N18=<0.008, extent_solidity_prod(X,N19), N19>0.765. 
ab147(X) :- area(X,N0), N0>60871.0. 
ab148(X) :- area(X,N0), N0>57994.0. 
ab149(X) :- solidity(X,N9), N9>0.99, not ab148(X). 
ab150(X) :- majoraxislength(X,N2), N2>325.293, aspectration(X,N4), N4=<1.638, shapefactor1(X,N12), N12=<0.006, not ab149(X). 
ab151(X) :- extent(X,N8), N8=<0.768. 
ab152(X) :- area(X,N0), N0>46373.0, minoraxislength(X,N3), N3>204.662, shapefactor1(X,N12), N12>0.006, shapefactor4(X,N15), N15>0.997, not ab151(X). 
ab153(X) :- minoraxislength(X,N3), N3=<216.796, shapefactor1(X,N12), N12=<0.006. 
ab154(X) :- perimeter_per_axis(X,N21), N21=<1.637, not ab147(X), not ab150(X), not ab152(X), not ab153(X). 
ab155(X) :- perimeter(X,N1), N1=<1020.755, perimeter_per_axis(X,N21), N21>1.679. 
ab156(X) :- aspectration(X,N4), N4>1.849. 
ab157(X) :- shapefactor4(X,N15), N15=<0.989, roundness_compact_gap(X,N17), N17>0.01, not ab155(X), not ab156(X). 
ab158(X) :- perimeter(X,N1), N1=<796.404, minoraxislength(X,N3), N3=<213.958. 
ab159(X) :- roundness_compact_gap(X,N17), N17=<0.049. 
ab160(X) :- shapefactor4(X,N15), N15>0.997. 
ab161(X) :- perimeter(X,N1), N1=<966.574, compactness(X,N11), N11=<0.763, not ab159(X), not ab160(X). 
ab162(X) :- aspectration(X,N4), N4>1.81, extent(X,N8), N8=<0.645. 
ab163(X) :- aspectration(X,N4), N4=<1.444, shapefactor4(X,N15), N15=<0.994, roundness_compact_gap(X,N17), N17>0.028. 
ab164(X) :- majoraxislength(X,N2), N2=<387.49, extent(X,N8), N8>0.744, compactness(X,N11), N11=<0.759, shapefactor4(X,N15), N15=<0.997. 
ab165(X) :- extent(X,N8), N8=<0.679. 
ab166(X) :- solidity(X,N9), N9>0.984, shapefactor2(X,N13), N13=<0.001, shapefactor4(X,N15), N15=<0.997, not ab165(X). 
ab167(X) :- extent(X,N8), N8>0.724, N8=<0.754, roundness_compact_gap(X,N17), N17>0.046, N17=<0.049. 
ab168(X) :- aspectration(X,N4), N4=<1.284. 
ab169(X) :- area(X,N0), N0=<40467.0, shapefactor1(X,N12), N12=<0.006. 
ab170(X) :- shapefactor4(X,N15), N15=<0.997, sf1_sf3_ratio(X,N18), N18=<0.009, not ab168(X), not ab169(X). 
ab171(X) :- area(X,N0), N0=<41979.0, not ab170(X). 
ab172(X) :- majoraxislength(X,N2), N2>302.712, minoraxislength(X,N3), N3>204.823, perimeter_per_axis(X,N21), N21=<1.609. 
ab173(X) :- shapefactor4(X,N15), N15=<0.986. 
ab174(X) :- minoraxislength(X,N3), N3>224.729. 
ab175(X) :- perimeter(X,N1), N1=<906.71, convexarea(X,N6), N6>57675.0. 
ab176(X) :- minoraxislength(X,N3), N3>206.614, N3=<206.654. 
ab177(X) :- minoraxislength(X,N3), N3>210.418, shapefactor4(X,N15), N15>0.998. 
ab178(X) :- area(X,N0), N0=<41607.0. 
ab179(X) :- area(X,N0), N0>73451.0. 
ab180(X) :- shapefactor1(X,N12), N12>0.006. 
ab181(X) :- area(X,N0), N0=<66306.0. 
ab182(X) :- extent(X,N8), N8=<0.694, not ab181(X). 
ab183(X) :- roundness(X,N10), N10>0.819, N10=<0.826.