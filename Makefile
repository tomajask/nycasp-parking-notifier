TAG = nycasp-parking-notifier

build:
	docker build -t $(TAG) .

dev: build
	docker run --rm -it --volume "$(shell pwd):/notifier" $(TAG)

run: build
	docker run --rm -it $(TAG) ruby notifier.rb
