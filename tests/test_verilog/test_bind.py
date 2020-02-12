import os
import magma as m
import magma.testing
from rtl import RTL
import rtl_monitor


def test_bind():
    RTL4 = RTL.generate(4)

    m.compile("build/bind_test", RTL4)
    assert m.testing.check_files_equal(__file__,
                                       f"build/bind_test.v",
                                       f"gold/bind_test.v")

    monitor_file = os.path.join(os.path.dirname(__file__), "build",
                                "Monitor.sv")
    if os.path.exists(monitor_file):
        os.remove(monitor_file)
    assert m.testing.check_files_equal(__file__,
                                       f"build/RTLMonitor.sv",
                                       f"gold/RTLMonitor.sv")