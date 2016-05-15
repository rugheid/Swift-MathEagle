//
//  Graph.swift
//  MathEagle
//
//  Created by Rugen Heidbuchel on 05/05/16.
//  Copyright © 2016 Jorestha Solutions. All rights reserved.
//

/**
 A class representing a weighted graph.
 The edges can be unidirectional.
 The edges can have weights and capacities.
 */
public class Graph <VertexNameType: protocol<Equatable, Hashable>, EdgeWeightType: protocol<IntegerLiteralConvertible, Addable, Comparable>, EdgeCapacityType: protocol<IntegerLiteralConvertible>> {
    
    public typealias Edge = GraphEdge<VertexNameType, EdgeWeightType, EdgeCapacityType>
    public typealias EdgeProperties = GraphEdgeProperties<EdgeWeightType, EdgeCapacityType>
    public typealias VerticesGenerator = GraphVerticesGenerator<VertexNameType, EdgeWeightType, EdgeCapacityType>
    public typealias EdgesGenerator = GraphEdgesGenerator<VertexNameType, EdgeWeightType, EdgeCapacityType>
    
    
    // MARK: Internal Properties
    
    /**
     An adjacency list to store the edges of the graph.
     */
    private var adjacencyList: [VertexNameType: [VertexNameType: EdgeProperties]]
    
    
    // MARK: Initialisers
    
    public init() {
        adjacencyList = [:]
    }
    
    
    // MARK: Vertex Management
    
    /**
     Returns an array containg all vertices in the graph.
     
     This method should not be used to iterate over the vertices of the graph.
     */
    public var vertices: [VertexNameType] {
        var vert = [VertexNameType]()
        for vertex in adjacencyList.keys {
            vert.append(vertex)
        }
        return vert
    }
    
    /**
     Returns a generator that generates the vertices of the graph.
     
     This method should be used if you want to iterate over the vertices of the graph, because otherwise
     the entire vertices array will be stored in memory.
     */
    public func generateVertices() -> VerticesGenerator {
        return VerticesGenerator(adjacencyListGenerator: self.adjacencyList.generate())
    }
    
    /**
     Returns any vertex of the graph, or nil if the graph does not contain any vertices.
     */
    public func anyVertex() -> VertexNameType? {
        return self.adjacencyList.keys.first
    }
    
    /**
     Returns the number of vertices the graph contains.
     */
    public var numberOfVertices: Int {
        return adjacencyList.count
    }
    
    /**
     Adds the given vertex to the graph.
     If the vertex already exists, nothing happens.
     
     - parameter name: The name of the vertex.
     */
    public func addVertex(name: VertexNameType) {
        if adjacencyList[name] != nil {
            return
        }
        adjacencyList[name] = [:]
    }
    
    /**
     Removes the given vertex.
     All edges from and to this vertex are removed.
     If it doesn't exist, nothing happens.
     
     - parameter name: The name of the vertex.
     */
    public func removeVertex(name: VertexNameType) {
        adjacencyList.removeValueForKey(name)
        for vertex in generateVertices() {
            removeEdge(fromVertex: vertex, toVertex: name)
        }
    }
    
    /**
     Returns whether the graph contains the given vertex.
     
     - parameter name: The name of the vertex.
     */
    public func containsVertex(name: VertexNameType) -> Bool {
        return adjacencyList[name] != nil
    }
    
    /**
     Returns the degree of the given vertex. This is the number
     of edges leaving from the given vertex. If the given vertex
     does not exist, 0 is returned.
     
     - parameter name: The name of the vertex.
     */
    public func degreeOfVertex(name: VertexNameType) -> Int {
        return adjacencyList[name]?.count ?? 0
    }
    
    /**
     Returns the number of vertices with odd degree.
     */
    public var numberOfVerticesWithOddDegree: Int {
        var count = 0
        for vertex in self.generateVertices() {
            if degreeOfVertex(vertex) % 2 != 0 {
                count += 1
            }
        }
        return count
    }
    
    
    // MARK: Edge Management
    
    /**
     Returns a list of all edges in the graph. The edges are unidirectional.
     */
    public var edges: [Edge] {
        var edgesList = [Edge]()
        for from in self.generateVertices() {
            for to in self.generateVertices() {
                if let properties = getEdge(fromVertex: from, toVertex: to) {
                    edgesList.append(Edge(fromVertex: from, toVertex: to, properties: properties))
                }
            }
        }
        return edgesList
    }
    
    /**
     Returns a generator that generates the edges of the graph.
     
     This should be used to iterate over the edges of the graph. If you
     would use `edges`, the entire edges array would be constructed first.
     */
    public func generateEdges() -> EdgesGenerator {
        return EdgesGenerator(graph: self,
                              firstVerticesGenerator: generateVertices())
    }
    
    /**
     Adds the given unidirectional edge to the graph.
     If the from or to vertices do not exist, they are added.
     
     - parameter edge: The edge containing the weight and capacity of the edge.
     - parameter from: The vertex the edge is coming from.
     - parameter to:   The vertex the edge is going to.
     */
    public func addUnidirectionalEdge(edge: EdgeProperties, fromVertex from: VertexNameType, toVertex to: VertexNameType) {
        self.addVertex(from)
        self.addVertex(to)
        adjacencyList[from]![to] = edge
    }
    
    /**
     Adds the given unidirectional edge to the graph.
     If the from or to vertices do not exist, they are added.
     
     - parameter weight:   The weight of the edge.
     - parameter capacity: The capacity of the edge.
     - parameter from:     The vertex the edge is coming from.
     - parameter to:       The vertex the edge is going to.
     */
    public func addUnidirectionalEdge(weight: EdgeWeightType = 1, capacity: EdgeCapacityType = 1, fromVertex from: VertexNameType, toVertex to: VertexNameType) {
        let edge = EdgeProperties(weight: weight, capacity: capacity)
        self.addUnidirectionalEdge(edge, fromVertex: from, toVertex: to)
    }
    
    /**
     Adds the given unidirectional edge to the graph.
     If the from or to vertices do not exist, they are added.
     
     - parameter edge: The edge containing the weight and capacity of the edge.
     - parameter from: The vertex the edge is coming from.
     - parameter to:   The vertex the edge is going to.
     */
    public func addBidirectionalEdge(edge: EdgeProperties, fromVertex from: VertexNameType, toVertex to: VertexNameType) {
        addUnidirectionalEdge(edge, fromVertex: from, toVertex: to)
        addUnidirectionalEdge(edge, fromVertex: to, toVertex: from)
    }
    
    /**
     Adds the given unidirectional edge to the graph.
     If the from or to vertices do not exist, they are added.
     
     - parameter weight:   The weight of the edge.
     - parameter capacity: The capacity of the edge.
     - parameter from:     The vertex the edge is coming from.
     - parameter to:       The vertex the edge is going to.
     */
    public func addBidirectionalEdge(weight: EdgeWeightType = 1, capacity: EdgeCapacityType = 1, fromVertex from: VertexNameType, toVertex to: VertexNameType) {
        let edge = EdgeProperties(weight: weight, capacity: capacity)
        addBidirectionalEdge(edge, fromVertex: from, toVertex: to)
    }
    
    /**
     Removes the edge between the two given vertices and returns it.
     If the given edge doesn't exist, nil is returned.
     
     - parameter from: The vertex the edge is coming from.
     - parameter to:   The vertex the edge is going to.
     */
    public func removeEdge(fromVertex from: VertexNameType, toVertex to: VertexNameType) -> EdgeProperties? {
        return adjacencyList[from]?.removeValueForKey(to)
    }
    
    /**
     Removes both edges between the two given vertices and returns it.
     If only one edge exists, that edge is returned.
     If the given edge doesn't exist, nil is returned.
     
     - parameter from: The first vertex.
     - parameter to:   The second vertex.
     */
    public func removeBidirectionalEdge(fromVertex from: VertexNameType, toVertex to: VertexNameType) -> EdgeProperties? {
        let firstEdge = removeEdge(fromVertex: from, toVertex: to)
        let secondEdge = removeEdge(fromVertex: to, toVertex: from)
        return firstEdge ?? secondEdge
    }
    
    /**
     Get the edge between the two given vertices.
     
     - parameter from: The vertex the edge is coming from.
     - parameter to:   The vertex the edge is going to.
     
     - returns: The edge between the two given vertices, or nil if it doesn't exist.
     */
    public func getEdge(fromVertex from: VertexNameType, toVertex to: VertexNameType) -> EdgeProperties? {
        return adjacencyList[from]?[to]
    }
    
    /**
     Returns the weight of the edge between the two given vertices.
     
     - parameter from: The vertex the edge is coming from.
     - parameter to:   The vertex the edge is going to.
     */
    public func getEdgeWeight(fromVertex from: VertexNameType, toVertex to: VertexNameType) -> EdgeWeightType {
        return getEdge(fromVertex: from, toVertex: to)?.weight ?? 0
    }
    
    /**
     Returns the capacity of the edge between the two given vertices.
     
     - parameter from: The vertex the edge is coming from.
     - parameter to:   The vertex the edge is going to.
     */
    public func getEdgeCapacity(fromVertex from: VertexNameType, toVertex to: VertexNameType) -> EdgeCapacityType {
        return getEdge(fromVertex: from, toVertex: to)?.capacity ?? 0
    }
    
    /**
     Returns the edges starting from a given vertex.
     
     - parameter from: The vertex to start from.
     
     - returns: A dictionary where the keys are the to vertices.
     */
    public func getEdges(fromVertex from: VertexNameType) -> [VertexNameType: EdgeProperties] {
        var edges = [VertexNameType: EdgeProperties]()
        for to in self.generateVertices() {
            if let edge = getEdge(fromVertex: from, toVertex: to) {
                edges[to] = edge
            }
        }
        return edges
    }
    
    /**
     Returns whether the graph contains an edge between the two given vertices.
     
     - parameter from: The vertex the edge is coming from.
     - parameter to:   The vertex the edge is going to.
     */
    public func containsEdge(fromVertex from: VertexNameType, toVertex to: VertexNameType) -> Bool {
        return adjacencyList[from]?[to] != nil
    }
    
    /**
     Returns whether the graph contains a bidirectional edge between the two given vertices.
     
     - parameter from: The first vertex.
     - parameter to:   The second vertex.
     */
    public func containsBidirectionalEdge(fromVertex from: VertexNameType, toVertex to: VertexNameType) -> Bool {
        return containsEdge(fromVertex: from, toVertex: to) && containsEdge(fromVertex: to, toVertex: from)
    }
    
    /**
     Returns the number of edges. Bidirectional edges are counted once.
     If you want bidirectional edges counted twice, use `numberOfEdges(countBidirectionalEdgesTwice:)`.
     */
    public var numberOfEdges: Int {
        return numberOfEdges()
    }
    
    /**
     Returns the number of edges.
     
     - parameter countTwice: Determines whether bidirectional edges should be counted twice.
     */
    public func numberOfEdges(countBidirectionalEdgesTwice countTwice: Bool = false) -> Int {
        var count = 0
        if countTwice {
            for vertex in self.generateVertices() {
                count += adjacencyList[vertex]!.count
            }
        } else {
            var done = [VertexNameType: Set<VertexNameType>]()
            for vertex in self.generateVertices() {
                done[vertex] = []
            }
            for vertex in self.generateVertices() {
                for (to, _) in adjacencyList[vertex]! {
                    if !done[to]!.contains(vertex) {
                        done[vertex]!.insert(to)
                        count += 1
                    }
                }
            }
        }
        return count
    }
    
    
    // MARK: Shortest Path
    
    public typealias ShortestPathResult = GraphShortestPathResult<VertexNameType, EdgeWeightType>
    public typealias MinDistance = GraphMinDistance<VertexNameType, EdgeWeightType>
    
    /**
     Returns the shortest path between the two given nodes, or nil if no path exists.
     This uses Dijkstra's algorithm. Note that it can't handle negative edge weights.
     
     - parameter from: The source vertex.
     - parameter to:   The destination vertex.
     
     - complexity: O(E + V*log(V))
     */
    public func dijkstra(fromVertex from: VertexNameType, toVertex to: VertexNameType) -> ShortestPathResult? {
        
        var minimumDistances = [VertexNameType: MinDistance]()
        for vertex in self.generateVertices() {
            minimumDistances[vertex] = MinDistance()
        }
        minimumDistances[from] = MinDistance(vertex: from, distance: 0)
        
        var activeVertices = Set<VertexNameType>()
        activeVertices.insert(from)
        
        while !activeVertices.isEmpty {
            
            let vertex = activeVertices.first!
            
            if vertex == to {
                
                var nextVertex = minimumDistances[to]!.vertex!
                var path = [to, nextVertex]
                
                while nextVertex != from {
                    nextVertex = minimumDistances[nextVertex]!.vertex!
                    path.append(nextVertex)
                }
                
                path = path.reverse()
                
                return ShortestPathResult(path: path, totalDistance: minimumDistances[to]!.distance!)
            }
            
            activeVertices.removeFirst()
            
            for edgeVertex in self.generateVertices() {
                
                guard let edge = getEdge(fromVertex: vertex, toVertex: edgeVertex) else {
                    continue
                }
                
                if minimumDistances[edgeVertex]!.distance == nil || (minimumDistances[edgeVertex]!.distance! > minimumDistances[vertex]!.distance! + edge.weight) {
                    
                    minimumDistances[edgeVertex] = MinDistance(
                        vertex: vertex,
                        distance: minimumDistances[vertex]!.distance! + edge.weight)
                    activeVertices.insert(edgeVertex)
                }
            }
        }
        
        return nil
    }
    
    /**
     Calculates the minimal distances to all vertices using the Bellman-Ford algorithm.
     Note that Bellman-Ford can handle negative weights, but not negative cycles.
     
     - parameter from: The vertex to calculate the distances from.
     
     - throws: Throws a `GraphError.NegativeCycle` error when the graph contains a negative cycle.
     
     - returns: Returns a dictionary mapping every vertex to it's minimal distance.
     
     - complexity: O(VE)
     */
    public func bellmanFord(fromVertex from: VertexNameType) throws -> [VertexNameType: MinDistance] {
        
        var minimumDistances = [VertexNameType: MinDistance]()
        for vertex in self.generateVertices() {
            minimumDistances[vertex] = MinDistance()
        }
        minimumDistances[from] = MinDistance(vertex: from, distance: 0)
        
        for _ in 1 ..< numberOfVertices {
            for edge in self.edges {
                guard let minDistanceBegin = minimumDistances[edge.fromVertex]!.distance else {
                    continue
                }
                let minDistanceEnd = minimumDistances[edge.toVertex]!.distance
                if minDistanceEnd == nil || (minDistanceEnd! > minDistanceBegin + edge.weight) {
                    minimumDistances[edge.toVertex] = MinDistance(
                        vertex: edge.fromVertex,
                        distance: minDistanceBegin + edge.weight)
                }
            }
//            for beginVertex in self.generateVertices() {
//                for endVertex in self.generateVertices() {
//                    if let edge = getEdge(fromVertex: beginVertex, toVertex: endVertex) {
//                        guard let minDistanceBegin = minimumDistances[beginVertex]!.distance else {
//                            continue
//                        }
//                        let minDistanceEnd = minimumDistances[endVertex]!.distance
//                        if minDistanceEnd == nil || (minDistanceEnd! > minDistanceBegin + edge.weight) {
//                            minimumDistances[endVertex] = MinDistance(
//                                vertex: beginVertex,
//                                distance: minDistanceBegin + edge.weight)
//                        }
//                    }
//                }
//            }
        }
        
        for beginVertex in self.generateVertices() {
            for endVertex in self.generateVertices() {
                if let edge = getEdge(fromVertex: beginVertex, toVertex: endVertex) {
                    guard let minDistanceBegin = minimumDistances[beginVertex]!.distance,
                        let minDistanceEnd = minimumDistances[endVertex]!.distance else {
                        continue
                    }
                    if minDistanceBegin + edge.weight < minDistanceEnd {
                        throw GraphError.NegativeCycle
                    }
                }
            }
        }
        
        return minimumDistances
    }
    
    public typealias FloydWarshallResult = GraphFloydWarshallResult<VertexNameType, EdgeWeightType>
    
    /**
     Calculates the shortest paths between all nodes in the graph using
     the Floyd-Warshal algorithm.
     Note that Floyd-Warshal can handle negative values, but not negative cycles.
     
     - throws: Throws a `GraphError.NegativeCycle` error when the graph contains a negative cycle.
     
     - returns: Returns a FloydWarshallResult object. You can use this object to get the shortest
                paths between nodes.
     
     - complexity: O(V^3)
     */
    public func floydWarshall() throws -> FloydWarshallResult {
        
        var minimumDistances = [VertexNameType: [VertexNameType: MinDistance]]()
        for from in self.generateVertices() {
            minimumDistances[from] = [VertexNameType: MinDistance]()
            for to in self.generateVertices() {
                if from == to {
                    minimumDistances[from]![to] = MinDistance(vertex: nil, distance: 0)
                    continue
                }
                if containsEdge(fromVertex: from, toVertex: to) {
                    let weight = getEdgeWeight(fromVertex: from, toVertex: to)
                    minimumDistances[from]![to] = MinDistance(vertex: to, distance: weight)
                } else {
                    minimumDistances[from]![to] = MinDistance()
                }
            }
        }
        
        for k in self.generateVertices() {
            for from in self.generateVertices() {
                for to in self.generateVertices() {
                    if let fromToKDist = minimumDistances[from]![k]!.distance,
                        let kToToDist = minimumDistances[k]![to]!.distance where
                        minimumDistances[from]![to]!.distance == nil ||
                        minimumDistances[from]![to]!.distance > fromToKDist + kToToDist {
                        minimumDistances[from]![to]!.distance = fromToKDist + kToToDist
                        minimumDistances[from]![to]!.vertex = minimumDistances[from]![k]!.vertex
                    }
                }
            }
        }
        
        // TODO: Detect negative cycles
        /*
         This can be achieved in a couple of ways. We could check the minimum distances of 
         vertices to themselves. If they are negative, there exists a negative cycle.
         The problem with this implementation is that distances in Floyd-Warshall can grow
         exponentially when there are negative cycles. That's why we should do that
         check in every iteration of the inner loop. That takes some work!
         However, it won't change the worst case time complexity.
         We could also use Bellman-Ford first to detect negative cycles. This
         would take O(VE) which also doesn't affect O(V^3)
         
         See this paper:
         http://www.or.uni-bonn.de/~hougardy/paper/Floyd-Warshall.pdf
        */
        
        return FloydWarshallResult(minimumDistances: minimumDistances)
    }
    
    
    // MARK: Bipartite
    
    public typealias Bipartition = GraphBipartition<VertexNameType>
    
    /**
     Returns a bipartition of the graph, or nil if it's not bipartite.
     
     - complexity: O(V)
     */
    public func bipartition() -> Bipartition? {
        
        var bipartition = Bipartition()
        
        if numberOfVertices == 0 {
            return bipartition
        }
        
        let beginVertex = self.anyVertex()!
        bipartition.firstSet.insert(beginVertex)
        var queue = [beginVertex]
        
        while !queue.isEmpty {

            let from = queue.popLast()!
            for (to, _) in getEdges(fromVertex: from) {
                
                if bipartition.containsVertex(to) {
                    if bipartition.inSameSet(from, to) {
                        return nil
                    }
                } else {
                    bipartition.addVertex(to, toOppositeSetOfVertex: from)
                    queue.append(to)
                }
            }
        }
        
        return bipartition
    }
}


// MARK: - Vertices

/**
 *  A generator that generates the vertices of a graph.
 */
public struct GraphVerticesGenerator <VertexNameType: protocol<Hashable>, WeightType: protocol<IntegerLiteralConvertible>, CapacityType: protocol<IntegerLiteralConvertible>> : SequenceType, GeneratorType {
    
    private typealias AdjacencyListGenerator = DictionaryGenerator<VertexNameType, [VertexNameType: GraphEdgeProperties<WeightType, CapacityType>]>
    
    
    // MARK: Properties
    
    /**
     The graph to generate the vertices of.
     */
    private var adjacencyListGenerator: AdjacencyListGenerator
    
    
    // MARK: Initialisers
    
    private init(adjacencyListGenerator: AdjacencyListGenerator) {
        self.adjacencyListGenerator = adjacencyListGenerator
    }
    
    
    // MARK: GeneratorType
    
    public mutating func next() -> VertexNameType? {
        if let (vertex, _) = self.adjacencyListGenerator.next() {
            return vertex
        } else {
            return nil
        }
    }
}


// MARK: Edges

/**
 A struct representing an edge in a graph.
 The edge can have a weight and a capacity.
 */
public struct GraphEdge <VertexNameType, WeightType: protocol<IntegerLiteralConvertible>, CapacityType: protocol<IntegerLiteralConvertible>> {
    
    public typealias Properties = GraphEdgeProperties<WeightType, CapacityType>
    
    
    // MARK: Properties
    
    /**
     The vertex the edge comes from.
     */
    public var fromVertex: VertexNameType
    
    /**
     The vertex the edge goes to.
     */
    public var toVertex: VertexNameType
    
    /**
     The properties of the edge. (weight, capacity)
     */
    public var properties: Properties
    
    
    // MARK: Initialisers
    
    public init(fromVertex from: VertexNameType, toVertex to: VertexNameType, properties: Properties) {
        self.fromVertex = from
        self.toVertex = to
        self.properties = properties
    }
    
    public init(fromVertex from: VertexNameType, toVertex to: VertexNameType, weight: WeightType = 1, capacity: CapacityType = 1) {
        self.fromVertex = from
        self.toVertex = to
        self.properties = Properties(weight: weight, capacity: capacity)
    }
    
    
    // MARK: Computed Properties
    
    /**
     Returns the weight of the edge. This is shorthand for `properties.weight`.
     */
    public var weight: WeightType {
        return properties.weight
    }
    
    /**
     Returns the capacity of the edge. This is shorthand for `properties.capacity`.
     */
    public var capacity: CapacityType {
        return properties.capacity
    }
}

/**
 A struct representing the properties of an edge in a graph.
 The edge can have a weight and a capacity.
 */
public struct GraphEdgeProperties <WeightType: protocol<IntegerLiteralConvertible>, CapacityType: protocol<IntegerLiteralConvertible>> {
    
    
    // MARK: Properties
    
    /**
     Represents the weight of the edge.
     */
    public var weight: WeightType
    
    /**
     Represents the capacity of the edge.
     */
    public var capacity: CapacityType
    
    
    // MARK: Initialisers
    
    public init(weight: WeightType = 1, capacity: CapacityType = 1) {
        self.weight = weight
        self.capacity = capacity
    }
}

/**
 A generator that generates all the edges of a graph.
 */
public class GraphEdgesGenerator <VertexNameType: protocol<Hashable>, WeightType: protocol<IntegerLiteralConvertible, Addable, Comparable>, CapacityType: protocol<IntegerLiteralConvertible>> : SequenceType, GeneratorType {
    
    private typealias VerticesGenerator = GraphVerticesGenerator<VertexNameType, WeightType, CapacityType>
    private typealias GraphType = Graph<VertexNameType, WeightType, CapacityType>
    public typealias Edge = GraphEdge<VertexNameType, WeightType, CapacityType>
    
    
    // MARK: Properties
    
    private var graph: GraphType
    
    /**
     The first vertices generator.
     */
    private var firstVerticesGenerator: VerticesGenerator
    
    /**
     The current vertex the edges are coming from.
     */
    private var from: VertexNameType?
    
    /**
     The second vertices generator.
     */
    private var secondVerticesGenerator: VerticesGenerator
    
    /**
     A unused vertices generator.
     */
    private let unusedVerticesGenerator: VerticesGenerator
    
    
    // MARK: Initialisers
    
    private init(graph: GraphType, firstVerticesGenerator: VerticesGenerator) {
        self.graph = graph
        self.firstVerticesGenerator = firstVerticesGenerator
        self.secondVerticesGenerator = firstVerticesGenerator
        self.unusedVerticesGenerator = firstVerticesGenerator
        self.from = self.firstVerticesGenerator.next()
    }
    
    
    // MARK: GeneratorType
    
    @warn_unused_result public func next() -> Edge? {
        while from != nil {
            while let to = secondVerticesGenerator.next() {
                if let edge = graph.getEdge(fromVertex: from!, toVertex: to) {
                    return Edge(fromVertex: from!, toVertex: to, properties: edge)
                }
            }
            self.secondVerticesGenerator = self.unusedVerticesGenerator
            from = self.firstVerticesGenerator.next()
        }
        return nil
    }
}


// MARK: ShortestPathResult

/**
 *  A struct representing the result of a shortest path algorithm.
 */
public struct GraphShortestPathResult <VertexNameType, DistanceType: protocol<IntegerLiteralConvertible>> {
    
    
    // MARK: Properties
    
    /**
     The path, represented as an array of vertex names.
     The source and destination are included.
     */
    public var path: [VertexNameType]
    
    /**
     The total distance of the path.
     */
    public var totalDistance: DistanceType
    
    
    // MARK: Initialisers
    
    public init() {
        self.path = []
        self.totalDistance = 0
    }
    
    public init(path: [VertexNameType], totalDistance: DistanceType) {
        self.path = path
        self.totalDistance = totalDistance
    }
}


/**
 *  A struct to hold the minimum distance to a vertex.
 *  This struct is used in shortest path algorithms.
 */
public struct GraphMinDistance <VertexNameType, DistanceType> {
    
    
    // MARK: Properties
    
    /**
     The name of the vertex from which the shortest path comes.
     */
    public var vertex: VertexNameType?
    
    /**
     The distance of the shortest path to the vertex.
     */
    public var distance: DistanceType?
    
    
    // MARK: Initialisers
    
    public init() {}
    
    public init(vertex: VertexNameType?, distance: DistanceType?) {
        self.vertex = vertex
        self.distance = distance
    }
}


/**
 *  A struct to represent the result of the Floyd-Warshall algorithm.
 */
public struct GraphFloydWarshallResult <VertexNameType: protocol<Hashable>, DistanceType: protocol<IntegerLiteralConvertible>> {
    
    public typealias MinDistance = GraphMinDistance<VertexNameType, DistanceType>
    public typealias ShortestPathResult = GraphShortestPathResult<VertexNameType, DistanceType>
    
    
    // MARK: Properties
    
    /**
     Represents the minimum distances between all vertices.
     You can get a MinDistance instance like `minimumDistances[from][to]`.
     This object contains the minimum distance from vertex `from` to vertex `to`.
     `minimumDistances[from][to].distance` gives the minimal distance from `from`
     to `to. If it is nil, it means `to` is not reachable.
     `minimumDistances[from][to].vertex` gives the next vertex in the shortest path
     from `from` to `to`.
     */
    public var minimumDistances: [VertexNameType: [VertexNameType: MinDistance]]
    
    
    // MARK: Methods
    
    /**
     Returns the shortest path between the two given vertices.
     
     - parameter from: The start node.
     - parameter to:   The end node.
     
     - returns: An array containing the shortest path. The begin and end nodes are also included.
     */
    public func shortestPath(fromVertex from: VertexNameType, toVertex to: VertexNameType) -> ShortestPathResult {
        guard var nextVertex = minimumDistances[from]![to]!.vertex else {
            return ShortestPathResult()
        }
        var path = [from, nextVertex]
        while nextVertex != to {
            nextVertex = minimumDistances[nextVertex]![to]!.vertex!
            path.append(nextVertex)
        }
        return ShortestPathResult(path: path, totalDistance: minimumDistances[from]![to]!.distance!)
    }
}


/**
 *  A struct to represent a biparition of a graph.
 */
public struct GraphBipartition <VertexNameType: protocol<Hashable>> {
    
    
    // MARK: Properties
    
    /**
     The first set of the bipartition.
     */
    public var firstSet: Set<VertexNameType>
    
    /**
     The second set of the bipartition.
     */
    public var secondSet: Set<VertexNameType>
    
    
    // MARK: Initialisers
    
    public init() {
        firstSet = []
        secondSet = []
    }
    
    public init(firstSet: Set<VertexNameType>, secondSet: Set<VertexNameType>) {
        self.firstSet = firstSet
        self.secondSet = secondSet
    }
    
    
    // MARK: Methods
    
    /**
     Returns whether the bipartition contains the given vertex.
     
     - parameter vertex: The vertex to check.
     */
    public func containsVertex(vertex: VertexNameType) -> Bool {
        return self.firstSet.contains(vertex) || self.secondSet.contains(vertex)
    }
    
    /**
     Returns the set number of a given vertex.
     
     - parameter vertex: The vertex to get the set number for.
     
     - returns: 1 if the vertex is in the first set, 2 if it's in the second and nil
                if it's not in any set.
     */
    public func setNumberOfVertex(vertex: VertexNameType) -> Int? {
        if self.firstSet.contains(vertex) {
            return 1
        } else if self.secondSet.contains(vertex) {
            return 2
        } else {
            return nil
        }
    }
    
    /**
     Adds the given vertex to the set with the given set number.
     
     - parameter vertex:    The vertex to add.
     - parameter setNumber: The number of the set to add the vertex to. This should be either 1 or 2.
     */
    public mutating func addVertex(vertex: VertexNameType, toSetWithNumber setNumber: Int) {
        if setNumber == 1 {
            self.firstSet.insert(vertex)
        } else if setNumber == 2 {
            self.secondSet.insert(vertex)
        } else {
            NSException(name: "Invalid set number", reason: "The set number \(setNumber) is invalid.", userInfo: nil).raise()
        }
    }
    
    /**
     Adds the given vertex to the set the given other vertex is not in.
     
     - parameter vertex: The vertex to add.
     - parameter other:  A vertex in the set where the vertex should not be added to.
     */
    public mutating func addVertex(vertex: VertexNameType, toOppositeSetOfVertex other: VertexNameType) {
        guard var setNumber = setNumberOfVertex(other) else {
            NSException(name: "Unknown vertex", reason: "The bipartition doesn't contain the given vertex.", userInfo: nil).raise()
            return
        }
        setNumber = setNumber % 2 + 1
        self.addVertex(vertex, toSetWithNumber: setNumber)
    }
    
    /**
     Returns whether the two given vertices are in the same set of the bipartition.
     If one or both of the vertices are not in the bipartition, an exception is thrown.
     
     - parameter firstVertex:  The first vertex.
     - parameter secondVertex: The second vertex.
     */
    public func inSameSet(firstVertex: VertexNameType, _ secondVertex: VertexNameType) -> Bool {
        guard let firstSetNumber = setNumberOfVertex(firstVertex), let secondSetNumber = setNumberOfVertex(secondVertex) else {
            fatalError("One or both of the vertices are not in the bipartition.")
        }
        return firstSetNumber == secondSetNumber
    }
    
    /**
     Returns whether the two given vertices are in different sets of the bipartition.
     If one or both of the vertices are not in the bipartition, an exception is thrown.
     
     - parameter firstVertex:  The first vertex.
     - parameter secondVertex: The second vertex.
     */
    public func inDifferentSets(firstVertex: VertexNameType, _ secondVertex: VertexNameType) -> Bool {
        return !inSameSet(firstVertex, secondVertex)
    }
}


// MARK: Errors

/**
 An enum to hold errors for the Graph class.
 
 - NegativeCycle: Means the graph contains a negative cycle.
 */
public enum GraphError: ErrorType {
    
    case NegativeCycle
}
