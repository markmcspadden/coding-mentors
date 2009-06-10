CREATE TABLE "mentorship_skills" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "mentorship_id" integer, "skill_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "mentorships" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "mentee_id" integer, "mentor_id" integer, "sender_id" integer, "receiver_id" integer, "accepted_at" datetime, "rejected_at" datetime, "completed_at" datetime, "created_at" datetime, "updated_at" datetime, "sender_note" text, "receiver_note" text);
CREATE TABLE "open_id_authentication_associations" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "issued" integer, "lifetime" integer, "handle" varchar(255), "assoc_type" varchar(255), "server_url" blob, "secret" blob);
CREATE TABLE "open_id_authentication_nonces" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "timestamp" integer NOT NULL, "server_url" varchar(255), "salt" varchar(255) NOT NULL);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "skills" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "user_skills" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "skill_id" integer, "level" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "master_skills" text, "intermediate_skills" text, "newbie_skills" text, "remote_availability" varchar(255), "local_availability" varchar(255), "available_to_mentor" boolean, "available_to_be_mentored" boolean, "created_at" datetime, "updated_at" datetime, "identity_url" varchar(255), "email" varchar(255));
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20090516063734');

INSERT INTO schema_migrations (version) VALUES ('20090516211155');

INSERT INTO schema_migrations (version) VALUES ('20090608104610');

INSERT INTO schema_migrations (version) VALUES ('20090608104727');

INSERT INTO schema_migrations (version) VALUES ('20090609013249');

INSERT INTO schema_migrations (version) VALUES ('20090609205953');

INSERT INTO schema_migrations (version) VALUES ('20090610003206');

INSERT INTO schema_migrations (version) VALUES ('20090610003359');

INSERT INTO schema_migrations (version) VALUES ('20090610015817');