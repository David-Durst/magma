import abc
import magma as m  # TODO(rsetaluri): Remove package import.
from magma.t import Direction, Type


class MagmaProtocolMeta(type):
    @abc.abstractmethod
    def _to_magma_(cls):
        # To retrieve underlying magma type.
        raise NotImplementedError()

    @abc.abstractmethod
    def _qualify_magma_(cls, direction: Direction):
        # To qualify underlying type (e.g. give me a Foo with the underlying
        # type qualified to be an input).
        raise NotImplementedError()

    @abc.abstractmethod
    def _flip_magma_(cls):
        # To flip underlying type (e.g. give me a Foo with the underlying type
        # flipped).
        raise NotImplementedError()

    def qualify(cls, direction: Direction):
        return cls._qualify_magma_(direction)

    @abc.abstractmethod
    def _from_magma_value_(cls, val: Type):
        # To create an instance from a value.
        raise NotImplementedError()

    def flip(cls):
        return cls._flip_magma_()


class MagmaProtocol(metaclass=MagmaProtocolMeta):
    @abc.abstractmethod
    def _get_magma_value_(self):
        # To access underlying magma value.
        raise NotImplementedError()

    @classmethod
    def is_input(cls):
        return cls._to_magma_().is_input()

    @classmethod
    def is_mixed(cls):
        return cls._to_magma_().is_mixed()

    @classmethod
    def is_output(cls):
        return cls._to_magma_().is_output()

    def value(self):
        return self._get_magma_value_().value()

    def trace(self):
        return self._get_magma_value_().trace()

    def driven(self):
        return self._get_magma_value_().driven()

    def flatten(self):
        return self._get_magma_value_().flatten()

    @property
    def name(self):
        return self._get_magma_value_().name

    def __imatmul__(self, other):
        m.wire(other, self._get_magma_value_())
