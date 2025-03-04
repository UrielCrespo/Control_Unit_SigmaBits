# Control_Unit_SigmaBits
FPGA MAX DE10-LITE
A control unit for a processor, managing states like fetch, decode, execute, memory, and write, with 7-segment displays showing the current state.

Project Description:
This project involves the design and implementation of a Control Unit for a simple processor, developed by Uriel Crespo, Gael Leyva, and Imanol Barrientos. The control unit is responsible for managing the flow of operations through distinct states, including Fetch, Decode, Execute, Memory, and Write, which represent the core stages of the instruction cycle in a processor.

The system is implemented using VHDL (VHSIC Hardware Description Language) and is designed to handle various control signals, such as:

Direction Flag (DirFlag): Indicates when the program counter (PC) should update.

Decoder Wait Flag (DecoWait): Manages delays during the decoding phase.

Jump Flag (Jump): Determines if a branch or jump instruction is executed.

Memory Flag (MemoFlag): Signals memory access requests.

Memory Wait Flag (MemoWait): Handles memory access delays.

Write Flag (WriteFlag): Controls data writing operations.

Start Flags (StartFlags): A 2-bit vector used to manage initialization and reset conditions.

The control unit operates as a Finite State Machine (FSM), transitioning between states based on the input flags and signals. A clock divider is integrated to manage timing and ensure smooth state transitions. The current state of the processor is displayed in real-time using 7-segment displays, which provide a visual representation of the active state (e.g., Fetch, Decode, Execute, etc.).

This project demonstrates key concepts in digital design, computer architecture, and hardware-software co-design, making it an excellent educational tool for understanding the role of control units in processors. It highlights the importance of state management, signal handling, and synchronization in digital systems. The implementation is modular, scalable, and adheres to best practices in hardware description languages.

Developed by Uriel Crespo, Gael Leyva, and Imanol Barrientos, this project showcases their expertise in VHDL programming, state machine design, and processor control logic. It serves as a practical example of how theoretical concepts in computer architecture are applied to real-world hardware design.
