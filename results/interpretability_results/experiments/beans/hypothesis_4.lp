class(X,'dermason') :- convexarea(X,N6), N6=<40675.0, not ab1(X), not ab2(X), not ab21(X), not ab25(X). 
class(X,'sira') :- majoraxislength(X,N2), N2=<343.84, compactness(X,N11), N11=<0.847, not ab27(X), not ab32(X), not ab33(X), not ab37(X), not ab38(X), not ab39(X), not ab40(X), not ab41(X), not ab42(X), not ab43(X), not ab44(X), not ab46(X), not ab47(X), not ab48(X), not ab52(X), not ab54(X), not ab55(X), not ab57(X), not ab58(X), not ab59(X), not ab60(X). 
class(X,'seker') :- shapefactor2(X,N13), N13>0.002, not ab66(X), not ab67(X), not ab69(X), not ab70(X), not ab72(X), not ab73(X), not ab74(X), not ab75(X). 
class(X,'horoz') :- compactness(X,N11), N11=<0.727, not ab80(X), not ab81(X), not ab82(X), not ab83(X), not ab84(X), not ab86(X), not ab87(X). 
class(X,'cali') :- compactness(X,N11), N11=<0.784, not ab88(X), not ab93(X), not ab99(X), not ab101(X), not ab104(X). 
class(X,'barbunya') :- majoraxislength(X,N2), N2=<469.286, not ab118(X), not ab125(X), not ab130(X), not ab131(X). 
class(X,'bombay') :- area(X,N0), N0>106700.0. 
class(X,'horoz') :- compactness(X,N11), N11=<0.762, not ab137(X), not ab138(X). 
class(X,'dermason') :- convexarea(X,N6), N6=<42668.0, not ab139(X), not ab141(X), not ab142(X), not ab143(X), not ab144(X). 
class(X,'cali') :- area(X,N0), N0>58074.0, not ab145(X). 
class(X,'sira') :- minoraxislength(X,N3), N3=<210.418. 
class(X,'seker') :- roundness(X,N10), N10>0.913. 
class(X,'cali') :- minoraxislength(X,N3), N3>212.927, not ab147(X). 
class(X,'seker') :- area(X,N0), N0>55103.0. 
class(X,'horoz') :- area(X,N0), N0>48525.0. 
class(X,'sira') :- area(X,N0), N0=<48525.0. 
ab1(X) :- shapefactor1(X,N12), N12=<0.007. 
ab2(X) :- perimeter(X,N1), N1>739.545, shapefactor2(X,N13), N13=<0.001. 
ab3(X) :- area(X,N0), N0>37504.0, N0=<37873.0. 
ab4(X) :- majoraxislength(X,N2), N2=<273.649, minoraxislength(X,N3), N3=<179.678, not ab3(X). 
ab5(X) :- perimeter(X,N1), N1>736.433, extent(X,N8), N8>0.731. 
ab6(X) :- extent(X,N8), N8>0.746, N8=<0.748. 
ab7(X) :- perimeter(X,N1), N1>733.425, extent(X,N8), N8>0.767. 
ab8(X) :- area(X,N0), N0>37086.0, convexarea(X,N6), N6=<38852.0, shapefactor4(X,N15), N15>0.994, not ab4(X), not ab5(X), not ab6(X), not ab7(X). 
ab9(X) :- majoraxislength(X,N2), N2>268.897. 
ab10(X) :- minoraxislength(X,N3), N3>186.432, not ab9(X). 
ab11(X) :- area(X,N0), N0>39623.0. 
ab12(X) :- area(X,N0), N0>38980.0, not ab11(X). 
ab13(X) :- majoraxislength(X,N2), N2>276.634, N2=<289.858, minoraxislength(X,N3), N3=<180.247, extent(X,N8), N8=<0.764, shapefactor4(X,N15), N15=<0.993, not ab12(X). 
ab14(X) :- majoraxislength(X,N2), N2>279.369, N2=<279.89, solidity(X,N9), N9>0.986. 
ab15(X) :- majoraxislength(X,N2), N2>283.072, shapefactor2(X,N13), N13>0.002. 
ab16(X) :- aspectration(X,N4), N4>1.783. 
ab17(X) :- area(X,N0), N0>40102.0, extent(X,N8), N8=<0.742. 
ab18(X) :- extent(X,N8), N8>0.74, N8=<0.742. 
ab19(X) :- majoraxislength(X,N2), N2>281.079, extent(X,N8), N8>0.697, N8=<0.701. 
ab20(X) :- majoraxislength(X,N2), N2>274.961, minoraxislength(X,N3), N3>185.666. 
ab21(X) :- perimeter(X,N1), N1>704.877, convexarea(X,N6), N6>37545.0, roundness(X,N10), N10=<0.903, shapefactor4(X,N15), N15=<0.997, not ab8(X), not ab10(X), not ab13(X), not ab14(X), not ab15(X), not ab16(X), not ab17(X), not ab18(X), not ab19(X), not ab20(X). 
ab22(X) :- area(X,N0), N0=<30008.0. 
ab23(X) :- shapefactor4(X,N15), N15=<0.996, not ab22(X). 
ab24(X) :- area(X,N0), N0>28395.0, minoraxislength(X,N3), N3=<174.14. 
ab25(X) :- minoraxislength(X,N3), N3>173.86, compactness(X,N11), N11>0.884, not ab23(X), not ab24(X). 
ab26(X) :- majoraxislength(X,N2), N2=<285.891, aspectration(X,N4), N4=<1.882, shapefactor1(X,N12), N12>0.006. 
ab27(X) :- roundness(X,N10), N10=<0.835, not ab26(X). 
ab28(X) :- perimeter(X,N1), N1=<898.251, majoraxislength(X,N2), N2>326.176, minoraxislength(X,N3), N3>211.999, shapefactor4(X,N15), N15=<0.997. 
ab29(X) :- area(X,N0), N0>55563.0. 
ab30(X) :- area(X,N0), N0=<49639.0. 
ab31(X) :- roundness(X,N10), N10>0.893, N10=<0.915, not ab29(X), not ab30(X). 
ab32(X) :- minoraxislength(X,N3), N3>210.971, not ab28(X), not ab31(X). 
ab33(X) :- convexarea(X,N6), N6=<42673.0, roundness(X,N10), N10>0.935. 
ab34(X) :- aspectration(X,N4), N4>1.506. 
ab35(X) :- extent(X,N8), N8=<0.703. 
ab36(X) :- majoraxislength(X,N2), N2>273.853, roundness(X,N10), N10>0.918, not ab34(X), not ab35(X). 
ab37(X) :- convexarea(X,N6), N6=<42673.0, extent(X,N8), N8=<0.763, solidity(X,N9), N9>0.99, roundness(X,N10), N10>0.907, not ab36(X). 
ab38(X) :- perimeter(X,N1), N1=<767.737, majoraxislength(X,N2), N2>299.53, convexarea(X,N6), N6=<42673.0. 
ab39(X) :- majoraxislength(X,N2), N2>289.854, convexarea(X,N6), N6=<42673.0, roundness(X,N10), N10>0.9. 
ab40(X) :- area(X,N0), N0>42088.0, convexarea(X,N6), N6=<42673.0, roundness(X,N10), N10>0.907, shapefactor1(X,N12), N12>0.007. 
ab41(X) :- area(X,N0), N0=<42042.0, majoraxislength(X,N2), N2>286.931, roundness(X,N10), N10>0.908. 
ab42(X) :- area(X,N0), N0=<42042.0, roundness(X,N10), N10>0.911, N10=<0.911. 
ab43(X) :- area(X,N0), N0=<42042.0, convexarea(X,N6), N6>41162.0, N6=<41429.0, roundness(X,N10), N10>0.917. 
ab44(X) :- area(X,N0), N0=<42042.0, majoraxislength(X,N2), N2>292.086, convexarea(X,N6), N6>42526.0, shapefactor4(X,N15), N15>0.992. 
ab45(X) :- perimeter(X,N1), N1>783.797. 
ab46(X) :- majoraxislength(X,N2), N2>303.69, convexarea(X,N6), N6=<42477.0, solidity(X,N9), N9=<0.988, not ab45(X). 
ab47(X) :- aspectration(X,N4), N4>1.39, convexarea(X,N6), N6=<42477.0, solidity(X,N9), N9=<0.988, compactness(X,N11), N11>0.838. 
ab48(X) :- convexarea(X,N6), N6=<42477.0, solidity(X,N9), N9>0.988, N9=<0.988. 
ab49(X) :- majoraxislength(X,N2), N2>300.588. 
ab50(X) :- minoraxislength(X,N3), N3>201.87, aspectration(X,N4), N4>1.403, not ab49(X). 
ab51(X) :- area(X,N0), N0=<45937.0, compactness(X,N11), N11>0.845. 
ab52(X) :- minoraxislength(X,N3), N3>200.204, roundness(X,N10), N10>0.917, not ab50(X), not ab51(X). 
ab53(X) :- area(X,N0), N0=<40306.0, solidity(X,N9), N9>0.99. 
ab54(X) :- perimeter(X,N1), N1=<742.484, majoraxislength(X,N2), N2>271.181, convexarea(X,N6), N6=<42477.0, solidity(X,N9), N9>0.988, not ab53(X). 
ab55(X) :- aspectration(X,N4), N4>1.882. 
ab56(X) :- area(X,N0), N0>41941.0. 
ab57(X) :- perimeter(X,N1), N1=<770.196, majoraxislength(X,N2), N2>292.369, convexarea(X,N6), N6=<42477.0, extent(X,N8), N8=<0.782, solidity(X,N9), N9>0.988, not ab56(X). 
ab58(X) :- perimeter(X,N1), N1=<724.827, convexarea(X,N6), N6=<42477.0, roundness(X,N10), N10>0.9. 
ab59(X) :- convexarea(X,N6), N6=<42477.0, roundness(X,N10), N10>0.9, N10=<0.9. 
ab60(X) :- solidity(X,N9), N9=<0.988, shapefactor1(X,N12), N12=<0.006, shapefactor4(X,N15), N15>0.998. 
ab61(X) :- minoraxislength(X,N3), N3=<191.188. 
ab62(X) :- aspectration(X,N4), N4>1.327, shapefactor4(X,N15), N15=<0.996. 
ab63(X) :- area(X,N0), N0>41130.0, shapefactor4(X,N15), N15>0.995, not ab61(X), not ab62(X). 
ab64(X) :- extent(X,N8), N8=<0.701. 
ab65(X) :- compactness(X,N11), N11=<0.862, shapefactor2(X,N13), N13>0.002, not ab64(X). 
ab66(X) :- compactness(X,N11), N11=<0.87, shapefactor4(X,N15), N15=<0.997, not ab63(X), not ab65(X). 
ab67(X) :- convexarea(X,N6), N6>57737.0, shapefactor2(X,N13), N13=<0.002. 
ab68(X) :- majoraxislength(X,N2), N2>275.638, roundness(X,N10), N10>0.916. 
ab69(X) :- aspectration(X,N4), N4>1.421, compactness(X,N11), N11=<0.877, shapefactor1(X,N12), N12>0.006, not ab68(X). 
ab70(X) :- perimeter(X,N1), N1=<759.66, aspectration(X,N4), N4>1.283, solidity(X,N9), N9=<0.991, compactness(X,N11), N11=<0.873, shapefactor1(X,N12), N12>0.006, shapefactor4(X,N15), N15>0.998, N15=<0.998. 
ab71(X) :- area(X,N0), N0>37521.0, N0=<37735.0. 
ab72(X) :- minoraxislength(X,N3), N3>190.707, aspectration(X,N4), N4>1.283, shapefactor1(X,N12), N12>0.007, shapefactor4(X,N15), N15=<0.998, not ab71(X). 
ab73(X) :- minoraxislength(X,N3), N3>195.382, N3=<195.449, aspectration(X,N4), N4>1.283, solidity(X,N9), N9>0.991. 
ab74(X) :- minoraxislength(X,N3), N3=<192.612, aspectration(X,N4), N4>1.283, solidity(X,N9), N9>0.992, shapefactor1(X,N12), N12=<0.007. 
ab75(X) :- area(X,N0), N0>36373.0, perimeter(X,N1), N1=<693.373, aspectration(X,N4), N4>1.283, solidity(X,N9), N9>0.991. 
ab76(X) :- area(X,N0), N0>72214.0, shapefactor1(X,N12), N12>0.006. 
ab77(X) :- extent(X,N8), N8=<0.657, shapefactor2(X,N13), N13>0.001. 
ab78(X) :- minoraxislength(X,N3), N3>213.525, convexarea(X,N6), N6=<69119.0. 
ab79(X) :- area(X,N0), N0=<72197.0, extent(X,N8), N8>0.815. 
ab80(X) :- minoraxislength(X,N3), N3>210.941, not ab76(X), not ab77(X), not ab78(X), not ab79(X). 
ab81(X) :- perimeter(X,N1), N1=<920.481, roundness(X,N10), N10>0.829, compactness(X,N11), N11>0.704, shapefactor1(X,N12), N12=<0.007. 
ab82(X) :- area(X,N0), N0=<59431.0, perimeter(X,N1), N1=<965.459, convexarea(X,N6), N6>59975.0, compactness(X,N11), N11>0.704. 
ab83(X) :- minoraxislength(X,N3), N3=<207.224, aspectration(X,N4), N4>1.95, solidity(X,N9), N9=<0.988, compactness(X,N11), N11>0.707, shapefactor2(X,N13), N13=<0.001. 
ab84(X) :- aspectration(X,N4), N4>1.983, compactness(X,N11), N11>0.709. 
ab85(X) :- area(X,N0), N0>61484.0. 
ab86(X) :- area(X,N0), N0>58533.0, extent(X,N8), N8>0.793, compactness(X,N11), N11>0.718, not ab85(X). 
ab87(X) :- area(X,N0), N0>43136.0, shapefactor2(X,N13), N13>0.001. 
ab88(X) :- area(X,N0), N0>116272.0. 
ab89(X) :- shapefactor4(X,N15), N15=<0.975. 
ab90(X) :- aspectration(X,N4), N4>1.782, shapefactor2(X,N13), N13>0.001. 
ab91(X) :- perimeter(X,N1), N1=<935.784, extent(X,N8), N8=<0.736. 
ab92(X) :- convexarea(X,N6), N6>56187.0, extent(X,N8), N8>0.703, shapefactor4(X,N15), N15=<0.993, not ab89(X), not ab90(X), not ab91(X). 
ab93(X) :- area(X,N0), N0=<60993.0, not ab92(X). 
ab94(X) :- area(X,N0), N0=<58877.0. 
ab95(X) :- majoraxislength(X,N2), N2=<381.652, not ab94(X). 
ab96(X) :- roundness(X,N10), N10>0.78, compactness(X,N11), N11=<0.751, not ab95(X). 
ab97(X) :- minoraxislength(X,N3), N3>221.036, compactness(X,N11), N11=<0.745, shapefactor4(X,N15), N15=<0.991. 
ab98(X) :- aspectration(X,N4), N4>1.827, N4=<1.843. 
ab99(X) :- roundness(X,N10), N10=<0.801, not ab96(X), not ab97(X), not ab98(X). 
ab100(X) :- aspectration(X,N4), N4>1.748, extent(X,N8), N8=<0.743. 
ab101(X) :- solidity(X,N9), N9=<0.988, shapefactor4(X,N15), N15>0.995, not ab100(X). 
ab102(X) :- shapefactor2(X,N13), N13=<0.001. 
ab103(X) :- solidity(X,N9), N9>0.989, N9=<0.99. 
ab104(X) :- perimeter(X,N1), N1>965.459, solidity(X,N9), N9=<0.99, shapefactor4(X,N15), N15>0.996, not ab102(X), not ab103(X). 
ab105(X) :- area(X,N0), N0=<42135.0, shapefactor4(X,N15), N15=<0.997. 
ab106(X) :- area(X,N0), N0>58322.0. 
ab107(X) :- area(X,N0), N0>50486.0, extent(X,N8), N8>0.789. 
ab108(X) :- roundness(X,N10), N10=<0.789, shapefactor4(X,N15), N15>0.993, not ab105(X), not ab106(X), not ab107(X). 
ab109(X) :- solidity(X,N9), N9>0.99. 
ab110(X) :- area(X,N0), N0=<56627.0, perimeter(X,N1), N1>919.308. 
ab111(X) :- shapefactor1(X,N12), N12=<0.006, shapefactor4(X,N15), N15>0.997, not ab109(X), not ab110(X). 
ab112(X) :- area(X,N0), N0=<42012.0. 
ab113(X) :- roundness(X,N10), N10=<0.807, not ab112(X). 
ab114(X) :- perimeter(X,N1), N1>789.111, minoraxislength(X,N3), N3>190.868, aspectration(X,N4), N4=<1.666, solidity(X,N9), N9=<0.988, not ab113(X). 
ab115(X) :- area(X,N0), N0>56329.0, perimeter(X,N1), N1>986.967. 
ab116(X) :- extent(X,N8), N8>0.733, N8=<0.734. 
ab117(X) :- shapefactor4(X,N15), N15>0.998, N15=<0.998. 
ab118(X) :- shapefactor1(X,N12), N12>0.006, not ab108(X), not ab111(X), not ab114(X), not ab115(X), not ab116(X), not ab117(X). 
ab119(X) :- roundness(X,N10), N10>0.893. 
ab120(X) :- aspectration(X,N4), N4>1.473, solidity(X,N9), N9=<0.987. 
ab121(X) :- shapefactor2(X,N13), N13>0.001, shapefactor4(X,N15), N15>0.992, not ab119(X), not ab120(X). 
ab122(X) :- area(X,N0), N0>76416.0. 
ab123(X) :- area(X,N0), N0>75754.0, not ab122(X). 
ab124(X) :- area(X,N0), N0=<76729.0, solidity(X,N9), N9>0.987, shapefactor1(X,N12), N12=<0.005, not ab123(X). 
ab125(X) :- roundness(X,N10), N10>0.857, shapefactor4(X,N15), N15=<0.995, not ab121(X), not ab124(X). 
ab126(X) :- shapefactor4(X,N15), N15=<0.996. 
ab127(X) :- extent(X,N8), N8>0.798, solidity(X,N9), N9=<0.992, not ab126(X). 
ab128(X) :- solidity(X,N9), N9>0.991, N9=<0.991. 
ab129(X) :- shapefactor4(X,N15), N15=<0.993. 
ab130(X) :- solidity(X,N9), N9>0.99, not ab127(X), not ab128(X), not ab129(X). 
ab131(X) :- aspectration(X,N4), N4>1.503, roundness(X,N10), N10>0.843, shapefactor4(X,N15), N15=<0.992. 
ab132(X) :- roundness(X,N10), N10=<0.825. 
ab133(X) :- area(X,N0), N0=<49564.0, not ab132(X). 
ab134(X) :- shapefactor4(X,N15), N15>0.995, not ab133(X). 
ab135(X) :- roundness(X,N10), N10>0.821, N10=<0.855, shapefactor4(X,N15), N15>0.993, not ab134(X). 
ab136(X) :- roundness(X,N10), N10=<0.794. 
ab137(X) :- compactness(X,N11), N11>0.743, shapefactor4(X,N15), N15>0.988, not ab135(X), not ab136(X). 
ab138(X) :- aspectration(X,N4), N4>1.88. 
ab139(X) :- shapefactor4(X,N15), N15=<0.992. 
ab140(X) :- majoraxislength(X,N2), N2>263.893, shapefactor2(X,N13), N13>0.002. 
ab141(X) :- majoraxislength(X,N2), N2=<268.446, aspectration(X,N4), N4>1.32, shapefactor1(X,N12), N12=<0.007, not ab140(X). 
ab142(X) :- minoraxislength(X,N3), N3=<173.108, extent(X,N8), N8=<0.757. 
ab143(X) :- solidity(X,N9), N9>0.991, N9=<0.991. 
ab144(X) :- extent(X,N8), N8>0.708, N8=<0.708. 
ab145(X) :- minoraxislength(X,N3), N3=<194.565. 
ab146(X) :- perimeter(X,N1), N1>906.71. 
ab147(X) :- area(X,N0), N0>57617.0, not ab146(X).