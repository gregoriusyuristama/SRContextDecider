import SRCore

public struct ContextDecider {
    public init() {}

    public func decide(context: CodeContext) -> LLMDecision {
        if context.sensitivityScore >= 0.7 {
            return .useLocal(reason: "Sensitive content detected (score: \(String(format: "%.2f", context.sensitivityScore)))")
        }
        if context.tokenEstimate > 4000 {
            return .useCloud(reason: "File too large for local model (~\(context.tokenEstimate) tokens)")
        }
        if context.complexity == .complex {
            return .useCloud(reason: "Complex code (\(context.lineCount) lines)")
        }
        if context.language == .unknown {
            return .useCloud(reason: "Unknown language — cloud handles it better")
        }
        return .useLocal(reason: "Privacy-first: file is safe for on-device processing")
    }
}
