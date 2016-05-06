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
    
    public typealias Edge = GraphEdge<EdgeWeightType, EdgeCapacityType>
    
    // MARK: Internal Properties
    
    private var adjacencyList: [VertexNameType: [VertexNameType: Edge]]
    
    
    // MARK: Initialisers
    
    public init() {
        adjacencyList = [:]
    }
    
    
    // MARK: Vertex Management
    
    /**
     Returns an array containg all vertices in the graph.
     */
    public var vertices: [VertexNameType] {
        var vert = [VertexNameType]()
        for vertex in lazyVertices {
            vert.append(vertex)
        }
        return vert
    }
    
    /**
     Returns a lazy collection map to loop over the vertices of the the graph.
     */
    public var lazyVertices: LazyMapCollection<[VertexNameType: [VertexNameType: Edge]], VertexNameType> {
        return adjacencyList.keys
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
        for vertex in lazyVertices {
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
        for vertex in lazyVertices {
            if degreeOfVertex(vertex) % 2 != 0 {
                count += 1
            }
        }
        return count
    }
    
    
    // MARK: Edge Management
    
    /**
     Adds the given unidirectional edge to the graph.
     If the from or to vertices do not exist, they are added.
     
     - parameter edge: The edge containing the weight and capacity of the edge.
     - parameter from: The vertex the edge is coming from.
     - parameter to:   The vertex the edge is going to.
     */
    public func addUnidirectionalEdge(edge: Edge, fromVertex from: VertexNameType, toVertex to: VertexNameType) {
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
        let edge = Edge(weight: weight, capacity: capacity)
        self.addUnidirectionalEdge(edge, fromVertex: from, toVertex: to)
    }
    
    /**
     Adds the given unidirectional edge to the graph.
     If the from or to vertices do not exist, they are added.
     
     - parameter edge: The edge containing the weight and capacity of the edge.
     - parameter from: The vertex the edge is coming from.
     - parameter to:   The vertex the edge is going to.
     */
    public func addBidirectionalEdge(edge: Edge, fromVertex from: VertexNameType, toVertex to: VertexNameType) {
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
        let edge = Edge(weight: weight, capacity: capacity)
        addBidirectionalEdge(edge, fromVertex: from, toVertex: to)
    }
    
    /**
     Removes the edge between the two given vertices and returns it.
     If the given edge doesn't exist, nil is returned.
     
     - parameter from: The vertex the edge is coming from.
     - parameter to:   The vertex the edge is going to.
     */
    public func removeEdge(fromVertex from: VertexNameType, toVertex to: VertexNameType) -> Edge? {
        return adjacencyList[from]?.removeValueForKey(to)
    }
    
    /**
     Removes both edges between the two given vertices and returns it.
     If only one edge exists, that edge is returned.
     If the given edge doesn't exist, nil is returned.
     
     - parameter from: The first vertex.
     - parameter to:   The second vertex.
     */
    public func removeBidirectionalEdge(fromVertex from: VertexNameType, toVertex to: VertexNameType) -> Edge? {
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
    public func getEdge(fromVertex from: VertexNameType, toVertex to: VertexNameType) -> Edge? {
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
     Returns the number of edges.
     
     - parameter countTwice: Determines whether bidirectional edges should be counted twice.
     */
    public func numberOfEdges(countBidirectionalEdgesTwice countTwice: Bool = false) -> Int {
        // TODO: Implement this
        var count = 0
        for vertex in lazyVertices {
            if countTwice {
                count += adjacencyList[vertex]!.count
            } else {
                for to in adjacencyList[vertex]! {
                    
                }
            }
        }
        return count
    }
    
    
    // MARK: Shortest Path
    
    public typealias ShortestPathResult = GraphShortestPathResult<VertexNameType, EdgeWeightType>
    private typealias MinDistance = GraphMinDistance<VertexNameType, EdgeWeightType>
    
    /**
     Returns the shortest path between the two given nodes, or nil if no path exists.
     
     - parameter from: The source vertex.
     - parameter to:   The destination vertex.
     */
    public func shortestPath(fromVertex from: VertexNameType, toVertex to: VertexNameType) -> ShortestPathResult? {
        
        var minimumDistances = [VertexNameType: MinDistance]()
        for vertex in lazyVertices {
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
            
            for edgeVertex in lazyVertices {
                
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
        
//        // Get indices of from and to vertices
//        size_t source = indexOfVertex(fromVertex);
//        size_t target = indexOfVertex(toVertex);
//        
//        // Define a struct for the minimum distances to a certain vertex
//        struct MinDistance {
//            size_t from;
//            EdgeWeightType distance;
//        };
//        
//        // Create a vector to hold the minimum distances to all nodes
//        // The index corresponds to the index of the node
//        std::vector<MinDistance> minDistance(numberOfVertices(), {source, std::numeric_limits<EdgeWeightType>::max()});
//        minDistance[source] = {source, EdgeWeightType()};
//        
//        // Create a set to hold the vertices we're processing
//        std::set<std::pair<EdgeWeightType, size_t>> activeVertices;
//        activeVertices.insert({EdgeWeightType(), source});
//        
//        // Keep looping as long as we're processing
//        while (!activeVertices.empty()) {
//            
//            // Get one of the vertices we're processing
//            std::size_t where = activeVertices.begin()->second;
//            
//            // If we're at the target, we got the best distance, so create the path and return it
//            if (where == target) {
//                size_t nextVertexIndex = minDistance[target].from;
//                std::vector<VertexNameType> path = {toVertex, nameOfVertexAtIndex(nextVertexIndex)};
//                while (nextVertexIndex != source) {
//                    nextVertexIndex = minDistance[nextVertexIndex].from;
//                    path.push_back(nameOfVertexAtIndex(nextVertexIndex));
//                }
//                std::reverse(path.begin(), path.end());
//                return {true, minDistance[where].distance, path};
//            }
//            
//            // Remove the vertex we're processing from the set
//            activeVertices.erase(activeVertices.begin());
//            
//            // Loop over the edges of vertex we're processing
//            for (auto edge : adjacencyList[where])
//            if (minDistance[edge.to].distance > minDistance[where].distance + edge.weight) {
//                activeVertices.erase( {minDistance[edge.to].distance, edge.to} );
//                minDistance[edge.to] = {where, minDistance[where].distance + edge.weight};
//                activeVertices.insert( {minDistance[edge.to].distance, edge.to} );
//            }
//        }
//        
//        // If it did not finish yet, there was no path to the end, so return an empty path
//        return {false, EdgeWeightType(), {}};
    }
}


// MARK: Edge

/**
 A struct representing an edge in a graph.
 The edge can have a weight and a capacity.
 */
public struct GraphEdge <WeightType: protocol<IntegerLiteralConvertible>, CapacityType: protocol<IntegerLiteralConvertible>> {
    
    
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
 *  A private struct to holde the minimum distance to a vertex.
 *  This struct is used in shortest path algorithms.
 */
private struct GraphMinDistance <VertexNameType, DistanceType: protocol<Comparable>> {
    
    
    // MARK: Properties
    
    /**
     The name of the vertex from which the shortest path comes.
     */
    var vertex: VertexNameType?
    
    /**
     The distance of the shortest path to the vertex.
     */
    var distance: DistanceType?
    
    
    // MARK: Initialisers
    
    init() {}
    
    init(vertex: VertexNameType?, distance: DistanceType?) {
        self.vertex = vertex
        self.distance = distance
    }
}
