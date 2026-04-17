# jiratui config

## Setup

1. Copy `.env.example` to `.env` and fill in your credentials:

   ```sh
   cp .env.example .env
   ```

2. Edit `.env` with your values:

   ```
   JIRA_API_USERNAME=your-email@example.com
   JIRA_API_TOKEN=your-jira-api-token
   JIRA_API_BASE_URL=https://your-org.atlassian.net
   ```

3. Source the env file before running jiratui:

   ```sh
   source ~/.config/jiratui/.env && jiratui
   ```

   Or add to your shell profile / use [direnv](https://direnv.net/) to auto-load it.

## Files

| File | Description |
|------|-------------|
| `config.yaml` | Main config — safe to commit |
| `.env` | Your credentials — **gitignored, never commit** |
| `.env.example` | Template for credentials — safe to commit |
