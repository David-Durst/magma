import functools
import ast
import inspect
import textwrap
from collections import OrderedDict
from magma.logging import warning, debug
import astor


class CircuitDefinitionSyntaxError(Exception):
    pass


def get_ast(obj):
    indented_program_txt = inspect.getsource(obj)
    program_txt = textwrap.dedent(indented_program_txt)
    return ast.parse(program_txt)


class IfTransformer(ast.NodeTransformer):
    def flatten(self, _list):
        """1-deep flatten"""
        flat_list = []
        for item in _list:
            if isinstance(item, list):
                flat_list.extend(item)
            else:
                flat_list.append(item)
        return flat_list

    def visit_If(self, node):
        # Flatten in case there's a nest If statement that returns a list
        node.body = self.flatten(map(self.visit, node.body))
        if not hasattr(node, "orelse"):
            raise NotImplementedError("If without else")
        node.orelse = self.flatten(map(self.visit, node.orelse))
        seen = OrderedDict()
        for stmt in node.body:
            if not isinstance(stmt, ast.Assign):
                # TODO: Print info from original source file/line
                raise CircuitDefinitionSyntaxError(
                    f"Expected only assignment statements in if statement, got"
                    f" {type(stmt)}")
            if len(stmt.targets) > 1:
                raise NotImplementedError("Assigning more than one value")
            key = ast.dump(stmt.targets[0])
            if key in seen:
                # TODO: Print the line number
                warning("Assigning to value twice inside `if` block,"
                        " taking the last value (first value is ignored)")
            seen[key] = stmt
        orelse_seen = set()
        for stmt in node.orelse:
            key = ast.dump(stmt.targets[0])
            if key in seen:
                if key in orelse_seen:
                    warning("Assigning to value twice inside `else` block,"
                            " taking the last value (first value is ignored)")
                orelse_seen.add(key)
                seen[key].value = ast.Call(
                    ast.Name("mux", ast.Load()),
                    [ast.List([seen[key].value, stmt.value],
                              ast.Load()), node.test],
                    [])
            else:
                raise NotImplementedError("Assigning to a variable once in"
                                          " `else` block (not in then block)")
        return [node for node in seen.values()]

    def visit_IfExp(self, node):
        if not hasattr(node, "orelse"):
            raise NotImplementedError("If without else")
        node.body = self.visit(node.body)
        node.orelse = self.visit(node.orelse)
        return ast.Call(
            ast.Name("mux", ast.Load()),
            [ast.List([node.body, node.orelse],
                      ast.Load()), node.test],
            [])


def combinational(fn):
    stack = inspect.stack()
    defn_locals = stack[1].frame.f_locals
    defn_globals = stack[1].frame.f_globals
    tree = get_ast(fn)
    tree = IfTransformer().visit(tree)
    tree = ast.fix_missing_locations(tree)
    # TODO: Only remove @m.circuit.combinational, there could be others
    tree.body[0].decorator_list = []
    debug(astor.to_source(tree))
    exec(compile(tree, filename="<ast>", mode="exec"), defn_globals,
         defn_locals)

    fn = defn_locals[fn.__name__]

    @classmethod
    @functools.wraps(fn)
    def wrapped(io):
        return fn(io)

    return wrapped
