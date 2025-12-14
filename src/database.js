import {Client} from "jsr:@db/postgres";

export var client = new Client({
    hostname: "localhost",
    port: 5432,
    user: "subnodal",
    password: "subnodal",
    database: "subnodal",
    tls: {
        enabled: false
    }
});

await client.connect();