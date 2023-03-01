---
title: "Cloudflare Pages Step by Step"
date: 2023-03-01T22:47:06+09:00
outputs: 'Reveal'
draft: false
---

# Cloudflare Pages Step by Step

* Yusuke Wada <https://github.com/yusukebe>
* 2023-03-01 [Serverless Meetup Japan Virtual #26](https://serverless.connpass.com/event/274263/)

---

## Me:)

* Yusuke Wada
* <https://github.com/yusukebe>
* <https://twitter.com/yusukebe>
* Creator of [Hono](https://hono.dev/)

---

## Agenda

---

Creating a full-stack application on Cloudflare Pages

"**Step-by-Step**"

---

[github.com/yusukebe/cloudflare-pages-step-by-step](https://github.com/yusukebe/cloudflare-pages-step-by-step)

---

## TOC

* 01 Basic
* 02 Vite
* 03 React
* 04 Functions
* 05 Hono
* 06 D1
* 07 RPC
* 08 Testing

---

## What is a Cloudflare Pages

---

> Cloudflare Pages is a JAMstack platform for frontend developers to collaborate and deploy websites.
> 
> <https://pages.cloudflare.com>

---

> * **Developer-focused** with effortless Git integration.
> * **Advanced collaboration** built-in with unlimited seats.
> * **Unmatched performance** on Cloudflare’s edge network.
> * **Dynamic functionality** through integration with Cloudflare Workers.
>
> <https://pages.cloudflare.com>

---

## The frameworks

---

* Gatsby
* Jekyll
* Next.js
* Nuxt.js
* Preact
* Qwik
* Svelte
* ...

---

Also Hono!

![SS](https://ss.yusukebe.com/7eeac7060096d3f7ed6bbc4391d1374e0335fa6c365c895e71e4d9bf51621567.png)

---

Three ways to set up a Pages project:

1. Git
2. Direct Uploads
3. Wrangler

---

## Develop with Wrangler

```txt
wrangler pages dev <directory | command>
```

---

## Deploy with Wrangler


```txt
wrangler pages publish <directory>
```

---

## 01 Basic


```txt
.
├── package.json
└── pages
    └── index.html
```

```txt
wrangler pages dev ./pages
```

---

## 02 Vite

```txt
.
├── index.html
├── package.json
└── vite.config.ts
```

```txt
wrangler pages dev -- vite
```

---

## What is Vite?

> Vite is a build tool that aims to provide a faster and leaner development experience for modern web projects. It consists of two major parts:
> 
> * A dev server - ...
> * A build command - ...

[vitejs.dev/guide/](https://vitejs.dev/guide/)

---

## 03 React

```txt
.
├── index.html
├── package.json
├── src
│   ├── App.tsx
│   └── main.tsx
├── tsconfig.json
└── vite.config.ts
```

---

## 04 Functions

```txt
.
├── functions
│   └── hello.ts
├── package.json
└── pages
    └── index.html
```

---

## 05 Hono

```txt
.
├── functions
│   └── api
│       └── [[route]].ts
├── package.json
└── pages
    └── index.html
```

---

## 06 D1

```txt
.
├── functions
│   └── api
│       └── [[route]].ts
├── package.json
├── pages
│   └── index.html
├── posts.sql
└── wrangler.toml
```

---

## 07 RPC

```txt
.
├── functions
│   └── api
│       └── [[route]].ts
├── index.html
├── package.json
├── src
│   ├── App.tsx
│   └── main.tsx
├── tsconfig.json
└── vite.config.ts
```

---

## 08 Testing

```txt
.
├── functions
│   └── api
│       └── [[route]].ts
├── jest.config.js
├── package.json
├── pages
│   └── index.html
└── server
    ├── index.test.ts
    └── index.ts
```

---

## Full-stack  "[TODO](https://github.com/yusukebe/hono-examples/tree/main/projects/todo>)"

```txt
.
├── common
│   └── types.ts
├── front
│   ├── App.tsx
│   ├── client.ts
│   ├── components
│   │   ├── AddTaskForm.tsx
│   │   ├── TaskItem.tsx
│   │   └── TaskList.tsx
│   └── main.tsx
├── functions
│   └── api
│       └── [[route]].ts
├── index.html
├── package.json
├── server
│   └── index.ts
├── todo.sql
├── tsconfig.json
├── vite.config.ts
└── wrangler.toml
```

---

## Wrap-up

* Create a full-stack application on Cloudflare Pages
* Web API with Cloudflare Functions
* Database with Cloudflare D1
* React SPA in `pages`
