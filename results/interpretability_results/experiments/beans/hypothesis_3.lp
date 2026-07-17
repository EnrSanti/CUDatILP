class(X,'dermason') :- convexarea(X,N6), N6=<40675.0, not ab17(X), not ab19(X), not ab25(X), not ab28(X). 
class(X,'sira') :- majoraxislength(X,N2), N2=<343.84, compactness(X,N11), N11=<0.853, not ab39(X), not ab50(X), not ab57(X), not ab58(X). 
class(X,'seker') :- shapefactor2(X,N13), N13>0.002, not ab63(X), not ab66(X), not ab67(X), not ab68(X). 
class(X,'horoz') :- shapefactor1(X,N12), N12>0.006, not ab76(X). 
class(X,'cali') :- compactness(X,N11), N11=<0.784, not ab77(X), not ab85(X), not ab90(X), not ab97(X), not ab101(X), not ab102(X), not ab103(X), not ab105(X), not ab106(X), not ab107(X), not ab109(X), not ab112(X). 
class(X,'barbunya') :- majoraxislength(X,N2), N2=<469.286, not ab131(X), not ab138(X), not ab144(X), not ab145(X), not ab146(X), not ab147(X), not ab148(X), not ab149(X), not ab152(X), not ab153(X), not ab154(X). 
class(X,'bombay') :- area(X,N0), N0>106700.0. 
class(X,'cali') :- shapefactor1(X,N12), N12=<0.006, not ab156(X), not ab158(X). 
class(X,'dermason') :- convexarea(X,N6), N6=<42458.0, not ab161(X), not ab162(X), not ab163(X), not ab164(X). 
class(X,'sira') :- minoraxislength(X,N3), N3=<208.906, not ab167(X), not ab168(X). 
class(X,'horoz') :- perimeter(X,N1), N1>931.321. 
class(X,'seker') :- majoraxislength(X,N2), N2=<339.932, not ab169(X), not ab171(X). 
class(X,'cali') :- shapefactor1(X,N12), N12=<0.006. 
class(X,'sira') :- area(X,N0), N0>55103.0. 
class(X,'horoz') :- area(X,N0), N0>45666.0. 
class(X,'cali') :- area(X,N0), N0=<45666.0. 
ab1(X) :- aspectration(X,N4), N4>1.368, roundness(X,N10), N10>0.933. 
ab2(X) :- area(X,N0), N0>38969.0, aspectration(X,N4), N4=<1.322. 
ab3(X) :- majoraxislength(X,N2), N2=<251.882, shapefactor4(X,N15), N15>0.998. 
ab4(X) :- aspectration(X,N4), N4>1.301, solidity(X,N9), N9=<0.991, roundness(X,N10), N10>0.926, shapefactor4(X,N15), N15=<0.998, not ab1(X), not ab2(X), not ab3(X). 
ab5(X) :- shapefactor4(X,N15), N15>0.997. 
ab6(X) :- extent(X,N8), N8=<0.72, compactness(X,N11), N11=<0.861, not ab5(X). 
ab7(X) :- area(X,N0), N0>39712.0. 
ab8(X) :- minoraxislength(X,N3), N3=<188.527, not ab7(X). 
ab9(X) :- roundness(X,N10), N10=<0.925, compactness(X,N11), N11=<0.887, shapefactor4(X,N15), N15>0.993, N15=<0.996, not ab8(X). 
ab10(X) :- aspectration(X,N4), N4=<1.285, compactness(X,N11), N11=<0.881. 
ab11(X) :- area(X,N0), N0>39009.0, aspectration(X,N4), N4>1.373, shapefactor2(X,N13), N13>0.002, shapefactor4(X,N15), N15>0.998. 
ab12(X) :- aspectration(X,N4), N4>1.412, shapefactor4(X,N15), N15>0.998. 
ab13(X) :- aspectration(X,N4), N4>1.301, N4=<1.315, roundness(X,N10), N10>0.958. 
ab14(X) :- extent(X,N8), N8=<0.722. 
ab15(X) :- area(X,N0), N0>39009.0, aspectration(X,N4), N4>1.412, N4=<1.422, not ab14(X). 
ab16(X) :- perimeter(X,N1), N1=<691.866, shapefactor4(X,N15), N15=<0.994. 
ab17(X) :- shapefactor1(X,N12), N12=<0.007, not ab4(X), not ab6(X), not ab9(X), not ab10(X), not ab11(X), not ab12(X), not ab13(X), not ab15(X), not ab16(X). 
ab18(X) :- area(X,N0), N0=<35808.0, extent(X,N8), N8>0.802. 
ab19(X) :- perimeter(X,N1), N1>704.877, roundness(X,N10), N10=<0.903, shapefactor2(X,N13), N13=<0.001, not ab18(X). 
ab20(X) :- area(X,N0), N0>39041.0. 
ab21(X) :- perimeter(X,N1), N1>749.899, extent(X,N8), N8>0.729, not ab20(X). 
ab22(X) :- perimeter(X,N1), N1>756.557, N1=<765.067. 
ab23(X) :- roundness(X,N10), N10=<0.874, not ab21(X), not ab22(X). 
ab24(X) :- shapefactor4(X,N15), N15>0.997, not ab23(X). 
ab25(X) :- minoraxislength(X,N3), N3>168.675, convexarea(X,N6), N6>37545.0, roundness(X,N10), N10=<0.901, not ab24(X). 
ab26(X) :- area(X,N0), N0=<30008.0. 
ab27(X) :- shapefactor4(X,N15), N15=<0.996, not ab26(X). 
ab28(X) :- compactness(X,N11), N11>0.884, shapefactor1(X,N12), N12=<0.007, not ab27(X). 
ab29(X) :- minoraxislength(X,N3), N3>193.634. 
ab30(X) :- area(X,N0), N0=<44904.0, shapefactor1(X,N12), N12=<0.007, not ab29(X). 
ab31(X) :- area(X,N0), N0=<41487.0, minoraxislength(X,N3), N3=<181.163. 
ab32(X) :- extent(X,N8), N8=<0.68, roundness(X,N10), N10>0.825. 
ab33(X) :- perimeter(X,N1), N1=<839.583, minoraxislength(X,N3), N3>172.503, aspectration(X,N4), N4=<1.882, shapefactor1(X,N12), N12>0.006, not ab30(X), not ab31(X), not ab32(X). 
ab34(X) :- perimeter(X,N1), N1>852.11, compactness(X,N11), N11>0.732, shapefactor1(X,N12), N12>0.006, shapefactor4(X,N15), N15>0.986, N15=<0.99. 
ab35(X) :- perimeter(X,N1), N1>856.955, majoraxislength(X,N2), N2=<305.151, shapefactor1(X,N12), N12>0.006. 
ab36(X) :- area(X,N0), N0>48044.0, N0=<48099.0, shapefactor1(X,N12), N12>0.006. 
ab37(X) :- solidity(X,N9), N9>0.98, N9=<0.98. 
ab38(X) :- roundness(X,N10), N10>0.731, N10=<0.737. 
ab39(X) :- roundness(X,N10), N10=<0.835, not ab33(X), not ab34(X), not ab35(X), not ab36(X), not ab37(X), not ab38(X). 
ab40(X) :- extent(X,N8), N8=<0.752. 
ab41(X) :- perimeter(X,N1), N1>760.096, roundness(X,N10), N10=<0.934, not ab40(X). 
ab42(X) :- extent(X,N8), N8>0.781. 
ab43(X) :- solidity(X,N9), N9>0.991, not ab42(X). 
ab44(X) :- aspectration(X,N4), N4>1.464, shapefactor2(X,N13), N13>0.002. 
ab45(X) :- majoraxislength(X,N2), N2>284.999. 
ab46(X) :- minoraxislength(X,N3), N3>191.033. 
ab47(X) :- perimeter(X,N1), N1=<752.069, extent(X,N8), N8=<0.785, not ab43(X), not ab44(X), not ab45(X), not ab46(X). 
ab48(X) :- perimeter(X,N1), N1=<744.001, extent(X,N8), N8>0.801. 
ab49(X) :- area(X,N0), N0=<41315.0, majoraxislength(X,N2), N2=<287.829, solidity(X,N9), N9=<0.992, shapefactor1(X,N12), N12>0.007, not ab47(X), not ab48(X). 
ab50(X) :- perimeter(X,N1), N1=<764.207, solidity(X,N9), N9>0.99, not ab41(X), not ab49(X). 
ab51(X) :- minoraxislength(X,N3), N3>224.729. 
ab52(X) :- solidity(X,N9), N9=<0.985, shapefactor4(X,N15), N15>0.992. 
ab53(X) :- solidity(X,N9), N9>0.989, N9=<0.989. 
ab54(X) :- roundness(X,N10), N10>0.92. 
ab55(X) :- majoraxislength(X,N2), N2>337.875. 
ab56(X) :- perimeter(X,N1), N1=<898.251, shapefactor4(X,N15), N15=<0.998, not ab51(X), not ab52(X), not ab53(X), not ab54(X), not ab55(X). 
ab57(X) :- minoraxislength(X,N3), N3>210.971, not ab56(X). 
ab58(X) :- majoraxislength(X,N2), N2>298.339, convexarea(X,N6), N6=<42673.0, solidity(X,N9), N9>0.99. 
ab59(X) :- area(X,N0), N0>51268.0. 
ab60(X) :- minoraxislength(X,N3), N3>202.486, not ab59(X). 
ab61(X) :- roundness(X,N10), N10=<0.79. 
ab62(X) :- perimeter(X,N1), N1>739.802, N1=<747.919, minoraxislength(X,N3), N3=<197.113. 
ab63(X) :- shapefactor2(X,N13), N13=<0.002, shapefactor4(X,N15), N15=<0.997, not ab60(X), not ab61(X), not ab62(X). 
ab64(X) :- area(X,N0), N0=<52341.0. 
ab65(X) :- solidity(X,N9), N9=<0.982, not ab64(X). 
ab66(X) :- majoraxislength(X,N2), N2>259.378, minoraxislength(X,N3), N3>226.914, roundness(X,N10), N10=<0.921, not ab65(X). 
ab67(X) :- aspectration(X,N4), N4>1.397, extent(X,N8), N8=<0.739. 
ab68(X) :- solidity(X,N9), N9>0.99, roundness(X,N10), N10=<0.921, compactness(X,N11), N11=<0.89. 
ab69(X) :- majoraxislength(X,N2), N2>351.332, compactness(X,N11), N11>0.748. 
ab70(X) :- compactness(X,N11), N11=<0.739, shapefactor2(X,N13), N13=<0.001. 
ab71(X) :- roundness(X,N10), N10=<0.843, compactness(X,N11), N11=<0.762, not ab69(X), not ab70(X). 
ab72(X) :- area(X,N0), N0>57371.0. 
ab73(X) :- minoraxislength(X,N3), N3>208.612, not ab72(X). 
ab74(X) :- area(X,N0), N0=<57500.0, shapefactor4(X,N15), N15=<0.986. 
ab75(X) :- extent(X,N8), N8>0.803, N8=<0.805. 
ab76(X) :- compactness(X,N11), N11>0.738, not ab71(X), not ab73(X), not ab74(X), not ab75(X). 
ab77(X) :- area(X,N0), N0>116272.0. 
ab78(X) :- minoraxislength(X,N3), N3=<231.932, roundness(X,N10), N10=<0.762. 
ab79(X) :- minoraxislength(X,N3), N3=<219.845, roundness(X,N10), N10=<0.792. 
ab80(X) :- area(X,N0), N0>65289.0, minoraxislength(X,N3), N3=<214.526. 
ab81(X) :- compactness(X,N11), N11=<0.751, shapefactor4(X,N15), N15=<0.993, not ab78(X), not ab79(X), not ab80(X). 
ab82(X) :- area(X,N0), N0=<69220.0. 
ab83(X) :- roundness(X,N10), N10>0.794, shapefactor2(X,N13), N13=<0.001, not ab82(X). 
ab84(X) :- shapefactor2(X,N13), N13>0.001, N13=<0.001. 
ab85(X) :- roundness(X,N10), N10=<0.801, not ab81(X), not ab83(X), not ab84(X). 
ab86(X) :- area(X,N0), N0>67849.0. 
ab87(X) :- solidity(X,N9), N9>0.987, not ab86(X). 
ab88(X) :- aspectration(X,N4), N4>1.748, solidity(X,N9), N9>0.986, not ab87(X). 
ab89(X) :- area(X,N0), N0>65732.0, roundness(X,N10), N10>0.858. 
ab90(X) :- solidity(X,N9), N9=<0.988, shapefactor4(X,N15), N15>0.995, not ab88(X), not ab89(X). 
ab91(X) :- shapefactor4(X,N15), N15>0.997. 
ab92(X) :- minoraxislength(X,N3), N3=<203.046. 
ab93(X) :- aspectration(X,N4), N4>1.662, shapefactor4(X,N15), N15>0.993, not ab92(X). 
ab94(X) :- perimeter(X,N1), N1>897.669, extent(X,N8), N8>0.741, not ab91(X), not ab93(X). 
ab95(X) :- area(X,N0), N0>58835.0, perimeter(X,N1), N1>921.449, majoraxislength(X,N2), N2=<356.039. 
ab96(X) :- extent(X,N8), N8>0.677, N8=<0.683. 
ab97(X) :- majoraxislength(X,N2), N2=<361.678, not ab94(X), not ab95(X), not ab96(X). 
ab98(X) :- perimeter(X,N1), N1=<978.997. 
ab99(X) :- shapefactor2(X,N13), N13=<0.001. 
ab100(X) :- solidity(X,N9), N9>0.989, N9=<0.99. 
ab101(X) :- solidity(X,N9), N9=<0.99, shapefactor4(X,N15), N15>0.996, not ab98(X), not ab99(X), not ab100(X). 
ab102(X) :- minoraxislength(X,N3), N3>236.32, convexarea(X,N6), N6=<73835.0, roundness(X,N10), N10=<0.83. 
ab103(X) :- perimeter(X,N1), N1>965.707, minoraxislength(X,N3), N3=<218.157, extent(X,N8), N8>0.811. 
ab104(X) :- roundness(X,N10), N10=<0.803. 
ab105(X) :- area(X,N0), N0=<64492.0, perimeter(X,N1), N1>992.946, not ab104(X). 
ab106(X) :- area(X,N0), N0=<68024.0, perimeter(X,N1), N1>1001.937, shapefactor2(X,N13), N13>0.001, shapefactor4(X,N15), N15>0.987. 
ab107(X) :- shapefactor1(X,N12), N12>0.006, N12=<0.006. 
ab108(X) :- extent(X,N8), N8>0.8. 
ab109(X) :- majoraxislength(X,N2), N2=<416.301, roundness(X,N10), N10>0.844, shapefactor2(X,N13), N13=<0.001, shapefactor4(X,N15), N15>0.997, not ab108(X). 
ab110(X) :- perimeter(X,N1), N1=<1016.057. 
ab111(X) :- area(X,N0), N0=<68264.0, not ab110(X). 
ab112(X) :- majoraxislength(X,N2), N2=<412.382, roundness(X,N10), N10=<0.83, shapefactor2(X,N13), N13=<0.001, not ab111(X). 
ab113(X) :- roundness(X,N10), N10>0.895. 
ab114(X) :- minoraxislength(X,N3), N3=<212.061. 
ab115(X) :- solidity(X,N9), N9=<0.99, shapefactor4(X,N15), N15>0.996, not ab113(X), not ab114(X). 
ab116(X) :- extent(X,N8), N8=<0.705. 
ab117(X) :- extent(X,N8), N8=<0.771. 
ab118(X) :- aspectration(X,N4), N4>1.533. 
ab119(X) :- minoraxislength(X,N3), N3>232.926, shapefactor2(X,N13), N13>0.001, not ab117(X), not ab118(X). 
ab120(X) :- shapefactor2(X,N13), N13=<0.001. 
ab121(X) :- solidity(X,N9), N9>0.99, shapefactor4(X,N15), N15=<0.993. 
ab122(X) :- roundness(X,N10), N10>0.874, not ab115(X), not ab116(X), not ab119(X), not ab120(X), not ab121(X). 
ab123(X) :- extent(X,N8), N8=<0.703. 
ab124(X) :- aspectration(X,N4), N4=<1.609, solidity(X,N9), N9>0.989. 
ab125(X) :- area(X,N0), N0>57000.0, N0=<61787.0. 
ab126(X) :- compactness(X,N11), N11=<0.793, shapefactor4(X,N15), N15=<0.996, not ab123(X), not ab124(X), not ab125(X). 
ab127(X) :- area(X,N0), N0=<69623.0, solidity(X,N9), N9>0.988, roundness(X,N10), N10=<0.862. 
ab128(X) :- area(X,N0), N0>50035.0, N0=<51408.0. 
ab129(X) :- minoraxislength(X,N3), N3>204.703, shapefactor4(X,N15), N15>0.993, not ab122(X), not ab126(X), not ab127(X), not ab128(X). 
ab130(X) :- solidity(X,N9), N9>0.987, roundness(X,N10), N10=<0.869, shapefactor4(X,N15), N15=<0.992. 
ab131(X) :- roundness(X,N10), N10>0.857, not ab129(X), not ab130(X). 
ab132(X) :- extent(X,N8), N8>0.694. 
ab133(X) :- shapefactor4(X,N15), N15=<0.994, not ab132(X). 
ab134(X) :- roundness(X,N10), N10=<0.776, not ab133(X). 
ab135(X) :- minoraxislength(X,N3), N3>222.836, shapefactor4(X,N15), N15>0.995. 
ab136(X) :- solidity(X,N9), N9=<0.983, shapefactor4(X,N15), N15>0.995. 
ab137(X) :- shapefactor4(X,N15), N15>0.995, N15=<0.995. 
ab138(X) :- compactness(X,N11), N11=<0.747, not ab134(X), not ab135(X), not ab136(X), not ab137(X). 
ab139(X) :- solidity(X,N9), N9=<0.963. 
ab140(X) :- area(X,N0), N0=<40786.0. 
ab141(X) :- area(X,N0), N0=<68062.0, not ab140(X). 
ab142(X) :- roundness(X,N10), N10>0.825, not ab141(X). 
ab143(X) :- roundness(X,N10), N10=<0.836, not ab139(X), not ab142(X). 
ab144(X) :- roundness(X,N10), N10>0.806, compactness(X,N11), N11=<0.795, shapefactor4(X,N15), N15=<0.993, not ab143(X). 
ab145(X) :- area(X,N0), N0=<39127.0. 
ab146(X) :- area(X,N0), N0=<61918.0, solidity(X,N9), N9>0.989, roundness(X,N10), N10=<0.853. 
ab147(X) :- area(X,N0), N0>80724.0, solidity(X,N9), N9>0.99. 
ab148(X) :- perimeter(X,N1), N1>846.474, N1=<1040.579, majoraxislength(X,N2), N2=<300.831, solidity(X,N9), N9>0.985. 
ab149(X) :- solidity(X,N9), N9=<0.971, roundness(X,N10), N10>0.844. 
ab150(X) :- aspectration(X,N4), N4=<1.612. 
ab151(X) :- perimeter(X,N1), N1>937.773, not ab150(X). 
ab152(X) :- minoraxislength(X,N3), N3=<236.7, solidity(X,N9), N9>0.985, N9=<0.985, shapefactor4(X,N15), N15=<0.995, not ab151(X). 
ab153(X) :- extent(X,N8), N8>0.769, solidity(X,N9), N9>0.99, shapefactor4(X,N15), N15>0.998. 
ab154(X) :- solidity(X,N9), N9>0.99, N9=<0.99. 
ab155(X) :- minoraxislength(X,N3), N3>237.9. 
ab156(X) :- roundness(X,N10), N10=<0.826, not ab155(X). 
ab157(X) :- majoraxislength(X,N2), N2=<303.848. 
ab158(X) :- perimeter(X,N1), N1=<896.189, not ab157(X). 
ab159(X) :- perimeter(X,N1), N1=<732.733. 
ab160(X) :- shapefactor4(X,N15), N15>0.995, not ab159(X). 
ab161(X) :- minoraxislength(X,N3), N3>194.336, not ab160(X). 
ab162(X) :- area(X,N0), N0>41443.0, extent(X,N8), N8=<0.715, roundness(X,N10), N10>0.914. 
ab163(X) :- area(X,N0), N0>41875.0, perimeter(X,N1), N1=<754.72. 
ab164(X) :- area(X,N0), N0>41979.0, N0=<41993.0. 
ab165(X) :- area(X,N0), N0=<41607.0. 
ab166(X) :- roundness(X,N10), N10=<0.918, not ab165(X). 
ab167(X) :- shapefactor4(X,N15), N15>0.998, not ab166(X). 
ab168(X) :- area(X,N0), N0>57790.0. 
ab169(X) :- majoraxislength(X,N2), N2=<274.863. 
ab170(X) :- area(X,N0), N0>55103.0. 
ab171(X) :- area(X,N0), N0>51426.0, roundness(X,N10), N10=<0.887, not ab170(X).