CREATE TABLE "mentorships" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "mentee_id" integer, "mentor_id" integer, "sender_id" integer, "receiver_id" integer, "accepted_at" datetime, "rejected_at" datetime, "completed_at" datetime, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "master_skills" text, "intermediate_skills" text, "newbie_skills" text, "remote_availability" varchar(255), "local_availability" varchar(255), "available_to_mentor" boolean, "available_to_be_mentored" boolean, "created_at" datetime, "updated_at" datetime);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20090516063734');

INSERT INTO schema_migrations (version) VALUES ('20090516211155');