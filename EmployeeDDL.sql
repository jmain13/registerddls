CREATE EXTENSION "uuid-ossp";

CREATE TYPE role AS ENUM ('General Manager', 'Shift Manager', 'Cashier');

CREATE TABLE Employee (
    RecordID uuid NOT NULL,
    fName character varying(32) NOT NULL DEFAULT(''),
    lName character varying(32) NOT NULL DEFAULT(''),
    employeeID int NOT NULL DEFAULT(0),
    active BOOLEAN NOT NULL DEFAULT(FALSE),
    position role NOT NULL,
    Manager character varying(32) NOT NULL DEFAULT(''),
    password character varying(32) NOT NULL,
    createdOn timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT employee_pkey PRIMARY KEY (RecordID)
) WITH (
  OIDS=FALSE
);

CREATE INDEX ix_employee_employeeID
    ON Employee
    USING btree
    (employeeID);
    
