import SRCore

public struct ComplexityAnalyzer {
    public static func analyze(lineCount: Int, tokenEstimate: Int) -> CodeComplexity {
        if lineCount > 200 || tokenEstimate > 4000 {
            return .complex
        } else if lineCount > 50 {
            return .moderate
        } else {
            return .simple
        }
    }
}
