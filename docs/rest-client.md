# 🔌 REST client — testing your DRF APIs

Kulala replaces Postman with plain-text `.http` files that live in your repo,
go through code review and get versioned like everything else. No account, no
GUI, no separate collection to keep in sync with the code.

> Requires `curl` and `git`. On first use it downloads `kulala-core` (~100 MB)
> into `~/.local/share/nvim/kulala.nvim/bin/`. Check it with `:checkhealth kulala`.

---

## The 30-second version

Create `api.http` anywhere in your Django project:

```http
GET http://127.0.0.1:8000/api/products/
Accept: application/json
```

Put the cursor on it and press `Space+Rs`. The response opens in a split on the
right, JSON already formatted.

That's the whole loop. Everything below is convenience.

---

## Several requests in one file

`###` separates requests. Give them a name and you can reference their
responses later.

```http
### LIST_PRODUCTS
GET http://127.0.0.1:8000/api/products/

### CREATE_PRODUCT
POST http://127.0.0.1:8000/api/products/
Content-Type: application/json

{
  "name": "Keyboard",
  "price": "49.99"
}
```

`Space+Rn` / `Space+Rp` jump between them, `Space+Rf` searches them by name,
and `Space+Ra` fires the whole file in order.

> The blank line between the headers and the JSON body is **required**. Without
> it Django receives an empty body and DRF answers `400`.

---

## Environments — never hardcode the host

Put `http-client.env.json` next to your `.http` file:

```json
{
  "dev": {
    "host": "http://127.0.0.1:8000",
    "token": "paste-your-dev-token"
  },
  "staging": {
    "host": "https://staging.example.com",
    "token": "..."
  }
}
```

Then use `{{host}}` in the requests:

```http
GET {{host}}/api/products/
Authorization: Token {{token}}
```

`Space+Re` switches environment. The choice is **per buffer**, so one file can
point at local while another hits staging. `dev` is the default (set in
`lua/plugins/http.lua`).

> ⚠️ Secrets go in `http-client.private.env.json`, which Kulala reads and merges
> on top. **Add it to `.gitignore`** — the plain `http-client.env.json` is meant
> to be committed.

---

## DRF authentication

### TokenAuthentication

Log in once and capture the token automatically, so you never copy-paste it:

```http
### LOGIN
POST {{host}}/api/auth/token/
Content-Type: application/json

{
  "username": "admin",
  "password": "admin"
}

> {%
  client.global.set("token", response.body.json.token);
%}

### ME
GET {{host}}/api/me/
Authorization: Token {{token}}
```

Run `LOGIN` once (`Space+Rs`), then every request using `{{token}}` is
authenticated. `Space+Rx` clears the captured globals.

> `> {% ... %}` is a post-request script and runs on Node, which this config
> already requires for Copilot.

### SimpleJWT

Same idea, the token just lives under a different key:

```http
### LOGIN
POST {{host}}/api/token/
Content-Type: application/json

{ "username": "admin", "password": "admin" }

> {%
  client.global.set("access", response.body.json.access);
  client.global.set("refresh", response.body.json.refresh);
%}

### ME
GET {{host}}/api/me/
Authorization: Bearer {{access}}
```

### SessionAuthentication

DRF's session auth needs the CSRF token. Kulala keeps a cookie jar between
requests (`Space+Rj` opens it), so you only have to forward the header:

```http
### GET_CSRF
GET {{host}}/api/csrf/

### CREATE
POST {{host}}/api/products/
Content-Type: application/json
X-CSRFToken: {{GET_CSRF.response.cookies.csrftoken.value}}

{ "name": "Mouse", "price": "19.99" }
```

`{{NAME.response...}}` reads from a previous **named** request — but only after
you have actually run it.

---

## Uploads and other body types

```http
### UPLOAD
POST {{host}}/api/products/1/image/
Authorization: Token {{token}}
Content-Type: multipart/form-data

< ./fixtures/photo.png
```

```http
### FORM
POST {{host}}/api/login/
Content-Type: application/x-www-form-urlencoded

username=admin&password=admin
```

---

## Keymaps

All under `Space+R` (press `Space+R` and wait — which-key lists them).

| Shortcut | Action |
|----------|--------|
| `Space+Rs` | Send the request under the cursor |
| `Space+Ra` | Send every request in the file |
| `Space+Rr` | Replay the last request |
| `Space+Ro` / `Space+Rq` | Open / close the response window |
| `Space+Rt` | Toggle headers ↔ body |
| `Space+Rb` | Scratchpad (throwaway request, no file) |
| `Space+Rf` | Find request by name |
| `Space+Rn` / `Space+Rp` | Next / previous request |
| `Space+Re` | Select environment |
| `Space+Rc` | Copy the request as a `curl` command |
| `Space+RC` | Paste a `curl` command as a request |
| `Space+Ri` | Inspect the request with `{{variables}}` resolved |
| `Space+Rj` | Open the cookie jar |
| `Space+Rx` | Clear captured global variables |

Inside the response window: `Tab` / `Shift+Tab` cycle the panes (body, headers,
verbose, script output, report), and `q` closes it.

> `Space+Rc` is the bridge to the rest of the world: build the request here,
> copy it as `curl` and paste it into a bug report or a CI script.

---

## Suggested workflow with Django

1. `Space+ld` → LazyDocker, confirm Postgres is up.
2. `Space+tt` → terminal, `python manage.py runserver`.
3. `Ctrl+h/l` back to the code, open `api.http`.
4. `Space+Rs` on the request you are working on.
5. Something returns `500`? `Space+db` sets a breakpoint in the view and
   `Space+dc` starts the debugger — see [django.md](django.md).

Keep `api.http` committed next to the app it exercises. It doubles as
documentation: a new person clones the repo and has every endpoint runnable.

---

## Troubleshooting

| Symptom | Cause |
|---------|-------|
| `:checkhealth kulala` reports `kulala-core not found` | The backend didn't download. Re-open a `.http` file with a working connection. |
| Variables come through as literal `{{host}}` | `http-client.env.json` is not in the same folder as the `.http` file, or the environment name doesn't exist. `Space+Ri` shows what actually got resolved. |
| DRF answers `400` on a POST that looks right | Missing blank line between headers and body. |
| `{{NAME.response.body.$.x}}` arrives as plain text | The named request hasn't been run yet in this session. |
| The token expired mid-session | `Space+Rx` clears globals, then re-run `LOGIN`. |

More: `:help kulala`, or the per-topic help files (`:help kulala.authentication`).
