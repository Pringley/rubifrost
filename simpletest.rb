require 'rubifrost'

# Establish connection to a Python bifrost server.
python = RuBifrost.python

# Importing a module returns a module proxy.
NumPy = python.import 'numpy'

# The module proxy has access to all of its methods.
p NumPy.mean([1,2,3,4,5])
# => 3.0

# Methods that return objects (such as networkx.Graph) instead return object
# proxies, which in turn have all the methods of the object.
NetworkX = python.import 'networkx'
graph = NetworkX.Graph()
graph.add_edges_from([
  [1, 2], [1, 3], [2, 3],
  [5, 6], [5, 8], [6, 7]
])

# Object proxies can also be used as arguments for other methods. In addition,
# complicated nested objects can be returned as results.
p NetworkX.connected_components(graph)
# => [[8, 5, 6, 7], [1, 2, 3]]
