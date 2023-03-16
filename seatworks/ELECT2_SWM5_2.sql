DROP SCHEMA IF EXISTS onlinefitnessapp;
CREATE SCHEMA onlinefitnessapp;
USE onlinefitnessapp;

DROP TABLE users;
DROP TABLE exercises;
DROP TABLE exerciseProgram;
DROP TABLE workoutLog;
DROP TABLE programDetails;
DROP TABLE logDetails;

CREATE TABLE users (
    user_username                   VARCHAR(45) PRIMARY KEY NOT NULL,
    user_password                   VARCHAR(45) NOT NULL,
    user_fitnessObjective           VARCHAR(45) NOT NULL,
    user_profileImage               BLOB NULL
);

CREATE TABLE exercises (
    exercise_id                     INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    exercise_name                   VARCHAR(45) NOT NULL,
    exercise_description            VARCHAR(45) NOT NULL,
    exercise_category               VARCHAR(45) NOT NULL
);

CREATE TABLE exerciseProgram (
    exerciseProgram_id              INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    exerciseProgram_name            VARCHAR(45) NOT NULL,
    exerciseProgram_description     VARCHAR(45) NOT NULL
);

CREATE TABLE workoutLog (
    log_id                          INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    log_startTime                   DATETIME NOT NULL,
    log_endTime                     DATETIME NOT NULL,

    user_username                   VARCHAR(45) NOT NULL,
    INDEX fk_username_idx (user_username ASC) VISIBLE,
    CONSTRAINT fk_username_id
        FOREIGN KEY (user_username)
        REFERENCES users (user_username)
        ON DELETE CASCADE
        ON UPDATE RESTRICT
);

CREATE TABLE programDetails (
    exerciseDetails_id              INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    exerciseDetails_sets            INT NOT NULL,
    exerciseDetails_reps            INT NOT NULL,
    exerciseDetails_weight          DECIMAL(10, 2) NOT NULL,

    exerciseProgram_id              INT NOT NULL,
    exercise_id                     INT NOT NULL,

    INDEX fk_exerciseProgramID_idx (exerciseProgram_id ASC) VISIBLE,
    CONSTRAINT fk_exerciseProgram_id
        FOREIGN KEY (exerciseProgram_id)
        REFERENCES exerciseProgram (exerciseProgram_id)
        ON DELETE CASCADE
        ON UPDATE RESTRICT,
    INDEX fk_exerciseID_idx (exercise_id ASC) VISIBLE,
    CONSTRAINT fk_exerciseID
        FOREIGN KEY (exercise_id)
        REFERENCES exercises (exercise_id)
        ON DELETE CASCADE
        ON UPDATE RESTRICT
);

CREATE TABLE logDetails (
    exerciseLog_id                  INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    exerciseLog_sets                INT NOT NULL,
    exerciseLog_reps                INT NOT NULL,
    exerciseLog_weight              DECIMAL(10, 2) NOT NULL,

    log_id                          INT NOT NULL,
    exercise_id                     INT NOT NULL,

    INDEX fk_exerciseLog_id_idx (log_id ASC) VISIBLE,
    CONSTRAINT fk_exerciseLog_id
        FOREIGN KEY (log_id)
        REFERENCES workoutLog (log_id)
        ON DELETE CASCADE
        ON UPDATE RESTRICT,
    INDEX fk_exerciseLog_exerciseID_idx (exercise_id ASC) VISIBLE,
    CONSTRAINT fk_exerciseLog_exerciseID
        FOREIGN KEY (exercise_id)
        REFERENCES exercises (exercise_id)
        ON DELETE CASCADE
        ON UPDATE RESTRICT
);