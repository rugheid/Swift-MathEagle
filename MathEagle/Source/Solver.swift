protocol NewtonMethodSolvable : FloatLiteralConvertible, SignedNumberType {
    func +(lhs:Self, rhs:Self) -> Self
    func /(lhs:Self, rhs:Self) -> Self
    func -(lhs:Self, rhs:Self) -> Self
    func *(lhs:Self, rhs:Self) -> Self
}

extension CGFloat : NewtonMethodSolvable { }
extension Double : NewtonMethodSolvable { }
extension Float : NewtonMethodSolvable { }

struct Solver {
    
    static func newton<T:NewtonMethodSolvable>(guess: T, accuracy err: T = 1e-7, iterations: Int = 100, f: (T) -> (T)) -> T {
        return newton(
            guess,
            accuracy: err,
            iterations: iterations,
            df: {
                ( f($0 + err) - f($0) ) / err
            },
            f: f
        )
    }
    
    static func newton<T:NewtonMethodSolvable>(guess: T, accuracy err: T = 1e-7, iterations: Int = 100, df:(T) -> (T), f: (T) -> (T)) -> T {
        var converged = false
        var k = 1
        var x = guess
        while k < iterations && !converged {
            let prev = x
            x = x - f(x) / df(x)
            print("k", k, "x", x, "prev", prev)
            converged = abs(x - prev) <= err
            k += 1
        }
        return x
        
    }
    
}
