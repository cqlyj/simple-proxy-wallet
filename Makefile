-include .env

all : install build

build :; @forge build

install:
	@forge install OpenZeppelin/openzeppelin-contracts@v5.2.0 --no-commit && forge install OpenZeppelin/openzeppelin-contracts-upgradeable@v5.2.0 --no-commit