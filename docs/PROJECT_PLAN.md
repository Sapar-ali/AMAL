# AMAL — Project Plan (Single Source of Truth)

## Decisions
- Name: AMAL
- Platform: iOS (SwiftUI)
- Auth: Email + OTP (без пароля)
- Integrations v1: HealthKit (read‑only), Calendar (read‑only)
- Tone: «мудрый старец» (RU)
- Audience: новички
- Units: метрические
- Brand: руническое золото (#D4AF37) на тёмном фоне

## MVP Scope
- Onboarding: email→OTP → выбор 2 королевств → профиль (возраст/рост/вес) → разрешения HK/Calendar → время пушей
- Daily: 2 квеста + «секретная миссия», альтернатива, вечерний итог, простая прокачка статов
- Screens: Home, Stats, Profile

## Daily Logic (v1)
- Дефолты: 6000 шагов, 5 минут mindfulness, 7 ч сна
- Адаптация: целимся в 70–80% успеха; ±10–15% на следующий день
- Секретные: звонок близкому, 10 страниц чтения, 5 минут тишины, стакан воды

## Backlog & Status
- Init iOS project with XcodeGen, Info.plist, entitlements — DONE
- Onboarding skeleton (Email, OTP, Realms, Profile, Permissions) — DONE
- HealthKit read‑only wrapper + permission flow — DONE
- Calendar read‑only wrapper + permission flow — DONE
- Main tabs (Home, Stats, Profile) — IN PROGRESS
- Quest generator + notifications — IN PROGRESS
- RU copy + localization — TODO
- Build verification on Simulator / Device — TODO

## Next Up
1) Завершить генератор квестов и обновление статов
2) Добавить RU строки и тексты «мудрого старца» по экранам
3) Проверка сборки в симуляторе (установка iOS Runtime), затем на устройстве

## How We Work
- Этот файл и docs/TODO.md — источник правды по плану и очередности
- Обновляем после каждой вехи; коммиты сопровождаем краткими сообщениями
