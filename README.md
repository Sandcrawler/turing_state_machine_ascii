# turing_state_machine_ascii

Basic shell Turing state machine that outputs ascii characters as the array (rather than 0 or 1).

Line 50 allows 6X and 7X which is converted back to ascii with xxd in line 202.

Random card sets are generated to input. The last generated card set is output to ./tmp.card (in case a good one is found).

Added:

Python Turning State Machine that outputs ascii chacters as the array. 

No random generation in this one, a specific halting instruction set has been loaded (one found from randomly running the above bash script).

Run with: python3 pturing_ascii.py
