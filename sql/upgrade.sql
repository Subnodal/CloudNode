CREATE TABLE IF NOT EXISTS account (
    id BYTEA PRIMARY KEY,
    primary_region VARCHAR(20) NOT NULL
);

CREATE SCHEMA IF NOT EXISTS vpc;

CREATE TABLE IF NOT EXISTS vpc.vpc (
    id BYTEA PRIMARY KEY,
    account_id BYTEA NOT NULL REFERENCES account(id)
);

CREATE TABLE IF NOT EXISTS vpc.subnet (
    id BYTEA PRIMARY KEY,
    name VARCHAR(256) NOT NULL,
    vpc_id BYTEA NOT NULL REFERENCES vpc.vpc(id),
    az VARCHAR(20) NOT NULL,
    netmask INTEGER NOT NULL,
    is_public BOOLEAN NOT NULL
);

CREATE SCHEMA IF NOT EXISTS compute;

CREATE TABLE IF NOT EXISTS compute.instance (
    id BYTEA PRIMARY KEY,
    name VARCHAR(256) NOT NULL,
    account_id BYTEA NOT NULL REFERENCES account(id),
    az VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS compute.interface (
    id BYTEA PRIMARY KEY,
    compute_instance_id BYTEA NOT NULL REFERENCES compute.instance(id),
    subnet_id BYTEA NOT NULL REFERENCES vpc.subnet(id)
);

CREATE TABLE IF NOT EXISTS compute.firewall_rule (
    id BYTEA PRIMARY KEY,
    name VARCHAR(256) NOT NULL,
    interface_id BYTEA NOT NULL REFERENCES compute.interface(id),
    inbound BOOLEAN NOT NULL,
    port_start INTEGER NOT NULL,
    port_end INTEGER NOT NULL,
    protocol VARCHAR(20) NOT NULL
);