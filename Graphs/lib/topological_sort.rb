require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  sorted = []
  top = []
  vertices.each do |vertex|
    if vertex.in_edges.empty?
      top << vertex
    end
  end
  until top.empty?
    current = top.shift
    sorted << current
    edges = current.out_edges.dup
    edges.each do |edge|
      if edge.to_vertex.in_edges.length == 1
        top << edge.to_vertex
      end
      edge.destroy!
    end
  end
  sorted
end
