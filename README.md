# FTA Identity Verification SDK Overview

`@fintech-automation/Identity_Verification_iOS_SDK` is a branded Flutter SDK around a managed
identity verification capture engine. It provides:

- FTA backend session creation and result lookup.
- Built-in runtime configuration.
- Branded wrapper screens before and after the camera capture step.
- Grouped `brand`, `theme`, `localization`, and `callbacks`
  options for readable host integration.

The flow is:

```text
intro -> prepare -> capture -> processing -> success | fail | error
```

## Installation

```ruby
source 'https://github.com/Fintech-Automation/ios_specs'

pod 'IdentityVerificationiOSSDK', '~> 1.0.0'
```

## Usage

```swift
import IdentityVerificationiOSSDK

IdentityVerificationView.init(
    frame: "FRAME",
    verificationToken: "YOUR_TOKEN",
    onSuccess: { model in
        print("Identity Verification Successed: \(model.id ?? "") \(model.status ?? "")" );
    },
    onFail: { model in
        print("Identity Verification Failed: \(model.id ?? "") \(model.status ?? "") \(model.failReason ?? "")" );
    },
    onError: { error in
        print("Identity Verification Error: \(error.stage ?? "") \(error.message ?? "")" );
    },
    onCancel: {
        print("Identity Verification Cancel" );
    },
    onAnalysisComplete: {
        print("Identity Verification Analysis Complete" );
    },
    onScreenChange: { type in
        print("Identity Verification Screen Change To \(type?.rawValue ?? "")" );
    },
    onContinue: {
        print("Identity Verification Continue" );
    }
)

## Authentication Token

Obtain a `verificationToken` before rendering the component, then pass it through
the `verificationToken` prop. For the API request and response details, refer to the
[UniFi Identity Verification API documentation](https://api-docs.accelerationcloud.com/resource/unifi-identity-verification).
```



## Component Props

Top-level props are reserved for session/runtime parameters:

### Required Backend Parameters

To communicate with the Identity Verification backend, pass all of the following
parameters explicitly. The liveness session cannot be created or queried
correctly without valid values for them.

| Parameter | Purpose |
| --- | --- |
| `verificationToken` | Bearer token used to authenticate backend requests. |


| Prop           | Type                     | Required | Default        | Description                                     |
| -------------- | ------------------------ | -------- | -------------- | ----------------------------------------------- |
| `verificationToken`  | `String`                 | Yes      | none           | Bearer token used to authenticate backend APIs. |
| `flow`         | `LivenessFlow`           | No       | SDK defaults   | Flow behavior.                                  |
| `brand`        | `LivenessBrand`          | No       | SDK defaults   | Brand shown in the SDK header.                  |
| `theme`        | `LivenessTheme`          | No       | SDK defaults   | Visual system tokens.                           |
| `localization` | `LivenessLocalization`   | No       | SDK defaults   | SDK-owned screen copy.                          |
| `onSuccess`    | `((LivenessResultModel) -> Void)`      | No       | none           | Called after the backend returns a successful liveness result.|
| `onFail`    | `((LivenessResultModel) -> Void)`      | No       | none           | Called after the backend returns a non-passing or failed result. |
| `onError`    | `((LivenessErrorModel) -> Void)`      | No       | none           | Called when a session, camera, capture, or result-fetch error occurs. |
| `onCancel`    | `(() -> Void)`      | No       | none           | Called when the user cancels the live capture flow. |
| `onAnalysisComplete`    | `(() -> Void)`      | No       | none           | Called when the capture detector finishes analysis and the SDK begins fetching backend results. |
| `onScreenChange`    | `((LivenessScreenType?) -> Void)`      | No       | none           | Called when the flow changes screens. |
| `onSessionStatusChange` | `(event: { status?: SessionStatus; stage?: string; message?: string; isEligible: boolean }) => void`    | Called after the SDK validates the token/session state. status indicates the session state, and isEligible indicates whether the session is eligible for verification. |
| `onContinue`    | `(() -> Void)`      | No       | none           | Called when the user taps Continue on the success screen. |


### SessionStatus values

- `COMPLETED`: The token already completed the liveness check successfully.
- `EXPIRED`: The token has expired or the backend returned an auth/session-expired response.
- `INVALID`: The token is invalid, rejected, or otherwise failed validation.
- `READY`: Session token is valid and ready for liveness detection.
- `RETRY_LIMIT_EXCEEDED`: Retry limit exceeded — no further attempts allowed.



### Result Class
```swift
public class LivenessResultModel: Decodable {
    public var id:String?;
    public var status:String?;
    public var failReason:String?;
    public var createdTime:String?;
    public var completedTime:String?;
}
```

## Brand Class

```swift
public class LivenessBrand : Codable { 
    /// Brand text in the top-left chrome. Defaults to hidden.
    var name:String?;

    /// Optional image URL for the brand mark. Preferred for hosted/runtime wrappers.
    var logoUrl: URL?;

      /// Top-right security label; pass `''` to hide.
    var secureLabel: String? ;

}
```

| Field         | Default               | Description                                                           |
| ------------- | --------------------- | --------------------------------------------------------------------- |
| `name`        | `''`                  | Your business name.                                                   |
| `logoUrl`     | none                  | Optional image URL brand mark; preferred for hosted/runtime wrappers. |
| `secureLabel` | `'Encrypted session'` | Top-right security label; pass `''` to hide.                          |

### Friendly Note 📝
> **Note:** The brand mark is rendered with the following priority:
> 
> 1. **`logoUrl`** – If no `logo` is provided, we'll display your image.
> 2. **`name`** – As a last resort, we'll generate a clean initials-based mark (e.g., "Company Name" → "CN") to keep the UI tidy.
> 
> This ensures your brand identity always appears — whether as a rich component, an image, or a simple text abbreviation. ✨


## Flow Class

```swift
public class LivenessFlow: Codable {
    /// Starts at Prepare instead of Intro.
    var  skipIntro:Bool?;

    /// Goes straight to capture after Intro, or immediately when `skipIntro` is also true.
    var  skipPrepare:Bool?;
    
}
```

| Field         | Default | Description                                                                         |
| ------------- | ------- | ----------------------------------------------------------------------------------- |
| `skipIntro`   | `false` | Starts at Prepare instead of Intro.                                                 |
| `skipPrepare` | `false` | Goes straight to capture after Intro, or immediately when `skipIntro` is also true. |


## Theme

```swift
IdentityVerificationView.init(
    theme: LivenessTheme(
        colors: LivenessThemeColors(
            primary: "#1634A4",
            secondary: "#1A3DBF",
            heading: "#111827",
        ),
        shape:LivenessThemeShape(radius: 22),
        typography: LivenessThemeTypography(fontFamily: "Inter, system-ui, sans-serif",)
    ),
)
```

| Field                   | Default            | Description                                            |
| ----------------------- | ------------------ | ------------------------------------------------------ |
| `colors.primary`        | `'#1634A4'`        | Main brand color.                                      |
| `colors.secondary`      | `'#1A3DBF'`        | Secondary brand accent color.                          |
| `colors.heading`        | `'#111827'`        | Main heading and strong text color.                    |
| `shape.radius`          | `22`               | Root/card corner radius in pixels.                     |
| `typography.fontFamily` | Inter/system stack | Font family used by wrapper screens and capture theme. |


## Localization

`localization` customizes SDK-owned screens and is grouped by screen.

```swift
public class LivenessLocalization: Codable {
    var intro: LivenessLocalizationIntro?;

    var prepare: LivenessLocalizationPrepare?;

    var starting: LivenessLocalizationPageElements?;

    var processing: LivenessLocalizationPageElements?;

    var success: LivenessLocalizationResultElements?;

    var fail: LivenessLocalizationResultElements?;

    var cameraPermission: LivenessLocalizationPageElements?;

}

public class LivenessLocalizationIntro: Codable {
    var eyebrow: String?;
    var title: String?;
    var body: String?;
    var cta: String?;

    /// Small trust line under the intro CTA; pass `''` to hide.
    var trustLabel: String? ;

}

public class LivenessLocalizationPrepare: Codable {
    var eyebrow: String?;
    var title: String? ;
    var tips: [LivenessLocalizationPageElements]?;
    var cta: String?;
    var backLabel: String?;
    
}

public class LivenessLocalizationPageElements: Codable {
    var title: String?;
    var body: String?;
    
}

public class LivenessLocalizationResultElements: Codable {
    var title: String?;
    var body: String?;
    var cta: String?;

}

```

### Localization props reference

| Prop path          | Type     | Description                                         |
| ------------------ | -------- | --------------------------------------------------- |
| `intro.eyebrow`    | `string` | Small overline text above the intro title.          |
| `intro.title`      | `string` | Main heading shown on the intro screen.             |
| `intro.body`       | `string` | Paragraph explaining the check on the intro screen. |
| `intro.cta`        | `string` | Primary call-to-action on the intro screen.         |
| `intro.trustLabel` | `string` | Small security/trust label shown in header.         |

| `prepare.eyebrow` | `string` | Overline text for the prepare screen. |
| `prepare.title` | `string` | Main heading for the prepare screen. |
| `prepare.tips` | `Array<{title:string, body:string}>` | Array of tip objects displayed as a short checklist. |
| `prepare.cta` | `string` | Primary action label on the prepare screen. |
| `prepare.backLabel` | `string` | Back button label on the prepare screen. |

| `starting.title` | `string` | Title shown while the camera is starting. |
| `starting.body` | `string` | Supporting text while a session is being created. |

| `processing.title` | `string` | Title shown while verification is in progress. |
| `processing.body` | `string` | Supporting text shown during result fetch. |

| `success.title` | `string` | Title for the success screen. |
| `success.body` | `string` | Supporting success text. |
| `success.cta` | `string` | Continue/acknowledge button text on success. |

| `fail.title` | `string` | Title shown when a scan cannot complete. |
| `fail.body` | `string` | Guidance text shown on failure. |
| `fail.cta` | `string` | Retry button label on fail screen. |

| `cameraPermission.title` | `string` | Title when camera permission is required. |
| `cameraPermission.body` | `string` | Instructional text for granting camera permission. |

## Notes

- The camera capture step owns the camera oval geometry and liveness model flow.
  This SDK themes the surrounding UI and supported capture theme tokens.
- The underlying capture runtime uses process-global client configuration. If a
  host app also configures the same provider runtime, mount this SDK with that
  shared global behavior in mind.
- Camera capture requires browser camera permission, HTTPS in production, WebGL,
  and network access to liveness assets.
- Bundled runtime ids are public client identifiers. Privileged operations stay
  on the FTA backend.

## License

This repository includes the FinTech Identity Verification SDK, which is licensed under a Commercial License Agreement. See [COMMERCIAL-LICENSE.md](./COMMERCIAL-LICENSE.md) for full terms.

Use of this SDK requires explicit permission from FinTech Automation.

