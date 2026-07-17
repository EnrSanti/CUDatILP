class(X,'dermason') :- convexarea(X,N6), N6=<40675.0, not ab2(X), not ab5(X), not ab17(X), not ab18(X), not ab22(X), not ab23(X), not ab24(X), not ab28(X), not ab29(X). 
class(X,'sira') :- majoraxislength(X,N2), N2=<343.84, sf1_sf3_ratio(X,N18), N18>0.009, not ab30(X), not ab31(X), not ab39(X), not ab46(X), not ab51(X), not ab52(X). 
class(X,'seker') :- shapefactor2(X,N13), N13>0.002, not ab54(X), not ab58(X), not ab60(X), not ab64(X), not ab65(X). 
class(X,'horoz') :- sf1_sf3_ratio(X,N18), N18>0.011, not ab67(X), not ab69(X), not ab75(X), not ab78(X). 
class(X,'cali') :- roundness_compact_gap(X,N17), N17>0.054, not ab79(X), not ab87(X), not ab95(X), not ab97(X), not ab99(X), not ab101(X), not ab103(X), not ab104(X), not ab105(X), not ab107(X), not ab108(X). 
class(X,'barbunya') :- roundness_compact_gap(X,N17), N17=<0.036, not ab109(X), not ab111(X), not ab112(X), not ab114(X), not ab117(X), not ab118(X), not ab119(X). 
class(X,'bombay') :- area(X,N0), N0>105542.0. 
class(X,'barbunya') :- area(X,N0), N0>58074.0, not ab120(X), not ab125(X). 
class(X,'sira') :- perimeter(X,N1), N1>769.398, convexarea(X,N6), N6=<59041.0, not ab126(X), not ab131(X), not ab133(X), not ab135(X), not ab138(X), not ab140(X). 
class(X,'dermason') :- minoraxislength(X,N3), N3=<195.449, not ab141(X), not ab143(X), not ab144(X). 
class(X,'cali') :- minoraxislength(X,N3), N3>220.489, not ab145(X), not ab146(X), not ab147(X), not ab148(X). 
class(X,'horoz') :- majoraxislength(X,N2), N2>342.891, not ab149(X), not ab150(X). 
class(X,'seker') :- shapefactor4(X,N15), N15>0.997, not ab152(X), not ab153(X), not ab154(X). 
class(X,'barbunya') :- aspectration(X,N4), N4>1.442. 
class(X,'sira') :- area(X,N0), N0=<40740.0. 
class(X,'seker') :- area(X,N0), N0>51643.0. 
class(X,'dermason') :- area(X,N0), N0=<40774.0. 
class(X,'cali') :- area(X,N0), N0>47981.0. 
class(X,'barbunya') :- area(X,N0), N0>41698.0. 
class(X,'sira') :- area(X,N0), N0=<41698.0. 
ab1(X) :- extent(X,N8), N8>0.791, shapefactor4(X,N15), N15=<0.998, sf1_sf3_ratio(X,N18), N18>0.008. 
ab2(X) :- sf1_sf3_ratio(X,N18), N18=<0.009, not ab1(X). 
ab3(X) :- area(X,N0), N0>39147.0. 
ab4(X) :- majoraxislength(X,N2), N2>293.688, N2=<298.088, shapefactor4(X,N15), N15>0.995, not ab3(X). 
ab5(X) :- perimeter(X,N1), N1>704.877, majoraxislength(X,N2), N2>290.431, perimeter_per_axis(X,N21), N21>1.613, not ab4(X). 
ab6(X) :- perimeter(X,N1), N1>729.628. 
ab7(X) :- solidity(X,N9), N9=<0.986, not ab6(X). 
ab8(X) :- area(X,N0), N0=<37225.0, not ab7(X). 
ab9(X) :- extent_solidity_prod(X,N19), N19>0.801. 
ab10(X) :- minoraxislength(X,N3), N3>183.688, shapefactor4(X,N15), N15>0.998. 
ab11(X) :- aspectration(X,N4), N4>1.497, ecc_roundness_gap(X,N20), N20>-0.19, N20=<-0.145. 
ab12(X) :- majoraxislength(X,N2), N2=<267.082, ecc_roundness_gap(X,N20), N20>-0.19, perimeter_per_axis(X,N21), N21=<1.614. 
ab13(X) :- shapefactor4(X,N15), N15=<0.991. 
ab14(X) :- extent(X,N8), N8=<0.714. 
ab15(X) :- minoraxislength(X,N3), N3=<182.741, shapefactor1(X,N12), N12=<0.007, not ab14(X). 
ab16(X) :- perimeter(X,N1), N1=<730.356, not ab8(X), not ab9(X), not ab10(X), not ab11(X), not ab12(X), not ab13(X), not ab15(X). 
ab17(X) :- perimeter(X,N1), N1>704.877, convexarea(X,N6), N6>37545.0, roundness_compact_gap(X,N17), N17=<0.092, perimeter_per_axis(X,N21), N21>1.612, not ab16(X). 
ab18(X) :- area(X,N0), N0>33069.0, N0=<34146.0, perimeter(X,N1), N1>704.877, extent_solidity_prod(X,N19), N19>0.732. 
ab19(X) :- majoraxislength(X,N2), N2>256.821, shapefactor2(X,N13), N13>0.002. 
ab20(X) :- perimeter(X,N1), N1=<706.337. 
ab21(X) :- perimeter(X,N1), N1=<709.64, roundness_compact_gap(X,N17), N17=<0.069, not ab20(X). 
ab22(X) :- area(X,N0), N0>33069.0, perimeter(X,N1), N1>704.877, solidity(X,N9), N9=<0.989, extent_solidity_prod(X,N19), N19>0.732, ecc_roundness_gap(X,N20), N20>-0.274, N20=<-0.201, not ab19(X), not ab21(X). 
ab23(X) :- area(X,N0), N0>33069.0, N0=<36408.0, perimeter(X,N1), N1>713.066, minoraxislength(X,N3), N3>179.019, roundness(X,N10), N10=<0.894. 
ab24(X) :- area(X,N0), N0>33069.0, perimeter(X,N1), N1>755.236, N1=<755.253, majoraxislength(X,N2), N2>286.879, roundness_compact_gap(X,N17), N17=<0.108, sf1_sf3_ratio(X,N18), N18>0.012. 
ab25(X) :- perimeter(X,N1), N1=<706.381. 
ab26(X) :- perimeter_per_axis(X,N21), N21=<1.618, not ab25(X). 
ab27(X) :- area(X,N0), N0>34414.0, N0=<34495.0. 
ab28(X) :- area(X,N0), N0>33069.0, perimeter(X,N1), N1>704.877, convexarea(X,N6), N6=<36473.0, solidity(X,N9), N9>0.987, shapefactor4(X,N15), N15=<0.996, not ab26(X), not ab27(X). 
ab29(X) :- area(X,N0), N0>33069.0, minoraxislength(X,N3), N3>174.924, roundness(X,N10), N10>0.893, N10=<0.893, extent_solidity_prod(X,N19), N19=<0.732. 
ab30(X) :- roundness(X,N10), N10=<0.835. 
ab31(X) :- convexarea(X,N6), N6=<42673.0, roundness(X,N10), N10>0.934. 
ab32(X) :- extent(X,N8), N8>0.806, sf1_sf3_ratio(X,N18), N18=<0.013. 
ab33(X) :- perimeter_per_axis(X,N21), N21=<1.603. 
ab34(X) :- convexarea(X,N6), N6>42324.0, not ab33(X). 
ab35(X) :- area(X,N0), N0=<40803.0, minoraxislength(X,N3), N3>185.221. 
ab36(X) :- perimeter(X,N1), N1=<749.122, roundness_compact_gap(X,N17), N17>0.109, N17=<0.113, not ab35(X). 
ab37(X) :- shapefactor4(X,N15), N15>0.997. 
ab38(X) :- perimeter(X,N1), N1>760.877, solidity(X,N9), N9>0.989, N9=<0.99, not ab37(X). 
ab39(X) :- convexarea(X,N6), N6=<42673.0, roundness_compact_gap(X,N17), N17>0.106, not ab32(X), not ab34(X), not ab36(X), not ab38(X). 
ab40(X) :- extent(X,N8), N8>0.793. 
ab41(X) :- roundness(X,N10), N10>0.925. 
ab42(X) :- convexarea(X,N6), N6>42624.0, not ab41(X). 
ab43(X) :- extent(X,N8), N8>0.756. 
ab44(X) :- solidity(X,N9), N9=<0.987, roundness(X,N10), N10>0.911, not ab43(X). 
ab45(X) :- majoraxislength(X,N2), N2>275.248. 
ab46(X) :- perimeter(X,N1), N1=<766.264, sf1_sf3_ratio(X,N18), N18=<0.009, not ab40(X), not ab42(X), not ab44(X), not ab45(X). 
ab47(X) :- area(X,N0), N0=<37481.0. 
ab48(X) :- majoraxislength(X,N2), N2>284.238. 
ab49(X) :- minoraxislength(X,N3), N3=<177.2. 
ab50(X) :- perimeter(X,N1), N1>743.739, shapefactor4(X,N15), N15=<0.997, not ab49(X). 
ab51(X) :- perimeter(X,N1), N1=<766.264, solidity(X,N9), N9=<0.987, shapefactor4(X,N15), N15>0.997, not ab47(X), not ab48(X), not ab50(X). 
ab52(X) :- convexarea(X,N6), N6=<38024.0, shapefactor4(X,N15), N15>0.998. 
ab53(X) :- perimeter(X,N1), N1>796.404, N1=<813.48. 
ab54(X) :- solidity(X,N9), N9=<0.988, compactness(X,N11), N11=<0.854, ecc_roundness_gap(X,N20), N20>-0.289, not ab53(X). 
ab55(X) :- roundness_compact_gap(X,N17), N17=<-0.079. 
ab56(X) :- extent(X,N8), N8>0.78, shapefactor2(X,N13), N13>0.002. 
ab57(X) :- area(X,N0), N0>37269.0, majoraxislength(X,N2), N2=<251.416. 
ab58(X) :- shapefactor4(X,N15), N15=<0.995, ecc_roundness_gap(X,N20), N20>-0.326, not ab55(X), not ab56(X), not ab57(X). 
ab59(X) :- area(X,N0), N0>46373.0. 
ab60(X) :- compactness(X,N11), N11=<0.854, shapefactor4(X,N15), N15>0.998, N15=<0.998, ecc_roundness_gap(X,N20), N20>-0.309, not ab59(X). 
ab61(X) :- perimeter(X,N1), N1>927.16. 
ab62(X) :- perimeter(X,N1), N1>899.17, not ab61(X). 
ab63(X) :- aspectration(X,N4), N4>1.222, not ab62(X). 
ab64(X) :- minoraxislength(X,N3), N3>227.61, ecc_roundness_gap(X,N20), N20>-0.33, not ab63(X). 
ab65(X) :- extent(X,N8), N8=<0.777, shapefactor4(X,N15), N15>0.999, roundness_compact_gap(X,N17), N17>0.086, sf1_sf3_ratio(X,N18), N18>0.009, perimeter_per_axis(X,N21), N21=<1.591. 
ab66(X) :- aspectration(X,N4), N4>1.79, roundness(X,N10), N10>0.847. 
ab67(X) :- roundness(X,N10), N10>0.843, sf1_sf3_ratio(X,N18), N18=<0.013, not ab66(X). 
ab68(X) :- extent(X,N8), N8>0.775. 
ab69(X) :- shapefactor2(X,N13), N13>0.001, sf1_sf3_ratio(X,N18), N18=<0.013, not ab68(X). 
ab70(X) :- shapefactor1(X,N12), N12=<0.006. 
ab71(X) :- extent(X,N8), N8=<0.708, not ab70(X). 
ab72(X) :- area(X,N0), N0>73623.0. 
ab73(X) :- shapefactor4(X,N15), N15>0.99. 
ab74(X) :- sf1_sf3_ratio(X,N18), N18=<0.011, not ab73(X). 
ab75(X) :- shapefactor1(X,N12), N12=<0.006, sf1_sf3_ratio(X,N18), N18=<0.013, not ab71(X), not ab72(X), not ab74(X). 
ab76(X) :- majoraxislength(X,N2), N2>363.142. 
ab77(X) :- shapefactor4(X,N15), N15>0.997, not ab76(X). 
ab78(X) :- compactness(X,N11), N11>0.724, shapefactor4(X,N15), N15>0.997, not ab77(X). 
ab79(X) :- area(X,N0), N0>116272.0. 
ab80(X) :- shapefactor4(X,N15), N15>0.997. 
ab81(X) :- extent(X,N8), N8>0.82. 
ab82(X) :- solidity(X,N9), N9=<0.988, shapefactor4(X,N15), N15>0.993. 
ab83(X) :- solidity(X,N9), N9=<0.972. 
ab84(X) :- extent(X,N8), N8=<0.766, shapefactor4(X,N15), N15>0.995. 
ab85(X) :- perimeter(X,N1), N1>893.42, extent(X,N8), N8>0.745, not ab80(X), not ab81(X), not ab82(X), not ab83(X), not ab84(X). 
ab86(X) :- area(X,N0), N0=<56376.0, perimeter(X,N1), N1>921.449. 
ab87(X) :- convexarea(X,N6), N6=<59888.0, not ab85(X), not ab86(X). 
ab88(X) :- area(X,N0), N0>73451.0. 
ab89(X) :- aspectration(X,N4), N4>1.87, not ab88(X). 
ab90(X) :- sf1_sf3_ratio(X,N18), N18>0.01, not ab89(X). 
ab91(X) :- perimeter(X,N1), N1=<951.177. 
ab92(X) :- extent(X,N8), N8>0.769, not ab91(X). 
ab93(X) :- minoraxislength(X,N3), N3=<232.829, not ab92(X). 
ab94(X) :- minoraxislength(X,N3), N3=<236.7, solidity(X,N9), N9>0.989, not ab93(X). 
ab95(X) :- solidity(X,N9), N9=<0.99, shapefactor4(X,N15), N15>0.996, not ab90(X), not ab94(X). 
ab96(X) :- minoraxislength(X,N3), N3=<246.115. 
ab97(X) :- majoraxislength(X,N2), N2=<403.174, roundness(X,N10), N10=<0.868, sf1_sf3_ratio(X,N18), N18=<0.008, not ab96(X). 
ab98(X) :- extent(X,N8), N8=<0.773. 
ab99(X) :- perimeter(X,N1), N1=<1011.417, sf1_sf3_ratio(X,N18), N18=<0.008, not ab98(X). 
ab100(X) :- area(X,N0), N0>64317.0. 
ab101(X) :- area(X,N0), N0=<68456.0, perimeter(X,N1), N1>936.527, extent(X,N8), N8>0.811, shapefactor4(X,N15), N15>0.993, not ab100(X). 
ab102(X) :- minoraxislength(X,N3), N3=<214.574. 
ab103(X) :- area(X,N0), N0=<68456.0, solidity(X,N9), N9=<0.984, shapefactor4(X,N15), N15>0.993, not ab102(X). 
ab104(X) :- solidity(X,N9), N9=<0.986, shapefactor4(X,N15), N15>0.994, perimeter_per_axis(X,N21), N21>1.659. 
ab105(X) :- majoraxislength(X,N2), N2=<404.96, extent(X,N8), N8=<0.708, shapefactor2(X,N13), N13>0.001. 
ab106(X) :- area(X,N0), N0>64492.0. 
ab107(X) :- majoraxislength(X,N2), N2=<404.96, extent(X,N8), N8=<0.646, not ab106(X). 
ab108(X) :- majoraxislength(X,N2), N2=<404.96, solidity(X,N9), N9=<0.984, roundness_compact_gap(X,N17), N17>0.062, N17=<0.063. 
ab109(X) :- area(X,N0), N0=<40740.0. 
ab110(X) :- area(X,N0), N0>87031.0, N0=<102015.0. 
ab111(X) :- majoraxislength(X,N2), N2>439.644, perimeter_per_axis(X,N21), N21=<1.711, not ab110(X). 
ab112(X) :- area(X,N0), N0>50978.0, N0=<51426.0. 
ab113(X) :- perimeter(X,N1), N1>932.171. 
ab114(X) :- minoraxislength(X,N3), N3>196.478, shapefactor1(X,N12), N12>0.006, not ab113(X). 
ab115(X) :- minoraxislength(X,N3), N3=<222.117. 
ab116(X) :- area(X,N0), N0=<66444.0, shapefactor1(X,N12), N12=<0.006. 
ab117(X) :- shapefactor4(X,N15), N15=<0.989, roundness_compact_gap(X,N17), N17>0.01, not ab115(X), not ab116(X). 
ab118(X) :- convexarea(X,N6), N6=<49733.0, roundness(X,N10), N10=<0.747. 
ab119(X) :- area(X,N0), N0>77492.0, aspectration(X,N4), N4>1.827. 
ab120(X) :- shapefactor4(X,N15), N15=<0.988. 
ab121(X) :- area(X,N0), N0>73118.0. 
ab122(X) :- roundness_compact_gap(X,N17), N17>0.072, not ab121(X). 
ab123(X) :- solidity(X,N9), N9>0.985, not ab122(X). 
ab124(X) :- shapefactor4(X,N15), N15>0.995, not ab123(X). 
ab125(X) :- aspectration(X,N4), N4>1.756, not ab124(X). 
ab126(X) :- shapefactor4(X,N15), N15>0.998. 
ab127(X) :- extent(X,N8), N8>0.77. 
ab128(X) :- perimeter_per_axis(X,N21), N21=<1.613, not ab127(X). 
ab129(X) :- minoraxislength(X,N3), N3=<215.448, roundness_compact_gap(X,N17), N17>0.058, not ab128(X). 
ab130(X) :- area(X,N0), N0=<55563.0, sf1_sf3_ratio(X,N18), N18=<0.008. 
ab131(X) :- minoraxislength(X,N3), N3>208.906, not ab129(X), not ab130(X). 
ab132(X) :- majoraxislength(X,N2), N2>351.332. 
ab133(X) :- extent(X,N8), N8>0.792, perimeter_per_axis(X,N21), N21>1.629, not ab132(X). 
ab134(X) :- area(X,N0), N0=<34146.0. 
ab135(X) :- minoraxislength(X,N3), N3=<177.063, not ab134(X). 
ab136(X) :- extent(X,N8), N8>0.728. 
ab137(X) :- solidity(X,N9), N9>0.988, not ab136(X). 
ab138(X) :- shapefactor4(X,N15), N15>0.997, perimeter_per_axis(X,N21), N21>1.629, not ab137(X). 
ab139(X) :- area(X,N0), N0>54187.0. 
ab140(X) :- area(X,N0), N0>50976.0, perimeter_per_axis(X,N21), N21>1.663, not ab139(X). 
ab141(X) :- perimeter(X,N1), N1=<756.279, roundness_compact_gap(X,N17), N17=<0.024. 
ab142(X) :- area(X,N0), N0>41918.0. 
ab143(X) :- extent(X,N8), N8=<0.715, roundness(X,N10), N10>0.914, not ab142(X). 
ab144(X) :- roundness(X,N10), N10>0.925, N10=<0.926. 
ab145(X) :- perimeter_per_axis(X,N21), N21=<1.631. 
ab146(X) :- aspectration(X,N4), N4>1.849. 
ab147(X) :- convexarea(X,N6), N6=<73618.0, solidity(X,N9), N9=<0.963. 
ab148(X) :- area(X,N0), N0>67585.0, minoraxislength(X,N3), N3=<231.346, solidity(X,N9), N9>0.977. 
ab149(X) :- shapefactor4(X,N15), N15>0.996. 
ab150(X) :- area(X,N0), N0=<56724.0, shapefactor2(X,N13), N13>0.001. 
ab151(X) :- aspectration(X,N4), N4=<1.415. 
ab152(X) :- ecc_roundness_gap(X,N20), N20>-0.142, not ab151(X). 
ab153(X) :- area(X,N0), N0=<40774.0. 
ab154(X) :- area(X,N0), N0>48094.0, shapefactor4(X,N15), N15>0.999.