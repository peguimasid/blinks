### Blinks 🔗

A sleek and modern link storage built with Elixir, Phoenix, and LiveView.

#### Overview

Blinks is a simple Elixir application created to play with Phoenix LiveView. It demonstrates real-time link updates with PubSub and tracks users presence to display online users count.

#### Features

- Store and organize links with a clean interface
- Real-time updates across all connected clients
- Live tracking of online users via Phoenix Presence

#### Demo

Check out the real-time features in action:

https://github.com/user-attachments/assets/af5b2c9d-de83-46d1-a6ea-fc0971a8f363

#### Technology

- Elixir & Phoenix Framework
- Phoenix LiveView for reactive UIs
- Phoenix PubSub for real-time communication
- Phoenix Presence for user tracking

#### Quick Start

```bash
# Start database with Docker Compose
docker compose up -d

# Get dependencies
mix deps.get

# Setup database
mix ecto.setup

# Start server
mix phx.server
```

Visit [`localhost:4000`](http://localhost:4000) in your browser
