DROP SCHEMA IF EXISTS onlinewebsite;
CREATE SCHEMA onlinewebsite;
USE onlinewebsite;

DROP TABLE users;
DROP TABLE blogs;
DROP TABLE comments;

CREATE TABLE users (
    username            VARCHAR(45) PRIMARY KEY NOT NULL,
    pass                VARCHAR(45) NOT NULL,
    email               VARCHAR(45) NOT NULL,
    userImage           BLOB NULL
);

CREATE TABLE blogs (
    blog_id             INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    blog_title          VARCHAR(45) NOT NULL,
    blog_body           VARCHAR(255) NOT NULL,
    blog_datePosted     DATE NOT NULL,

    author_username     VARCHAR(45) NOT NULL,
    INDEX fk_authorUsername_idx (author_username ASC) VISIBLE,
    CONSTRAINT fk_authorUsername_id
        FOREIGN KEY (author_username)
        REFERENCES users (username)
        ON DELETE CASCADE
        ON UPDATE RESTRICT
);

CREATE TABLE comments (
    comments_id         INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    comments_body       VARCHAR(45) NOT NULL,
    comments_datePosted DATE NOT NULL,

    author_username     VARCHAR(45) NOT NULL,
    blog_id             INT NOT NULL,
    INDEX fk_authorUsernameC_idx (author_username ASC) VISIBLE,
    CONSTRAINT fk_authorUsernameC_id
        FOREIGN KEY (author_username)
        REFERENCES users (username)
        ON DELETE CASCADE
        ON UPDATE RESTRICT,
    INDEX fk_blog_id_idx (blog_id ASC) VISIBLE,
    CONSTRAINT fk_blog_id
        FOREIGN KEY (blog_id)
        REFERENCES blogs (blog_id)
        ON DELETE CASCADE
        ON UPDATE RESTRICT
);