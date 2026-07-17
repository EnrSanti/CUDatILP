class(X,'dermason') :- area(X,N0), N0=<42159.0, not ab16(X), not ab23(X). 
class(X,'sira') :- majoraxislength(X,N2), N2=<343.84, compactness(X,N11), N11=<0.85, not ab41(X), not ab51(X), not ab54(X), not ab56(X). 
class(X,'seker') :- shapefactor2(X,N13), N13>0.002, not ab72(X), not ab73(X), not ab74(X), not ab75(X). 
class(X,'horoz') :- shapefactor1(X,N12), N12>0.006, not ab84(X). 
class(X,'cali') :- compactness(X,N11), N11=<0.782, not ab85(X), not ab95(X), not ab111(X), not ab123(X), not ab124(X). 
class(X,'barbunya') :- area(X,N0), N0=<115967.0, not ab137(X), not ab140(X), not ab141(X), not ab142(X), not ab143(X), not ab144(X), not ab146(X), not ab147(X), not ab149(X), not ab150(X), not ab151(X). 
class(X,'bombay') :- area(X,N0), N0>106700.0. 
class(X,'cali') :- shapefactor1(X,N12), N12=<0.006, not ab152(X), not ab153(X), not ab154(X), not ab155(X). 
class(X,'sira') :- majoraxislength(X,N2), N2>341.57, minoraxislength(X,N3), N3=<212.614, not ab156(X). 
class(X,'dermason') :- area(X,N0), N0=<42139.0, not ab157(X). 
class(X,'horoz') :- compactness(X,N11), N11=<0.778. 
class(X,'seker') :- solidity(X,N9), N9>0.991, not ab158(X). 
class(X,'barbunya') :- area(X,N0), N0>57649.0. 
class(X,'sira') :- minoraxislength(X,N3), N3=<201.33, not ab159(X). 
class(X,'seker') :- extent(X,N8), N8=<0.789, not ab160(X). 
class(X,'barbunya') :- extent(X,N8), N8=<0.8. 
class(X,'cali') :- area(X,N0), N0>49699.0. 
class(X,'sira') :- area(X,N0), N0=<49699.0. 
ab1(X) :- extent(X,N8), N8=<0.727. 
ab2(X) :- area(X,N0), N0>39048.0, not ab1(X). 
ab3(X) :- area(X,N0), N0>37052.0, perimeter(X,N1), N1=<734.278. 
ab4(X) :- shapefactor4(X,N15), N15>0.997, N15=<0.997, not ab2(X), not ab3(X). 
ab5(X) :- roundness(X,N10), N10=<0.878. 
ab6(X) :- minoraxislength(X,N3), N3>182.286, N3=<183.167, shapefactor4(X,N15), N15>0.998. 
ab7(X) :- perimeter(X,N1), N1>746.535, minoraxislength(X,N3), N3>184.311. 
ab8(X) :- area(X,N0), N0>39128.0. 
ab9(X) :- minoraxislength(X,N3), N3=<185.408, shapefactor1(X,N12), N12=<0.007, not ab8(X). 
ab10(X) :- roundness(X,N10), N10=<0.903, not ab4(X), not ab5(X), not ab6(X), not ab7(X), not ab9(X). 
ab11(X) :- perimeter(X,N1), N1=<748.048, compactness(X,N11), N11=<0.876, shapefactor1(X,N12), N12>0.007, not ab10(X). 
ab12(X) :- perimeter(X,N1), N1=<703.561. 
ab13(X) :- perimeter(X,N1), N1=<716.994, not ab12(X). 
ab14(X) :- minoraxislength(X,N3), N3=<186.686. 
ab15(X) :- area(X,N0), N0=<39127.0, minoraxislength(X,N3), N3>186.673, compactness(X,N11), N11=<0.876, shapefactor4(X,N15), N15=<0.997, not ab13(X), not ab14(X). 
ab16(X) :- minoraxislength(X,N3), N3>180.769, not ab11(X), not ab15(X). 
ab17(X) :- area(X,N0), N0=<38246.0. 
ab18(X) :- area(X,N0), N0=<41028.0, majoraxislength(X,N2), N2=<299.53, not ab17(X). 
ab19(X) :- perimeter(X,N1), N1=<769.398, roundness(X,N10), N10>0.865, not ab18(X). 
ab20(X) :- extent(X,N8), N8=<0.717, solidity(X,N9), N9>0.989, roundness(X,N10), N10>0.844. 
ab21(X) :- perimeter(X,N1), N1>775.151, minoraxislength(X,N3), N3>179.416. 
ab22(X) :- area(X,N0), N0=<41759.0, majoraxislength(X,N2), N2>302.552, roundness(X,N10), N10>0.858. 
ab23(X) :- perimeter(X,N1), N1>702.212, majoraxislength(X,N2), N2>296.058, not ab19(X), not ab20(X), not ab21(X), not ab22(X). 
ab24(X) :- aspectration(X,N4), N4=<1.882, roundness(X,N10), N10>0.835, shapefactor1(X,N12), N12>0.006, shapefactor4(X,N15), N15>0.988. 
ab25(X) :- shapefactor4(X,N15), N15>0.998. 
ab26(X) :- area(X,N0), N0>48300.0. 
ab27(X) :- area(X,N0), N0>42043.0, not ab26(X). 
ab28(X) :- area(X,N0), N0>41210.0, not ab27(X). 
ab29(X) :- shapefactor4(X,N15), N15=<0.989, not ab28(X). 
ab30(X) :- minoraxislength(X,N3), N3>198.973. 
ab31(X) :- minoraxislength(X,N3), N3>190.868, solidity(X,N9), N9>0.98, not ab30(X). 
ab32(X) :- area(X,N0), N0>36811.0, shapefactor4(X,N15), N15>0.997. 
ab33(X) :- aspectration(X,N4), N4=<1.882, shapefactor1(X,N12), N12>0.006, shapefactor2(X,N13), N13>0.001, not ab25(X), not ab29(X), not ab31(X), not ab32(X). 
ab34(X) :- majoraxislength(X,N2), N2=<322.252. 
ab35(X) :- area(X,N0), N0>48557.0, roundness(X,N10), N10>0.822. 
ab36(X) :- aspectration(X,N4), N4=<1.882, roundness(X,N10), N10>0.821, N10=<0.826, shapefactor2(X,N13), N13=<0.001, not ab34(X), not ab35(X). 
ab37(X) :- roundness(X,N10), N10>0.83, N10=<0.83. 
ab38(X) :- aspectration(X,N4), N4>1.796, extent(X,N8), N8=<0.783, compactness(X,N11), N11>0.742. 
ab39(X) :- roundness(X,N10), N10>0.838, N10=<0.838. 
ab40(X) :- solidity(X,N9), N9>0.981, roundness(X,N10), N10=<0.721. 
ab41(X) :- roundness(X,N10), N10=<0.838, not ab24(X), not ab33(X), not ab36(X), not ab37(X), not ab38(X), not ab39(X), not ab40(X). 
ab42(X) :- minoraxislength(X,N3), N3>206.004. 
ab43(X) :- roundness(X,N10), N10>0.935. 
ab44(X) :- majoraxislength(X,N2), N2=<269.386. 
ab45(X) :- perimeter(X,N1), N1=<748.568, not ab44(X). 
ab46(X) :- majoraxislength(X,N2), N2>285.391. 
ab47(X) :- majoraxislength(X,N2), N2>280.967, extent(X,N8), N8=<0.752, not ab46(X). 
ab48(X) :- shapefactor4(X,N15), N15=<0.997, not ab42(X), not ab43(X), not ab45(X), not ab47(X). 
ab49(X) :- solidity(X,N9), N9>0.992, roundness(X,N10), N10=<0.92. 
ab50(X) :- extent(X,N8), N8>0.799, N8=<0.8, solidity(X,N9), N9>0.992. 
ab51(X) :- roundness(X,N10), N10>0.918, not ab48(X), not ab49(X), not ab50(X). 
ab52(X) :- area(X,N0), N0=<55796.0. 
ab53(X) :- majoraxislength(X,N2), N2=<337.875, minoraxislength(X,N3), N3=<217.016, not ab52(X). 
ab54(X) :- convexarea(X,N6), N6>56476.0, not ab53(X). 
ab55(X) :- area(X,N0), N0>41155.0. 
ab56(X) :- aspectration(X,N4), N4>1.801, convexarea(X,N6), N6=<42673.0, not ab55(X). 
ab57(X) :- majoraxislength(X,N2), N2>275.743. 
ab58(X) :- shapefactor2(X,N13), N13=<0.002, not ab57(X). 
ab59(X) :- solidity(X,N9), N9=<0.987. 
ab60(X) :- aspectration(X,N4), N4=<1.339, shapefactor4(X,N15), N15=<0.999. 
ab61(X) :- minoraxislength(X,N3), N3>192.766, extent(X,N8), N8=<0.73. 
ab62(X) :- shapefactor4(X,N15), N15>0.998, not ab58(X), not ab59(X), not ab60(X), not ab61(X). 
ab63(X) :- area(X,N0), N0>40937.0, N0=<41034.0. 
ab64(X) :- area(X,N0), N0>42026.0. 
ab65(X) :- minoraxislength(X,N3), N3>196.692, shapefactor4(X,N15), N15=<0.998. 
ab66(X) :- roundness(X,N10), N10=<0.936, shapefactor4(X,N15), N15=<0.997. 
ab67(X) :- area(X,N0), N0>40566.0, roundness(X,N10), N10=<0.94, not ab63(X), not ab64(X), not ab65(X), not ab66(X). 
ab68(X) :- solidity(X,N9), N9>0.991. 
ab69(X) :- area(X,N0), N0>39452.0, perimeter(X,N1), N1=<735.873, not ab68(X). 
ab70(X) :- minoraxislength(X,N3), N3>191.46, shapefactor4(X,N15), N15>0.996, N15=<0.998, not ab67(X), not ab69(X). 
ab71(X) :- aspectration(X,N4), N4=<1.454, compactness(X,N11), N11=<0.828. 
ab72(X) :- area(X,N0), N0=<42139.0, shapefactor2(X,N13), N13=<0.002, not ab62(X), not ab70(X), not ab71(X). 
ab73(X) :- majoraxislength(X,N2), N2>276.062, minoraxislength(X,N3), N3>243.682, roundness(X,N10), N10=<0.939. 
ab74(X) :- area(X,N0), N0>51071.0, roundness(X,N10), N10=<0.939, compactness(X,N11), N11=<0.891, shapefactor4(X,N15), N15>0.999. 
ab75(X) :- compactness(X,N11), N11=<0.891, shapefactor2(X,N13), N13>0.003, shapefactor4(X,N15), N15=<0.996. 
ab76(X) :- area(X,N0), N0>56290.0. 
ab77(X) :- area(X,N0), N0=<41130.0. 
ab78(X) :- shapefactor4(X,N15), N15=<0.988, not ab76(X), not ab77(X). 
ab79(X) :- solidity(X,N9), N9=<0.982. 
ab80(X) :- area(X,N0), N0>54267.0, N0=<56074.0. 
ab81(X) :- roundness(X,N10), N10=<0.834, compactness(X,N11), N11=<0.762, not ab79(X), not ab80(X). 
ab82(X) :- shapefactor4(X,N15), N15>0.997, N15=<0.997. 
ab83(X) :- area(X,N0), N0>57103.0, convexarea(X,N6), N6=<58240.0. 
ab84(X) :- compactness(X,N11), N11>0.745, not ab78(X), not ab81(X), not ab82(X), not ab83(X). 
ab85(X) :- area(X,N0), N0>116272.0. 
ab86(X) :- area(X,N0), N0>81139.0. 
ab87(X) :- area(X,N0), N0=<68670.0, minoraxislength(X,N3), N3=<212.23. 
ab88(X) :- shapefactor4(X,N15), N15>0.995, not ab86(X), not ab87(X). 
ab89(X) :- area(X,N0), N0>65579.0, perimeter(X,N1), N1=<1032.779. 
ab90(X) :- minoraxislength(X,N3), N3=<219.845, extent(X,N8), N8=<0.702, not ab89(X). 
ab91(X) :- extent(X,N8), N8>0.811. 
ab92(X) :- minoraxislength(X,N3), N3>213.525, N3=<215.232. 
ab93(X) :- roundness(X,N10), N10>0.763, compactness(X,N11), N11=<0.751, not ab88(X), not ab90(X), not ab91(X), not ab92(X). 
ab94(X) :- area(X,N0), N0=<85767.0, aspectration(X,N4), N4=<1.843, shapefactor2(X,N13), N13=<0.001. 
ab95(X) :- roundness(X,N10), N10=<0.801, not ab93(X), not ab94(X). 
ab96(X) :- minoraxislength(X,N3), N3=<205.399. 
ab97(X) :- extent(X,N8), N8=<0.704, not ab96(X). 
ab98(X) :- roundness(X,N10), N10>0.865. 
ab99(X) :- area(X,N0), N0>79363.0, not ab98(X). 
ab100(X) :- area(X,N0), N0>56376.0, N0=<60493.0. 
ab101(X) :- area(X,N0), N0>55820.0, solidity(X,N9), N9>0.988, not ab97(X), not ab99(X), not ab100(X). 
ab102(X) :- aspectration(X,N4), N4=<1.743, not ab101(X). 
ab103(X) :- majoraxislength(X,N2), N2=<342.492. 
ab104(X) :- perimeter(X,N1), N1=<920.668, not ab103(X). 
ab105(X) :- solidity(X,N9), N9>0.986, shapefactor4(X,N15), N15=<0.997, not ab102(X), not ab104(X). 
ab106(X) :- aspectration(X,N4), N4>1.791. 
ab107(X) :- area(X,N0), N0=<70042.0, not ab106(X). 
ab108(X) :- solidity(X,N9), N9>0.99, shapefactor4(X,N15), N15>0.997, not ab107(X). 
ab109(X) :- shapefactor4(X,N15), N15>0.998, N15=<0.998. 
ab110(X) :- area(X,N0), N0=<61129.0, shapefactor4(X,N15), N15>0.999. 
ab111(X) :- solidity(X,N9), N9=<0.991, shapefactor4(X,N15), N15>0.995, not ab105(X), not ab108(X), not ab109(X), not ab110(X). 
ab112(X) :- solidity(X,N9), N9=<0.985. 
ab113(X) :- aspectration(X,N4), N4=<1.662, not ab112(X). 
ab114(X) :- shapefactor2(X,N13), N13=<0.001. 
ab115(X) :- shapefactor4(X,N15), N15>0.993, not ab113(X), not ab114(X). 
ab116(X) :- roundness(X,N10), N10=<0.825. 
ab117(X) :- extent(X,N8), N8>0.743, not ab115(X), not ab116(X). 
ab118(X) :- area(X,N0), N0=<55513.0. 
ab119(X) :- minoraxislength(X,N3), N3=<205.53, not ab118(X). 
ab120(X) :- area(X,N0), N0=<58078.0, not ab119(X). 
ab121(X) :- extent(X,N8), N8=<0.732, shapefactor2(X,N13), N13>0.001, not ab120(X). 
ab122(X) :- majoraxislength(X,N2), N2>352.179, roundness(X,N10), N10>0.874. 
ab123(X) :- majoraxislength(X,N2), N2=<361.877, not ab117(X), not ab121(X), not ab122(X). 
ab124(X) :- convexarea(X,N6), N6=<73835.0, roundness(X,N10), N10=<0.83, compactness(X,N11), N11>0.773. 
ab125(X) :- extent(X,N8), N8=<0.708. 
ab126(X) :- solidity(X,N9), N9>0.99, not ab125(X). 
ab127(X) :- roundness(X,N10), N10>0.88. 
ab128(X) :- area(X,N0), N0>62128.0, aspectration(X,N4), N4=<1.593, not ab127(X). 
ab129(X) :- aspectration(X,N4), N4>1.497, solidity(X,N9), N9=<0.989, shapefactor4(X,N15), N15=<0.996, not ab112(X), not ab128(X). 
ab130(X) :- area(X,N0), N0>68384.0, N0=<69623.0, solidity(X,N9), N9>0.988, N9=<0.99. 
ab131(X) :- extent(X,N8), N8>0.771. 
ab132(X) :- minoraxislength(X,N3), N3>232.344, N3=<233.284, roundness(X,N10), N10>0.864, not ab131(X). 
ab133(X) :- convexarea(X,N6), N6=<57509.0, extent(X,N8), N8=<0.713. 
ab134(X) :- area(X,N0), N0=<48439.0. 
ab135(X) :- minoraxislength(X,N3), N3=<223.037, aspectration(X,N4), N4=<1.619, extent(X,N8), N8>0.794, not ab134(X). 
ab136(X) :- shapefactor1(X,N12), N12=<0.006, shapefactor4(X,N15), N15>0.994, not ab126(X), not ab129(X), not ab130(X), not ab132(X), not ab133(X), not ab135(X). 
ab137(X) :- roundness(X,N10), N10>0.851, not ab136(X). 
ab138(X) :- extent(X,N8), N8>0.76. 
ab139(X) :- minoraxislength(X,N3), N3>216.846, extent(X,N8), N8>0.645, not ab138(X). 
ab140(X) :- compactness(X,N11), N11=<0.728, not ab139(X). 
ab141(X) :- roundness(X,N10), N10>0.806, shapefactor2(X,N13), N13=<0.001, shapefactor4(X,N15), N15=<0.991. 
ab142(X) :- shapefactor4(X,N15), N15=<0.975. 
ab143(X) :- perimeter(X,N1), N1=<796.404. 
ab144(X) :- area(X,N0), N0=<56074.0, compactness(X,N11), N11=<0.751. 
ab145(X) :- aspectration(X,N4), N4>1.612. 
ab146(X) :- roundness(X,N10), N10>0.84, N10=<0.846, compactness(X,N11), N11=<0.8, shapefactor4(X,N15), N15=<0.996, not ab145(X). 
ab147(X) :- area(X,N0), N0=<64526.0, compactness(X,N11), N11=<0.746. 
ab148(X) :- extent(X,N8), N8>0.752. 
ab149(X) :- roundness(X,N10), N10>0.825, shapefactor2(X,N13), N13=<0.001, shapefactor4(X,N15), N15=<0.994, not ab148(X). 
ab150(X) :- majoraxislength(X,N2), N2>296.846, N2=<297.87. 
ab151(X) :- solidity(X,N9), N9>0.976, shapefactor4(X,N15), N15=<0.987. 
ab152(X) :- compactness(X,N11), N11>0.835. 
ab153(X) :- aspectration(X,N4), N4>1.626. 
ab154(X) :- minoraxislength(X,N3), N3=<223.779, aspectration(X,N4), N4=<1.548. 
ab155(X) :- extent(X,N8), N8>0.798, solidity(X,N9), N9=<0.992, shapefactor4(X,N15), N15>0.997. 
ab156(X) :- perimeter(X,N1), N1>937.773. 
ab157(X) :- shapefactor4(X,N15), N15=<0.992. 
ab158(X) :- area(X,N0), N0>57144.0. 
ab159(X) :- minoraxislength(X,N3), N3=<191.352. 
ab160(X) :- aspectration(X,N4), N4=<1.404.