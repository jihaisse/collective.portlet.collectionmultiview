#! /bin/bash

I18NDOMAIN="collective.portlet.collectionmultiview" # A remplacer par le domaine du produit

# creation des langues. Ajoutez les langues voulues dans le tableau
langues=(en fr nl)
for lang in "${langues[@]}"; do
	mkdir -p locales/${lang}/LC_MESSAGES
	touch locales/${lang}/LC_MESSAGES/${I18NDOMAIN}.po
	touch locales/${lang}/LC_MESSAGES/plone.po
done

# creation du fichier .pot
touch locales/${I18NDOMAIN}.pot
touch locales/manual.pot
touch locales/plone.pot

# Synchronise the templates and scripts with the .pot.
# All on one line normally:
i18ndude rebuild-pot --pot locales/${I18NDOMAIN}.pot \
    --create ${I18NDOMAIN} \
    --merge locales/manual.pot \
   .

# Synchronise the resulting .pot with all .po files
for po in locales/*/LC_MESSAGES/${I18NDOMAIN}.po; do
    i18ndude sync --pot locales/${I18NDOMAIN}.pot ${po}
done

# Synchronise the plone.pot with all plone.po files
touch locales/plone.pot
for po in locales/*/LC_MESSAGES/plone.po; do
    i18ndude sync --pot locales/plone.pot ${po}
done

# Compile all .po in .mo
for po in $(find . -path '*/LC_MESSAGES/*.po'); do
    msgfmt -o ${po/%po/mo} ${po}
done
