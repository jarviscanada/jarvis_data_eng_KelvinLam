CREATE TABLE IF NOT EXISTS PUBLIC.host_info
(
    id               SERIAL        NOT NULL,
    "timestamp"      TIMESTAMP     NOT NULL,
    hostname         TEXT          NOT NULL,
    cpu_number       int           NOT NULL,
    cpu_architecture TEXT          NOT NULL,
    cpu_model        TEXT          NOT NULL,
    cpu_mhz          NUMERIC(8, 3) NOT NULL,
    L2_cache         NUMERIC(8)    NOT NULL,
    total_mem        NUMERIC(8)    NOT NULL
);

CREATE TABLE IF NOT EXISTS PUBLIC.host_usage
(
    host_id        SERIAL     NOT NULL,
    "timestamp"    TIMESTAMP  NOT NULL,
    memory_free    NUMERIC(8) NOT NULL,
    cpu_idle       NUMERIC(3) NOT NULL,
    cpu_kernel     NUMERIC(3) NOT NULL,
    disk_io        NUMERIC(8) NOT NULL,
    disk_available NUMERIC(8) NOT NULL
);