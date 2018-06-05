--------------------------------------------------------------------------------
-- Copyright (C) 1999-2008 Easics NV.
-- This source file may be used and distributed without restriction
-- provided that this copyright statement is not removed from the file
-- and that any derivative work contains the original copyright notice
-- and the associated disclaimer.
--
-- THIS SOURCE FILE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS
-- OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
-- WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
--
-- Purpose : synthesizable CRC function
--   * polynomial: x^32 + x^26 + x^23 + x^22 + x^16 + x^12 + x^11 + x^10 + x^8 + x^7 + x^5 + x^4 + x^2 + x^1 + 1
--   * data width: 184
--
-- Info : tools@easics.be
--        http://www.easics.com
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

package PCK_CRC32_D184 is
  -- polynomial: x^32 + x^26 + x^23 + x^22 + x^16 + x^12 + x^11 + x^10 + x^8 + x^7 + x^5 + x^4 + x^2 + x^1 + 1
  -- data width: 184
  -- convention: the first serial bit is D[183]
  function nextCRC32_D184
    (Data: std_logic_vector(183 downto 0);
     crc:  std_logic_vector(31 downto 0))
    return std_logic_vector;
end PCK_CRC32_D184;


package body PCK_CRC32_D184 is

  -- polynomial: x^32 + x^26 + x^23 + x^22 + x^16 + x^12 + x^11 + x^10 + x^8 + x^7 + x^5 + x^4 + x^2 + x^1 + 1
  -- data width: 184
  -- convention: the first serial bit is D[183]
  function nextCRC32_D184
    (Data: std_logic_vector(183 downto 0);
     crc:  std_logic_vector(31 downto 0))
    return std_logic_vector is

    variable d:      std_logic_vector(183 downto 0);
    variable c:      std_logic_vector(31 downto 0);
    variable newcrc: std_logic_vector(31 downto 0);

  begin
    d := Data;
    c := crc;

    newcrc(0) := d(183) xor d(182) xor d(172) xor d(171) xor d(170) xor d(169) xor d(167) xor d(166) xor d(162) xor d(161) xor d(158) xor d(156) xor d(155) xor d(151) xor d(149) xor d(144) xor d(143) xor d(137) xor d(136) xor d(135) xor d(134) xor d(132) xor d(128) xor d(127) xor d(126) xor d(125) xor d(123) xor d(119) xor d(118) xor d(117) xor d(116) xor d(114) xor d(113) xor d(111) xor d(110) xor d(106) xor d(104) xor d(103) xor d(101) xor d(99) xor d(98) xor d(97) xor d(96) xor d(95) xor d(94) xor d(87) xor d(85) xor d(84) xor d(83) xor d(82) xor d(81) xor d(79) xor d(73) xor d(72) xor d(68) xor d(67) xor d(66) xor d(65) xor d(63) xor d(61) xor d(60) xor d(58) xor d(55) xor d(54) xor d(53) xor d(50) xor d(48) xor d(47) xor d(45) xor d(44) xor d(37) xor d(34) xor d(32) xor d(31) xor d(30) xor d(29) xor d(28) xor d(26) xor d(25) xor d(24) xor d(16) xor d(12) xor d(10) xor d(9) xor d(6) xor d(0) xor c(3) xor c(4) xor c(6) xor c(9) xor c(10) xor c(14) xor c(15) xor c(17) xor c(18) xor c(19) xor c(20) xor c(30) xor c(31);
    newcrc(1) := d(182) xor d(173) xor d(169) xor d(168) xor d(166) xor d(163) xor d(161) xor d(159) xor d(158) xor d(157) xor d(155) xor d(152) xor d(151) xor d(150) xor d(149) xor d(145) xor d(143) xor d(138) xor d(134) xor d(133) xor d(132) xor d(129) xor d(125) xor d(124) xor d(123) xor d(120) xor d(116) xor d(115) xor d(113) xor d(112) xor d(110) xor d(107) xor d(106) xor d(105) xor d(103) xor d(102) xor d(101) xor d(100) xor d(94) xor d(88) xor d(87) xor d(86) xor d(81) xor d(80) xor d(79) xor d(74) xor d(72) xor d(69) xor d(65) xor d(64) xor d(63) xor d(62) xor d(60) xor d(59) xor d(58) xor d(56) xor d(53) xor d(51) xor d(50) xor d(49) xor d(47) xor d(46) xor d(44) xor d(38) xor d(37) xor d(35) xor d(34) xor d(33) xor d(28) xor d(27) xor d(24) xor d(17) xor d(16) xor d(13) xor d(12) xor d(11) xor d(9) xor d(7) xor d(6) xor d(1) xor d(0) xor c(0) xor c(3) xor c(5) xor c(6) xor c(7) xor c(9) xor c(11) xor c(14) xor c(16) xor c(17) xor c(21) xor c(30);
    newcrc(2) := d(182) xor d(174) xor d(172) xor d(171) xor d(166) xor d(164) xor d(161) xor d(160) xor d(159) xor d(155) xor d(153) xor d(152) xor d(150) xor d(149) xor d(146) xor d(143) xor d(139) xor d(137) xor d(136) xor d(133) xor d(132) xor d(130) xor d(128) xor d(127) xor d(124) xor d(123) xor d(121) xor d(119) xor d(118) xor d(110) xor d(108) xor d(107) xor d(102) xor d(99) xor d(98) xor d(97) xor d(96) xor d(94) xor d(89) xor d(88) xor d(85) xor d(84) xor d(83) xor d(80) xor d(79) xor d(75) xor d(72) xor d(70) xor d(68) xor d(67) xor d(64) xor d(59) xor d(58) xor d(57) xor d(55) xor d(53) xor d(52) xor d(51) xor d(44) xor d(39) xor d(38) xor d(37) xor d(36) xor d(35) xor d(32) xor d(31) xor d(30) xor d(26) xor d(24) xor d(18) xor d(17) xor d(16) xor d(14) xor d(13) xor d(9) xor d(8) xor d(7) xor d(6) xor d(2) xor d(1) xor d(0) xor c(0) xor c(1) xor c(3) xor c(7) xor c(8) xor c(9) xor c(12) xor c(14) xor c(19) xor c(20) xor c(22) xor c(30);
    newcrc(3) := d(183) xor d(175) xor d(173) xor d(172) xor d(167) xor d(165) xor d(162) xor d(161) xor d(160) xor d(156) xor d(154) xor d(153) xor d(151) xor d(150) xor d(147) xor d(144) xor d(140) xor d(138) xor d(137) xor d(134) xor d(133) xor d(131) xor d(129) xor d(128) xor d(125) xor d(124) xor d(122) xor d(120) xor d(119) xor d(111) xor d(109) xor d(108) xor d(103) xor d(100) xor d(99) xor d(98) xor d(97) xor d(95) xor d(90) xor d(89) xor d(86) xor d(85) xor d(84) xor d(81) xor d(80) xor d(76) xor d(73) xor d(71) xor d(69) xor d(68) xor d(65) xor d(60) xor d(59) xor d(58) xor d(56) xor d(54) xor d(53) xor d(52) xor d(45) xor d(40) xor d(39) xor d(38) xor d(37) xor d(36) xor d(33) xor d(32) xor d(31) xor d(27) xor d(25) xor d(19) xor d(18) xor d(17) xor d(15) xor d(14) xor d(10) xor d(9) xor d(8) xor d(7) xor d(3) xor d(2) xor d(1) xor c(1) xor c(2) xor c(4) xor c(8) xor c(9) xor c(10) xor c(13) xor c(15) xor c(20) xor c(21) xor c(23) xor c(31);
    newcrc(4) := d(183) xor d(182) xor d(176) xor d(174) xor d(173) xor d(172) xor d(171) xor d(170) xor d(169) xor d(168) xor d(167) xor d(163) xor d(158) xor d(157) xor d(156) xor d(154) xor d(152) xor d(149) xor d(148) xor d(145) xor d(144) xor d(143) xor d(141) xor d(139) xor d(138) xor d(137) xor d(136) xor d(130) xor d(129) xor d(128) xor d(127) xor d(121) xor d(120) xor d(119) xor d(118) xor d(117) xor d(116) xor d(114) xor d(113) xor d(112) xor d(111) xor d(109) xor d(106) xor d(103) xor d(100) xor d(97) xor d(95) xor d(94) xor d(91) xor d(90) xor d(86) xor d(84) xor d(83) xor d(79) xor d(77) xor d(74) xor d(73) xor d(70) xor d(69) xor d(68) xor d(67) xor d(65) xor d(63) xor d(59) xor d(58) xor d(57) xor d(50) xor d(48) xor d(47) xor d(46) xor d(45) xor d(44) xor d(41) xor d(40) xor d(39) xor d(38) xor d(33) xor d(31) xor d(30) xor d(29) xor d(25) xor d(24) xor d(20) xor d(19) xor d(18) xor d(15) xor d(12) xor d(11) xor d(8) xor d(6) xor d(4) xor d(3) xor d(2) xor d(0) xor c(0) xor c(2) xor c(4) xor c(5) xor c(6) xor c(11) xor c(15) xor c(16) xor c(17) xor c(18) xor c(19) xor c(20) xor c(21) xor c(22) xor c(24) xor c(30) xor c(31);
    newcrc(5) := d(182) xor d(177) xor d(175) xor d(174) xor d(173) xor d(168) xor d(167) xor d(166) xor d(164) xor d(162) xor d(161) xor d(159) xor d(157) xor d(156) xor d(153) xor d(151) xor d(150) xor d(146) xor d(145) xor d(143) xor d(142) xor d(140) xor d(139) xor d(138) xor d(136) xor d(135) xor d(134) xor d(132) xor d(131) xor d(130) xor d(129) xor d(127) xor d(126) xor d(125) xor d(123) xor d(122) xor d(121) xor d(120) xor d(116) xor d(115) xor d(112) xor d(111) xor d(107) xor d(106) xor d(103) xor d(99) xor d(97) xor d(94) xor d(92) xor d(91) xor d(83) xor d(82) xor d(81) xor d(80) xor d(79) xor d(78) xor d(75) xor d(74) xor d(73) xor d(72) xor d(71) xor d(70) xor d(69) xor d(67) xor d(65) xor d(64) xor d(63) xor d(61) xor d(59) xor d(55) xor d(54) xor d(53) xor d(51) xor d(50) xor d(49) xor d(46) xor d(44) xor d(42) xor d(41) xor d(40) xor d(39) xor d(37) xor d(29) xor d(28) xor d(24) xor d(21) xor d(20) xor d(19) xor d(13) xor d(10) xor d(7) xor d(6) xor d(5) xor d(4) xor d(3) xor d(1) xor d(0) xor c(1) xor c(4) xor c(5) xor c(7) xor c(9) xor c(10) xor c(12) xor c(14) xor c(15) xor c(16) xor c(21) xor c(22) xor c(23) xor c(25) xor c(30);
    newcrc(6) := d(183) xor d(178) xor d(176) xor d(175) xor d(174) xor d(169) xor d(168) xor d(167) xor d(165) xor d(163) xor d(162) xor d(160) xor d(158) xor d(157) xor d(154) xor d(152) xor d(151) xor d(147) xor d(146) xor d(144) xor d(143) xor d(141) xor d(140) xor d(139) xor d(137) xor d(136) xor d(135) xor d(133) xor d(132) xor d(131) xor d(130) xor d(128) xor d(127) xor d(126) xor d(124) xor d(123) xor d(122) xor d(121) xor d(117) xor d(116) xor d(113) xor d(112) xor d(108) xor d(107) xor d(104) xor d(100) xor d(98) xor d(95) xor d(93) xor d(92) xor d(84) xor d(83) xor d(82) xor d(81) xor d(80) xor d(79) xor d(76) xor d(75) xor d(74) xor d(73) xor d(72) xor d(71) xor d(70) xor d(68) xor d(66) xor d(65) xor d(64) xor d(62) xor d(60) xor d(56) xor d(55) xor d(54) xor d(52) xor d(51) xor d(50) xor d(47) xor d(45) xor d(43) xor d(42) xor d(41) xor d(40) xor d(38) xor d(30) xor d(29) xor d(25) xor d(22) xor d(21) xor d(20) xor d(14) xor d(11) xor d(8) xor d(7) xor d(6) xor d(5) xor d(4) xor d(2) xor d(1) xor c(0) xor c(2) xor c(5) xor c(6) xor c(8) xor c(10) xor c(11) xor c(13) xor c(15) xor c(16) xor c(17) xor c(22) xor c(23) xor c(24) xor c(26) xor c(31);
    newcrc(7) := d(183) xor d(182) xor d(179) xor d(177) xor d(176) xor d(175) xor d(172) xor d(171) xor d(168) xor d(167) xor d(164) xor d(163) xor d(162) xor d(159) xor d(156) xor d(153) xor d(152) xor d(151) xor d(149) xor d(148) xor d(147) xor d(145) xor d(143) xor d(142) xor d(141) xor d(140) xor d(138) xor d(135) xor d(133) xor d(131) xor d(129) xor d(126) xor d(124) xor d(122) xor d(119) xor d(116) xor d(111) xor d(110) xor d(109) xor d(108) xor d(106) xor d(105) xor d(104) xor d(103) xor d(98) xor d(97) xor d(95) xor d(93) xor d(87) xor d(80) xor d(79) xor d(77) xor d(76) xor d(75) xor d(74) xor d(71) xor d(69) xor d(68) xor d(60) xor d(58) xor d(57) xor d(56) xor d(54) xor d(52) xor d(51) xor d(50) xor d(47) xor d(46) xor d(45) xor d(43) xor d(42) xor d(41) xor d(39) xor d(37) xor d(34) xor d(32) xor d(29) xor d(28) xor d(25) xor d(24) xor d(23) xor d(22) xor d(21) xor d(16) xor d(15) xor d(10) xor d(8) xor d(7) xor d(5) xor d(3) xor d(2) xor d(0) xor c(0) xor c(1) xor c(4) xor c(7) xor c(10) xor c(11) xor c(12) xor c(15) xor c(16) xor c(19) xor c(20) xor c(23) xor c(24) xor c(25) xor c(27) xor c(30) xor c(31);
    newcrc(8) := d(182) xor d(180) xor d(178) xor d(177) xor d(176) xor d(173) xor d(171) xor d(170) xor d(168) xor d(167) xor d(166) xor d(165) xor d(164) xor d(163) xor d(162) xor d(161) xor d(160) xor d(158) xor d(157) xor d(156) xor d(155) xor d(154) xor d(153) xor d(152) xor d(151) xor d(150) xor d(148) xor d(146) xor d(142) xor d(141) xor d(139) xor d(137) xor d(135) xor d(130) xor d(128) xor d(126) xor d(120) xor d(119) xor d(118) xor d(116) xor d(114) xor d(113) xor d(112) xor d(109) xor d(107) xor d(105) xor d(103) xor d(101) xor d(97) xor d(95) xor d(88) xor d(87) xor d(85) xor d(84) xor d(83) xor d(82) xor d(80) xor d(79) xor d(78) xor d(77) xor d(76) xor d(75) xor d(73) xor d(70) xor d(69) xor d(68) xor d(67) xor d(66) xor d(65) xor d(63) xor d(60) xor d(59) xor d(57) xor d(54) xor d(52) xor d(51) xor d(50) xor d(46) xor d(45) xor d(43) xor d(42) xor d(40) xor d(38) xor d(37) xor d(35) xor d(34) xor d(33) xor d(32) xor d(31) xor d(28) xor d(23) xor d(22) xor d(17) xor d(12) xor d(11) xor d(10) xor d(8) xor d(4) xor d(3) xor d(1) xor d(0) xor c(0) xor c(1) xor c(2) xor c(3) xor c(4) xor c(5) xor c(6) xor c(8) xor c(9) xor c(10) xor c(11) xor c(12) xor c(13) xor c(14) xor c(15) xor c(16) xor c(18) xor c(19) xor c(21) xor c(24) xor c(25) xor c(26) xor c(28) xor c(30);
    newcrc(9) := d(183) xor d(181) xor d(179) xor d(178) xor d(177) xor d(174) xor d(172) xor d(171) xor d(169) xor d(168) xor d(167) xor d(166) xor d(165) xor d(164) xor d(163) xor d(162) xor d(161) xor d(159) xor d(158) xor d(157) xor d(156) xor d(155) xor d(154) xor d(153) xor d(152) xor d(151) xor d(149) xor d(147) xor d(143) xor d(142) xor d(140) xor d(138) xor d(136) xor d(131) xor d(129) xor d(127) xor d(121) xor d(120) xor d(119) xor d(117) xor d(115) xor d(114) xor d(113) xor d(110) xor d(108) xor d(106) xor d(104) xor d(102) xor d(98) xor d(96) xor d(89) xor d(88) xor d(86) xor d(85) xor d(84) xor d(83) xor d(81) xor d(80) xor d(79) xor d(78) xor d(77) xor d(76) xor d(74) xor d(71) xor d(70) xor d(69) xor d(68) xor d(67) xor d(66) xor d(64) xor d(61) xor d(60) xor d(58) xor d(55) xor d(53) xor d(52) xor d(51) xor d(47) xor d(46) xor d(44) xor d(43) xor d(41) xor d(39) xor d(38) xor d(36) xor d(35) xor d(34) xor d(33) xor d(32) xor d(29) xor d(24) xor d(23) xor d(18) xor d(13) xor d(12) xor d(11) xor d(9) xor d(5) xor d(4) xor d(2) xor d(1) xor c(0) xor c(1) xor c(2) xor c(3) xor c(4) xor c(5) xor c(6) xor c(7) xor c(9) xor c(10) xor c(11) xor c(12) xor c(13) xor c(14) xor c(15) xor c(16) xor c(17) xor c(19) xor c(20) xor c(22) xor c(25) xor c(26) xor c(27) xor c(29) xor c(31);
    newcrc(10) := d(183) xor d(180) xor d(179) xor d(178) xor d(175) xor d(173) xor d(171) xor d(168) xor d(165) xor d(164) xor d(163) xor d(161) xor d(160) xor d(159) xor d(157) xor d(154) xor d(153) xor d(152) xor d(151) xor d(150) xor d(149) xor d(148) xor d(141) xor d(139) xor d(136) xor d(135) xor d(134) xor d(130) xor d(127) xor d(126) xor d(125) xor d(123) xor d(122) xor d(121) xor d(120) xor d(119) xor d(117) xor d(115) xor d(113) xor d(110) xor d(109) xor d(107) xor d(106) xor d(105) xor d(104) xor d(101) xor d(98) xor d(96) xor d(95) xor d(94) xor d(90) xor d(89) xor d(86) xor d(83) xor d(80) xor d(78) xor d(77) xor d(75) xor d(73) xor d(71) xor d(70) xor d(69) xor d(66) xor d(63) xor d(62) xor d(60) xor d(59) xor d(58) xor d(56) xor d(55) xor d(52) xor d(50) xor d(42) xor d(40) xor d(39) xor d(36) xor d(35) xor d(33) xor d(32) xor d(31) xor d(29) xor d(28) xor d(26) xor d(19) xor d(16) xor d(14) xor d(13) xor d(9) xor d(5) xor d(3) xor d(2) xor d(0) xor c(0) xor c(1) xor c(2) xor c(5) xor c(7) xor c(8) xor c(9) xor c(11) xor c(12) xor c(13) xor c(16) xor c(19) xor c(21) xor c(23) xor c(26) xor c(27) xor c(28) xor c(31);
    newcrc(11) := d(183) xor d(182) xor d(181) xor d(180) xor d(179) xor d(176) xor d(174) xor d(171) xor d(170) xor d(167) xor d(165) xor d(164) xor d(160) xor d(156) xor d(154) xor d(153) xor d(152) xor d(150) xor d(144) xor d(143) xor d(142) xor d(140) xor d(134) xor d(132) xor d(131) xor d(125) xor d(124) xor d(122) xor d(121) xor d(120) xor d(119) xor d(117) xor d(113) xor d(108) xor d(107) xor d(105) xor d(104) xor d(103) xor d(102) xor d(101) xor d(98) xor d(94) xor d(91) xor d(90) xor d(85) xor d(83) xor d(82) xor d(78) xor d(76) xor d(74) xor d(73) xor d(71) xor d(70) xor d(68) xor d(66) xor d(65) xor d(64) xor d(59) xor d(58) xor d(57) xor d(56) xor d(55) xor d(54) xor d(51) xor d(50) xor d(48) xor d(47) xor d(45) xor d(44) xor d(43) xor d(41) xor d(40) xor d(36) xor d(33) xor d(31) xor d(28) xor d(27) xor d(26) xor d(25) xor d(24) xor d(20) xor d(17) xor d(16) xor d(15) xor d(14) xor d(12) xor d(9) xor d(4) xor d(3) xor d(1) xor d(0) xor c(0) xor c(1) xor c(2) xor c(4) xor c(8) xor c(12) xor c(13) xor c(15) xor c(18) xor c(19) xor c(22) xor c(24) xor c(27) xor c(28) xor c(29) xor c(30) xor c(31);
    newcrc(12) := d(181) xor d(180) xor d(177) xor d(175) xor d(170) xor d(169) xor d(168) xor d(167) xor d(165) xor d(162) xor d(158) xor d(157) xor d(156) xor d(154) xor d(153) xor d(149) xor d(145) xor d(141) xor d(137) xor d(136) xor d(134) xor d(133) xor d(128) xor d(127) xor d(122) xor d(121) xor d(120) xor d(119) xor d(117) xor d(116) xor d(113) xor d(111) xor d(110) xor d(109) xor d(108) xor d(105) xor d(102) xor d(101) xor d(98) xor d(97) xor d(96) xor d(94) xor d(92) xor d(91) xor d(87) xor d(86) xor d(85) xor d(82) xor d(81) xor d(77) xor d(75) xor d(74) xor d(73) xor d(71) xor d(69) xor d(68) xor d(63) xor d(61) xor d(59) xor d(57) xor d(56) xor d(54) xor d(53) xor d(52) xor d(51) xor d(50) xor d(49) xor d(47) xor d(46) xor d(42) xor d(41) xor d(31) xor d(30) xor d(27) xor d(24) xor d(21) xor d(18) xor d(17) xor d(15) xor d(13) xor d(12) xor d(9) xor d(6) xor d(5) xor d(4) xor d(2) xor d(1) xor d(0) xor c(1) xor c(2) xor c(4) xor c(5) xor c(6) xor c(10) xor c(13) xor c(15) xor c(16) xor c(17) xor c(18) xor c(23) xor c(25) xor c(28) xor c(29);
    newcrc(13) := d(182) xor d(181) xor d(178) xor d(176) xor d(171) xor d(170) xor d(169) xor d(168) xor d(166) xor d(163) xor d(159) xor d(158) xor d(157) xor d(155) xor d(154) xor d(150) xor d(146) xor d(142) xor d(138) xor d(137) xor d(135) xor d(134) xor d(129) xor d(128) xor d(123) xor d(122) xor d(121) xor d(120) xor d(118) xor d(117) xor d(114) xor d(112) xor d(111) xor d(110) xor d(109) xor d(106) xor d(103) xor d(102) xor d(99) xor d(98) xor d(97) xor d(95) xor d(93) xor d(92) xor d(88) xor d(87) xor d(86) xor d(83) xor d(82) xor d(78) xor d(76) xor d(75) xor d(74) xor d(72) xor d(70) xor d(69) xor d(64) xor d(62) xor d(60) xor d(58) xor d(57) xor d(55) xor d(54) xor d(53) xor d(52) xor d(51) xor d(50) xor d(48) xor d(47) xor d(43) xor d(42) xor d(32) xor d(31) xor d(28) xor d(25) xor d(22) xor d(19) xor d(18) xor d(16) xor d(14) xor d(13) xor d(10) xor d(7) xor d(6) xor d(5) xor d(3) xor d(2) xor d(1) xor c(2) xor c(3) xor c(5) xor c(6) xor c(7) xor c(11) xor c(14) xor c(16) xor c(17) xor c(18) xor c(19) xor c(24) xor c(26) xor c(29) xor c(30);
    newcrc(14) := d(183) xor d(182) xor d(179) xor d(177) xor d(172) xor d(171) xor d(170) xor d(169) xor d(167) xor d(164) xor d(160) xor d(159) xor d(158) xor d(156) xor d(155) xor d(151) xor d(147) xor d(143) xor d(139) xor d(138) xor d(136) xor d(135) xor d(130) xor d(129) xor d(124) xor d(123) xor d(122) xor d(121) xor d(119) xor d(118) xor d(115) xor d(113) xor d(112) xor d(111) xor d(110) xor d(107) xor d(104) xor d(103) xor d(100) xor d(99) xor d(98) xor d(96) xor d(94) xor d(93) xor d(89) xor d(88) xor d(87) xor d(84) xor d(83) xor d(79) xor d(77) xor d(76) xor d(75) xor d(73) xor d(71) xor d(70) xor d(65) xor d(63) xor d(61) xor d(59) xor d(58) xor d(56) xor d(55) xor d(54) xor d(53) xor d(52) xor d(51) xor d(49) xor d(48) xor d(44) xor d(43) xor d(33) xor d(32) xor d(29) xor d(26) xor d(23) xor d(20) xor d(19) xor d(17) xor d(15) xor d(14) xor d(11) xor d(8) xor d(7) xor d(6) xor d(4) xor d(3) xor d(2) xor c(3) xor c(4) xor c(6) xor c(7) xor c(8) xor c(12) xor c(15) xor c(17) xor c(18) xor c(19) xor c(20) xor c(25) xor c(27) xor c(30) xor c(31);
    newcrc(15) := d(183) xor d(180) xor d(178) xor d(173) xor d(172) xor d(171) xor d(170) xor d(168) xor d(165) xor d(161) xor d(160) xor d(159) xor d(157) xor d(156) xor d(152) xor d(148) xor d(144) xor d(140) xor d(139) xor d(137) xor d(136) xor d(131) xor d(130) xor d(125) xor d(124) xor d(123) xor d(122) xor d(120) xor d(119) xor d(116) xor d(114) xor d(113) xor d(112) xor d(111) xor d(108) xor d(105) xor d(104) xor d(101) xor d(100) xor d(99) xor d(97) xor d(95) xor d(94) xor d(90) xor d(89) xor d(88) xor d(85) xor d(84) xor d(80) xor d(78) xor d(77) xor d(76) xor d(74) xor d(72) xor d(71) xor d(66) xor d(64) xor d(62) xor d(60) xor d(59) xor d(57) xor d(56) xor d(55) xor d(54) xor d(53) xor d(52) xor d(50) xor d(49) xor d(45) xor d(44) xor d(34) xor d(33) xor d(30) xor d(27) xor d(24) xor d(21) xor d(20) xor d(18) xor d(16) xor d(15) xor d(12) xor d(9) xor d(8) xor d(7) xor d(5) xor d(4) xor d(3) xor c(0) xor c(4) xor c(5) xor c(7) xor c(8) xor c(9) xor c(13) xor c(16) xor c(18) xor c(19) xor c(20) xor c(21) xor c(26) xor c(28) xor c(31);
    newcrc(16) := d(183) xor d(182) xor d(181) xor d(179) xor d(174) xor d(173) xor d(170) xor d(167) xor d(160) xor d(157) xor d(156) xor d(155) xor d(153) xor d(151) xor d(145) xor d(144) xor d(143) xor d(141) xor d(140) xor d(138) xor d(136) xor d(135) xor d(134) xor d(131) xor d(128) xor d(127) xor d(124) xor d(121) xor d(120) xor d(119) xor d(118) xor d(116) xor d(115) xor d(112) xor d(111) xor d(110) xor d(109) xor d(105) xor d(104) xor d(103) xor d(102) xor d(100) xor d(99) xor d(97) xor d(94) xor d(91) xor d(90) xor d(89) xor d(87) xor d(86) xor d(84) xor d(83) xor d(82) xor d(78) xor d(77) xor d(75) xor d(68) xor d(66) xor d(57) xor d(56) xor d(51) xor d(48) xor d(47) xor d(46) xor d(44) xor d(37) xor d(35) xor d(32) xor d(30) xor d(29) xor d(26) xor d(24) xor d(22) xor d(21) xor d(19) xor d(17) xor d(13) xor d(12) xor d(8) xor d(5) xor d(4) xor d(0) xor c(1) xor c(3) xor c(4) xor c(5) xor c(8) xor c(15) xor c(18) xor c(21) xor c(22) xor c(27) xor c(29) xor c(30) xor c(31);
    newcrc(17) := d(183) xor d(182) xor d(180) xor d(175) xor d(174) xor d(171) xor d(168) xor d(161) xor d(158) xor d(157) xor d(156) xor d(154) xor d(152) xor d(146) xor d(145) xor d(144) xor d(142) xor d(141) xor d(139) xor d(137) xor d(136) xor d(135) xor d(132) xor d(129) xor d(128) xor d(125) xor d(122) xor d(121) xor d(120) xor d(119) xor d(117) xor d(116) xor d(113) xor d(112) xor d(111) xor d(110) xor d(106) xor d(105) xor d(104) xor d(103) xor d(101) xor d(100) xor d(98) xor d(95) xor d(92) xor d(91) xor d(90) xor d(88) xor d(87) xor d(85) xor d(84) xor d(83) xor d(79) xor d(78) xor d(76) xor d(69) xor d(67) xor d(58) xor d(57) xor d(52) xor d(49) xor d(48) xor d(47) xor d(45) xor d(38) xor d(36) xor d(33) xor d(31) xor d(30) xor d(27) xor d(25) xor d(23) xor d(22) xor d(20) xor d(18) xor d(14) xor d(13) xor d(9) xor d(6) xor d(5) xor d(1) xor c(0) xor c(2) xor c(4) xor c(5) xor c(6) xor c(9) xor c(16) xor c(19) xor c(22) xor c(23) xor c(28) xor c(30) xor c(31);
    newcrc(18) := d(183) xor d(181) xor d(176) xor d(175) xor d(172) xor d(169) xor d(162) xor d(159) xor d(158) xor d(157) xor d(155) xor d(153) xor d(147) xor d(146) xor d(145) xor d(143) xor d(142) xor d(140) xor d(138) xor d(137) xor d(136) xor d(133) xor d(130) xor d(129) xor d(126) xor d(123) xor d(122) xor d(121) xor d(120) xor d(118) xor d(117) xor d(114) xor d(113) xor d(112) xor d(111) xor d(107) xor d(106) xor d(105) xor d(104) xor d(102) xor d(101) xor d(99) xor d(96) xor d(93) xor d(92) xor d(91) xor d(89) xor d(88) xor d(86) xor d(85) xor d(84) xor d(80) xor d(79) xor d(77) xor d(70) xor d(68) xor d(59) xor d(58) xor d(53) xor d(50) xor d(49) xor d(48) xor d(46) xor d(39) xor d(37) xor d(34) xor d(32) xor d(31) xor d(28) xor d(26) xor d(24) xor d(23) xor d(21) xor d(19) xor d(15) xor d(14) xor d(10) xor d(7) xor d(6) xor d(2) xor c(1) xor c(3) xor c(5) xor c(6) xor c(7) xor c(10) xor c(17) xor c(20) xor c(23) xor c(24) xor c(29) xor c(31);
    newcrc(19) := d(182) xor d(177) xor d(176) xor d(173) xor d(170) xor d(163) xor d(160) xor d(159) xor d(158) xor d(156) xor d(154) xor d(148) xor d(147) xor d(146) xor d(144) xor d(143) xor d(141) xor d(139) xor d(138) xor d(137) xor d(134) xor d(131) xor d(130) xor d(127) xor d(124) xor d(123) xor d(122) xor d(121) xor d(119) xor d(118) xor d(115) xor d(114) xor d(113) xor d(112) xor d(108) xor d(107) xor d(106) xor d(105) xor d(103) xor d(102) xor d(100) xor d(97) xor d(94) xor d(93) xor d(92) xor d(90) xor d(89) xor d(87) xor d(86) xor d(85) xor d(81) xor d(80) xor d(78) xor d(71) xor d(69) xor d(60) xor d(59) xor d(54) xor d(51) xor d(50) xor d(49) xor d(47) xor d(40) xor d(38) xor d(35) xor d(33) xor d(32) xor d(29) xor d(27) xor d(25) xor d(24) xor d(22) xor d(20) xor d(16) xor d(15) xor d(11) xor d(8) xor d(7) xor d(3) xor c(2) xor c(4) xor c(6) xor c(7) xor c(8) xor c(11) xor c(18) xor c(21) xor c(24) xor c(25) xor c(30);
    newcrc(20) := d(183) xor d(178) xor d(177) xor d(174) xor d(171) xor d(164) xor d(161) xor d(160) xor d(159) xor d(157) xor d(155) xor d(149) xor d(148) xor d(147) xor d(145) xor d(144) xor d(142) xor d(140) xor d(139) xor d(138) xor d(135) xor d(132) xor d(131) xor d(128) xor d(125) xor d(124) xor d(123) xor d(122) xor d(120) xor d(119) xor d(116) xor d(115) xor d(114) xor d(113) xor d(109) xor d(108) xor d(107) xor d(106) xor d(104) xor d(103) xor d(101) xor d(98) xor d(95) xor d(94) xor d(93) xor d(91) xor d(90) xor d(88) xor d(87) xor d(86) xor d(82) xor d(81) xor d(79) xor d(72) xor d(70) xor d(61) xor d(60) xor d(55) xor d(52) xor d(51) xor d(50) xor d(48) xor d(41) xor d(39) xor d(36) xor d(34) xor d(33) xor d(30) xor d(28) xor d(26) xor d(25) xor d(23) xor d(21) xor d(17) xor d(16) xor d(12) xor d(9) xor d(8) xor d(4) xor c(3) xor c(5) xor c(7) xor c(8) xor c(9) xor c(12) xor c(19) xor c(22) xor c(25) xor c(26) xor c(31);
    newcrc(21) := d(179) xor d(178) xor d(175) xor d(172) xor d(165) xor d(162) xor d(161) xor d(160) xor d(158) xor d(156) xor d(150) xor d(149) xor d(148) xor d(146) xor d(145) xor d(143) xor d(141) xor d(140) xor d(139) xor d(136) xor d(133) xor d(132) xor d(129) xor d(126) xor d(125) xor d(124) xor d(123) xor d(121) xor d(120) xor d(117) xor d(116) xor d(115) xor d(114) xor d(110) xor d(109) xor d(108) xor d(107) xor d(105) xor d(104) xor d(102) xor d(99) xor d(96) xor d(95) xor d(94) xor d(92) xor d(91) xor d(89) xor d(88) xor d(87) xor d(83) xor d(82) xor d(80) xor d(73) xor d(71) xor d(62) xor d(61) xor d(56) xor d(53) xor d(52) xor d(51) xor d(49) xor d(42) xor d(40) xor d(37) xor d(35) xor d(34) xor d(31) xor d(29) xor d(27) xor d(26) xor d(24) xor d(22) xor d(18) xor d(17) xor d(13) xor d(10) xor d(9) xor d(5) xor c(4) xor c(6) xor c(8) xor c(9) xor c(10) xor c(13) xor c(20) xor c(23) xor c(26) xor c(27);
    newcrc(22) := d(183) xor d(182) xor d(180) xor d(179) xor d(176) xor d(173) xor d(172) xor d(171) xor d(170) xor d(169) xor d(167) xor d(163) xor d(159) xor d(158) xor d(157) xor d(156) xor d(155) xor d(150) xor d(147) xor d(146) xor d(143) xor d(142) xor d(141) xor d(140) xor d(136) xor d(135) xor d(133) xor d(132) xor d(130) xor d(128) xor d(124) xor d(123) xor d(122) xor d(121) xor d(119) xor d(115) xor d(114) xor d(113) xor d(109) xor d(108) xor d(105) xor d(104) xor d(101) xor d(100) xor d(99) xor d(98) xor d(94) xor d(93) xor d(92) xor d(90) xor d(89) xor d(88) xor d(87) xor d(85) xor d(82) xor d(79) xor d(74) xor d(73) xor d(68) xor d(67) xor d(66) xor d(65) xor d(62) xor d(61) xor d(60) xor d(58) xor d(57) xor d(55) xor d(52) xor d(48) xor d(47) xor d(45) xor d(44) xor d(43) xor d(41) xor d(38) xor d(37) xor d(36) xor d(35) xor d(34) xor d(31) xor d(29) xor d(27) xor d(26) xor d(24) xor d(23) xor d(19) xor d(18) xor d(16) xor d(14) xor d(12) xor d(11) xor d(9) xor d(0) xor c(3) xor c(4) xor c(5) xor c(6) xor c(7) xor c(11) xor c(15) xor c(17) xor c(18) xor c(19) xor c(20) xor c(21) xor c(24) xor c(27) xor c(28) xor c(30) xor c(31);
    newcrc(23) := d(182) xor d(181) xor d(180) xor d(177) xor d(174) xor d(173) xor d(169) xor d(168) xor d(167) xor d(166) xor d(164) xor d(162) xor d(161) xor d(160) xor d(159) xor d(157) xor d(155) xor d(149) xor d(148) xor d(147) xor d(142) xor d(141) xor d(135) xor d(133) xor d(132) xor d(131) xor d(129) xor d(128) xor d(127) xor d(126) xor d(124) xor d(122) xor d(120) xor d(119) xor d(118) xor d(117) xor d(115) xor d(113) xor d(111) xor d(109) xor d(105) xor d(104) xor d(103) xor d(102) xor d(100) xor d(98) xor d(97) xor d(96) xor d(93) xor d(91) xor d(90) xor d(89) xor d(88) xor d(87) xor d(86) xor d(85) xor d(84) xor d(82) xor d(81) xor d(80) xor d(79) xor d(75) xor d(74) xor d(73) xor d(72) xor d(69) xor d(65) xor d(62) xor d(60) xor d(59) xor d(56) xor d(55) xor d(54) xor d(50) xor d(49) xor d(47) xor d(46) xor d(42) xor d(39) xor d(38) xor d(36) xor d(35) xor d(34) xor d(31) xor d(29) xor d(27) xor d(26) xor d(20) xor d(19) xor d(17) xor d(16) xor d(15) xor d(13) xor d(9) xor d(6) xor d(1) xor d(0) xor c(3) xor c(5) xor c(7) xor c(8) xor c(9) xor c(10) xor c(12) xor c(14) xor c(15) xor c(16) xor c(17) xor c(21) xor c(22) xor c(25) xor c(28) xor c(29) xor c(30);
    newcrc(24) := d(183) xor d(182) xor d(181) xor d(178) xor d(175) xor d(174) xor d(170) xor d(169) xor d(168) xor d(167) xor d(165) xor d(163) xor d(162) xor d(161) xor d(160) xor d(158) xor d(156) xor d(150) xor d(149) xor d(148) xor d(143) xor d(142) xor d(136) xor d(134) xor d(133) xor d(132) xor d(130) xor d(129) xor d(128) xor d(127) xor d(125) xor d(123) xor d(121) xor d(120) xor d(119) xor d(118) xor d(116) xor d(114) xor d(112) xor d(110) xor d(106) xor d(105) xor d(104) xor d(103) xor d(101) xor d(99) xor d(98) xor d(97) xor d(94) xor d(92) xor d(91) xor d(90) xor d(89) xor d(88) xor d(87) xor d(86) xor d(85) xor d(83) xor d(82) xor d(81) xor d(80) xor d(76) xor d(75) xor d(74) xor d(73) xor d(70) xor d(66) xor d(63) xor d(61) xor d(60) xor d(57) xor d(56) xor d(55) xor d(51) xor d(50) xor d(48) xor d(47) xor d(43) xor d(40) xor d(39) xor d(37) xor d(36) xor d(35) xor d(32) xor d(30) xor d(28) xor d(27) xor d(21) xor d(20) xor d(18) xor d(17) xor d(16) xor d(14) xor d(10) xor d(7) xor d(2) xor d(1) xor c(4) xor c(6) xor c(8) xor c(9) xor c(10) xor c(11) xor c(13) xor c(15) xor c(16) xor c(17) xor c(18) xor c(22) xor c(23) xor c(26) xor c(29) xor c(30) xor c(31);
    newcrc(25) := d(183) xor d(182) xor d(179) xor d(176) xor d(175) xor d(171) xor d(170) xor d(169) xor d(168) xor d(166) xor d(164) xor d(163) xor d(162) xor d(161) xor d(159) xor d(157) xor d(151) xor d(150) xor d(149) xor d(144) xor d(143) xor d(137) xor d(135) xor d(134) xor d(133) xor d(131) xor d(130) xor d(129) xor d(128) xor d(126) xor d(124) xor d(122) xor d(121) xor d(120) xor d(119) xor d(117) xor d(115) xor d(113) xor d(111) xor d(107) xor d(106) xor d(105) xor d(104) xor d(102) xor d(100) xor d(99) xor d(98) xor d(95) xor d(93) xor d(92) xor d(91) xor d(90) xor d(89) xor d(88) xor d(87) xor d(86) xor d(84) xor d(83) xor d(82) xor d(81) xor d(77) xor d(76) xor d(75) xor d(74) xor d(71) xor d(67) xor d(64) xor d(62) xor d(61) xor d(58) xor d(57) xor d(56) xor d(52) xor d(51) xor d(49) xor d(48) xor d(44) xor d(41) xor d(40) xor d(38) xor d(37) xor d(36) xor d(33) xor d(31) xor d(29) xor d(28) xor d(22) xor d(21) xor d(19) xor d(18) xor d(17) xor d(15) xor d(11) xor d(8) xor d(3) xor d(2) xor c(5) xor c(7) xor c(9) xor c(10) xor c(11) xor c(12) xor c(14) xor c(16) xor c(17) xor c(18) xor c(19) xor c(23) xor c(24) xor c(27) xor c(30) xor c(31);
    newcrc(26) := d(182) xor d(180) xor d(177) xor d(176) xor d(166) xor d(165) xor d(164) xor d(163) xor d(161) xor d(160) xor d(156) xor d(155) xor d(152) xor d(150) xor d(149) xor d(145) xor d(143) xor d(138) xor d(137) xor d(131) xor d(130) xor d(129) xor d(128) xor d(126) xor d(122) xor d(121) xor d(120) xor d(119) xor d(117) xor d(113) xor d(112) xor d(111) xor d(110) xor d(108) xor d(107) xor d(105) xor d(104) xor d(100) xor d(98) xor d(97) xor d(95) xor d(93) xor d(92) xor d(91) xor d(90) xor d(89) xor d(88) xor d(81) xor d(79) xor d(78) xor d(77) xor d(76) xor d(75) xor d(73) xor d(67) xor d(66) xor d(62) xor d(61) xor d(60) xor d(59) xor d(57) xor d(55) xor d(54) xor d(52) xor d(49) xor d(48) xor d(47) xor d(44) xor d(42) xor d(41) xor d(39) xor d(38) xor d(31) xor d(28) xor d(26) xor d(25) xor d(24) xor d(23) xor d(22) xor d(20) xor d(19) xor d(18) xor d(10) xor d(6) xor d(4) xor d(3) xor d(0) xor c(0) xor c(3) xor c(4) xor c(8) xor c(9) xor c(11) xor c(12) xor c(13) xor c(14) xor c(24) xor c(25) xor c(28) xor c(30);
    newcrc(27) := d(183) xor d(181) xor d(178) xor d(177) xor d(167) xor d(166) xor d(165) xor d(164) xor d(162) xor d(161) xor d(157) xor d(156) xor d(153) xor d(151) xor d(150) xor d(146) xor d(144) xor d(139) xor d(138) xor d(132) xor d(131) xor d(130) xor d(129) xor d(127) xor d(123) xor d(122) xor d(121) xor d(120) xor d(118) xor d(114) xor d(113) xor d(112) xor d(111) xor d(109) xor d(108) xor d(106) xor d(105) xor d(101) xor d(99) xor d(98) xor d(96) xor d(94) xor d(93) xor d(92) xor d(91) xor d(90) xor d(89) xor d(82) xor d(80) xor d(79) xor d(78) xor d(77) xor d(76) xor d(74) xor d(68) xor d(67) xor d(63) xor d(62) xor d(61) xor d(60) xor d(58) xor d(56) xor d(55) xor d(53) xor d(50) xor d(49) xor d(48) xor d(45) xor d(43) xor d(42) xor d(40) xor d(39) xor d(32) xor d(29) xor d(27) xor d(26) xor d(25) xor d(24) xor d(23) xor d(21) xor d(20) xor d(19) xor d(11) xor d(7) xor d(5) xor d(4) xor d(1) xor c(1) xor c(4) xor c(5) xor c(9) xor c(10) xor c(12) xor c(13) xor c(14) xor c(15) xor c(25) xor c(26) xor c(29) xor c(31);
    newcrc(28) := d(182) xor d(179) xor d(178) xor d(168) xor d(167) xor d(166) xor d(165) xor d(163) xor d(162) xor d(158) xor d(157) xor d(154) xor d(152) xor d(151) xor d(147) xor d(145) xor d(140) xor d(139) xor d(133) xor d(132) xor d(131) xor d(130) xor d(128) xor d(124) xor d(123) xor d(122) xor d(121) xor d(119) xor d(115) xor d(114) xor d(113) xor d(112) xor d(110) xor d(109) xor d(107) xor d(106) xor d(102) xor d(100) xor d(99) xor d(97) xor d(95) xor d(94) xor d(93) xor d(92) xor d(91) xor d(90) xor d(83) xor d(81) xor d(80) xor d(79) xor d(78) xor d(77) xor d(75) xor d(69) xor d(68) xor d(64) xor d(63) xor d(62) xor d(61) xor d(59) xor d(57) xor d(56) xor d(54) xor d(51) xor d(50) xor d(49) xor d(46) xor d(44) xor d(43) xor d(41) xor d(40) xor d(33) xor d(30) xor d(28) xor d(27) xor d(26) xor d(25) xor d(24) xor d(22) xor d(21) xor d(20) xor d(12) xor d(8) xor d(6) xor d(5) xor d(2) xor c(0) xor c(2) xor c(5) xor c(6) xor c(10) xor c(11) xor c(13) xor c(14) xor c(15) xor c(16) xor c(26) xor c(27) xor c(30);
    newcrc(29) := d(183) xor d(180) xor d(179) xor d(169) xor d(168) xor d(167) xor d(166) xor d(164) xor d(163) xor d(159) xor d(158) xor d(155) xor d(153) xor d(152) xor d(148) xor d(146) xor d(141) xor d(140) xor d(134) xor d(133) xor d(132) xor d(131) xor d(129) xor d(125) xor d(124) xor d(123) xor d(122) xor d(120) xor d(116) xor d(115) xor d(114) xor d(113) xor d(111) xor d(110) xor d(108) xor d(107) xor d(103) xor d(101) xor d(100) xor d(98) xor d(96) xor d(95) xor d(94) xor d(93) xor d(92) xor d(91) xor d(84) xor d(82) xor d(81) xor d(80) xor d(79) xor d(78) xor d(76) xor d(70) xor d(69) xor d(65) xor d(64) xor d(63) xor d(62) xor d(60) xor d(58) xor d(57) xor d(55) xor d(52) xor d(51) xor d(50) xor d(47) xor d(45) xor d(44) xor d(42) xor d(41) xor d(34) xor d(31) xor d(29) xor d(28) xor d(27) xor d(26) xor d(25) xor d(23) xor d(22) xor d(21) xor d(13) xor d(9) xor d(7) xor d(6) xor d(3) xor c(0) xor c(1) xor c(3) xor c(6) xor c(7) xor c(11) xor c(12) xor c(14) xor c(15) xor c(16) xor c(17) xor c(27) xor c(28) xor c(31);
    newcrc(30) := d(181) xor d(180) xor d(170) xor d(169) xor d(168) xor d(167) xor d(165) xor d(164) xor d(160) xor d(159) xor d(156) xor d(154) xor d(153) xor d(149) xor d(147) xor d(142) xor d(141) xor d(135) xor d(134) xor d(133) xor d(132) xor d(130) xor d(126) xor d(125) xor d(124) xor d(123) xor d(121) xor d(117) xor d(116) xor d(115) xor d(114) xor d(112) xor d(111) xor d(109) xor d(108) xor d(104) xor d(102) xor d(101) xor d(99) xor d(97) xor d(96) xor d(95) xor d(94) xor d(93) xor d(92) xor d(85) xor d(83) xor d(82) xor d(81) xor d(80) xor d(79) xor d(77) xor d(71) xor d(70) xor d(66) xor d(65) xor d(64) xor d(63) xor d(61) xor d(59) xor d(58) xor d(56) xor d(53) xor d(52) xor d(51) xor d(48) xor d(46) xor d(45) xor d(43) xor d(42) xor d(35) xor d(32) xor d(30) xor d(29) xor d(28) xor d(27) xor d(26) xor d(24) xor d(23) xor d(22) xor d(14) xor d(10) xor d(8) xor d(7) xor d(4) xor c(1) xor c(2) xor c(4) xor c(7) xor c(8) xor c(12) xor c(13) xor c(15) xor c(16) xor c(17) xor c(18) xor c(28) xor c(29);
    newcrc(31) := d(182) xor d(181) xor d(171) xor d(170) xor d(169) xor d(168) xor d(166) xor d(165) xor d(161) xor d(160) xor d(157) xor d(155) xor d(154) xor d(150) xor d(148) xor d(143) xor d(142) xor d(136) xor d(135) xor d(134) xor d(133) xor d(131) xor d(127) xor d(126) xor d(125) xor d(124) xor d(122) xor d(118) xor d(117) xor d(116) xor d(115) xor d(113) xor d(112) xor d(110) xor d(109) xor d(105) xor d(103) xor d(102) xor d(100) xor d(98) xor d(97) xor d(96) xor d(95) xor d(94) xor d(93) xor d(86) xor d(84) xor d(83) xor d(82) xor d(81) xor d(80) xor d(78) xor d(72) xor d(71) xor d(67) xor d(66) xor d(65) xor d(64) xor d(62) xor d(60) xor d(59) xor d(57) xor d(54) xor d(53) xor d(52) xor d(49) xor d(47) xor d(46) xor d(44) xor d(43) xor d(36) xor d(33) xor d(31) xor d(30) xor d(29) xor d(28) xor d(27) xor d(25) xor d(24) xor d(23) xor d(15) xor d(11) xor d(9) xor d(8) xor d(5) xor c(2) xor c(3) xor c(5) xor c(8) xor c(9) xor c(13) xor c(14) xor c(16) xor c(17) xor c(18) xor c(19) xor c(29) xor c(30);
    return newcrc;
  end nextCRC32_D184;

end PCK_CRC32_D184;
