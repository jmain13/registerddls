CREATE EXTENSION "uuid-ossp";

CREATE TABLE product (
  id uuid NOT NULL,
  lookupcode character varying(32) NOT NULL DEFAULT(''),
  quantity int NOT NULL DEFAULT(0),
  price numeric(7, 2) NOT NULL DEFAULT(0),
  active boolean NOT NULL DEFAULT(FALSE),
  createdon timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT product_pkey PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);

CREATE INDEX ix_product_lookupcode
  ON product
  USING btree
  (lower(lookupcode::text) COLLATE pg_catalog."default");

INSERT INTO product VALUES (
       uuid_generate_v4()
     , 'lookupcode1'
     , 100
     , 0.01
     , FALSE
     , current_timestamp
);

INSERT INTO product VALUES (
       uuid_generate_v4()
     , 'lookupcode1'
     , 125
     , 10.50
     , FALSE
     , current_timestamp
);

INSERT INTO product VALUES (
       uuid_generate_v4()
     , 'lookupcode3'
     , 150
     , 19.64
     , FALSE
     , current_timestamp
);

INSERT INTO product VALUES (
       uuid_generate_v4()
     , 'lookupcode4'
     , 120
     , 10.00
     , TRUE
     , current_timestamp
);

INSERT INTO product VALUES (
       uuid_generate_v4()
     , 'lookupcode5'
     , 130
     , 21.50
     , TRUE
     , current_timestamp
);

CREATE TABLE employee (
  id uuid NOT NULL,
  employeeid character varying(32) NOT NULL DEFAULT(''),
  firstname character varying(128) NOT NULL DEFAULT(''),
  lastname character varying(128) NOT NULL DEFAULT(''),
  password character varying(512) NOT NULL DEFAULT(''),
  active boolean NOT NULL DEFAULT(FALSE),
  classification int NOT NULL DEFAULT(0),
  managerid uuid NOT NULL,
  createdon timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT employee_pkey PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);

CREATE INDEX ix_employee_employeeid
  ON employee
  USING hash(employeeid);


CREATE TABLE transaction (
  recordID uuid NOT NULL,
  cashierID int NOT NULL,
  totalQuantity int NOT NULL,
  totalPrice numeric(9, 2) NOT NULL,
  transactionType int NOT NULL, /*0 => Sale, 1 => Return*/
  referenceID uuid, /*if it's a Sale, then referenceID is NULL; otherwise it's the original Sale uuid*/
  createdon timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT transaction_key PRIMARY KEY (recordID)
) WITH (
  OIDS=FALSE
);

CREATE INDEX ix_transaction_recordID
  ON transaction
  USING hash(recordID);


CREATE TABLE transactionEntry (
  entryID uuid NOT NULL,
  fromTransaction uuid NOT NULL,
  lookupcode character varying(32) NOT NULL,
  quantity int NOT NULL DEFAULT(0),
  price numeric(7, 2) NOT NULL DEFAULT(0),
  PRIMARY KEY (entryID),
  FOREIGN KEY (fromTransaction) REFERENCES transaction (recordID)
) WITH (
  OIDS=FALSE
);


CREATE INDEX ix_transactionEntry_entryID
  ON transactionEntry
  USING hash(entryID);
