---
title: "Dive into Cloudflare Workers"
date: 2022-11-27T15:05:25+09:00
outputs: 'Reveal'
---

# Dive into Cloudflare Workers

2022-12-03 PWA Night Conference 2022

Yusuke Wada

---

## Me:)

* Yusuke Wada
* Supervisor at TravelBook Inc. <https://www.travelbook.co.jp>
* Web framework developer
* <https://yusukebe.com>
* <https://github.com/yusukebe>

---

Today's topics

## Cloudflare Workers

with D1 and Hono

---

### Cloudflare Workers

* Works on the Edge
* "Glue" for Supercloud
* Small and Fast
* Easy to deploy
* Write in JavaScript

---

### Cloudflare D1

* Serverless SQL database
* SQLite is used inside
* Integrated with Workers
* Open alpha

---

### Hono

* Created by me:)
* https://honojs.dev
* https://github.com/honojs/hono
* Fast web framework
* Works on Cloudflare Workers, Deno, Bun, and Node.js
* Using Web Standard API
* Express.js like syntax

---

## Live-coding

Making a Blog site

* Cloudflare Workers
* Cloudflare D1
* Hono

---

<https://github.com/yusukebe/hello-d1>

---

## 1. Your first Worker

---

### Setup project

```plain
yarn init -y
yarn add -D wrangler
yarn wrangler init -y
```

---

### Install Hono

```plain
yarn add hono
```

---

### `package.json`

```json
"scripts": {
  "dev": "wrangler dev src/index.tsx",
  "deploy": "wrangler publish src/index.tsx",
  "test": "jest"
}
```

---

### `tsconfig.json`

```json
{
  "compilerOptions": {
    "lib": [
      "ESNext"
    ],
    "types": [
      "jest",
      "@cloudflare/workers-types"
    ],
    "jsx": "react",
    "jsxFactory": "jsx",
    "jsxFragmentFactory": "Fragment"
  },
  "include": [
    "src/**/*",
    "tests/**/*"
  ]
}
```

---

### Write code

`src/index.tsx`

```ts
import { Hono } from 'hono'

const app = new Hono()
app.get('/hello', (c) => c.text('Hello PWA night!'))

export default app
```

---

### Run

```plain
yarn dev
```

```plain
open http://localhost:8787
```

---

### Deploy

```plain
yarn deploy
```

---

👍

---

## 2. Using Hono

---

<https://honojs.dev/>

---

👍

---

## 3. Blog Part 1

---

Model

```ts
type Post = {
  title: string
  body: string
}

const posts: Post[] = []
```

---

Logic

```ts
const createPost = (post: Post) => {
  posts.push(post)
}

const getPosts = () => {
  return posts
}
```

---

Validator Middleware

```ts
import { validator } from 'hono/validator'
```

---

`app.post('/post')`

```ts
app.post(
  '/post',
  validator((v) => ({
    title: v.body('title').isRequired(),
    body: v.body('body').isRequired(),
  })),
  (c) => {
    const { title, body } = c.req.valid()
    createPost({ title, body })
    return c.redirect('/')
  }
)
```

---

TSX

```plain
touch src/Layout.tsx
touch src/Top.tsx
```

---

`Layout.tsx`

```tsx
import { html } from 'hono/html'

export const Layout = (props: any) => html`<!DOCTYPE html>
  <html>
    <head>
      <title>Hello D1!</title>
      <link rel="stylesheet" href="https://unpkg.com/@picocss/pico@latest/css/pico.min.css" />
    </head>
    <body>
      <body>
        <main class="container">${props.children}</main>
      </body>
    </body>
  </html>`
```

---

`Top.tsx`

```tsx
import { jsx } from 'hono/jsx'
import { Layout } from './Layout'
import type { Post } from './index'
```

---

```tsx
const Form = () => {
  return (
    <form action='/post' method='POST'>
      <label>
        Title:
        <input name='title' />
      </label>
      <label>
        Body:
        <textarea name='body' rows='5' cols='33'></textarea>
      </label>
      <input type='submit' />
    </form>
  )
}
```

---

```tsx
export const Top = (props: { posts: Post[] }) => {
  return (
    <Layout>
      <h1>
        <a href='/'>Hello D1!</a>
      </h1>
      <Form />
      <hr />
      {props.posts.reverse().map((post) => {
        return (
          <article>
            <h2>{post.title}</h2>
            <p>{post.body}</p>
          </article>
        )
      })}
    </Layout>
  )
}
```

---

`app.get('/')`

```tsx
import { jsx } from 'hono/jsx'
import { Top } from './Top'

//...

app.get('/', (c) => {
  const posts = getPosts()
  return c.html(<Top posts={posts} />)
})
```

---

```plain
yarn dev
yarn deploy
```

---

👍

---

## 4. Using D1

---

`blog.sql`

```sql
CREATE TABLE post (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL
);
```

---

Create Database

```plain
wrangler d1 create pwa-night
```

---

`wrangler.toml`

```toml
[[ d1_databases ]]
binding = "DB"
database_name = "pwa-night"
database_id = ""
preview_database_id = ""
```

---

```plain
wrangler d1 execute pwa-night --file blog.sql
wrangler d1 execute pwa-night --command "SELECT name FROM sqlite_schema WHERE type ='table'"
```

---

👍

---

## 5. Blog Part 2

---

Bindings

```ts
interface Env {
  DB: D1Database
}

const app = new Hono<{ Bindings: Env }>()
```

---

`app.get('/')`

```ts
const { results } = await c.env.DB.prepare(
  `SELECT id,title,body FROM post;`
).all<Post>()
const posts = results
```

---

`app.post('/post')`

```ts
await c.env.DB.prepare(`INSERT INTO post(title, body) VALUES(?, ?);`)
  .bind(title, body)
  .run()
```

---

```plain
yarn dev
yarn deploy
```

---

👍

---

## 6. Tests

---

```plain
yarn add -D jest jest-environment-miniflare @types/jest esbuild-jest
```

---

`jest.config.js`

```js
module.exports = {
  testEnvironment: 'miniflare',
  testMatch: ['**/tests/**/*.+(ts|tsx)'],
  transform: {
    '^.+\\.(ts|tsx)$': 'esbuild-jest',
  },
}
```

---

`tests/index.ts`

```ts
import app from '../src/index'

describe('Test endpoints', () => {
  it('Should return 200 Response', async () => {
    const res = await app.request('http://localhost/hello')
    expect(res.status).toBe(200)
    expect(await res.text()).toBe('Hello!')
  })
})
```

---

## 7. Wrap up

* Your First Worker
* Using Hono
* Blog Part1
* Using D1
* Blog Part2
* Tests

---

## Try Cloudflare Workers