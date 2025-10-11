# はてなブログ自動投稿の設定手順

このリポジトリでは、`_posts/` ディレクトリに新しい記事を追加してpushすると、自動的にはてなブログに下書きとして投稿されます。

## 使い方

1. `_posts/` ディレクトリに新しい記事を作成（例: `2025-10-11-new-post.md`）
2. Front matterに `title` と `tags` または `categories` を記載：

```markdown
---
layout: single
title: "記事のタイトル"
date: 2025-10-11 12:00:00 +0900
categories: tech
tags: [Ruby, Jekyll]
---

記事の本文...
```

3. GitHubにpush：

```bash
git add _posts/2025-10-11-new-post.md
git commit -m "Add new post"
git push
```

4. GitHub Actionsが自動的に実行され、はてなブログに下書きとして投稿されます
5. はてなブログの管理画面で下書きを確認し、必要に応じて編集・公開

## トラブルシューティング

### GitHub Actionsが失敗する場合

- Secretsが正しく設定されているか確認
- はてなIDとAPIキーが正しいか確認
- Actions タブでエラーログを確認

### 記事が投稿されない場合

- `_posts/` ディレクトリ内の `.md` または `.markdown` ファイルか確認
- Front matterに `title` が含まれているか確認
- 新規ファイルとして追加されているか確認（編集のみでは投稿されません）
