#!/usr/bin/env bash
# Build do app Flutter Web no Vercel.
# O Vercel não traz o Flutter pré-instalado, então baixamos o SDK e compilamos.
set -euo pipefail

# Versão do Flutter usada no build (a mesma validada no CI).
FLUTTER_VERSION="${FLUTTER_VERSION:-3.44.2}"
FLUTTER_DIR="$HOME/flutter"

echo "==> Preparando Flutter $FLUTTER_VERSION"
if [ ! -x "$FLUTTER_DIR/bin/flutter" ]; then
  git clone https://github.com/flutter/flutter.git \
    --depth 1 --branch "$FLUTTER_VERSION" "$FLUTTER_DIR"
fi
export PATH="$FLUTTER_DIR/bin:$PATH"

# Evita aviso de "dubious ownership" no container do Vercel.
git config --global --add safe.directory "$FLUTTER_DIR" || true

echo "==> Versão do Flutter"
flutter --version

echo "==> Dependências"
flutter config --enable-web
flutter pub get

echo "==> Build web (base-href na raiz do domínio)"
# No Vercel o app é servido em "/", então o base-href padrão "/" está correto.
flutter build web --release

echo "==> Build concluído em build/web"
