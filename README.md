# AMAL (iOS)

Нативное iOS‑приложение (SwiftUI): LifeRPG с ИИ‑гейммастером.

- Аутентификация: email + OTP (v1 — без пароля)
- Интеграции: HealthKit (чтение), Calendar (чтение)
- Тон: «мудрый старец», аудитория: новички
- Акцент: руническое золото (#D4AF37)

## Сборка
1) `brew install xcodegen`
2) `xcodegen generate`
3) Открыть `AMAL.xcodeproj` в Xcode → запустить на симуляторе/устройстве

## Структура
- `AMAL/Sources` — SwiftUI код
- `AMAL/Resources` — Info.plist, entitlements
- `docs/` — план и бэклог
