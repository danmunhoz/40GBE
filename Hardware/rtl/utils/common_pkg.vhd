-------------------------------------------------------------------------------
-- ARQUIVO      : common_pkg.vhd
-- TÍTULO       : Common Package
-- PROJETO      : LP-CORES
-- AUTOR        : Paulo
-- FINALIDADE   : Definição de tipos e funções usados com freqüência nos projetos
-- NOTAS        :
-- REVISÃO      : $Id: common_pkg.vhd,v 1.2 2009-04-29 14:33:09 giovani Exp $
-- DEPENDÊNCIAS :
-------------------------------------------------------------------------------
-- ATENÇÃO      : Esta descrição VHDL é propriedade de Teracom Telemática LTDA.
--                O Uso ou duplicação não autorizados desta descrição são
--                estritamente proibidos.
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Bibliotecas
-------------------------------------------------------------------------------
library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_unsigned.all;
	use ieee.math_real.all;

-------------------------------------------------------------------------------
-- Package
-------------------------------------------------------------------------------
package common_pkg is

	-----------------------------------
	-- Tipos
	-----------------------------------

	-- Arrays de std_logic_vector
	type vector128_type is array (integer range <>) of std_logic_vector(127 downto 0);
	type vector72_type is array (integer range <>) of std_logic_vector(71 downto 0);
	type vector64_type is array (integer range <>) of std_logic_vector(63 downto 0);
	type vector32_type is array (integer range <>) of std_logic_vector(31 downto 0);
	type vector31_type is array (integer range <>) of std_logic_vector(30 downto 0);
	type vector30_type is array (integer range <>) of std_logic_vector(29 downto 0);
	type vector29_type is array (integer range <>) of std_logic_vector(28 downto 0);
	type vector28_type is array (integer range <>) of std_logic_vector(27 downto 0);
	type vector27_type is array (integer range <>) of std_logic_vector(26 downto 0);
	type vector26_type is array (integer range <>) of std_logic_vector(25 downto 0);
	type vector25_type is array (integer range <>) of std_logic_vector(24 downto 0);
	type vector24_type is array (integer range <>) of std_logic_vector(23 downto 0);
	type vector23_type is array (integer range <>) of std_logic_vector(22 downto 0);
	type vector22_type is array (integer range <>) of std_logic_vector(21 downto 0);
	type vector21_type is array (integer range <>) of std_logic_vector(20 downto 0);
	type vector20_type is array (integer range <>) of std_logic_vector(19 downto 0);
	type vector19_type is array (integer range <>) of std_logic_vector(18 downto 0);
	type vector18_type is array (integer range <>) of std_logic_vector(17 downto 0);
	type vector17_type is array (integer range <>) of std_logic_vector(16 downto 0);
	type vector16_type is array (integer range <>) of std_logic_vector(15 downto 0);
	type vector15_type is array (integer range <>) of std_logic_vector(14 downto 0);
	type vector14_type is array (integer range <>) of std_logic_vector(13 downto 0);
	type vector13_type is array (integer range <>) of std_logic_vector(12 downto 0);
	type vector12_type is array (integer range <>) of std_logic_vector(11 downto 0);
	type vector11_type is array (integer range <>) of std_logic_vector(10 downto 0);
	type vector10_type is array (integer range <>) of std_logic_vector(9 downto 0);
	type vector9_type is array (integer range <>) of std_logic_vector(8 downto 0);
	type vector8_type is array (integer range <>) of std_logic_vector(7 downto 0);
	type vector7_type is array (integer range <>) of std_logic_vector(6 downto 0);
	type vector6_type is array (integer range <>) of std_logic_vector(5 downto 0);
	type vector5_type is array (integer range <>) of std_logic_vector(4 downto 0);
	type vector4_type is array (integer range <>) of std_logic_vector(3 downto 0);
	type vector3_type is array (integer range <>) of std_logic_vector(2 downto 0);
	type vector2_type is array (integer range <>) of std_logic_vector(1 downto 0);
	type vector1_type is array (integer range <>) of std_logic_vector(0 downto 0);

	-- Array de inteiros
	type int_vector is array (integer range <>) of integer;

	
	-- LOG base 2
	function log2(x: integer) return integer;
	
	-- Retorna número de bits necessários para representar uma quantidade de valores
	function numbits (x: integer) return integer;


end common_pkg;

-------------------------------------------------------------------------------
-- Package Body
-------------------------------------------------------------------------------
package body common_pkg is
	
	-- Função LOG base 2
	function log2(x: integer) return integer is
	begin
		return integer(ceil(log2(real(x))));
	end log2;
	
	-- Retorna número de bits necessários para representar uma quantidade de valores
	function numbits (x: integer) return integer is
	begin
		if x = 0 or x = 1 then
			return 1;
		else
			return log2(x);
		end if;
	end numbits;


end common_pkg;
