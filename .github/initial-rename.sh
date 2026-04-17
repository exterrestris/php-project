#!/usr/bin/env bash
TEMPLATE_NS=$(echo "$TEMPLATE" | tr '/' '\\' | tr '-' ' ' | tr '[:upper:]' '[:lower:]' | sed -E 's/[[:alnum:]]+/\u&/g' | sed 's/ //g' | sed 's/\\/\\\\/')
PROJECT_NS=$(echo "$PROJECT" | tr '/' '\\' | tr '-' ' ' | tr '[:upper:]' '[:lower:]' | sed -E 's/[[:alnum:]]+/\u&/g' | sed 's/ //g' | sed 's/\\/\\\\/')
COMPOSER_TEMPLATE_NS=$(echo "$TEMPLATE_NS" | sed 's/\\/\\\\/g')
COMPOSER_PROJECT_NS=$(echo "$PROJECT_NS" | sed 's/\\/\\\\/g')

echo "Replacing '$TEMPLATE' with '$PROJECT' in README.md"
sed --in-place -E "s,$TEMPLATE,$PROJECT," README.md

echo "Replacing '$TEMPLATE' with '$PROJECT' in composer.json"
sed --in-place -E "s,$TEMPLATE,$PROJECT," composer.json

echo "Replacing '$COMPOSER_TEMPLATE_NS' with '$COMPOSER_PROJECT_NS' in composer.json"
sed --in-place -E "s,$COMPOSER_TEMPLATE_NS,$COMPOSER_PROJECT_NS," composer.json

echo "Replacing '$TEMPLATE_NS' with '$PROJECT_NS' in .idea/php-project.iml"
sed --in-place -E "s,$TEMPLATE_NS,$PROJECT_NS," .idea/php-project.iml

echo "Removing CHANGELOG.md"
rm -rf CHANGELOG.md
