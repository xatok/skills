---
name: mental-model-first
description: Open dense writing with a 1-3 sentence plain-English mental model — the picture in the head of someone who already gets it — then write the real thing in language a tired human can read. Use for explanations, architecture and design notes, PR and commit descriptions, READMEs, specs, debugging write-ups, reports, and any answer thick with jargon.
---

# Mental model first

Dense text fails not because the words are hard, but because the reader has
nowhere to put them. Give them somewhere to put them first.

Open with the mental model. Then write the real thing, complete and precise.

```
> **In plain English:** <1-3 sentences. The picture, not the facts.>
```

Blank line, then the full text — every name, number, path, and caveat intact.
Code and quoted material stay exactly as they are.

## Not a summary, not a rewrite

|  | What it gives |
|---|---|
| Summary | The same facts, fewer of them |
| Rewrite | The same facts, easier words |
| **Mental model** | **The one idea that makes the facts obvious** |

A summary answers "what does it say?" A mental model answers "what is this,
really?" Write the second one.

## How to write one

1. **Say what it actually is**, using none of the subject's own nouns. If you
   can't, you don't have the model yet — keep digging until you do.
2. **Say the trick** — the single idea that makes everything downstream
   inevitable. Usually one clause.
3. **Cut the rest.** Names, numbers, flags, edge cases go below, not here.

With no everyday equivalent, anchor to a physical one. Concrete beats complete
here; the complete version is two lines down.

### Examples

- **Debounce** — *It's the elevator door. Every new person walking up restarts
  the timer, and it closes only once nobody has come for a few seconds.*
- **A scoped access token** — *It's a valet key. It starts the car and it will
  not open the trunk.*
- **A cash-flow shortfall** — *You can be profitable and still bounce a check.
  The money lands in March; the rent is due in January.*

## Then write the body in plain English

The block hands over the shape. The body has to stay readable, or you have
merely bolted a good sentence onto bad prose.

Short sentences. Everyday words. Every sentence carrying a fact no other
sentence carries. Delete the ones that don't — that is most of the problem.

| Tell | Instead |
|---|---|
| Preamble: "Great question", "Let's dive in", "In this section we'll explore" | Start with the sentence that carries information |
| Inflated verbs: leverage, utilize, facilitate, enable, ensure | use, do, let, make sure |
| Vague nouns: solution, approach, framework, capabilities, functionality | Name the actual thing |
| Sales adjectives: robust, seamless, powerful, comprehensive, elegant | Cut them. Say what it does |
| Hedges: generally, typically, it's worth noting, may potentially | Commit — or state the exact condition |
| Decorative triads: "fast, flexible, and reliable" | One true item beats three that rhyme |
| "It's not just X — it's Y" | Say what it is, once |
| Labels: "Key takeaway:", "Important to note:" | If it matters, it is already there |
| Restating the question before answering | Answer it |
| A closing paragraph that repeats the opening | Stop when you are done |

Before and after:

- ✗ *This approach leverages a robust caching layer to ensure optimal
  performance, and it's worth noting that it may potentially reduce latency
  significantly in most scenarios.*
- ✓ *It keeps the last 500 results in memory, so a repeated request skips the
  database. Cold requests are unchanged.*

## Rules

- **1-3 sentences, under 60 words.** A long mental model is a summary wearing a
  hat.
- **No jargon in the block** — not even softened. That is the whole point.
- **Invent nothing.** The model must be true to what follows, only coarser.
- **Never let the block replace the detail.** It is a doorway, not a
  destination.
- **Skip it when it earns nothing** — short answers, a direct question, a
  yes/no, anything with no concept in it. A mental model for `npm install` is
  noise.
- **Silence beats decoration.** If the honest version of a sentence is nothing,
  write nothing.

## The test

Delete the block. Is the reader worse off?

Now read only the block. Could a smart outsider guess the *shape* of what
follows — and be surprised by none of it?

Both yes: ship it. Either no: you wrote a summary.
