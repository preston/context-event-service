# HealthCreek Server

HealthCreek is an API providing context-driven, temporally-oriented clinical experiences. It is an amalgamation of relevant existing standards and terminologies, fronted via a clean, RESTful JSON API that is easy to integrate into any JavaScript-based frontend, though *any* modern client is supported.

# Extremely Rough API Overview

This is an evolving work in progress. The proof-of-concept likely has differences.


## Pre-existing Security Resources

These are presumed to exist in the implementation prior to any actual use case. Most REST verbs are supported, used in the standard path'ing practice of "/<plural_noun>", "/<plural_noun>/:id", and utilization of sub-resources to represent model compositions and aggregations, when appropriate.

	/users # Generic type for all known people.
	/users/:id/identities # Actual authentication-related details specific to the IAM system.
	/users/:id/roles # Roles granted to the User.
	/groups	# An aggregation of Users.
	/groups/:id/members # Establishes a given User's membership in a Group.
	/groups/:id/roles # Roles granted to the Group; transitively to all Members.
	/roles # Defines a granular set of permissions.
	/roles/:id/interests # The highest-level SNOMED concept(s) of concern to a given Role.

## A Simple Encounter

Consider the following scenario:

- “Ernest Endocrinologist, MD” logs in.
- Ernest selects “Peter Patient”, and is immediately able to select a problem such as “Diabetes Type II" as the focus of an encounter starting in 5 minutes.
- Now that the system has established sufficient participant and problem context, as is already aware of concept classes of highest relevance to the known participants via group/role memberships, the server is able able to provide the client with relevancy and/or time-sorted facts about the situation that are most relevant to Ernest’s interests in the problem, such as labs, meds, and whatever else is built into the underlying classifier or reasoner.
- In HATEOAS style, the server is also able to provide *actionable* items to the client needed to emphasize the most likely client state transitions before, during and after the encounter. Note that during the encounter, the Participants *may* include the patient himself.

## API Usage

	POST /sessions # Doctor logs in. A secure cookie Session is issued.
	POST /contexts # Creates an empty Context. The users Roles, and transitively Interests, are automatically part of the new context.
	GET /users?role=patient&q=... # Find the relevant patient(s) via search or manual ID entry.
	POST /contexts/:id/participants # {user_id: 42, role: 'patient'} Associates the patient with the context. Additional Participants may be added/removed to the Context at any time. Context response is updated with...
	/users/:id/{issues,results,encounters} # Top-level lookup of patient-specific objects using SNOMED, LOINC and RxNorm terms, prioritized by relevance to the current Participant(s).
	POST /contexts/:id/foci # Doctor clicks a Problem and the systems declare a Focus of the context, using one or more SNOMED concepts.
	/<other_clinical_resources/:id?context=<context_id> # For generating resources specific to the context, as opposed to the global definition of the resource.
	PUT /contexts/:id # Optional, explicit "closing" of the context.
	GET /context/:id/logs # The audit trail record needed to actually “play back" the context. Every UI state transition for the patient’s visit will get logged against the context UUID, regardless of whether or not it's part of an encounter.
	WEBSOCKET /contexts/:id # Exclusively for "push" events send to the client out-of-band with any explicit request.
	GET /context/:id # At any time, to receive relevant semantic links (in REST HATEOAS style) to resources most relevant to the context.

# Developer Quick Start (OSX with Homebrew)

If you don't already have Postgres running locally:

    brew install postgresql

Create a "healthcreek" Postgres user using the dev/test credentials in config/database.yml, and assigned them full rights to manage schemas. As with most Ruby projects, use [RVM](https://rvm.io) to manage your local Ruby versions. [Install RVM](https://rvm.io) and:

	rvm install 2.3.1
	rvm use 2.3.1

Then,

	bundle install # to install all server-side library dependencies.

The HealthCreek Server application is designed in [12factor](http://12factor.net) style. Thus, the following environment variables are required to be set to support cookie-based CDN authorization grants. Set these in your ~/.bash_profile (or similar) and reload your terminal.

 * export HEALTHCREEK\_SNOMED\_DATA="/unzipped/snomed/directory" # Only set in development mode!
 * export HEALTHCREEK\_DATABASE\_URL="postgres://healthcreek:password@db.example.com:5432/healthcreek_production
" # Only used in "production" mode!
 * export HEALTHCREEK\_DATABASE\_URL\_TEST="postgres://healthcreek:password@db.example.com:5432/healthcreek_test
" # Only used in "test" mode!


The following additional environment variables are optional, but potentially useful in a production context. Note that the database connection pool is adjusted automatically based on these values. If in doubt, do NOT set these.

 * export HEALTHCREEK\_SERVER\_PROCESSES=8 # To override the number of pre-forked workers.
 * export HEALTHCREEK\_SERVER\_THREAD=8 # To override the number of threads per process.

Now,

	rake db:create # to create empty healthcreek_development and healthcreek_test databases in Postgres
	rake db:migrate # to apply all database migrations, in order, transactionally
	rake db:seed # loads a simple set of starter data
	rake test # to run all regression tests and generate a code coverage report. everything should pass!

You're now ready to run the application.

	rails s # to run the server in development mode in the foreground.

To automatically re-run regression tests on detected code changes, open another terminal window and run

	guard # hit <enter> to manually re-run all tests to run if a change isn't detected

# Deployment

Deployment is done exclusively with Docker, though "raw" deployment using Passenger and all another common methods, including Heroku, are supported as well.

## Building a Container

To build your current version:

	docker build healthcreek-server:latest

## Running a Container

When running the container, **all environment variables defined in the above section must be set using `-e FOO="bar"` options** to docker. The base form of the command, however, is

	docker run -it -m="512MB" \
		-e "HEALTHCREEK_ENV_VAR_NAME=value" \
		... \
		healtcreek-server:latest

## Regression Testing a Container

The container includes a regression test suite to ensure proper operation. Running in test mode is slightly different, as to not inadvertently affect your production database(s). The application server process must also be told to run in 'test' mode.

docker run -it -m="512MB" \
	-e "RAILS_ENV=test" \
	-e "HEALTHCREEK_ENV_VAR_NAME=value" \
	... \
	healtcreek-server:latest \
	rake test


# Attribution

Blame this on Preston Lee <preston@asu.edu>. "You're welcome" or "I'm sorry": whichever best applies.
