class(X,'dermason') :- area(X,N0), N0=<42159.0, not ab15(X), not ab23(X). 
class(X,'sira') :- majoraxislength(X,N2), N2=<343.84, compactness(X,N11), N11=<0.85, not ab37(X), not ab44(X), not ab50(X), not ab52(X). 
class(X,'seker') :- shapefactor2(X,N13), N13>0.002, not ab57(X), not ab59(X), not ab60(X), not ab63(X). 
class(X,'horoz') :- compactness(X,N11), N11=<0.728, not ab71(X), not ab72(X), not ab73(X). 
class(X,'cali') :- compactness(X,N11), N11=<0.785, not ab74(X), not ab81(X), not ab85(X), not ab89(X), not ab94(X), not ab95(X), not ab96(X). 
class(X,'barbunya') :- area(X,N0), N0=<115967.0, not ab108(X), not ab111(X), not ab125(X), not ab128(X), not ab130(X), not ab131(X), not ab132(X), not ab133(X), not ab134(X), not ab135(X), not ab136(X), not ab137(X), not ab138(X), not ab139(X). 
class(X,'bombay') :- area(X,N0), N0>106700.0. 
class(X,'cali') :- shapefactor1(X,N12), N12=<0.006, not ab141(X), not ab143(X). 
class(X,'horoz') :- roundness(X,N10), N10=<0.849, not ab150(X), not ab151(X). 
class(X,'sira') :- shapefactor2(X,N13), N13=<0.001, not ab154(X), not ab157(X), not ab158(X). 
class(X,'dermason') :- area(X,N0), N0=<42026.0, roundness(X,N10), N10>0.927, not ab159(X), not ab160(X), not ab161(X), not ab162(X). 
class(X,'seker') :- area(X,N0), N0>51945.0, shapefactor4(X,N15), N15>0.997. 
ab1(X) :- roundness(X,N10), N10=<0.879. 
ab2(X) :- aspectration(X,N4), N4>1.428, N4=<1.473. 
ab3(X) :- area(X,N0), N0>39453.0. 
ab4(X) :- shapefactor4(X,N15), N15>0.997, N15=<0.997, not ab2(X), not ab3(X). 
ab5(X) :- area(X,N0), N0>39528.0. 
ab6(X) :- area(X,N0), N0>39128.0, not ab5(X). 
ab7(X) :- minoraxislength(X,N3), N3>182.286, shapefactor4(X,N15), N15>0.998, not ab6(X). 
ab8(X) :- minoraxislength(X,N3), N3>184.148, extent(X,N8), N8=<0.746, shapefactor4(X,N15), N15=<0.995. 
ab9(X) :- roundness(X,N10), N10=<0.903, not ab1(X), not ab4(X), not ab7(X), not ab8(X). 
ab10(X) :- roundness(X,N10), N10>0.934. 
ab11(X) :- area(X,N0), N0=<39415.0, extent(X,N8), N8=<0.734, shapefactor1(X,N12), N12=<0.007, shapefactor4(X,N15), N15>0.997, not ab10(X). 
ab12(X) :- extent(X,N8), N8=<0.693. 
ab13(X) :- perimeter(X,N1), N1=<748.048, compactness(X,N11), N11=<0.876, shapefactor1(X,N12), N12>0.007, not ab9(X), not ab11(X), not ab12(X). 
ab14(X) :- solidity(X,N9), N9>0.993, compactness(X,N11), N11=<0.876, shapefactor4(X,N15), N15>0.999. 
ab15(X) :- minoraxislength(X,N3), N3>180.769, not ab13(X), not ab14(X). 
ab16(X) :- solidity(X,N9), N9=<0.987. 
ab17(X) :- solidity(X,N9), N9=<0.99, not ab16(X). 
ab18(X) :- majoraxislength(X,N2), N2>298.991, not ab17(X). 
ab19(X) :- aspectration(X,N4), N4=<1.742, not ab18(X). 
ab20(X) :- roundness(X,N10), N10>0.865, not ab19(X). 
ab21(X) :- majoraxislength(X,N2), N2=<298.088, solidity(X,N9), N9>0.988. 
ab22(X) :- area(X,N0), N0=<35808.0, perimeter(X,N1), N1=<739.41, shapefactor4(X,N15), N15>0.992. 
ab23(X) :- perimeter(X,N1), N1>702.212, shapefactor2(X,N13), N13=<0.002, not ab20(X), not ab21(X), not ab22(X). 
ab24(X) :- roundness(X,N10), N10=<0.835, shapefactor4(X,N15), N15=<0.978. 
ab25(X) :- roundness(X,N10), N10=<0.835, shapefactor4(X,N15), N15>0.998. 
ab26(X) :- roundness(X,N10), N10=<0.82. 
ab27(X) :- shapefactor4(X,N15), N15=<0.993, not ab26(X). 
ab28(X) :- aspectration(X,N4), N4=<1.725. 
ab29(X) :- extent(X,N8), N8=<0.783, solidity(X,N9), N9>0.983, not ab28(X). 
ab30(X) :- roundness(X,N10), N10=<0.835, shapefactor2(X,N13), N13=<0.001, not ab27(X), not ab29(X). 
ab31(X) :- area(X,N0), N0>50486.0. 
ab32(X) :- minoraxislength(X,N3), N3=<182.292. 
ab33(X) :- extent(X,N8), N8>0.774, compactness(X,N11), N11>0.767, not ab31(X), not ab32(X). 
ab34(X) :- extent(X,N8), N8=<0.696, shapefactor2(X,N13), N13>0.002. 
ab35(X) :- minoraxislength(X,N3), N3>186.371, solidity(X,N9), N9>0.985. 
ab36(X) :- minoraxislength(X,N3), N3=<199.214, aspectration(X,N4), N4=<1.882, compactness(X,N11), N11>0.743, not ab24(X), not ab25(X), not ab30(X), not ab33(X), not ab34(X), not ab35(X). 
ab37(X) :- roundness(X,N10), N10=<0.838, not ab36(X). 
ab38(X) :- solidity(X,N9), N9=<0.989. 
ab39(X) :- minoraxislength(X,N3), N3>200.187, not ab38(X). 
ab40(X) :- area(X,N0), N0>41221.0. 
ab41(X) :- perimeter(X,N1), N1>748.568, not ab40(X). 
ab42(X) :- area(X,N0), N0=<42139.0, aspectration(X,N4), N4>1.403, not ab41(X). 
ab43(X) :- solidity(X,N9), N9=<0.992, shapefactor4(X,N15), N15=<0.997, not ab39(X), not ab42(X). 
ab44(X) :- roundness(X,N10), N10>0.918, not ab43(X). 
ab45(X) :- perimeter(X,N1), N1=<873.756. 
ab46(X) :- minoraxislength(X,N3), N3>217.016, not ab45(X). 
ab47(X) :- shapefactor4(X,N15), N15>0.997. 
ab48(X) :- minoraxislength(X,N3), N3=<212.426, not ab47(X). 
ab49(X) :- perimeter(X,N1), N1=<898.251, shapefactor4(X,N15), N15=<0.998, not ab46(X), not ab48(X). 
ab50(X) :- minoraxislength(X,N3), N3>210.971, not ab49(X). 
ab51(X) :- area(X,N0), N0>41155.0. 
ab52(X) :- aspectration(X,N4), N4>1.801, convexarea(X,N6), N6=<42673.0, not ab51(X). 
ab53(X) :- shapefactor4(X,N15), N15=<0.995. 
ab54(X) :- area(X,N0), N0>42026.0, not ab53(X). 
ab55(X) :- extent(X,N8), N8=<0.728. 
ab56(X) :- majoraxislength(X,N2), N2=<275.961, solidity(X,N9), N9>0.99, shapefactor2(X,N13), N13>0.002, not ab55(X). 
ab57(X) :- roundness(X,N10), N10=<0.939, compactness(X,N11), N11=<0.87, shapefactor4(X,N15), N15=<0.999, not ab54(X), not ab56(X). 
ab58(X) :- majoraxislength(X,N2), N2=<304.477. 
ab59(X) :- perimeter(X,N1), N1>910.603, shapefactor2(X,N13), N13=<0.002, not ab58(X). 
ab60(X) :- area(X,N0), N0=<39571.0, solidity(X,N9), N9>0.992, compactness(X,N11), N11=<0.853. 
ab61(X) :- solidity(X,N9), N9>0.989, compactness(X,N11), N11>0.884. 
ab62(X) :- perimeter(X,N1), N1=<716.903, majoraxislength(X,N2), N2>250.243. 
ab63(X) :- perimeter(X,N1), N1=<719.654, compactness(X,N11), N11=<0.891, shapefactor4(X,N15), N15=<0.997, not ab61(X), not ab62(X). 
ab64(X) :- area(X,N0), N0>72214.0. 
ab65(X) :- perimeter(X,N1), N1>1027.807, aspectration(X,N4), N4=<1.893. 
ab66(X) :- solidity(X,N9), N9>0.988. 
ab67(X) :- extent(X,N8), N8>0.708, not ab64(X), not ab65(X), not ab66(X). 
ab68(X) :- shapefactor1(X,N12), N12>0.006, not ab67(X). 
ab69(X) :- extent(X,N8), N8=<0.645, roundness(X,N10), N10=<0.789. 
ab70(X) :- minoraxislength(X,N3), N3>218.715, N3=<219.84, convexarea(X,N6), N6=<73133.0. 
ab71(X) :- shapefactor1(X,N12), N12=<0.006, not ab68(X), not ab69(X), not ab70(X). 
ab72(X) :- perimeter(X,N1), N1=<920.481, roundness(X,N10), N10>0.829, compactness(X,N11), N11>0.704, shapefactor1(X,N12), N12=<0.007. 
ab73(X) :- majoraxislength(X,N2), N2=<378.781, convexarea(X,N6), N6>59975.0, compactness(X,N11), N11>0.704. 
ab74(X) :- area(X,N0), N0>116272.0. 
ab75(X) :- perimeter(X,N1), N1>1149.98, compactness(X,N11), N11=<0.742. 
ab76(X) :- roundness(X,N10), N10=<0.771, not ab75(X). 
ab77(X) :- area(X,N0), N0>80390.0. 
ab78(X) :- shapefactor4(X,N15), N15>0.995, not ab77(X). 
ab79(X) :- shapefactor2(X,N13), N13=<0.001, not ab76(X), not ab78(X). 
ab80(X) :- roundness(X,N10), N10>0.748, shapefactor4(X,N15), N15>0.982, N15=<0.985. 
ab81(X) :- roundness(X,N10), N10=<0.801, not ab79(X), not ab80(X). 
ab82(X) :- shapefactor4(X,N15), N15=<0.982. 
ab83(X) :- perimeter(X,N1), N1>939.011, solidity(X,N9), N9>0.981. 
ab84(X) :- convexarea(X,N6), N6>56187.0, extent(X,N8), N8>0.741, shapefactor4(X,N15), N15=<0.993, not ab82(X), not ab83(X). 
ab85(X) :- area(X,N0), N0=<60993.0, not ab84(X). 
ab86(X) :- area(X,N0), N0=<66874.0. 
ab87(X) :- extent(X,N8), N8>0.743, not ab86(X). 
ab88(X) :- aspectration(X,N4), N4>1.748, not ab87(X). 
ab89(X) :- solidity(X,N9), N9=<0.988, shapefactor4(X,N15), N15>0.995, not ab88(X). 
ab90(X) :- perimeter(X,N1), N1=<978.997. 
ab91(X) :- shapefactor2(X,N13), N13=<0.001. 
ab92(X) :- shapefactor2(X,N13), N13>0.001. 
ab93(X) :- area(X,N0), N0>72327.0, solidity(X,N9), N9>0.989. 
ab94(X) :- solidity(X,N9), N9=<0.99, shapefactor4(X,N15), N15>0.996, not ab90(X), not ab91(X), not ab92(X), not ab93(X). 
ab95(X) :- majoraxislength(X,N2), N2=<399.933, roundness(X,N10), N10=<0.83, compactness(X,N11), N11>0.773. 
ab96(X) :- area(X,N0), N0=<64492.0, majoraxislength(X,N2), N2=<399.933, extent(X,N8), N8=<0.645, roundness(X,N10), N10=<0.837, shapefactor4(X,N15), N15=<0.988. 
ab97(X) :- convexarea(X,N6), N6=<42244.0. 
ab98(X) :- roundness(X,N10), N10=<0.815, compactness(X,N11), N11>0.755, not ab97(X). 
ab99(X) :- area(X,N0), N0=<34924.0. 
ab100(X) :- majoraxislength(X,N2), N2=<314.0, not ab99(X). 
ab101(X) :- shapefactor4(X,N15), N15=<0.996, not ab100(X). 
ab102(X) :- perimeter(X,N1), N1>813.48, compactness(X,N11), N11>0.765, not ab101(X). 
ab103(X) :- area(X,N0), N0=<38498.0. 
ab104(X) :- roundness(X,N10), N10=<0.789, shapefactor4(X,N15), N15>0.996, not ab103(X). 
ab105(X) :- extent(X,N8), N8>0.677. 
ab106(X) :- area(X,N0), N0>57055.0, minoraxislength(X,N3), N3>205.545, N3=<206.271, not ab105(X). 
ab107(X) :- solidity(X,N9), N9>0.98, N9=<0.98. 
ab108(X) :- shapefactor1(X,N12), N12>0.006, not ab98(X), not ab102(X), not ab104(X), not ab106(X), not ab107(X). 
ab109(X) :- aspectration(X,N4), N4>1.548. 
ab110(X) :- solidity(X,N9), N9>0.987, roundness(X,N10), N10=<0.869, not ab109(X). 
ab111(X) :- roundness(X,N10), N10>0.857, shapefactor4(X,N15), N15=<0.993, not ab110(X). 
ab112(X) :- shapefactor4(X,N15), N15>0.996. 
ab113(X) :- area(X,N0), N0=<67013.0, aspectration(X,N4), N4>1.475. 
ab114(X) :- minoraxislength(X,N3), N3>233.934, shapefactor2(X,N13), N13>0.001, not ab112(X), not ab113(X). 
ab115(X) :- extent(X,N8), N8=<0.703. 
ab116(X) :- solidity(X,N9), N9=<0.983. 
ab117(X) :- shapefactor4(X,N15), N15=<0.996, not ab114(X), not ab115(X), not ab116(X). 
ab118(X) :- roundness(X,N10), N10>0.902. 
ab119(X) :- shapefactor4(X,N15), N15>0.998, N15=<0.998. 
ab120(X) :- area(X,N0), N0>51782.0, N0=<54087.0. 
ab121(X) :- solidity(X,N9), N9=<0.99, not ab117(X), not ab118(X), not ab119(X), not ab120(X). 
ab122(X) :- extent(X,N8), N8=<0.705, solidity(X,N9), N9>0.99. 
ab123(X) :- extent(X,N8), N8=<0.717. 
ab124(X) :- area(X,N0), N0>64456.0, N0=<73478.0, aspectration(X,N4), N4=<1.566, solidity(X,N9), N9>0.991, not ab123(X). 
ab125(X) :- roundness(X,N10), N10>0.868, not ab121(X), not ab122(X), not ab124(X). 
ab126(X) :- shapefactor2(X,N13), N13>0.001. 
ab127(X) :- roundness(X,N10), N10=<0.825, shapefactor4(X,N15), N15>0.979. 
ab128(X) :- roundness(X,N10), N10>0.806, shapefactor4(X,N15), N15=<0.991, not ab126(X), not ab127(X). 
ab129(X) :- minoraxislength(X,N3), N3=<205.552. 
ab130(X) :- solidity(X,N9), N9>0.988, roundness(X,N10), N10=<0.867, shapefactor1(X,N12), N12>0.006, not ab129(X). 
ab131(X) :- perimeter(X,N1), N1>952.52, aspectration(X,N4), N4>1.568, roundness(X,N10), N10>0.83, shapefactor4(X,N15), N15=<0.994. 
ab132(X) :- area(X,N0), N0>85477.0, aspectration(X,N4), N4>1.568, extent(X,N8), N8>0.705, solidity(X,N9), N9>0.984, roundness(X,N10), N10>0.819, shapefactor4(X,N15), N15=<0.996. 
ab133(X) :- aspectration(X,N4), N4>1.568, N4=<1.568, roundness(X,N10), N10>0.819. 
ab134(X) :- perimeter(X,N1), N1>956.542, majoraxislength(X,N2), N2=<376.511, minoraxislength(X,N3), N3=<212.522, aspectration(X,N4), N4>1.575, roundness(X,N10), N10>0.819. 
ab135(X) :- aspectration(X,N4), N4>1.575, roundness(X,N10), N10>0.843, N10=<0.844. 
ab136(X) :- extent(X,N8), N8=<0.622. 
ab137(X) :- area(X,N0), N0=<69923.0, solidity(X,N9), N9>0.99, roundness(X,N10), N10=<0.864. 
ab138(X) :- solidity(X,N9), N9>0.976, shapefactor4(X,N15), N15=<0.987. 
ab139(X) :- roundness(X,N10), N10>0.865, N10=<0.865. 
ab140(X) :- solidity(X,N9), N9=<0.982. 
ab141(X) :- perimeter(X,N1), N1=<906.71, not ab140(X). 
ab142(X) :- minoraxislength(X,N3), N3>237.9. 
ab143(X) :- roundness(X,N10), N10=<0.826, not ab142(X). 
ab144(X) :- shapefactor4(X,N15), N15=<0.996. 
ab145(X) :- area(X,N0), N0>41774.0, solidity(X,N9), N9=<0.984. 
ab146(X) :- aspectration(X,N4), N4>1.707, solidity(X,N9), N9=<0.987, not ab144(X), not ab145(X). 
ab147(X) :- majoraxislength(X,N2), N2>371.691. 
ab148(X) :- shapefactor4(X,N15), N15>0.998. 
ab149(X) :- area(X,N0), N0>45893.0, extent(X,N8), N8=<0.661. 
ab150(X) :- shapefactor4(X,N15), N15>0.995, not ab146(X), not ab147(X), not ab148(X), not ab149(X). 
ab151(X) :- majoraxislength(X,N2), N2=<268.897. 
ab152(X) :- aspectration(X,N4), N4>1.824. 
ab153(X) :- minoraxislength(X,N3), N3>211.234. 
ab154(X) :- perimeter(X,N1), N1>921.449, not ab152(X), not ab153(X). 
ab155(X) :- perimeter(X,N1), N1>905.574. 
ab156(X) :- area(X,N0), N0>53775.0, extent(X,N8), N8=<0.65. 
ab157(X) :- majoraxislength(X,N2), N2>352.103, shapefactor4(X,N15), N15=<0.995, not ab155(X), not ab156(X). 
ab158(X) :- area(X,N0), N0>45893.0, perimeter(X,N1), N1=<867.948. 
ab159(X) :- extent(X,N8), N8=<0.714. 
ab160(X) :- extent(X,N8), N8>0.768, N8=<0.775. 
ab161(X) :- minoraxislength(X,N3), N3=<187.951, extent(X,N8), N8>0.779. 
ab162(X) :- extent(X,N8), N8>0.779, N8=<0.782.