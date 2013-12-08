require 'rubifrost'

python = RuBifrost.python
NumPy = python.import 'numpy'

ary = NumPy.array [1,2,3,4,5]
p NumPy.mean(ary)

NetworkX = python.import 'networkx'

graph = NetworkX.Graph()
graph.add_edge(1, 2)
graph.add_edge(1, 3)
graph.add_edge(2, 3)
graph.add_edge(5, 6)
graph.add_edge(6, 7)

p NetworkX.connected_components(graph)
