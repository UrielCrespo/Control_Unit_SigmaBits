library ieee;
use ieee.std_logic_1164.all;

entity divisor is
generic(
    pulsos : integer := 25000000
);
port(
    clk_in  : in  std_logic;
    clk_out : out std_logic
);
end divisor;

architecture behav of divisor is
signal output : std_logic := '0';  -- Se inicializa en '0' para evitar valores indefinidos
begin
    process(clk_in)
        variable cont : integer := 0;
    begin
        if rising_edge(clk_in) then
            cont := cont + 1;
            if cont = pulsos then
                cont := 0;
                output <= not output;  -- Invierte la salida
            end if;  -- Se elimina el else innecesario que mantenía output igual
        end if;
    end process;

    clk_out <= output;
end behav;
