class(X,'dermason') :- convexarea(X,N6), N6=<40165.0, not ab8(X), not ab10(X), not ab11(X), not ab14(X), not ab18(X). 
class(X,'sira') :- majoraxislength(X,N2), N2=<343.84, compactness(X,N11), N11=<0.853, not ab20(X), not ab21(X), not ab26(X), not ab30(X), not ab32(X), not ab36(X), not ab37(X). 
class(X,'horoz') :- compactness(X,N11), N11=<0.728, not ab44(X), not ab46(X), not ab47(X), not ab49(X), not ab50(X), not ab51(X), not ab52(X), not ab53(X). 
class(X,'seker') :- shapefactor2(X,N13), N13>0.002, not ab57(X), not ab59(X), not ab60(X), not ab61(X), not ab62(X), not ab63(X). 
class(X,'cali') :- area(X,N0), N0>60993.0, compactness(X,N11), N11=<0.784, not ab65(X), not ab70(X), not ab73(X), not ab77(X). 
class(X,'barbunya') :- majoraxislength(X,N2), N2=<469.286, shapefactor1(X,N12), N12=<0.006, not ab78(X), not ab80(X), not ab82(X), not ab84(X), not ab85(X), not ab86(X), not ab89(X), not ab90(X), not ab91(X), not ab92(X), not ab93(X), not ab94(X). 
class(X,'bombay') :- area(X,N0), N0>106700.0. 
class(X,'cali') :- area(X,N0), N0>57469.0, not ab98(X), not ab100(X), not ab101(X), not ab103(X), not ab104(X), not ab105(X). 
class(X,'horoz') :- roundness(X,N10), N10=<0.849, compactness(X,N11), N11=<0.762, not ab106(X), not ab108(X), not ab109(X), not ab110(X). 
class(X,'sira') :- compactness(X,N11), N11=<0.763, not ab111(X), not ab113(X), not ab114(X), not ab115(X). 
class(X,'dermason') :- perimeter(X,N1), N1=<792.671, minoraxislength(X,N3), N3=<183.422, not ab116(X), not ab117(X), not ab118(X). 
class(X,'sira') :- area(X,N0), N0=<48429.0, minoraxislength(X,N3), N3>196.581, not ab119(X). 
class(X,'barbunya') :- perimeter(X,N1), N1>933.828. 
class(X,'sira') :- majoraxislength(X,N2), N2>303.469, aspectration(X,N4), N4=<1.691, roundness(X,N10), N10=<0.934, shapefactor1(X,N12), N12>0.007. 
class(X,'sira') :- majoraxislength(X,N2), N2=<288.325, roundness(X,N10), N10=<0.795. 
class(X,'dermason') :- perimeter(X,N1), N1=<768.735, aspectration(X,N4), N4=<1.563, roundness(X,N10), N10>0.934. 
class(X,'sira') :- area(X,N0), N0=<37706.0, majoraxislength(X,N2), N2>245.99, N2=<288.325, roundness(X,N10), N10>0.883. 
class(X,'sira') :- majoraxislength(X,N2), N2=<288.325, minoraxislength(X,N3), N3>186.985, aspectration(X,N4), N4>1.428, not ab120(X). 
class(X,'dermason') :- perimeter(X,N1), N1=<768.735, aspectration(X,N4), N4=<1.563, solidity(X,N9), N9>0.99, not ab121(X). 
class(X,'barbunya') :- roundness(X,N10), N10=<0.833, not ab122(X), not ab123(X), not ab124(X). 
class(X,'sira') :- minoraxislength(X,N3), N3=<210.418, aspectration(X,N4), N4>1.66, N4=<1.683. 
class(X,'dermason') :- majoraxislength(X,N2), N2=<288.722, minoraxislength(X,N3), N3>183.521, solidity(X,N9), N9=<0.987. 
class(X,'sira') :- majoraxislength(X,N2), N2=<288.325, solidity(X,N9), N9>0.99, not ab125(X). 
class(X,'dermason') :- majoraxislength(X,N2), N2=<288.722, minoraxislength(X,N3), N3>183.521, roundness(X,N10), N10>0.921. 
class(X,'seker') :- shapefactor1(X,N12), N12=<0.006, not ab126(X), not ab127(X). 
class(X,'sira') :- majoraxislength(X,N2), N2=<281.18, roundness(X,N10), N10>0.92. 
class(X,'dermason') :- majoraxislength(X,N2), N2=<288.722, minoraxislength(X,N3), N3>183.521, solidity(X,N9), N9>0.988, not ab130(X), not ab131(X). 
class(X,'cali') :- area(X,N0), N0>50976.0, shapefactor1(X,N12), N12>0.006. 
class(X,'sira') :- majoraxislength(X,N2), N2=<281.18, not ab132(X). 
class(X,'horoz') :- area(X,N0), N0=<39158.0. 
class(X,'barbunya') :- shapefactor4(X,N15), N15>0.994, N15=<0.998, not ab134(X). 
class(X,'cali') :- shapefactor1(X,N12), N12=<0.006, not ab135(X). 
class(X,'horoz') :- minoraxislength(X,N3), N3>205.399. 
class(X,'sira') :- extent(X,N8), N8>0.708. 
class(X,'seker') :- area(X,N0), N0=<41607.0. 
class(X,'cali') :- area(X,N0), N0=<56376.0. 
ab1(X) :- shapefactor1(X,N12), N12>0.007. 
ab2(X) :- shapefactor4(X,N15), N15=<0.994. 
ab3(X) :- minoraxislength(X,N3), N3>187.079, shapefactor1(X,N12), N12>0.007. 
ab4(X) :- solidity(X,N9), N9>0.99, shapefactor1(X,N12), N12=<0.007. 
ab5(X) :- perimeter(X,N1), N1=<731.491, compactness(X,N11), N11=<0.876, shapefactor4(X,N15), N15=<0.998, not ab1(X), not ab2(X), not ab3(X), not ab4(X). 
ab6(X) :- aspectration(X,N4), N4>1.346, compactness(X,N11), N11=<0.887, shapefactor2(X,N13), N13>0.002. 
ab7(X) :- majoraxislength(X,N2), N2>262.025, minoraxislength(X,N3), N3>189.979, compactness(X,N11), N11=<0.887. 
ab8(X) :- shapefactor1(X,N12), N12=<0.007, not ab5(X), not ab6(X), not ab7(X). 
ab9(X) :- area(X,N0), N0=<35808.0, extent(X,N8), N8>0.802. 
ab10(X) :- perimeter(X,N1), N1>704.877, roundness(X,N10), N10=<0.901, shapefactor2(X,N13), N13=<0.001, not ab9(X). 
ab11(X) :- perimeter(X,N1), N1>704.877, convexarea(X,N6), N6>37545.0, roundness(X,N10), N10=<0.901, shapefactor1(X,N12), N12>0.007, shapefactor4(X,N15), N15=<0.997. 
ab12(X) :- perimeter(X,N1), N1=<707.652. 
ab13(X) :- majoraxislength(X,N2), N2=<268.897, not ab12(X). 
ab14(X) :- area(X,N0), N0>33857.0, majoraxislength(X,N2), N2=<286.384, extent(X,N8), N8>0.786, roundness(X,N10), N10=<0.88, not ab13(X). 
ab15(X) :- area(X,N0), N0=<30008.0. 
ab16(X) :- solidity(X,N9), N9=<0.99, shapefactor4(X,N15), N15=<0.999, not ab15(X). 
ab17(X) :- area(X,N0), N0>30008.0, shapefactor4(X,N15), N15=<0.995. 
ab18(X) :- majoraxislength(X,N2), N2=<235.56, shapefactor1(X,N12), N12=<0.007, not ab16(X), not ab17(X). 
ab19(X) :- aspectration(X,N4), N4=<1.882, roundness(X,N10), N10>0.835, shapefactor1(X,N12), N12>0.006. 
ab20(X) :- roundness(X,N10), N10=<0.837, not ab19(X). 
ab21(X) :- perimeter(X,N1), N1=<764.163, extent(X,N8), N8=<0.783, shapefactor4(X,N15), N15>0.997. 
ab22(X) :- minoraxislength(X,N3), N3=<211.999. 
ab23(X) :- minoraxislength(X,N3), N3>217.016. 
ab24(X) :- perimeter(X,N1), N1=<898.251, aspectration(X,N4), N4>1.466, shapefactor4(X,N15), N15=<0.997, not ab22(X), not ab23(X). 
ab25(X) :- aspectration(X,N4), N4>1.4, N4=<1.406. 
ab26(X) :- minoraxislength(X,N3), N3>210.971, not ab24(X), not ab25(X). 
ab27(X) :- area(X,N0), N0=<40168.0, majoraxislength(X,N2), N2>284.791. 
ab28(X) :- majoraxislength(X,N2), N2=<264.815. 
ab29(X) :- perimeter(X,N1), N1=<724.477, not ab28(X). 
ab30(X) :- minoraxislength(X,N3), N3=<180.512, convexarea(X,N6), N6=<42673.0, roundness(X,N10), N10>0.891, not ab27(X), not ab29(X). 
ab31(X) :- area(X,N0), N0>41155.0. 
ab32(X) :- aspectration(X,N4), N4>1.801, convexarea(X,N6), N6=<42673.0, compactness(X,N11), N11=<0.78, not ab31(X). 
ab33(X) :- extent(X,N8), N8=<0.663. 
ab34(X) :- minoraxislength(X,N3), N3>179.712. 
ab35(X) :- area(X,N0), N0>38250.0, minoraxislength(X,N3), N3=<171.788. 
ab36(X) :- convexarea(X,N6), N6=<42673.0, extent(X,N8), N8=<0.743, roundness(X,N10), N10>0.868, compactness(X,N11), N11=<0.78, not ab33(X), not ab34(X), not ab35(X). 
ab37(X) :- area(X,N0), N0=<38594.0, convexarea(X,N6), N6=<40423.0, roundness(X,N10), N10>0.9, shapefactor4(X,N15), N15>0.998. 
ab38(X) :- extent(X,N8), N8=<0.657, roundness(X,N10), N10=<0.793. 
ab39(X) :- majoraxislength(X,N2), N2>432.429, minoraxislength(X,N3), N3=<219.84. 
ab40(X) :- perimeter(X,N1), N1>1027.807, convexarea(X,N6), N6=<73133.0, shapefactor2(X,N13), N13>0.001. 
ab41(X) :- area(X,N0), N0>68315.0. 
ab42(X) :- convexarea(X,N6), N6=<73133.0, roundness(X,N10), N10>0.819, not ab41(X). 
ab43(X) :- area(X,N0), N0=<72197.0, extent(X,N8), N8>0.815. 
ab44(X) :- minoraxislength(X,N3), N3>210.941, not ab38(X), not ab39(X), not ab40(X), not ab42(X), not ab43(X). 
ab45(X) :- roundness(X,N10), N10=<0.829. 
ab46(X) :- perimeter(X,N1), N1=<920.481, compactness(X,N11), N11>0.704, shapefactor1(X,N12), N12=<0.007, not ab45(X). 
ab47(X) :- majoraxislength(X,N2), N2=<378.781, convexarea(X,N6), N6>59975.0, compactness(X,N11), N11>0.704. 
ab48(X) :- perimeter(X,N1), N1>965.459. 
ab49(X) :- area(X,N0), N0>59286.0, N0=<59431.0, compactness(X,N11), N11>0.704, not ab48(X). 
ab50(X) :- area(X,N0), N0>59763.0, aspectration(X,N4), N4>1.974, compactness(X,N11), N11>0.707, shapefactor4(X,N15), N15=<0.993. 
ab51(X) :- aspectration(X,N4), N4>1.981, extent(X,N8), N8>0.741, compactness(X,N11), N11>0.709. 
ab52(X) :- area(X,N0), N0>60251.0, N0=<61484.0, aspectration(X,N4), N4=<1.962, extent(X,N8), N8>0.793. 
ab53(X) :- extent(X,N8), N8>0.797, roundness(X,N10), N10>0.824, shapefactor4(X,N15), N15=<0.989. 
ab54(X) :- area(X,N0), N0>42070.0, solidity(X,N9), N9>0.991. 
ab55(X) :- area(X,N0), N0=<38286.0, solidity(X,N9), N9>0.991. 
ab56(X) :- area(X,N0), N0>40781.0, roundness(X,N10), N10>0.936. 
ab57(X) :- aspectration(X,N4), N4>1.404, compactness(X,N11), N11=<0.859, not ab54(X), not ab55(X), not ab56(X). 
ab58(X) :- aspectration(X,N4), N4>1.367. 
ab59(X) :- majoraxislength(X,N2), N2>259.617, shapefactor1(X,N12), N12>0.006, shapefactor4(X,N15), N15=<0.997, not ab58(X). 
ab60(X) :- area(X,N0), N0>56204.0, roundness(X,N10), N10=<0.939. 
ab61(X) :- extent(X,N8), N8>0.793, solidity(X,N9), N9=<0.991, compactness(X,N11), N11=<0.882, shapefactor1(X,N12), N12>0.006, shapefactor4(X,N15), N15=<0.998. 
ab62(X) :- extent(X,N8), N8=<0.73, roundness(X,N10), N10=<0.92, compactness(X,N11), N11=<0.877, shapefactor1(X,N12), N12>0.006. 
ab63(X) :- majoraxislength(X,N2), N2=<246.969, compactness(X,N11), N11=<0.893, shapefactor1(X,N12), N12>0.006, shapefactor4(X,N15), N15=<0.995. 
ab64(X) :- area(X,N0), N0=<116272.0, aspectration(X,N4), N4>1.872. 
ab65(X) :- perimeter(X,N1), N1>1260.637, not ab64(X). 
ab66(X) :- majoraxislength(X,N2), N2=<381.652. 
ab67(X) :- roundness(X,N10), N10>0.78, compactness(X,N11), N11=<0.751, not ab66(X). 
ab68(X) :- minoraxislength(X,N3), N3>221.036, compactness(X,N11), N11=<0.745, shapefactor4(X,N15), N15=<0.991. 
ab69(X) :- solidity(X,N9), N9>0.983, shapefactor2(X,N13), N13=<0.001. 
ab70(X) :- roundness(X,N10), N10=<0.801, not ab67(X), not ab68(X), not ab69(X). 
ab71(X) :- extent(X,N8), N8>0.719. 
ab72(X) :- aspectration(X,N4), N4>1.748, not ab71(X). 
ab73(X) :- solidity(X,N9), N9=<0.988, shapefactor4(X,N15), N15>0.995, not ab72(X). 
ab74(X) :- extent(X,N8), N8>0.803. 
ab75(X) :- minoraxislength(X,N3), N3>241.126. 
ab76(X) :- roundness(X,N10), N10=<0.835, not ab74(X), not ab75(X). 
ab77(X) :- solidity(X,N9), N9=<0.99, shapefactor4(X,N15), N15>0.996, not ab76(X). 
ab78(X) :- roundness(X,N10), N10>0.857, shapefactor4(X,N15), N15=<0.991. 
ab79(X) :- extent(X,N8), N8=<0.705, solidity(X,N9), N9=<0.991. 
ab80(X) :- solidity(X,N9), N9>0.989, roundness(X,N10), N10>0.858, not ab79(X). 
ab81(X) :- area(X,N0), N0>77787.0, roundness(X,N10), N10=<0.836. 
ab82(X) :- roundness(X,N10), N10>0.834, compactness(X,N11), N11=<0.793, shapefactor4(X,N15), N15=<0.994, not ab81(X). 
ab83(X) :- roundness(X,N10), N10=<0.868. 
ab84(X) :- extent(X,N8), N8>0.757, N8=<0.799, roundness(X,N10), N10>0.859, shapefactor4(X,N15), N15=<0.996, not ab83(X). 
ab85(X) :- perimeter(X,N1), N1>861.277, N1=<879.177, roundness(X,N10), N10>0.836. 
ab86(X) :- area(X,N0), N0=<51071.0, solidity(X,N9), N9>0.987. 
ab87(X) :- aspectration(X,N4), N4>1.603. 
ab88(X) :- solidity(X,N9), N9=<0.987, not ab87(X). 
ab89(X) :- aspectration(X,N4), N4>1.56, extent(X,N8), N8>0.708, roundness(X,N10), N10>0.841, N10=<0.86, compactness(X,N11), N11>0.784, not ab88(X). 
ab90(X) :- area(X,N0), N0>81544.0, roundness(X,N10), N10>0.865, shapefactor4(X,N15), N15=<0.996. 
ab91(X) :- roundness(X,N10), N10>0.884, shapefactor1(X,N12), N12>0.005, shapefactor4(X,N15), N15=<0.994. 
ab92(X) :- roundness(X,N10), N10>0.803, compactness(X,N11), N11=<0.785, shapefactor4(X,N15), N15=<0.991. 
ab93(X) :- solidity(X,N9), N9>0.976, shapefactor4(X,N15), N15=<0.987. 
ab94(X) :- roundness(X,N10), N10>0.865, N10=<0.865. 
ab95(X) :- area(X,N0), N0>59431.0, N0=<59780.0. 
ab96(X) :- roundness(X,N10), N10=<0.803, shapefactor1(X,N12), N12>0.006, not ab48(X). 
ab97(X) :- area(X,N0), N0=<57549.0. 
ab98(X) :- aspectration(X,N4), N4>1.75, not ab95(X), not ab96(X), not ab97(X). 
ab99(X) :- solidity(X,N9), N9=<0.989. 
ab100(X) :- extent(X,N8), N8>0.775, solidity(X,N9), N9=<0.991, shapefactor4(X,N15), N15>0.996, not ab99(X). 
ab101(X) :- compactness(X,N11), N11>0.827. 
ab102(X) :- extent(X,N8), N8>0.792. 
ab103(X) :- minoraxislength(X,N3), N3=<212.614, compactness(X,N11), N11>0.76, not ab102(X). 
ab104(X) :- area(X,N0), N0>70626.0, N0=<76729.0, solidity(X,N9), N9>0.99, N9=<0.991. 
ab105(X) :- area(X,N0), N0=<64871.0, shapefactor4(X,N15), N15>0.998. 
ab106(X) :- aspectration(X,N4), N4>1.871. 
ab107(X) :- area(X,N0), N0=<48290.0, roundness(X,N10), N10>0.823. 
ab108(X) :- aspectration(X,N4), N4=<1.785, solidity(X,N9), N9=<0.984, shapefactor4(X,N15), N15>0.988, not ab107(X). 
ab109(X) :- solidity(X,N9), N9=<0.985, shapefactor4(X,N15), N15>0.995. 
ab110(X) :- solidity(X,N9), N9>0.987, shapefactor2(X,N13), N13>0.001, shapefactor4(X,N15), N15>0.995. 
ab111(X) :- roundness(X,N10), N10=<0.789. 
ab112(X) :- solidity(X,N9), N9=<0.983. 
ab113(X) :- perimeter(X,N1), N1=<775.473, not ab112(X). 
ab114(X) :- convexarea(X,N6), N6>55364.0, extent(X,N8), N8>0.69, roundness(X,N10), N10=<0.849. 
ab115(X) :- area(X,N0), N0=<57103.0, shapefactor1(X,N12), N12=<0.006. 
ab116(X) :- area(X,N0), N0=<36584.0, convexarea(X,N6), N6=<40230.0. 
ab117(X) :- area(X,N0), N0>39118.0, N0=<39247.0, convexarea(X,N6), N6=<40230.0. 
ab118(X) :- aspectration(X,N4), N4>1.627, roundness(X,N10), N10>0.897. 
ab119(X) :- aspectration(X,N4), N4=<1.32. 
ab120(X) :- area(X,N0), N0>40557.0, shapefactor4(X,N15), N15>0.999. 
ab121(X) :- extent(X,N8), N8>0.762, N8=<0.773. 
ab122(X) :- area(X,N0), N0=<39247.0. 
ab123(X) :- perimeter(X,N1), N1>905.491, solidity(X,N9), N9>0.986. 
ab124(X) :- perimeter(X,N1), N1>931.202. 
ab125(X) :- area(X,N0), N0>40593.0, roundness(X,N10), N10>0.926. 
ab126(X) :- solidity(X,N9), N9>0.988, roundness(X,N10), N10=<0.907. 
ab127(X) :- solidity(X,N9), N9=<0.982. 
ab128(X) :- area(X,N0), N0=<40005.0. 
ab129(X) :- area(X,N0), N0=<40204.0, not ab128(X). 
ab130(X) :- area(X,N0), N0>39997.0, N0=<40647.0, not ab129(X). 
ab131(X) :- area(X,N0), N0>40975.0, perimeter(X,N1), N1>759.696. 
ab132(X) :- area(X,N0), N0=<35464.0. 
ab133(X) :- area(X,N0), N0=<44027.0. 
ab134(X) :- shapefactor4(X,N15), N15=<0.997, not ab133(X). 
ab135(X) :- perimeter(X,N1), N1>903.559.