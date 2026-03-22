# Neat Utils

Claude Code custom utility skills.

## Skills

| Skill | Name | Description |
| --- | --- | --- |
| `neat_util_pdf` | neat-util-pdf | PDF document generator using Playwright |
| `neat_util_insights` | neat-util-insights | Claude Code insights report reviewer and suggestion tracker |
| `neat_util_lint` | neat-util-lint | Skill pipeline linter for structural and logic consistency |

## Install / Uninstall

```bash
# Install one or more skills
./scripts/install.sh pdf insights lint

# Uninstall
./scripts/uninstall.sh pdf insights lint
```

## Conventions

- Folder naming: `neat_util_<skill>/`
- Skill naming: `neat-util-<name>` (in SKILL.md frontmatter)
- Output: saved under `docs/` in the target project (each skill defines its path)

## License

[MIT](LICENSE)
