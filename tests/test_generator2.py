import magma as m
from magma.testing import check_files_equal


class _MyMux(m.Generator2):
    cls_level_var = "I like being a mux"

    def __init__(self, width, height):
        self.width = width
        self.height = height
        sel_bits = m.math.log2_ceil(height)
        self.name = f"MyMux{width}x{height}"
        args = {f"I{i}": m.In(m.Bits[width]) for i in range(height)}
        args["O"] = m.Out(m.Bits[width])
        args["S"] = m.In(m.Bits[sel_bits])
        self.io = m.IO(**args)

    def to_string(self):
        return f"{_MyMux.cls_level_var} of {self.width}x{self.height}"


def test_type_relations():
    assert issubclass(_MyMux, m.Generator2)
    assert issubclass(_MyMux, m.DefineCircuitKind)
    MyMux4x4 = _MyMux(4, 4)  # circuit defn.
    assert isinstance(MyMux4x4, m.DefineCircuitKind)
    assert isinstance(MyMux4x4, _MyMux)
    assert issubclass(MyMux4x4, m.Circuit)

    insts = []

    class _(m.Circuit):
        mux = MyMux4x4()
        insts.append(mux)

    mux = insts[0]
    assert isinstance(mux, MyMux4x4)
    assert isinstance(mux, m.Circuit)


def test_properties():
    MyMux4x4 = _MyMux(4, 4)
    assert MyMux4x4.name == "MyMux4x4"
    assert MyMux4x4.width == 4
    assert MyMux4x4.height == 4
    assert MyMux4x4.to_string() == "I like being a mux of 4x4"


def test_compilation():

    class _Top(m.Circuit):
        io = m.IO(x=m.In(m.Bit), y=m.In(m.Bit), z=m.Out(m.Bit))
        mux = _MyMux(1, 2)()
        mux.I0[0] @= io.x
        mux.I1[0] @= io.y
        mux.S @= 0
        io.z @= mux.O[0]

    m.compile("build/TopGen", _Top, output="coreir")
    assert check_files_equal(__file__, "build/TopGen.json", "gold/TopGen.json")
