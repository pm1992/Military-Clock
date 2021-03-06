LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY Part_I_New IS
  PORT (
w  :in std_logic ;
clock :in std_logic ;
reset  :in std_logic ;
z  :out std_logic ;
led: out std_logic_vector(2 downto 0)
);
END Part_I_New;
ARCHITECTURE Behavior OF Part_I_New IS
  TYPE State_type IS (Normal, Slow10x, Slow100x, Fast60x, Fast200x);
  SIGNAL present_state, next_state : State_type; -- y_Q is present state, y_D is next state
BEGIN
 
  PROCESS (w, present_state) -- state table
  BEGIN
       case present_state IS     
			 WHEN Normal =>  --Normal
			if (w='0') then next_state<=Slow10x;
				else next_state<=Fast60x;
				end if;
             WHEN Slow10x =>  --Slow 10x
			if (w='0') then next_state<=Slow100x;
				else next_state<=Normal;
				end if;
             WHEN Slow100x =>  --Slow 100x
			if (w='0') then next_state<=Slow100x;
				else next_state<=Slow10x;
				end if;			
			 WHEN Fast60x => --Fast 60x
			if (w='1') then next_state<=Fast200x;  
				else next_state<=Normal;
				end if;           
			 WHEN Fast200x =>  --Fast 200x
			if (w='1') then next_state<=Fast200x;
				else next_state<=Fast60x;
				end if;  
			 
			
	
       END CASE;
  END PROCESS; 

  PROCESS (Clock) 
  begin
  IF(reset = '0') then
	  if (rising_edge(clock)) then
	  present_state<=next_State;
		end if;
else 
  present_state<=Normal;
  end if;
  
  END PROCESS;
  
  Process (present_state) --define state outputs here.
begin

	case present_state is 
		WHEN Normal => z<='0'; --Normal
				led<="010";  
		WHEN Slow10x => z<='0';  --Slow 10x
				led<="001";
		WHEN Slow100x => z<='0';   --Slow 100x
				led<="000";
		WHEN Fast60x => z<='0';  --Fast 60x
				led<="011";
		WHEN Fast200x => z<='1'; --Fast 200x
				led<="100";
		
				
		end case;
		
		end process;

  
END Behavior;
