----------------------------------------------------------------------------------
-- Company: 		ITESM Campus CCM
-- Engineer: 		Sigma Bits
-- 
-- Create Date:    04/03/2025 
-- Design Name: 
-- Module Name:    ControlUnit 
-- Project Name: 	 Control Unit
-- Target Devices: MAX DE10-LITE FPGA BOARD
-- Tool versions:  Quartus Prime Lite 23.1
-- Description: 	 Segundo avance de Reto

-- Dependencies: 
--
-- Revision: 		
-- Additional Comments: 
--
----------------------------------------------------------------------------------

-- Library and package declaration--
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Evidencia_Reto2_SigmaBits IS
    PORT(
        CLK : IN STD_LOGIC;
        BANDERA_DIRECCION : IN STD_LOGIC;
        BANDERA_ESPERA_DECODIFICADOR : IN STD_LOGIC;
        BANDERAS_INICIO : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        BANDERA_ESCRITURA : IN STD_LOGIC;
        BANDERA_MEMORIA : IN STD_LOGIC;
        BANDERA_DE_ESPERA_MEMORIA : IN STD_LOGIC;
        SALTO : IN STD_LOGIC;
        
        HEX5 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
        HEX4 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
        HEX3 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
        HEX2 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
        HEX1 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
        HEX0 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0)   
    );
END Evidencia_Reto2_SigmaBits;


ARCHITECTURE BEHAV OF Evidencia_Reto2_SigmaBits IS
---------------------------------------------------------------
-------------------Frequency Divider -------------------------- 
    COMPONENT divisor
        PORT(
            clk_in : IN STD_LOGIC;
            clk_out : OUT STD_LOGIC
        );
    END COMPONENT;
	 
---------------------------------------------------------------
---------------------------------------------------------------

   -- State name declaration as binary state
    TYPE STATE_TYPE IS (INICIO, FETCH, DECODIFICACION, EJECUCION, MEMORIA, ESCRITURA);
    
	--	Signals used in FSM 
	 SIGNAL ESTADO : STATE_TYPE := INICIO;

	-- Signals used in frequency divider  
    SIGNAL CLKOUT : STD_LOGIC; 	

BEGIN

    U0: divisor PORT MAP (CLK, CLKOUT);

	 -----------------Begin Moore State Machine --------------------

    PROCESS(CLKOUT)
    BEGIN
        IF (FALLING_EDGE(CLKOUT)) THEN
            CASE ESTADO IS
                WHEN INICIO =>
                    ESTADO <= FETCH;
                    
                WHEN FETCH =>
                    IF (BANDERA_DIRECCION = '1') THEN
                        ESTADO <= DECODIFICACION;
                    ELSE
                        ESTADO <= FETCH;
                    END IF;
                    
                WHEN DECODIFICACION =>
                    IF (SALTO = '1') THEN
                        IF (BANDERAS_INICIO /= "11") THEN 
                            IF (BANDERA_ESPERA_DECODIFICADOR = '1') THEN
                                ESTADO <= DECODIFICACION;
                            ELSE
                                ESTADO <= FETCH;
                            END IF;
                        ELSE
                            ESTADO <= INICIO;
                        END IF;
                    ELSE
                        ESTADO <= EJECUCION;
                    END IF;
                    
                WHEN EJECUCION =>
                    IF (BANDERA_MEMORIA = '1') THEN
                        IF (BANDERA_DE_ESPERA_MEMORIA = '1') THEN
                            ESTADO <= MEMORIA;
                        ELSE
                            IF (BANDERAS_INICIO = "11") THEN
                                ESTADO <= INICIO;
                            ELSIF (BANDERA_ESCRITURA = '1') THEN
                                ESTADO <= ESCRITURA;
                            ELSE
                                ESTADO <= FETCH;
                            END IF;
                        END IF;
                    ELSE
                        ESTADO <= ESCRITURA;
                    END IF;
                    
                WHEN MEMORIA =>
                    IF (BANDERA_ESCRITURA = '1') THEN
                        ESTADO <= ESCRITURA;
                    ELSE
                        IF (BANDERA_DE_ESPERA_MEMORIA = '1') THEN
                            ESTADO <= MEMORIA;
                        ELSE
                            IF (BANDERAS_INICIO = "11") THEN
                                ESTADO <= INICIO;
                            ELSE
                                ESTADO <= FETCH;
                            END IF;
                        END IF;
                    END IF;	
                    
                WHEN ESCRITURA =>
                    IF (BANDERAS_INICIO = "11") THEN
                        ESTADO <= INICIO;
                    ELSE
                        ESTADO <= FETCH;
                    END IF;
                
                WHEN OTHERS =>
                    ESTADO <= INICIO;
            END CASE;		
        END IF;
    END PROCESS;
    
	 -- Output logic definition of Moore State Machine, 6 displays 7 seg

    PROCESS(ESTADO)
    BEGIN
        CASE ESTADO IS
            WHEN INICIO =>
                HEX5 <= "1001111";  -- I
                HEX4 <= "1001000";  -- N
                HEX3 <= "1001111";  -- I
                HEX2 <= "1000110";  -- C
                HEX1 <= "1001111";  -- I
                HEX0 <= "1000000";  -- O
                
            WHEN FETCH =>
                HEX5 <= "0001110";  -- F
                HEX4 <= "0000110";  -- E
                HEX3 <= "1111000";  -- T
                HEX2 <= "1000110";  -- C
                HEX1 <= "0001001";  -- H
                HEX0 <= "1111111";  -- off
                
            WHEN DECODIFICACION =>
                HEX5 <= "0100001";  -- D
                HEX4 <= "0000110";  -- E
                HEX3 <= "1000110";  -- C
                HEX2 <= "1000000";  -- O
                HEX1 <= "1111111";  -- off
                HEX0 <= "1111111";  -- off
                
            WHEN EJECUCION =>
                HEX5 <= "0000110";  -- E
                HEX4 <= "1110001";  -- J
                HEX3 <= "0000110";  -- E
                HEX2 <= "1000110";  -- C
                HEX1 <= "1111111";  -- off
                HEX0 <= "1111111";  -- off
                
            WHEN MEMORIA =>
                HEX5 <= "1001100";  -- M
                HEX4 <= "1011000";  -- M
                HEX3 <= "0000110";  -- E
                HEX2 <= "1001100";  -- M
                HEX1 <= "1011000";  -- M
                HEX0 <= "1000000";  -- O
                
            WHEN ESCRITURA =>
                HEX5 <= "1000011";  -- W
                HEX4 <= "1100001";  -- W
                HEX3 <= "1001110";  -- R
                HEX2 <= "1001111";  -- I
                HEX1 <= "1111000";  -- T
                HEX0 <= "0000110";  -- E
                
            WHEN OTHERS =>
                -- off
                HEX5 <= "1111111";
                HEX4 <= "1111111";
                HEX3 <= "1111111";
                HEX2 <= "1111111";
                HEX1 <= "1111111";
                HEX0 <= "1111111";
        END CASE;
    END PROCESS;

END BEHAV;