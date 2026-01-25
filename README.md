# Kseito's Blog

A personal blog about technology and daily life.

## Site URL

https://kseito.github.io

## Tech Stack

- **Jekyll**: 4.4.1
- **Theme**: [Minimal Mistakes Jekyll Theme](https://mmistakes.github.io/minimal-mistakes/)
- **Hosting**: GitHub Pages
- **Deployment**: GitHub Actions (automatic)

## Setup

### Prerequisites

- Ruby 3.0 or higher
- Bundler

### Local Development

1. Clone the repository

```bash
git clone https://github.com/kseito/kseito.github.io.git
cd kseito.github.io
```

2. Install dependencies

```bash
bundle install
```

3. Start the local server

```bash
bundle exec jekyll serve
```

4. Open your browser and navigate to

```
http://localhost:4000
```

## Basic Usage

### Creating a New Post

#### Using the Script (Recommended)

Run the `new_post.sh` script with your desired post title:

```bash
./new_post.sh my-new-post
```

This will create a new file `_posts/YYYY-MM-DD-my-new-post.md` with the front matter template already set up.

#### Manual Creation

1. Create a new Markdown file in the `_posts` directory
2. Name the file using the format: `YYYY-MM-DD-title.md`

Example: `2025-10-25-my-new-post.md`

3. Add Front Matter

```markdown
---
layout: single
title: "Your Post Title"
date: 2025-10-25 12:00:00 +0900
categories: [tech]
tags: [Jekyll, blog]
---

Write your content here.
```

### Front Matter Fields

- `layout`: Layout type (typically `single`)
- `title`: Post title
- `date`: Publication date and time
- `categories`: Categories (array format)
- `tags`: Tags (array format)

### Previewing Changes

With the local server running, file changes will automatically trigger a rebuild.
Reload your browser to see the updates.

### Deployment

Push to the `main` branch and GitHub Actions will automatically build and deploy the site.
Changes will be live on GitHub Pages within a few minutes.

## Linting with textlint

This project uses [textlint](https://textlint.github.io/) to maintain consistent Japanese writing quality.

### Prerequisites

- Node.js 18.0 or higher
- npm

### Install Dependencies

```bash
npm install
```

### Running textlint

Check all posts for writing issues:

```bash
npm run lint
```

Automatically fix issues where possible:

```bash
npm run lint:fix
```

Check a specific post:

```bash
npx textlint _posts/YYYY-MM-DD-your-post.md
```

### textlint Rules

The project uses the following rule presets configured for a friendly, essay-style tone:

- **preset-ja-spacing**: Japanese spacing rules
- **preset-ja-technical-writing**: Technical writing rules (configured loosely)
- **no-doubled-joshi**: Checks for repeated particles (助詞) in sentences

Configuration can be customized in `.textlintrc.json`.

## Directory Structure

```
.
├── _config.yml          # Jekyll configuration file
├── _posts/              # Blog posts
├── _data/               # Data files (navigation, etc.)
├── _includes/           # Reusable components
├── _layouts/            # Layout templates
├── _site/               # Generated static files (gitignored)
├── about.markdown       # About page
├── index.html           # Homepage
├── Gemfile              # Ruby dependencies
└── .github/workflows/   # GitHub Actions configuration
```

## Customizing Site Settings

Edit `_config.yml` to customize site-wide settings:

- Site title and description
- Social media links
- Theme skin
- Author information
- Plugin configuration

Note: Restart the local server after changing `_config.yml`.

## Plugins

This blog uses the following Jekyll plugins:

- `jekyll-feed`: RSS feed generation
- `jekyll-seo-tag`: SEO optimization
- `jekyll-sitemap`: Sitemap generation
- `jekyll-include-cache`: Performance improvements

## License

Personal blog content - all rights reserved for individual articles.
