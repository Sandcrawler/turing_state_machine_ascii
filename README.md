# turing_state_machine_ascii

Basic shell Turing state machine that outputs ascii characters as the array (rather than 0 or 1).

Line 50 allows 6X and 7X which is converted back to ascii with xxd in line 202.

Random card sets are generated to input. The last generated card set is output to ./tmp.card (in case a good one is found).
