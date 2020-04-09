library work, std;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use std.standard.all;

entity segment is
	port
	(an: inout std_logic_vector (3 downto 0):="1110";
	segmente: out std_logic_vector (6 downto 0);
	clk: in bit; 
    anim: in std_logic_vector(1 downto 0)
	);
end segment;

architecture comportament of segment is
signal counter: std_logic_vector(25 downto 0):="00000000000000000000000000";
signal counter2: std_logic_vector(15 downto 0):="0000000000000000";
type memo is array (24 downto 0) of std_logic_vector (6 downto 0);
type mem is array (15 downto 0) of std_logic_vector (6 downto 0);
type mem2 is array (7 downto 0) of std_logic_vector (6 downto 0);
constant l: memo:=(			  
0 => "1111111", -- spatiu    primul este dp care il punem pe 1
1 => "0001000", -- A		  --LA ASSIGN PACKAGE PINS SA PUNEM INVERS PIN URILE
2 => "1100000", -- B
3 => "1000110", -- C
4 => "1000010", -- D
5 => "0000110", -- E
6 => "0111000", -- f
7 => "0100000", -- g
8 => "1101000", -- h
9 => "1001111", -- i
10 => "1000011", -- j
11 => "1111000", -- k
12 => "1000111", -- l
13 => "0101010", -- m
14 => "1101010", -- n
15 => "1000000", -- o
16 => "0011000", -- p
17 => "0010000", -- r
18 => "0100100", -- s
19 => "1111010", -- t
20 => "1000001", -- u
21 => "1100011", -- v
22 => "1000000", -- w
23 => "1001000", -- x
24 => "0010010"  -- z	
);
constant cuv: mem:=(
0 =>l(3),	--C
1 =>l(15),	--O
2 =>l(12),	--L
3 =>l(1),	--A
 -- COLA
4 =>l(15),	--O
5 =>l(12),	--L
6 =>l(1),	--A
7 =>l(3),	--C
-- OLAC
8 =>l(12),  --L
9 =>l(1),	--A
10 =>l(3),	--C
11 =>l(15),	--O
-- LACO	
12 =>l(1),	--A
13 =>l(3),	--C
14 =>l(15),	--O
15 =>l(12));--L
-- ACOL
--Dupa care se reia de la 0

constant cuv2: mem:=(
0 =>l(3),	--C
1 =>l(0),	--
2 =>l(0),	--
3 =>l(0),	--
 -- COLA
4 =>l(0),	--
5 =>l(15),	--O
6 =>l(0),	--
7 =>l(0),	--
-- OLAC
8 =>l(0),   --
9 =>l(0),	--
10 =>l(12),	--L
11 =>l(0),	--
-- LACO	
12 =>l(0),	--
13 =>l(0),	--
14 =>l(0),	--
15 =>l(1)); --A

constant cuv3: mem2:=(
0 =>l(3),	--C
1 =>l(15),	--O
2 =>l(12),	--L
3 =>l(1),	--A
 -- COLA
4 =>l(0),	--
5 =>l(0),	--
6 =>l(0),	--
7 =>l(0)
);--
	----
begin --arhitectura
	
animatie: process(clk)	 -- clk legam la B8
variable i: integer :=0;
variable j: integer :=12;
begin
	if clk='1' and clk'event then  -- 
		case anim is	   -- dreapta - stanga
	------------------------------- prima animatie		
			when "10" =>  ---------------------------	MERGE PERFEEECT!!!!!
		if (counter2="1111000000000000") then
		if(AN(0)='0') then
			AN(0)<='1'; 
			segmente<=cuv(i+3);
			AN(3)<='0';
		elsif (AN(3)='0') then 
			AN(3)<='1';
			segmente<=cuv(i+2);   
			AN(2)<='0';
		elsif (an(2)='0') then 
			an(2)<='1';
			segmente<=cuv(i+1);   
			an(1)<='0';
		elsif (an(1)='0') then 
			an(1)<='1';
			segmente<=cuv(i);   
			an(0)<='0';
		end if;	 -- AN
	end if;		 -- count 2
	if (counter2="1111000000000000") then counter2 <= (others =>'0'); end if;
		 counter2 <= counter2 + 1;
		 counter <= counter + 1;
	if(i=16) then i:=0; end if;
	if (counter="10111110101111000010111111") then i:=i+4; counter <= (others =>'0'); end if;
---------------------------------- prima animatie		

---------------------------------- a doua animatie
		when "01" =>  -- stanga - dreapta
		if (counter2="1111000000000000") then
		if(AN(0)='0') then
			AN(0)<='1'; 
			segmente<=cuv(j);
			AN(3)<='0';
		elsif (AN(3)='0') then 
			AN(3)<='1';
			segmente<=cuv(j+1);   
			AN(2)<='0';
		elsif (an(2)='0') then 
			an(2)<='1';
			segmente<=cuv(j+2);   
			an(1)<='0';
		elsif (an(1)='0') then 
			an(1)<='1';
			segmente<=cuv(j+3);   
			an(0)<='0';
		end if;	 -- AN
	end if;		 -- count 2
	if (counter2="1111000000000000") then counter2<="0000000000000000"; end if;
		 counter2 <= counter2 + 1;
		 counter <= counter + 1;
	if(j<0) then i:=15; end if;
	if (counter="10111110101111000010111111") then j:=j-4; counter <= (others =>'0'); end if;
----------------------------------- a doua animatie		

----------------------------------- a treia animatie
		when "11" => -- clipire toate
		 if (counter2="1111000000000000") then
		if(AN(0)='0') then
			AN(0)<='1'; 
			segmente<=cuv3(i);
			AN(3)<='0';
		elsif (AN(3)='0') then 
			AN(3)<='1';
			segmente<=cuv3(i+1);   
			AN(2)<='0';
		elsif (an(2)='0') then 
			an(2)<='1';
			segmente<=cuv3(i+2);   
			an(1)<='0';
		elsif (an(1)='0') then 
			an(1)<='1';
			segmente<=cuv3(i+3);   
			an(0)<='0';
		end if;	 -- AN
	end if;		 -- count 2
	if (counter2="1111000000000000") then counter2 <= (others =>'0'); end if;
		 counter2 <= counter2 + 1;
		 counter <= counter + 1;
	if(i=8) then i:=0; end if;
	if (counter="10111110101111000010111111") then i:=i+4; counter <= (others =>'0'); end if;
----------------------------------- a treia animatie

----------------------------------- a patra animatie

		when "00" =>
 		if (counter2="1111000000000000") then
		if(AN(0)='0') then
			AN(0)<='1'; 
			segmente<=cuv2(i+3);
			AN(3)<='0';
		elsif (AN(3)='0') then 
			AN(3)<='1';
			segmente<=cuv2(i+2);   
			AN(2)<='0';
		elsif (an(2)='0') then 
			an(2)<='1';
			segmente<=cuv2(i+1);   
			an(1)<='0';
		elsif (an(1)='0') then 
			an(1)<='1';
			segmente<=cuv2(i);   
			an(0)<='0';
		end if;	 -- AN
	end if;		 -- count 2
	if (counter2="1111000000000000") then counter2 <= (others =>'0'); end if;
		 counter2 <= counter2 + 1;
		 counter <= counter + 1;
	if(i=16) then i:=0; end if;
	if (counter="10111110101111000010111111") then i:=i+4; counter <= (others =>'0'); end if;
---------------------------------- a patra animatie		
		when others => 
		an <="0000";
		segmente <= l(15);
		
		end case;
	end if; --clk
end process animatie;
end architecture;