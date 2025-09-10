build:
	hugo

serve:
	hugo serve

check: build
	mdl --style=.mdlrc.rb ./content
	htmlproofer --enforce-https=false --ignore-missing-alt=true --ignore-status-codes "999,429,403,0" --ignore-urls=/github.com/,/cdn./,/discord.gg/,/t.me/,/tools.ietf.org/,/www.googletagmanager.com/,/googletagmanager.com/ ./public
	python3 .github/workflows/check_images.py ./static/images

exif:
	for i in $(shell find ./static/images -name "*.png" -o -name "*.gif" -o -name "*.jpg" -o -name "*.jpeg"); do \
		echo "Processing $$i"; \
		exiftool -all= "$$i"; \
	done

