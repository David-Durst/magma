import magma as m
from magma.testing import check_files_equal


def test_ndarray_basic():
    class Main(m.Circuit):
        io = m.IO(I=m.In(m.Array[(3, 5), m.Bit]),
                  O=m.Out(m.Array[(5, 3), m.Bit]))
        for i in range(3):
            for j in range(5):
                io.O[j, i] @= io.I[i, j]
    m.compile("build/test_ndarray_basic", Main)
    assert check_files_equal(__file__, f"build/test_ndarray_basic.v",
                             f"gold/test_ndarray_basic.v")


def test_ndarray_slicing():
    class Main(m.Circuit):
        io = m.IO(a0=m.Out(m.Array[(4, 5, 3), m.Bit]),
                  a1=m.Out(m.Array[(4, 5, 3), m.Bit]),
                  b=m.In(m.Array[(4, 5, 2), m.Bit]),
                  c=m.In(m.Array[(3, 2), m.Bit]))
        io.a0[0:2] @= io.b
        io.a0[2] @= m.Array[(4, 5), m.Bit]([0 for _ in range(5)])

        io.a1[2, 2:5, 0:2] @= io.c
        io.a1[2, 0:2, 0:2] @= m.Array[(2, 2), m.Bit]([0 for _ in range(2)])
        io.a1[3, :, 0:2] @= m.Array[(5, 2), m.Bit]([0 for _ in range(2)])
        io.a1[0:2, :, 0:2] @= m.Array[(2, 5, 2), m.Bit](
            [m.Array[(2, 5), m.Bit]([0 for _ in range(5)]) for _ in range(2)])
        io.a1[2] @= m.Array[(4, 5), m.Bit]([0 for _ in range(5)])

    m.compile("build/test_ndarray_slicing", Main, inline=True)
    assert check_files_equal(__file__, f"build/test_ndarray_slicing.v",
                             f"gold/test_ndarray_slicing.v")


def test_ndarray_dyanmic_getitem():
    class Main(m.Circuit):
        io = m.IO(rdata=m.Out(m.Array[(2, 3), m.Bit]), raddr=m.In(m.Bits[2]))
        io += m.ClockIO()
        mem = m.Register(m.Array[(2, 3, 4), m.Bit])()
        mem.I @= mem.O
        io.rdata @= mem.O[io.raddr]

    m.compile("build/test_ndarray_dynamic_getitem", Main, inline=True)
    assert check_files_equal(__file__, f"build/test_ndarray_dynamic_getitem.v",
                             f"gold/test_ndarray_dynamic_getitem.v")


def test_ndarray_dyanmic_getitem2():
    class Main(m.Circuit):
        io = m.IO(
            rdata0=m.Out(m.Array[(2, 3), m.Bit]), raddr0=m.In(m.Bits[2]),
            rdata1=m.Out(m.Array[(2, 3), m.Bit]), raddr1=m.In(m.Bits[2])
        )
        io += m.ClockIO()
        mem = m.Register(m.Array[(2, 3, 4, 2), m.Bit])()
        mem.I @= mem.O
        io.rdata0 @= mem.O[io.raddr0, 0]
        io.rdata1 @= mem.O[io.raddr1, 1]

    m.compile("build/test_ndarray_dynamic_getitem2", Main, inline=True)
    assert check_files_equal(__file__, f"build/test_ndarray_dynamic_getitem2.v",
                             f"gold/test_ndarray_dynamic_getitem2.v")
