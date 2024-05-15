.DEFAULT_GOAL := rebuild

clean:
	flutter packages pub run build_runner clean

build:
	flutter packages pub run build_runner build --delete-conflicting-outputs

rebuild:
	flutter packages pub run build_runner clean
	flutter packages pub run build_runner build --delete-conflicting-outputs