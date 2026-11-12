# MEHEDY WhatsApp Automation

এটি MEHEDY-এর ব্যক্তিগত WhatsApp automation starter। Website, owner dashboard, Node.js API, PostgreSQL settings store এবং Baileys ভিত্তিক single-owner pairing/runtime একই Node service-এ আছে।

## গুরুত্বপূর্ণ সীমাবদ্ধতা

- এটি **single-owner personal bot starter**, multi-tenant SaaS নয়।
- `.public` দিলে Group-এর সদস্যরা সাধারণ কমান্ড চালাতে পারবে; `.private` দিলে শুধু Owner চালাতে পারবে।
- `.public` / `.private` এবং `.owner`, `.restart`-এর মতো sensitive কমান্ড Owner-only।
- `.menu`, `.help`, `.ping`, `.alive`, `.owner`, `.public`, `.private`, `.groupinfo`, `.tagall`, `.antilink`, `.welcome` implement করা হয়েছে। Anti-link ও welcome toggle state সংরক্ষণ করে, কিন্তু message moderation / welcome event handler এখনো implement করা হয়নি।
- Pairing Code ও live WhatsApp connection বাস্তব account দিয়ে পরীক্ষা করতে হবে। Baileys unofficial WhatsApp Web integration; account restriction ঝুঁকি থাকতে পারে।
- Session files অত্যন্ত sensitive। কখনো GitHub-এ upload বা অন্যকে share করবে না।
- Server process বন্ধ করা WhatsApp Linked Devices থেকে device unlink করার সমান নয়।
- WhatsApp-এর Terms ও applicable rules মেনে ব্যবহার করো।

## 1) Requirements

- Node.js 20+
- npm
- নিজের WhatsApp account
- Local testing-এর জন্য PostgreSQL optional; `DATABASE_URL` না দিলে JSON development store ব্যবহার হবে।
- Production-এর জন্য PostgreSQL এবং persistent disk/volume strongly recommended।

## 2) Local setup (Windows)

1. ZIP Extract করো।
2. VS Code-এ project folder open করো।
3. Terminal → New Terminal।
4. চালাও:

```bash
npm install
```

5. `.env.example` copy করে `.env` নামে রাখো।
6. `.env`-এ নিজের password এবং random TOKEN_SECRET বসাও। `OWNER_NUMBER`-এ তোমার নিজের Bangladesh number international digits format-এ বসাও (যেমন 8801XXXXXXXXX)। ZIP-এ ব্যক্তিগত নম্বর রাখা হয়নি।
7. Local test-এ `DATABASE_URL` ফাঁকা রাখা যায়। Production-এ Railway PostgreSQL URL বসাও।
8. চালাও:

```bash
npm run check
npm start
```

9. Browser-এ `http://localhost:3000` খোলো।
10. `.env`-এর `DASHBOARD_PASSWORD` দিয়ে login করো।
11. Pairing number `8801611895004` বা নিজের WhatsApp number দাও, Generate pairing code চাপো।
12. WhatsApp → Linked devices → Link a device → Link with phone number instead → pairing code লিখো।

Pairing code না এলে server log দেখো, একটু অপেক্ষা করো, তারপর চেষ্টা করো। WhatsApp client version/network changes হলে Baileys compatibility সমস্যা হতে পারে।

## 3) PostgreSQL

Railway-তে PostgreSQL service create করে private `DATABASE_URL` copy করো এবং Backend service-এর Variables-এ সেট করো। App startup-এ `bot_settings` এবং `bot_events` table create করবে।

`DATABASE_URL` কখনো frontend code বা GitHub-এ দেবে না।

## 4) Railway deploy

- Project GitHub-এ private repository হিসেবে push করো।
- Railway-তে New Project → Deploy from GitHub Repo।
- Root directory project root-ই থাকবে।
- Add PostgreSQL service।
- Backend service Variables-এ `.env.example`-এর সব required variable বসাও।
- `DATABASE_URL` PostgreSQL service-এর reference variable হিসেবে দাও।
- Backend service-এর জন্য persistent volume mount করো; `SESSION_DIR` সেই mount path-এ সেট করো, যেমন `/data/sessions`।
- Railway generated domain-এ health check `/api/health`।
- Deploy logs দেখো এবং pairing test করো।

## 5) Commands

| Command | Access | কাজ |
|---|---|---|
| `.menu`, `.help` | Public mode-এ সবাই; Private mode-এ Owner | Menu |
| `.ping` | Public mode-এ সবাই; Private mode-এ Owner | Response |
| `.alive` | Public mode-এ সবাই; Private mode-এ Owner | Bot status |
| `.public` | Owner only | Public mode |
| `.private` | Owner only | Private mode |
| `.owner` | Owner only | Owner info |
| `.groupinfo` | Access mode অনুযায়ী | Group metadata |
| `.tagall [text]` | Access mode অনুযায়ী | Group members mention |
| `.antilink on/off` | Owner only | Setting toggle |
| `.welcome on/off` | Owner only | Setting toggle |

## 6) Change points

- `OWNER_NAME`, `OWNER_NUMBER`, `BOT_PREFIX`: `.env`
- Website texts/design: `public/index.html`, `public/styles.css`
- API: `src/routes/api.js`
- Commands and WhatsApp event handling: `src/bot/engine.js`
- Database settings: `src/store.js`

## 7) Security

- Strong unique `DASHBOARD_PASSWORD` and `TOKEN_SECRET` use করো।
- `.env`, `sessions/`, `data/` commit করবে না।
- Pairing code, `sessions/creds.json`, auth files কারও সঙ্গে share করবে না।
- Dashboard public internet-এ expose করলে HTTPS ব্যবহার করো।
- এই starter-এ production-grade multi-user auth, CSRF system, multi-tenant isolation, billing বা admin roles নেই।
- Sensitive command changes server-side owner check দিয়ে করা হয়েছে, তবু public deployment-এর আগে security review দরকার।

## 8) Troubleshooting

- `npm is not recognized`: Node.js LTS install করে terminal restart করো।
- Dashboard login fail: `.env`-এর password ঠিক আছে কি না দেখো।
- Pairing fail: valid international digits-only number, internet, Baileys compatibility এবং Railway logs পরীক্ষা করো।
- Railway restart-এর পর logout: `SESSION_DIR` persistent volume-এ আছে কি না নিশ্চিত করো।
- PostgreSQL error: `DATABASE_URL` সঠিক এবং DB reachable কি না দেখো।

## Credits and legal

This is a new MEHEDY personal project. It uses the open-source `@whiskeysockets/baileys` library; see its license and documentation. It is not affiliated with or endorsed by WhatsApp/Meta. Use responsibly.

## 9) 900-command catalogue website

Website-এর `900+ Commands` link অথবা `http://localhost:3000/commands.html` খুললে searchable command library পাওয়া যাবে।

- মোট 900টি catalogue entry, 30টি category।
- Search, category filter, status filter ও pagination আছে।
- প্রতিটি card খুললে description, example usage, permission এবং demo/implementation note দেখা যায়।
- `Working` = বর্তমান starter source-এ command handler আছে।
- `Requires setup` = compatible provider/API বা extra configuration দরকার।
- `Planned` = catalogue reference; বর্তমান bot-এ handler নেই।
- Demo text একটি explanatory preview; এটি WhatsApp-এ command execute করে না।

এই version-এ 20টি command handler অন্তর্ভুক্ত: `.menu`, `.help`, `.ping`, `.alive`, `.owner`, `.public`, `.private`, `.groupinfo`, `.tagall`, `.kick`, `.promote`, `.demote`, `.groupname`, `.groupdesc`, `.link`, `.revoke`, `.mute`, `.unmute`, `.antilink`, `.welcome`।
