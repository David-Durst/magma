import pytest


@pytest.fixture(autouse=True)
def magma_test():
    """
    Clear the circuit cache before running, allows name reuse across tests
    without collisions
    """
    import magma.circuit
    magma.circuit.__magma_clear_circuit_cache()
    import magma.config
    magma.config.set_compile_dir('callee_file_dir')