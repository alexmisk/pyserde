.PHONY: all setup build test coverage pep8 mypy fmt docs open-docs bench

all: setup test pep8 mypy

setup:
	pipenv install --dev
	pipenv run pip list

build:
	pipenv run python setup.py sdist
	pipenv run python setup.py bdist_wheel

test:
	pytest test_serde.py --doctest-modules serde -v

coverage:
	pytest test_serde.py --doctest-modules serde -v --cov=serde --cov-report term --cov-report xml

pep8:
	pipenv run flake8

mypy:
	pipenv run mypy serde

fmt:
	pipenv run yapf --recursive -i serde test_serde.py bench.py
	pipenv run isort -rc --atomic serde test_serde.py bench.py

docs:
	pipenv run pdoc serde --html -o html --force
	cp -f html/serde/* docs/

open-docs:
	pipenv run pdoc serde --html -o html --force --http 127.0.0.1:5001

bench:
	pipenv run python bench.py
