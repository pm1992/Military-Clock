LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY mod_ten_four IS
  PORT (
w		: in  std_logic;
clock	: in std_logic;
reset	: in std_logic;
enable  : in std_logic;
z		: out std_logic_vector(3 downto 0)
);
END mod_ten_four;
ARCHITECTURE Behavior OF mod_ten_four IS
  TYPE State_type IS (A, B, C, D, E, F, G, H, I, J);
  SIGNAL present_state, next_state : State_type; -- y_Q is present state, y_D is next state
BEGIN
 
  PROCESS (w, present_state) -- state table
  BEGIN
       case present_state IS     
		 WHEN A => 
			if (w = '0') then next_state <= B;
			else  next_state <= B;
			end if;
         WHEN B =>  
			if (w = '0') then next_state <= C;
			else  next_state <= C;
			end if;
         WHEN C =>  
			if (w = '0') then next_state <= D;
			else  next_state <= D;
			end if;
		 WHEN D => 
			if (w = '0') then next_state <= E;
			else  next_state <= A;
			end if;
		 WHEN E =>  
			if (w = '0') then next_state <= F;
			--else  next_state <= E;
			end if;
		
		WHEN F =>  
			if (w = '0') then next_state <= G;
			--else  next_state <= E;
			end if;
			
			WHEN G =>  
			if (w = '0') then next_state <= H;
			--else  next_state <= E;
			end if;
			
			WHEN H =>  
			if (w = '0') then next_state <= I;
			--else  next_state <= E;
			end if;
			
			WHEN I =>  
			if (w = '0') then next_state <= J;
			--else  next_state <= E;
			end if;
			
			WHEN J =>  
			if (w = '0') then next_state <= A;
			--else  next_state <= E;
			end if;
       END CASE;
  END PROCESS; 

  PROCESS (Clock) 
  begin
if (rising_edge(clock) and reset='0' and enable = '1') then
	present_state <= next_state;
	end if;
		
	if ( reset = '1') then	
	if (rising_edge(clock) and enable = '1') then
	present_state <= A;
	end if;
	
	else 
    present_state <= next_state;
    end if;
  END PROCESS;
  
  Process (present_state) --define
  begin
  Case present_state is
	WHEN A => z <= "0000";
		
	WHEN B => z <= "0001";
		
	WHEN C => z <= "0010";
		
	WHEN D => z <= "0011";
		
	WHEN E => z <= "0100";
	
	WHEN F => z <= "0101";
	
	WHEN G => z <= "0110";
	
	WHEN H => z <= "0111";
	
	WHEN I => z <= "1001";
	
	WHEN J => z <= "1010";
	
		
	
	end case;
	end process;
  
END Behavior;
