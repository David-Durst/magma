from magma import * 
from magma.ir import compile 


def test_print_ir():

    And2 = DeclareCircuit('And2', "I0", In(Bit), "I1", In(Bit), "O", Out(Bit)) 

    AndN2 = DefineCircuit("And2", "I", In(Array2), "O", Out(Bit) ) 
    and2 = And2() 
    wire( AndN2.I[0], and2.I0 ) 
    wire( AndN2.I[1], and2.I1 ) 
    wire( and2.O, AndN2.O ) 
    EndCircuit() 

    main = DefineCircuit("main", "I0", In(Bit), "I1", In(Bit), "O", Out(Bit)) 
    and2 = AndN2() 
    main.O( and2(array(main.I0, main.I1)) ) 
    EndCircuit() 

    result = compile(main)
    assert result == """And2 = DefineCircuit("And2", "I", Array(2,In(Bit)), "O", Out(Bit))  # {filename} 9
inst0 = And2()
wire(And2.I[0], inst0.I0)
wire(And2.I[1], inst0.I1)
wire(inst0.O, And2.O)
EndCircuit()

main = DefineCircuit("main", "I0", In(Bit), "I1", In(Bit), "O", Out(Bit))  # {filename} 16
inst0 = And2()
wire(main.I0, inst0.I[0])
wire(main.I1, inst0.I[1])
wire(inst0.O, main.O)
EndCircuit()

""".format(filename=__file__)
