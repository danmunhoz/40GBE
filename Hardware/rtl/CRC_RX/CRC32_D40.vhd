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
--   * data width: 24
--
-- Info : tools@easics.be
--        http://www.easics.com
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

package PCK_CRC32_D40 is
  -- polynomial: x^32 + x^26 + x^23 + x^22 + x^16 + x^12 + x^11 + x^10 + x^8 + x^7 + x^5 + x^4 + x^2 + x^1 + 1
  -- data width: 40
  -- convention: the first serial bit is D[39]
  function nextCRC32_D40
    (Data: std_logic_vector(39 downto 0);
     crc:  std_logic_vector(31 downto 0))
    return std_logic_vector;
end PCK_CRC32_D40;


package body PCK_CRC32_D40 is

  -- polynomial: x^32 + x^26 + x^23 + x^22 + x^16 + x^12 + x^11 + x^10 + x^8 + x^7 + x^5 + x^4 + x^2 + x^1 + 1
  -- data width: 40
  -- convention: the first serial bit is D[39]
  function nextCRC32_D40
    (Data: std_logic_vector(39 downto 0);
     crc:  std_logic_vector(31 downto 0))
    return std_logic_vector is

    variable d:      std_logic_vector(39 downto 0);
    variable c:      std_logic_vector(31 downto 0);
    variable newcrc: std_logic_vector(31 downto 0);

  begin
    d := Data;
    c := crc;

    newcrc(0) := d(26) xor d(25) xor d(24) xor d(21) xor d(18) xor d(15) xor d(14) xor d(13) xor d(10) xor d(9) xor d(6) xor d(0) xor c(1) xor c(2) xor c(4) xor c(8) xor c(16) xor c(17) xor c(18) xor c(20) xor c(21) xor c(22) xor c(23) xor c(24) xor c(26) xor c(29);
    newcrc(1) := d(27) xor d(24) xor d(22) xor d(21) xor d(19) xor d(18) xor d(16) xor d(13) xor d(11) xor d(9) xor d(7) xor d(6) xor d(1) xor d(0) xor c(1) xor c(3) xor c(4) xor c(5) xor c(8) xor c(9) xor c(16) xor c(19) xor c(20) xor c(25) xor c(26) xor c(27) xor c(29) xor c(30);
    newcrc(2) := d(26) xor d(24) xor d(23) xor d(22) xor d(21) xor d(20) xor d(19) xor d(18) xor d(17) xor d(15) xor d(13) xor d(9) xor d(8) xor d(7) xor d(6) xor d(2) xor d(1) xor d(0) xor c(0) xor c(1) xor c(5) xor c(6) xor c(8) xor c(9) xor c(10) xor c(16) xor c(18) xor c(22) xor c(23) xor c(24) xor c(27) xor c(28) xor c(29) xor c(30) xor c(31);
    newcrc(3) := d(27) xor d(25) xor d(23) xor d(22) xor d(21) xor d(20) xor d(19) xor d(18) xor d(16) xor d(14) xor d(10) xor d(9) xor d(8) xor d(7) xor d(3) xor d(2) xor d(1) xor c(0) xor c(1) xor c(2) xor c(6) xor c(7) xor c(9) xor c(10) xor c(11) xor c(17) xor c(19) xor c(23) xor c(24) xor c(25) xor c(28) xor c(29) xor c(30) xor c(31);
    newcrc(4) := d(25) xor d(24) xor d(23) xor d(22) xor d(20) xor d(19) xor d(18) xor d(17) xor d(14) xor d(13) xor d(12) xor d(11) xor d(8) xor d(6) xor d(4) xor d(3) xor d(2) xor d(0) xor c(0) xor c(3) xor c(4) xor c(7) xor c(10) xor c(11) xor c(12) xor c(16) xor c(17) xor c(21) xor c(22) xor c(23) xor c(25) xor c(30) xor c(31);
    newcrc(5) := d(24) xor d(23) xor d(20) xor d(19) xor d(12) xor d(10) xor d(7) xor d(6) xor d(5) xor d(4) xor d(3) xor d(1) xor d(0) xor c(2) xor c(5) xor c(11) xor c(12) xor c(13) xor c(16) xor c(20) xor c(21) xor c(29) xor c(31);
    newcrc(6) := d(25) xor d(21) xor d(20) xor d(13) xor d(11) xor d(8) xor d(7) xor d(6) xor d(5) xor d(4) xor d(2) xor d(1) xor c(0) xor c(3) xor c(6) xor c(12) xor c(13) xor c(14) xor c(17) xor c(21) xor c(22) xor c(30);
    newcrc(7) := d(25) xor d(24) xor d(22) xor d(18) xor d(15) xor d(13) xor d(12) xor d(10) xor d(8) xor d(7) xor d(5) xor d(3) xor d(2) xor d(0) xor c(0) xor c(2) xor c(7) xor c(8) xor c(13) xor c(14) xor c(15) xor c(16) xor c(17) xor c(20) xor c(21) xor c(24) xor c(26) xor c(29) xor c(31);
    newcrc(8) := d(23) xor d(21) xor d(19) xor d(18) xor d(16) xor d(15) xor d(11) xor d(10) xor d(8) xor d(4) xor d(3) xor d(1) xor d(0) xor c(0) xor c(2) xor c(3) xor c(4) xor c(9) xor c(14) xor c(15) xor c(20) xor c(23) xor c(24) xor c(25) xor c(26) xor c(27) xor c(29) xor c(30);
    newcrc(9) := d(24) xor d(22) xor d(20) xor d(19) xor d(17) xor d(16) xor d(12) xor d(11) xor d(9) xor d(5) xor d(4) xor d(2) xor d(1) xor c(1) xor c(3) xor c(4) xor c(5) xor c(10) xor c(15) xor c(16) xor c(21) xor c(24) xor c(25) xor c(26) xor c(27) xor c(28) xor c(30) xor c(31);
    newcrc(10) := d(26) xor d(23) xor d(20) xor d(17) xor d(15) xor d(14) xor d(12) xor d(9) xor d(5) xor d(3) xor d(2) xor d(0) xor c(1) xor c(5) xor c(6) xor c(8) xor c(11) xor c(18) xor c(20) xor c(21) xor c(23) xor c(24) xor c(25) xor c(27) xor c(28) xor c(31);
    newcrc(11) := d(27) xor d(26) xor d(25) xor d(24) xor d(16) xor d(14) xor d(9) xor d(4) xor d(3) xor d(1) xor d(0) xor c(1) xor c(4) xor c(6) xor c(7) xor c(8) xor c(9) xor c(12) xor c(16) xor c(17) xor c(18) xor c(19) xor c(20) xor c(23) xor c(25) xor c(28);
    newcrc(12) := d(27) xor d(24) xor d(21) xor d(18) xor d(17) xor d(14) xor d(13) xor d(12) xor d(9) xor d(6) xor d(5) xor d(4) xor d(2) xor d(1) xor d(0) xor c(1) xor c(4) xor c(5) xor c(7) xor c(9) xor c(10) xor c(13) xor c(16) xor c(19) xor c(22) xor c(23);
    newcrc(13) := d(25) xor d(22) xor d(19) xor d(18) xor d(15) xor d(14) xor d(13) xor d(12) xor d(10) xor d(7) xor d(6) xor d(5) xor d(3) xor d(2) xor d(1) xor c(2) xor c(5) xor c(6) xor c(8) xor c(10) xor c(11) xor c(14) xor c(17) xor c(20) xor c(23) xor c(24);
    newcrc(14) := d(26) xor d(23) xor d(20) xor d(19) xor d(16) xor d(15) xor d(14) xor d(13) xor d(11) xor d(8) xor d(7) xor d(6) xor d(4) xor d(3) xor d(2) xor c(0) xor c(3) xor c(6) xor c(7) xor c(9) xor c(11) xor c(12) xor c(15) xor c(18) xor c(21) xor c(24) xor c(25);
    newcrc(15) := d(27) xor d(24) xor d(21) xor d(20) xor d(17) xor d(16) xor d(15) xor d(14) xor d(12) xor d(9) xor d(8) xor d(7) xor d(5) xor d(4) xor d(3) xor c(0) xor c(1) xor c(4) xor c(7) xor c(8) xor c(10) xor c(12) xor c(13) xor c(16) xor c(19) xor c(22) xor c(25) xor c(26);
    newcrc(16) := d(26) xor d(24) xor d(22) xor d(17) xor d(16) xor d(14) xor d(12) xor d(8) xor d(5) xor d(4) xor d(0) xor c(0) xor c(4) xor c(5) xor c(9) xor c(11) xor c(13) xor c(14) xor c(16) xor c(18) xor c(21) xor c(22) xor c(24) xor c(27) xor c(29);
    newcrc(17) := d(27) xor d(25) xor d(23) xor d(18) xor d(17) xor d(15) xor d(13) xor d(9) xor d(6) xor d(5) xor d(1) xor c(1) xor c(5) xor c(6) xor c(10) xor c(12) xor c(14) xor c(15) xor c(17) xor c(19) xor c(22) xor c(23) xor c(25) xor c(28) xor c(30);
    newcrc(18) := d(26) xor d(24) xor d(19) xor d(18) xor d(16) xor d(14) xor d(12) xor d(10) xor d(7) xor d(6) xor d(2) xor c(2) xor c(6) xor c(7) xor c(11) xor c(13) xor c(15) xor c(16) xor c(18) xor c(20) xor c(23) xor c(24) xor c(26) xor c(29) xor c(31);
    newcrc(19) := d(27) xor d(25) xor d(24) xor d(20) xor d(19) xor d(17) xor d(15) xor d(13) xor d(11) xor d(8) xor d(7) xor d(3) xor c(0) xor c(3) xor c(7) xor c(8) xor c(12) xor c(14) xor c(16) xor c(17) xor c(19) xor c(21) xor c(24) xor c(25) xor c(27) xor c(30);
    newcrc(20) := d(26) xor d(25) xor d(21) xor d(20) xor d(18) xor d(16) xor d(14) xor d(9) xor d(8) xor d(4) xor c(0) xor c(1) xor c(4) xor c(8) xor c(9) xor c(13) xor c(15) xor c(17) xor c(18) xor c(20) xor c(22) xor c(25) xor c(26) xor c(28) xor c(31);
    newcrc(21) := d(27) xor d(26) xor d(24) xor d(22) xor d(21) xor d(19) xor d(17) xor d(15) xor d(10) xor d(9) xor d(5) xor c(1) xor c(2) xor c(5) xor c(9) xor c(10) xor c(14) xor c(16) xor c(18) xor c(19) xor c(21) xor c(23) xor c(26) xor c(27) xor c(29);
    newcrc(22) := d(27) xor d(26) xor d(24) xor d(23) xor d(22) xor d(21) xor d(20) xor d(16) xor d(15) xor d(14) xor d(13) xor d(12) xor d(11) xor d(9) xor d(0) xor c(1) xor c(3) xor c(4) xor c(6) xor c(8) xor c(10) xor c(11) xor c(15) xor c(16) xor c(18) xor c(19) xor c(21) xor c(23) xor c(26) xor c(27) xor c(28) xor c(29) xor c(30);
    newcrc(23) := d(27) xor d(26) xor d(23) xor d(22) xor d(18) xor d(17) xor d(16) xor d(9) xor d(6) xor d(1) xor d(0) xor c(1) xor c(5) xor c(7) xor c(8) xor c(9) xor c(11) xor c(12) xor c(18) xor c(19) xor c(21) xor c(23) xor c(26) xor c(27) xor c(28) xor c(30) xor c(31);
    newcrc(24) := d(27) xor d(23) xor d(19) xor d(18) xor d(17) xor d(12) xor d(10) xor d(7) xor d(2) xor d(1) xor c(2) xor c(6) xor c(8) xor c(9) xor c(10) xor c(12) xor c(13) xor c(19) xor c(20) xor c(22) xor c(24) xor c(27) xor c(28) xor c(29) xor c(31);
    newcrc(25) := d(20) xor d(19) xor d(18) xor d(13) xor d(12) xor d(11) xor d(8) xor d(3) xor d(2) xor c(0) xor c(3) xor c(7) xor c(9) xor c(10) xor c(11) xor c(13) xor c(14) xor c(20) xor c(21) xor c(23) xor c(25) xor c(28) xor c(29) xor c(30);
    newcrc(26) := d(26) xor d(25) xor d(24) xor d(20) xor d(19) xor d(18) xor d(15) xor d(12) xor d(10) xor d(6) xor d(4) xor d(3) xor d(0) xor c(2) xor c(10) xor c(11) xor c(12) xor c(14) xor c(15) xor c(16) xor c(17) xor c(18) xor c(20) xor c(23) xor c(30) xor c(31);
    newcrc(27) := d(27) xor d(26) xor d(25) xor d(24) xor d(21) xor d(20) xor d(19) xor d(16) xor d(13) xor d(11) xor d(7) xor d(5) xor d(4) xor d(1) xor c(3) xor c(11) xor c(12) xor c(13) xor c(15) xor c(16) xor c(17) xor c(18) xor c(19) xor c(21) xor c(24) xor c(31);
    newcrc(28) := d(27) xor d(26) xor d(25) xor d(24) xor d(22) xor d(21) xor d(20) xor d(17) xor d(14) xor d(8) xor d(6) xor d(5) xor d(2) xor c(0) xor c(4) xor c(12) xor c(13) xor c(14) xor c(16) xor c(17) xor c(18) xor c(19) xor c(20) xor c(22) xor c(25);
    newcrc(29) := d(27) xor d(26) xor d(25) xor d(23) xor d(22) xor d(21) xor d(18) xor d(15) xor d(12) xor d(9) xor d(7) xor d(6) xor d(3) xor c(1) xor c(5) xor c(13) xor c(14) xor c(15) xor c(17) xor c(18) xor c(19) xor c(20) xor c(21) xor c(23) xor c(26);
    newcrc(30) := d(27) xor d(26) xor d(24) xor d(23) xor d(22) xor d(19) xor d(16) xor d(13) xor d(12) xor d(10) xor d(8) xor d(7) xor d(4) xor c(0) xor c(2) xor c(6) xor c(14) xor c(15) xor c(16) xor c(18) xor c(19) xor c(20) xor c(21) xor c(22) xor c(24) xor c(27);
    newcrc(31) := d(27) xor d(25) xor d(24) xor d(23) xor d(20) xor d(17) xor d(14) xor d(13) xor d(12) xor d(11) xor d(9) xor d(8) xor d(5) xor c(0) xor c(1) xor c(3) xor c(7) xor c(15) xor c(16) xor c(17) xor c(19) xor c(20) xor c(21) xor c(22) xor c(23) xor c(25) xor c(28);
    return newcrc;
  end nextCRC32_D40;

end PCK_CRC32_D40;