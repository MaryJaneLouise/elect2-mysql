DROP SCHEMA IF EXISTS onlinebookstoredb;
CREATE SCHEMA onlinebookstoredb;
USE onlinebookstoredb;

DROP TABLE author;
DROP TABLE books;
DROP TABLE customer;
DROP TABLE orderDetails;
DROP TABLE publisher;
DROP TABLE orders;
DROP TABLE shipment;

CREATE TABLE author(
    author_id               INT NOT NULL AUTO_INCREMENT,
    author_name             VARCHAR(45) NOT NULL,
    author_biography        VARCHAR(45) NULL,

    PRIMARY KEY (author_id)
);

CREATE TABLE publisher(
    publisher_id            INT NOT NULL AUTO_INCREMENT,
    publisher_name          VARCHAR(45) NOT NULL,
    publisher_address       VARCHAR(45) NOT NULL,

    PRIMARY KEY (publisher_id)
);

CREATE TABLE customer(
    customer_id               INT NOT NULL AUTO_INCREMENT,
    customer_name             VARCHAR(45) NOT NULL,
    customer_emailAdd         VARCHAR(45) NOT NULL,
    customer_pass             VARCHAR(45) NOT NULL,

    PRIMARY KEY (customer_id)
);

CREATE TABLE books (
    book_ISBN               VARCHAR(45) NOT NULL,
    book_title              VARCHAR(45) NOT NULL,
    book_publicationDate    DATE NOT NULL,
    book_price              DECIMAL(10, 2) NOT NULL,
    book_description        VARCHAR(45) NOT NULL,

    author_id               INT NOT NULL,
    publisher_id            INT NOT NULL,

    PRIMARY KEY (book_ISBN),
    INDEX fk_author_id_idx (author_id ASC) VISIBLE,
    CONSTRAINT fk_author_id
        FOREIGN KEY (author_id)
        REFERENCES author (author_id)
        ON DELETE CASCADE
        ON UPDATE RESTRICT,
    INDEX fk_publisher_id_idx (publisher_id ASC) VISIBLE,
    CONSTRAINT fk_publisher_id
        FOREIGN KEY (publisher_id)
        REFERENCES publisher (publisher_id)
        ON DELETE CASCADE
        ON UPDATE RESTRICT
);

CREATE TABLE orders(
    order_id                  INT NOT NULL AUTO_INCREMENT,
    order_date                DATE NOT NULL,
    order_status              VARCHAR(45) NOT NULL,
    order_totalPrice          DECIMAL(20, 2) NOT NULL,
    order_shippingAdd         VARCHAR(45) NOT NULL,

    customer_id               INT NOT NULL,

    PRIMARY KEY (order_id),
    INDEX fk_customer_id_idx (customer_id ASC) VISIBLE,
    CONSTRAINT fk_customer_id
        FOREIGN KEY (customer_id)
        REFERENCES customer (customer_id)
        ON DELETE CASCADE
        ON UPDATE RESTRICT
);

CREATE TABLE orderDetails(
    orderDetail_id          INT NOT NULL AUTO_INCREMENT,
    book_ISBN               VARCHAR(45) NOT NULL,
    order_id                INT NOT NULL,

    PRIMARY KEY (orderDetail_id),
    INDEX fk_book_ISBN_idx (book_ISBN ASC) VISIBLE,
    CONSTRAINT fk_book_ISBN
        FOREIGN KEY (book_ISBN)
        REFERENCES books (book_ISBN)
        ON DELETE CASCADE
        ON UPDATE RESTRICT,
    INDEX fk_order_id_idx (order_id ASC) VISIBLE,
    CONSTRAINT fk_order_id
        FOREIGN KEY (order_id)
        REFERENCES orders (order_id)
        ON DELETE CASCADE
        ON UPDATE RESTRICT
);

CREATE TABLE shipment(
    shipment_trackingNumber VARCHAR(45) NOT NULL,
    shipment_shipDate       DATE NOT NULL,
    shipment_delDate        DATE NOT NULL,

    order_id          INT NOT NULL,
    PRIMARY KEY (shipment_trackingNumber),
    INDEX fk_orderDetail_id_idx (order_id ASC) VISIBLE,
    CONSTRAINT fk_shipmentOrder_id
        FOREIGN KEY (order_id)
        REFERENCES orders (order_id)
        ON DELETE CASCADE
        ON UPDATE RESTRICT
);