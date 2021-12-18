// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(OSX)
  import AppKit.NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
public enum APPJAMFontFamily {
  public enum GmarketSans {
    public static let bold = APPJAMFontConvertible(name: "GmarketSansBold", family: "Gmarket Sans", path: "GmarketSansBold.otf")
    public static let light = APPJAMFontConvertible(name: "GmarketSansLight", family: "Gmarket Sans", path: "GmarketSansLight.otf")
    public static let medium = APPJAMFontConvertible(name: "GmarketSansMedium", family: "Gmarket Sans", path: "GmarketSansMedium.otf")
    public static let all: [APPJAMFontConvertible] = [bold, light, medium]
  }
  public enum NotoSansCJKKR {
    public static let black = APPJAMFontConvertible(name: "NotoSansCJKkr-Black", family: "Noto Sans CJK KR", path: "NotoSansCJKkr-Black.otf")
    public static let bold = APPJAMFontConvertible(name: "NotoSansCJKkr-Bold", family: "Noto Sans CJK KR", path: "NotoSansCJKkr-Bold.otf")
    public static let demiLight = APPJAMFontConvertible(name: "NotoSansCJKkr-DemiLight", family: "Noto Sans CJK KR", path: "NotoSansCJKkr-DemiLight.otf")
    public static let light = APPJAMFontConvertible(name: "NotoSansCJKkr-Light", family: "Noto Sans CJK KR", path: "NotoSansCJKkr-Light.otf")
    public static let medium = APPJAMFontConvertible(name: "NotoSansCJKkr-Medium", family: "Noto Sans CJK KR", path: "NotoSansCJKkr-Medium.otf")
    public static let regular = APPJAMFontConvertible(name: "NotoSansCJKkr-Regular", family: "Noto Sans CJK KR", path: "NotoSansCJKkr-Regular.otf")
    public static let thin = APPJAMFontConvertible(name: "NotoSansCJKkr-Thin", family: "Noto Sans CJK KR", path: "NotoSansCJKkr-Thin.otf")
    public static let all: [APPJAMFontConvertible] = [black, bold, demiLight, light, medium, regular, thin]
  }
  public enum NotoSansMonoCJKKR {
    public static let bold = APPJAMFontConvertible(name: "NotoSansMonoCJKkr-Bold", family: "Noto Sans Mono CJK KR", path: "NotoSansMonoCJKkr-Bold.otf")
    public static let regular = APPJAMFontConvertible(name: "NotoSansMonoCJKkr-Regular", family: "Noto Sans Mono CJK KR", path: "NotoSansMonoCJKkr-Regular.otf")
    public static let all: [APPJAMFontConvertible] = [bold, regular]
  }
  public static let allCustomFonts: [APPJAMFontConvertible] = [GmarketSans.all, NotoSansCJKKR.all, NotoSansMonoCJKKR.all].flatMap { $0 }
  public static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

public struct APPJAMFontConvertible {
  public let name: String
  public let family: String
  public let path: String

  #if os(OSX)
  public typealias Font = NSFont
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Font = UIFont
  #endif

  public func font(size: CGFloat) -> Font {
    guard let font = Font(font: self, size: size) else {
      fatalError("Unable to initialize font '\(name)' (\(family))")
    }
    return font
  }

  public func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate var url: URL? {
    // swiftlint:disable:next implicit_return
    return BundleToken.bundle.url(forResource: path, withExtension: nil)
  }
}

public extension APPJAMFontConvertible.Font {
  convenience init?(font: APPJAMFontConvertible, size: CGFloat) {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
      font.register()
    }
    #elseif os(OSX)
    if let url = font.url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      font.register()
    }
    #endif

    self.init(name: font.name, size: size)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    Bundle(for: BundleToken.self)
  }()
}
// swiftlint:enable convenience_type
// swiftlint:enable all
// swiftformat:enable all
