import Foundation

public struct SensitivityScanner {
    // (regex pattern, weight) pairs ordered by descending weight
    private static let rules: [(String, Float)] = [
        // PII
        (#"\b\d{3}-\d{2}-\d{4}\b"#,                                                   0.95), // SSN
        (#"\b(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|3[47][0-9]{13})\b"#,         0.95), // Credit card
        // Key-like strings (Anthropic / OpenAI style)
        (#"sk-[a-zA-Z0-9]{20,}"#,                                                      0.95),
        (#"(?i)bearer\s+[a-zA-Z0-9._\-]{20,}"#,                                       0.90),
        (#"(?i)(api[_\-]?key|apikey|secret[_\-]?key|access[_\-]?token|auth[_\-]?token)\s*[=:]\s*[\"'][^\"']{8,}[\"']"#, 0.90),
        (#"(?i)(password|passwd|pwd)\s*[=:]\s*[\"'][^\"']{4,}[\"']"#,                 0.85),
        // Internal hostnames
        (#"(?i)https?://[a-z0-9.\-]*\.(internal|staging|corp)(:[0-9]+)?"#,            0.40),
    ]

    public static func scan(_ code: String) -> Float {
        var maxScore: Float = 0.0
        for (pattern, weight) in rules {
            if code.range(of: pattern, options: .regularExpression) != nil {
                maxScore = max(maxScore, weight)
            }
        }
        return maxScore
    }
}
