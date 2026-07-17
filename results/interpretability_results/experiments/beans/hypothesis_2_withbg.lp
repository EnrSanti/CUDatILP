class(X,'dermason') :- area(X,N0), N0=<42159.0, not ab33(X), not ab41(X), not ab51(X), not ab52(X). 
class(X,'sira') :- majoraxislength(X,N2), N2=<343.84, sf1_sf3_ratio(X,N18), N18>0.009, not ab67(X), not ab73(X), not ab75(X), not ab76(X), not ab77(X), not ab78(X). 
class(X,'seker') :- shapefactor2(X,N13), N13>0.002, not ab86(X), not ab88(X), not ab95(X), not ab96(X). 
class(X,'horoz') :- sf1_sf3_ratio(X,N18), N18>0.011, not ab98(X), not ab101(X), not ab103(X), not ab111(X), not ab112(X), not ab113(X), not ab114(X), not ab115(X), not ab116(X). 
class(X,'cali') :- roundness_compact_gap(X,N17), N17>0.054, not ab117(X), not ab132(X), not ab140(X), not ab147(X), not ab148(X), not ab149(X), not ab150(X), not ab151(X). 
class(X,'barbunya') :- area(X,N0), N0=<115967.0, not ab157(X), not ab162(X), not ab163(X), not ab167(X), not ab168(X), not ab171(X), not ab173(X), not ab174(X). 
class(X,'bombay') :- area(X,N0), N0>94904.0. 
class(X,'sira') :- perimeter_per_axis(X,N21), N21=<1.648, not ab177(X), not ab179(X), not ab181(X). 
class(X,'cali') :- shapefactor1(X,N12), N12=<0.006, not ab182(X), not ab183(X), not ab184(X), not ab185(X). 
class(X,'horoz') :- majoraxislength(X,N2), N2>323.547, not ab186(X). 
class(X,'dermason') :- area(X,N0), N0=<41292.0. 
class(X,'seker') :- majoraxislength(X,N2), N2>278.307, not ab187(X). 
class(X,'dermason') :- ecc_roundness_gap(X,N20), N20=<-0.214. 
class(X,'sira') :- extent(X,N8), N8=<0.771. 
class(X,'cali') :- area(X,N0), N0>41486.0. 
class(X,'horoz') :- area(X,N0), N0=<41486.0. 
ab1(X) :- area(X,N0), N0=<39528.0. 
ab2(X) :- extent(X,N8), N8>0.791, not ab1(X). 
ab3(X) :- minoraxislength(X,N3), N3=<185.349. 
ab4(X) :- area(X,N0), N0>39529.0, not ab3(X). 
ab5(X) :- convexarea(X,N6), N6>39885.0, extent(X,N8), N8=<0.776, roundness(X,N10), N10=<0.911, not ab4(X). 
ab6(X) :- perimeter(X,N1), N1=<737.773, roundness_compact_gap(X,N17), N17=<0.056. 
ab7(X) :- convexarea(X,N6), N6>39580.0, roundness_compact_gap(X,N17), N17=<0.083, not ab2(X), not ab5(X), not ab6(X). 
ab8(X) :- majoraxislength(X,N2), N2>260.863. 
ab9(X) :- area(X,N0), N0=<37963.0, not ab8(X). 
ab10(X) :- area(X,N0), N0=<38760.0, extent(X,N8), N8=<0.735, roundness(X,N10), N10=<0.902, not ab9(X). 
ab11(X) :- extent(X,N8), N8=<0.734, solidity(X,N9), N9>0.989, shapefactor1(X,N12), N12=<0.007, roundness_compact_gap(X,N17), N17>0.09, N17=<0.092. 
ab12(X) :- extent(X,N8), N8=<0.734, solidity(X,N9), N9>0.989, roundness_compact_gap(X,N17), N17=<0.087, perimeter_per_axis(X,N21), N21>1.619. 
ab13(X) :- area(X,N0), N0=<35799.0. 
ab14(X) :- area(X,N0), N0=<39058.0, extent(X,N8), N8=<0.734, shapefactor4(X,N15), N15>0.999, not ab13(X). 
ab15(X) :- perimeter(X,N1), N1>745.439. 
ab16(X) :- area(X,N0), N0=<36534.0. 
ab17(X) :- extent(X,N8), N8>0.734, shapefactor4(X,N15), N15=<0.996, perimeter_per_axis(X,N21), N21>1.61, not ab15(X), not ab16(X). 
ab18(X) :- majoraxislength(X,N2), N2>258.077, N2=<258.216, extent(X,N8), N8=<0.734. 
ab19(X) :- perimeter(X,N1), N1=<746.911, sf1_sf3_ratio(X,N18), N18>0.009, not ab7(X), not ab10(X), not ab11(X), not ab12(X), not ab14(X), not ab17(X), not ab18(X). 
ab20(X) :- perimeter(X,N1), N1=<750.704. 
ab21(X) :- area(X,N0), N0>41774.0, not ab20(X). 
ab22(X) :- roundness_compact_gap(X,N17), N17>0.092, N17=<0.103, not ab21(X). 
ab23(X) :- perimeter(X,N1), N1>750.179, shapefactor4(X,N15), N15=<0.998, not ab22(X). 
ab24(X) :- majoraxislength(X,N2), N2>280.157. 
ab25(X) :- area(X,N0), N0>41139.0, convexarea(X,N6), N6=<41590.0, not ab24(X). 
ab26(X) :- sf1_sf3_ratio(X,N18), N18=<0.01, not ab23(X), not ab25(X). 
ab27(X) :- perimeter(X,N1), N1>761.164, shapefactor4(X,N15), N15>0.998. 
ab28(X) :- area(X,N0), N0=<40900.0, solidity(X,N9), N9>0.991. 
ab29(X) :- area(X,N0), N0>41443.0, roundness_compact_gap(X,N17), N17>0.117. 
ab30(X) :- perimeter(X,N1), N1>747.07, shapefactor4(X,N15), N15>0.997, sf1_sf3_ratio(X,N18), N18>0.009, perimeter_per_axis(X,N21), N21=<1.611, not ab26(X), not ab27(X), not ab28(X), not ab29(X). 
ab31(X) :- perimeter(X,N1), N1>747.07, convexarea(X,N6), N6>41706.0, N6=<41755.0, sf1_sf3_ratio(X,N18), N18>0.008, extent_solidity_prod(X,N19), N19>0.781. 
ab32(X) :- area(X,N0), N0>41486.0, perimeter(X,N1), N1>747.07, majoraxislength(X,N2), N2=<288.083, solidity(X,N9), N9>0.989, sf1_sf3_ratio(X,N18), N18>0.008, extent_solidity_prod(X,N19), N19>0.781, perimeter_per_axis(X,N21), N21>1.622. 
ab33(X) :- minoraxislength(X,N3), N3>180.769, not ab19(X), not ab30(X), not ab31(X), not ab32(X). 
ab34(X) :- roundness_compact_gap(X,N17), N17>0.12. 
ab35(X) :- area(X,N0), N0>41759.0. 
ab36(X) :- perimeter(X,N1), N1>772.243, not ab35(X). 
ab37(X) :- aspectration(X,N4), N4=<1.742, not ab34(X), not ab36(X). 
ab38(X) :- roundness(X,N10), N10>0.865, not ab37(X). 
ab39(X) :- majoraxislength(X,N2), N2=<298.088, solidity(X,N9), N9>0.988. 
ab40(X) :- area(X,N0), N0=<35808.0, perimeter(X,N1), N1=<739.41, shapefactor4(X,N15), N15>0.992. 
ab41(X) :- perimeter(X,N1), N1>702.212, shapefactor2(X,N13), N13=<0.002, not ab38(X), not ab39(X), not ab40(X). 
ab42(X) :- aspectration(X,N4), N4=<1.672, extent(X,N8), N8>0.782. 
ab43(X) :- extent(X,N8), N8>0.747. 
ab44(X) :- ecc_roundness_gap(X,N20), N20>-0.098, not ab43(X). 
ab45(X) :- roundness(X,N10), N10=<0.888, not ab44(X). 
ab46(X) :- area(X,N0), N0=<39900.0, shapefactor4(X,N15), N15=<0.996, not ab45(X). 
ab47(X) :- roundness(X,N10), N10>0.891. 
ab48(X) :- perimeter_per_axis(X,N21), N21=<1.621, not ab42(X), not ab46(X), not ab47(X). 
ab49(X) :- extent(X,N8), N8>0.781. 
ab50(X) :- compactness(X,N11), N11>0.798, sf1_sf3_ratio(X,N18), N18>0.011, not ab49(X). 
ab51(X) :- perimeter(X,N1), N1>686.809, minoraxislength(X,N3), N3>169.135, N3=<180.726, roundness(X,N10), N10=<0.892, roundness_compact_gap(X,N17), N17>0.061, not ab48(X), not ab50(X). 
ab52(X) :- area(X,N0), N0>33167.0, extent(X,N8), N8=<0.73, shapefactor4(X,N15), N15=<0.987, perimeter_per_axis(X,N21), N21>1.619. 
ab53(X) :- extent(X,N8), N8>0.795. 
ab54(X) :- extent(X,N8), N8=<0.727. 
ab55(X) :- solidity(X,N9), N9=<0.963. 
ab56(X) :- shapefactor1(X,N12), N12>0.007, not ab53(X), not ab54(X), not ab55(X). 
ab57(X) :- shapefactor4(X,N15), N15>0.997. 
ab58(X) :- majoraxislength(X,N2), N2=<324.631, convexarea(X,N6), N6>44699.0, not ab57(X). 
ab59(X) :- extent_solidity_prod(X,N19), N19>0.715, not ab56(X), not ab58(X). 
ab60(X) :- shapefactor2(X,N13), N13=<0.001, shapefactor4(X,N15), N15=<0.988. 
ab61(X) :- roundness(X,N10), N10>0.826, N10=<0.826. 
ab62(X) :- area(X,N0), N0>49316.0, N0=<49564.0. 
ab63(X) :- aspectration(X,N4), N4=<1.882, shapefactor1(X,N12), N12>0.006, sf1_sf3_ratio(X,N18), N18=<0.014, ecc_roundness_gap(X,N20), N20=<0.017, not ab59(X), not ab60(X), not ab61(X), not ab62(X). 
ab64(X) :- solidity(X,N9), N9>0.98, roundness(X,N10), N10=<0.737. 
ab65(X) :- solidity(X,N9), N9=<0.98, roundness(X,N10), N10>0.711, extent_solidity_prod(X,N19), N19>0.774. 
ab66(X) :- majoraxislength(X,N2), N2>340.648, N2=<340.66. 
ab67(X) :- roundness(X,N10), N10=<0.838, not ab63(X), not ab64(X), not ab65(X), not ab66(X). 
ab68(X) :- extent(X,N8), N8>0.793. 
ab69(X) :- solidity(X,N9), N9=<0.987, compactness(X,N11), N11=<0.853. 
ab70(X) :- roundness(X,N10), N10>0.925. 
ab71(X) :- majoraxislength(X,N2), N2>274.301, not ab70(X). 
ab72(X) :- extent(X,N8), N8>0.774, N8=<0.775. 
ab73(X) :- perimeter(X,N1), N1=<766.264, sf1_sf3_ratio(X,N18), N18=<0.009, not ab68(X), not ab69(X), not ab71(X), not ab72(X). 
ab74(X) :- area(X,N0), N0>41155.0. 
ab75(X) :- aspectration(X,N4), N4>1.801, convexarea(X,N6), N6=<42673.0, not ab74(X). 
ab76(X) :- perimeter(X,N1), N1=<766.264, shapefactor1(X,N12), N12>0.008, extent_solidity_prod(X,N19), N19>0.783. 
ab77(X) :- perimeter(X,N1), N1=<766.264, minoraxislength(X,N3), N3>187.219, solidity(X,N9), N9>0.991, extent_solidity_prod(X,N19), N19>0.783. 
ab78(X) :- area(X,N0), N0=<34790.0, perimeter(X,N1), N1=<766.264, extent_solidity_prod(X,N19), N19>0.783. 
ab79(X) :- roundness_compact_gap(X,N17), N17=<-0.069. 
ab80(X) :- solidity(X,N9), N9>0.991. 
ab81(X) :- extent(X,N8), N8=<0.729. 
ab82(X) :- area(X,N0), N0>38559.0, extent_solidity_prod(X,N19), N19=<0.766, not ab81(X). 
ab83(X) :- perimeter(X,N1), N1>719.654, ecc_roundness_gap(X,N20), N20=<-0.272, not ab82(X). 
ab84(X) :- aspectration(X,N4), N4>1.338, sf1_sf3_ratio(X,N18), N18>0.009, ecc_roundness_gap(X,N20), N20=<-0.226. 
ab85(X) :- roundness(X,N10), N10=<0.79. 
ab86(X) :- shapefactor4(X,N15), N15=<0.997, ecc_roundness_gap(X,N20), N20>-0.311, not ab79(X), not ab80(X), not ab83(X), not ab84(X), not ab85(X). 
ab87(X) :- area(X,N0), N0>52341.0, aspectration(X,N4), N4=<1.282. 
ab88(X) :- minoraxislength(X,N3), N3>224.165, shapefactor2(X,N13), N13=<0.002, ecc_roundness_gap(X,N20), N20>-0.247, not ab87(X). 
ab89(X) :- shapefactor4(X,N15), N15=<0.997. 
ab90(X) :- extent(X,N8), N8>0.75. 
ab91(X) :- aspectration(X,N4), N4>1.417. 
ab92(X) :- area(X,N0), N0>47029.0, not ab90(X), not ab91(X). 
ab93(X) :- aspectration(X,N4), N4=<1.384. 
ab94(X) :- perimeter(X,N1), N1>757.238, shapefactor2(X,N13), N13>0.002, not ab93(X). 
ab95(X) :- aspectration(X,N4), N4>1.381, shapefactor4(X,N15), N15=<0.998, ecc_roundness_gap(X,N20), N20>-0.326, not ab89(X), not ab92(X), not ab94(X). 
ab96(X) :- sf1_sf3_ratio(X,N18), N18=<0.006, ecc_roundness_gap(X,N20), N20>-0.33. 
ab97(X) :- extent(X,N8), N8>0.804. 
ab98(X) :- extent(X,N8), N8>0.709, shapefactor2(X,N13), N13=<0.001, sf1_sf3_ratio(X,N18), N18=<0.012, not ab97(X). 
ab99(X) :- aspectration(X,N4), N4>1.79, roundness(X,N10), N10>0.847. 
ab100(X) :- shapefactor2(X,N13), N13=<0.001. 
ab101(X) :- roundness(X,N10), N10>0.842, sf1_sf3_ratio(X,N18), N18=<0.013, not ab99(X), not ab100(X). 
ab102(X) :- extent(X,N8), N8=<0.64. 
ab103(X) :- aspectration(X,N4), N4>1.884, compactness(X,N11), N11>0.724, sf1_sf3_ratio(X,N18), N18=<0.013, not ab102(X). 
ab104(X) :- majoraxislength(X,N2), N2>395.717, roundness_compact_gap(X,N17), N17=<0.082. 
ab105(X) :- area(X,N0), N0=<47883.0. 
ab106(X) :- roundness_compact_gap(X,N17), N17=<0.036, not ab105(X). 
ab107(X) :- extent(X,N8), N8=<0.734. 
ab108(X) :- aspectration(X,N4), N4=<1.793, not ab107(X). 
ab109(X) :- shapefactor4(X,N15), N15>0.99, not ab108(X). 
ab110(X) :- area(X,N0), N0=<59105.0, sf1_sf3_ratio(X,N18), N18=<0.012, not ab109(X). 
ab111(X) :- extent(X,N8), N8>0.711, N8=<0.799, roundness_compact_gap(X,N17), N17=<0.093, sf1_sf3_ratio(X,N18), N18=<0.012, not ab104(X), not ab106(X), not ab110(X). 
ab112(X) :- majoraxislength(X,N2), N2=<299.047, sf1_sf3_ratio(X,N18), N18=<0.013. 
ab113(X) :- shapefactor4(X,N15), N15>0.998, sf1_sf3_ratio(X,N18), N18=<0.013. 
ab114(X) :- sf1_sf3_ratio(X,N18), N18>0.013, N18=<0.013. 
ab115(X) :- sf1_sf3_ratio(X,N18), N18>0.013, N18=<0.013. 
ab116(X) :- sf1_sf3_ratio(X,N18), N18>0.013, N18=<0.013. 
ab117(X) :- area(X,N0), N0>116272.0. 
ab118(X) :- extent(X,N8), N8>0.819. 
ab119(X) :- perimeter(X,N1), N1>921.449, aspectration(X,N4), N4>1.626. 
ab120(X) :- aspectration(X,N4), N4>1.727. 
ab121(X) :- extent(X,N8), N8=<0.705, not ab119(X), not ab120(X). 
ab122(X) :- solidity(X,N9), N9=<0.984, shapefactor4(X,N15), N15>0.993. 
ab123(X) :- perimeter_per_axis(X,N21), N21>1.659. 
ab124(X) :- area(X,N0), N0>64456.0, solidity(X,N9), N9>0.989. 
ab125(X) :- minoraxislength(X,N3), N3=<204.891. 
ab126(X) :- area(X,N0), N0>55549.0, perimeter(X,N1), N1=<918.039, roundness(X,N10), N10=<0.878, not ab125(X). 
ab127(X) :- perimeter(X,N1), N1=<951.177, shapefactor1(X,N12), N12=<0.006, extent_solidity_prod(X,N19), N19>0.772. 
ab128(X) :- perimeter(X,N1), N1>897.669, shapefactor4(X,N15), N15=<0.997, not ab118(X), not ab121(X), not ab122(X), not ab123(X), not ab124(X), not ab126(X), not ab127(X). 
ab129(X) :- majoraxislength(X,N2), N2>352.103, shapefactor4(X,N15), N15>0.997, ecc_roundness_gap(X,N20), N20=<-0.124. 
ab130(X) :- area(X,N0), N0=<50961.0. 
ab131(X) :- majoraxislength(X,N2), N2=<357.697, aspectration(X,N4), N4>1.79, not ab130(X). 
ab132(X) :- majoraxislength(X,N2), N2=<360.623, not ab128(X), not ab129(X), not ab131(X). 
ab133(X) :- roundness_compact_gap(X,N17), N17>0.103. 
ab134(X) :- perimeter(X,N1), N1>1088.437. 
ab135(X) :- shapefactor4(X,N15), N15>0.996, not ab134(X). 
ab136(X) :- roundness_compact_gap(X,N17), N17>0.079, not ab133(X), not ab135(X). 
ab137(X) :- perimeter(X,N1), N1=<956.785. 
ab138(X) :- sf1_sf3_ratio(X,N18), N18>0.011, not ab137(X). 
ab139(X) :- perimeter(X,N1), N1>984.886, N1=<989.467. 
ab140(X) :- solidity(X,N9), N9=<0.988, shapefactor4(X,N15), N15>0.995, not ab136(X), not ab138(X), not ab139(X). 
ab141(X) :- area(X,N0), N0=<54646.0. 
ab142(X) :- perimeter(X,N1), N1=<965.459, not ab141(X). 
ab143(X) :- roundness_compact_gap(X,N17), N17>0.082, N17=<0.084, perimeter_per_axis(X,N21), N21>1.638. 
ab144(X) :- area(X,N0), N0>69623.0, solidity(X,N9), N9=<0.989. 
ab145(X) :- area(X,N0), N0=<63317.0. 
ab146(X) :- extent(X,N8), N8=<0.775, roundness_compact_gap(X,N17), N17=<0.076, not ab144(X), not ab145(X). 
ab147(X) :- solidity(X,N9), N9=<0.99, shapefactor4(X,N15), N15>0.996, not ab142(X), not ab143(X), not ab146(X). 
ab148(X) :- majoraxislength(X,N2), N2=<399.933, extent(X,N8), N8=<0.67, sf1_sf3_ratio(X,N18), N18>0.011. 
ab149(X) :- majoraxislength(X,N2), N2=<399.933, extent(X,N8), N8>0.765, solidity(X,N9), N9>0.985, roundness(X,N10), N10=<0.836, shapefactor4(X,N15), N15=<0.991. 
ab150(X) :- perimeter(X,N1), N1>1030.908, aspectration(X,N4), N4>1.722, shapefactor2(X,N13), N13>0.001, shapefactor4(X,N15), N15>0.992. 
ab151(X) :- majoraxislength(X,N2), N2=<397.617, shapefactor4(X,N15), N15=<0.991, roundness_compact_gap(X,N17), N17>0.062, N17=<0.063. 
ab152(X) :- shapefactor1(X,N12), N12>0.006. 
ab153(X) :- area(X,N0), N0>58074.0, not ab152(X). 
ab154(X) :- perimeter(X,N1), N1>909.091. 
ab155(X) :- majoraxislength(X,N2), N2>307.996, shapefactor1(X,N12), N12=<0.006, perimeter_per_axis(X,N21), N21>1.629, not ab154(X). 
ab156(X) :- area(X,N0), N0=<51693.0, shapefactor4(X,N15), N15>0.997, sf1_sf3_ratio(X,N18), N18=<0.008. 
ab157(X) :- perimeter_per_axis(X,N21), N21=<1.64, not ab153(X), not ab155(X), not ab156(X). 
ab158(X) :- area(X,N0), N0=<68859.0, perimeter_per_axis(X,N21), N21>1.685. 
ab159(X) :- shapefactor2(X,N13), N13>0.001, perimeter_per_axis(X,N21), N21>1.673. 
ab160(X) :- solidity(X,N9), N9=<0.977, shapefactor4(X,N15), N15>0.988. 
ab161(X) :- aspectration(X,N4), N4=<1.645, extent(X,N8), N8>0.802. 
ab162(X) :- shapefactor4(X,N15), N15=<0.991, roundness_compact_gap(X,N17), N17>0.014, not ab158(X), not ab159(X), not ab160(X), not ab161(X). 
ab163(X) :- area(X,N0), N0=<41322.0. 
ab164(X) :- shapefactor4(X,N15), N15>0.997. 
ab165(X) :- area(X,N0), N0>67136.0, N0=<67498.0. 
ab166(X) :- area(X,N0), N0=<75731.0, extent(X,N8), N8>0.721, not ab165(X). 
ab167(X) :- solidity(X,N9), N9>0.984, compactness(X,N11), N11=<0.751, not ab164(X), not ab166(X). 
ab168(X) :- area(X,N0), N0>76545.0, N0=<77787.0, shapefactor4(X,N15), N15=<0.996, roundness_compact_gap(X,N17), N17>0.044. 
ab169(X) :- area(X,N0), N0=<59788.0. 
ab170(X) :- solidity(X,N9), N9=<0.989, not ab169(X). 
ab171(X) :- solidity(X,N9), N9>0.988, shapefactor4(X,N15), N15=<0.996, perimeter_per_axis(X,N21), N21>1.646, not ab170(X). 
ab172(X) :- area(X,N0), N0=<49755.0. 
ab173(X) :- area(X,N0), N0=<68377.0, aspectration(X,N4), N4>1.725, shapefactor4(X,N15), N15=<0.994, sf1_sf3_ratio(X,N18), N18>0.01, not ab172(X). 
ab174(X) :- solidity(X,N9), N9>0.989, roundness_compact_gap(X,N17), N17>0.037, perimeter_per_axis(X,N21), N21>1.662. 
ab175(X) :- shapefactor4(X,N15), N15=<0.994. 
ab176(X) :- extent(X,N8), N8=<0.745, sf1_sf3_ratio(X,N18), N18=<0.009. 
ab177(X) :- area(X,N0), N0=<41979.0, not ab175(X), not ab176(X). 
ab178(X) :- majoraxislength(X,N2), N2=<315.945, shapefactor4(X,N15), N15=<0.998. 
ab179(X) :- shapefactor1(X,N12), N12=<0.006, not ab178(X). 
ab180(X) :- perimeter(X,N1), N1>913.737. 
ab181(X) :- shapefactor4(X,N15), N15=<0.99, roundness_compact_gap(X,N17), N17>0.076, not ab180(X). 
ab182(X) :- roundness_compact_gap(X,N17), N17>0.054. 
ab183(X) :- perimeter_per_axis(X,N21), N21>1.668, N21=<1.669. 
ab184(X) :- extent(X,N8), N8=<0.694, roundness_compact_gap(X,N17), N17=<0.034. 
ab185(X) :- area(X,N0), N0=<65538.0, shapefactor4(X,N15), N15=<0.97. 
ab186(X) :- area(X,N0), N0>53370.0, minoraxislength(X,N3), N3=<202.01. 
ab187(X) :- roundness(X,N10), N10=<0.887.