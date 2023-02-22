---
title: "Future 2022 12"
date: 2022-12-03T05:22:38+09:00
outputs: 'Reveal'
draft: true
---

# Future

Yusuke Wada

Dec 2022

---

## Future of Hono

---

Make Hono...

## Defacto standard for Web Standard

---

## Web Standard

* Hono works on Web-interoperable runtime
* Cloudflare Workers (workerd), Vercel, Deno, Bun, ...(Node.js)
* Discussed in WinterCG

```ts
const req = new Request('http://localhost')
const res = new Response('Hello!', { status: 200 })
res.headers.append('x-custom', 'This is message')
```

---

## We have to do four things

---

1. Making the ecosystem
2. Write documents
3. Think about "Edgy" and "General"
4. Make it for "Frontend" and "Client"

---

## 1. Ecosystem

* Build easier ways to create 3rd-party middleware
* Organize GitHub repo and npm registry.
* Make it "monorepo"

---

## Built-in middleware

* Basic Authentication
* Bearer Authentication
* Cache
* Compress
* CORS
* ETag
* html
* JSX
* JWT Authentication
* Logger
* Pretty JSON
* Serving static files
* Validator

---

## 3rd-party middleware

* Sentry
* GraphQL
* Firebase Auth
* tRPC
* Auth0
* Rate limit
* R2 bucket CRUD
* D1 ORM integrated
* ...

---

## 2. Documents

* We have to write documents!
* Website
* Tutorial

---

## 3. "Edgy" and "General"

Hono is "edgy"

* Four routers
  * Trie-Router/RegExpRouter/StaticRouter/SmartRouter
* Optimized for speed
* Little bit fat
  * Although the core is only 35kB!
* Making "Validator" that is magical

---

## I want to keep Hono "Edgy"

---

## But sometimes we want "general" framework

* Should be small
* Should not depend other libraries
* Best for beginners
* Will be used in such "Cloudflare Official Blog"
* Bridge to other frameworks
  * There should be many other frameworks

---

## Pico

Ultra-tiny web framework for Cloudflare Workers and Deno

https://github.com/yusukebe/pico

---

* Ultra tiny - about 1kB!
* Using `URLPattern`
* Works on Cloudflare Workers and Deno
* Compatible with Hono

---

```ts
import { Pico } from '@picojs/pico'

const app = new Pico()
app.get('/', (c) => c.text('Hello Pico!'))

export default app
```

---

## Migrate to Hono

```ts
import { Pico } from '@picojs/pico'
const app = new Pico()
```

To

```ts
import { Hono } from 'hono'
const app = new Hono()
```

---

* Hono for making practical application
* Pico for general purpose
* But it's just an idea

---

## 4. For "Frontend" and "Client"

---

### For "Frontend"

* Hono has JSX but we can't "Frontend"
  * It's just a template engine not DOM builder
* HTML based approach not React
* e.g. Hotwire <https://hotwired.dev>

---

### For "Client"

* Generate the API Spec as Types
* Share the Types in both Server and Client
* Like "tRPC" but it is integrated with Server

---

#602 [*](https://user-images.githubusercontent.com/10682/195980084-bca96407-3f16-4e9d-bcd4-93b35b8c89e9.gif)

![SS](https://user-images.githubusercontent.com/10682/195980084-bca96407-3f16-4e9d-bcd4-93b35b8c89e9.gif)

---

## BTW

It is tiring to do maintenance while doing daily work.
I am dreaming of making this my main job.

---

:)