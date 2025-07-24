# bump_version 🌳

> "Structure isn't boring – it's your first line of clarity." — *You (probably during a cleanup)*

[![brew install](https://img.shields.io/badge/brew--install-success-green?logo=homebrew)](https://github.com/raymonepping/homebrew-bump_version)
[![version](https://img.shields.io/badge/version-0.6.1-blue)](https://github.com/raymonepping/homebrew-bump_version)

---

## 🚀 Quickstart

```bash
brew tap 
brew install /bump_version
bump_version
```

---


## 📂 Project Structure

```
./
├── bin/
│   ├── bump_version*
│   └── CHANGELOG_bump_version.md
├── Formula/
│   └── bump-version-cli.rb
├── lib/
├── tpl/
│   ├── readme_01_header.tpl
│   ├── readme_02_project.tpl
│   ├── readme_03_structure.tpl
│   ├── readme_04_body.tpl
│   ├── readme_05_quote.tpl
│   ├── readme_06_article.tpl
│   └── readme_07_footer.tpl
├── .backup.yaml
├── .backupignore
├── .version
├── FOLDER_TREE.md
├── README.md
├── reload_bump_version.sh*
└── sanity_check.md

5 directories, 17 files
```

---

## 🧭 What Is This?

bump_version is a Homebrew-installable, wizard-powered CLI that automates semantic versioning and changelog management in Bash scripts. It’s especially useful for:

- DevOps engineers maintaining custom Bash tooling or CLI projects
- Teams looking to standardize release versioning and automate changelogs
- Anyone tired of manual sed or awk gymnastics for version bumps

---

## 🔑 Key Features

- Instantly bump semantic versions (major, minor, patch) in Bash scripts
- Auto-generate or update changelog sections with conventional commit support
- Add clickable version badges for GitHub or Markdown docs
- Seamlessly integrates with release pipelines and CI/CD
- Zero-sed, zero-headache, emoji-ready 🐧

---

### Auto-bump your script version and changelog

```bash
bump_version
```

---

### ✨ Other CLI tooling available

✅ **brew-brain-cli**  
CLI toolkit to audit, document, and manage your Homebrew CLI arsenal with one meta-tool

✅ **bump-version-cli**  
CLI toolkit to bump semantic versions in Bash scripts and update changelogs

✅ **commit-gh-cli**  
CLI toolkit to commit, tag, and push changes to GitHub

✅ **folder-tree-cli**  
CLI toolkit to visualize folder structures with Markdown reports

✅ **radar-love-cli**  
CLI toolkit to simulate secret leaks and trigger GitHub PR scans

✅ **repository-audit-cli**  
CLI toolkit to audit Git repositories and folders, outputting Markdown/CSV/JSON reports

✅ **repository-backup-cli**  
CLI toolkit to back up GitHub repositories with tagging, ignore rules, and recovery

✅ **repository-export-cli**  
CLI toolkit to export, document, and manage your GitHub repositories from the CLI

✅ **self-doc-gen-cli**  
CLI toolkit for self-documenting CLI generation with Markdown templates and folder visualization

---

## 🧠 Philosophy

bump_version 

> Some might say that sunshine follows thunder
> Go and tell it to the man who cannot shine

> Some might say that we should never ponder
> On our thoughts today ‘cos they hold sway over time

---

## 📘 Read the Full Medium.com article

📖 [Article](..) 

---

© 2025 Your Name  
🧠 Powered by self_docs.sh — 🌐 Works locally, CI/CD, and via Brew
