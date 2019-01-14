# Context Event Service (CES) Reference Implementation

Context Event Service is an HTTP/2 and HTML 5-based backend service for powering context-driven, knowledge-based applications from pluggable knowledge-based agents using the Architecutre for Real-Time Application of Knowledge Artifacts (ARTAKA) paradigm. It is a essentially an event broker between an internal pub/sub system and any number of external clients. Push events are sent to clients using HTML Server Sent Events (SSE), while client publication of events is done via traditional REST. (The previous implementation based on WebSockets has been removed.) By integrating MVC-based client applications with CES -- including SMART, native mobile, and others -- clusters of decoupled, stateless backend agents are able to drive frontend state through instrumentation of existing client controller code. All technology choices have been made to support clean integration with any mainstream client development framework based on MVC principles and healthcare-specific environments such as SMART-on-FHIR. This CES implementation bases its internal domain model as a relational schema using  PostgeSQL for slow-moving sytsem objects, and MongoDB for temporilly-indexed event timelines known as a the Temporal Event Store (TES). Internal pub/sub support is implemented via Redis.


# Conceptual Overview

This CES implementation is intended to be customized for user logins via a configurable set OpenID Connect providers: part of the OAuth2 family of protocols used by many vendors and basis of SMART-on-FHIR. After a session is established, a [JWT](https://jwt.io) is issued that may be used to access the API for a time-limited period. Documentation is generated based on the model. For what the API actually does, see:

* [High-Level List of System Management REST Routes](https://github.com/preston/context-event-service/blob/master/doc/routes.txt) - This is a generated dump.
* [Schema Diagram](https://github.com/preston/context-event-service/blob/master/doc/models_complete.svg) - This is a normalized .svg showing the logical database model, with additional OR/M-level annotations. It's useful in understanding how resources relate behind the API.
* [Database DSL](https://github.com/preston/context-event-service/blob/master/db/schema.rb) - Generated database schema in ActiveRecord format.

**The event API is not a source of clinical knowledge.** Events are not intended to represent nor communicate knowledge structures. Data references are generally propogated via URIs that may be retrieved froma an _external_ source responsible for storage and management of the data. In other words, the CES is not intended to be used in isolation. It must be accompanied by an installed suite of asynchronous agents to receive and emit events eventually propogated back to connected clients.

# Public Sandbox

A public sandbox server is available at:

	http://context-event-service.prestonlee.com

As this is a non-production system, all sessions may be created anonymously. OAuth code is provided, though production implementations will require tying authentication and authorization to a local SSO provider.


# Developer Quick Start (OSX with Homebrew)

If you don't already have Postgres running locally:

    brew install postgresql

Create a "context" Postgres person using the dev/test credentials in config/database.yml, and assigned them full rights to manage schemas. As with most Ruby projects, use [RVM](https://rvm.io) to manage your local Ruby versions. [Install RVM](https://rvm.io) and:

	rvm install 2.5.1
	rvm use 2.5.1

Then,

	bundle install # to install all server-side library dependencies.

The Context Event Service is designed in [12factor](http://12factor.net) style. Thus, the following environment variables are required to be set to support cookie-based CDN authorization grants. Set these in your ~/.bash_profile (or similar) and reload your terminal.

 * export CONTEXT\_SECRET\_KEY\_BASE="some_unique_string" # Used for cryptographic signing.
 * export CONTEXT\_DATABASE\_URL="postgres://healthcreek:password@db.example.com:5432/healthcreek_production
" # Only used in "production" mode!
 * export CONTEXT\_DATABASE\_URL\_TEST="postgres://healthcreek:password@db.example.com:5432/healthcreek_test
" # Only used in "test" mode!


The following additional environment variables are optional, but potentially useful in a production context. Note that the database connection pool is adjusted automatically based on these values. If in doubt, do NOT set these.

 * export CONTEXT\_SERVER\_PROCESSES=8 # To override the number of pre-forked workers.
 * export CONTEXT\_SERVER\_THREAD=8 # To override the number of threads per process.

Now,

	rake db:create # to create empty healthcreek_development and context_test databases in Postgres
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

	docker build -t p3000/context-event-service:latest .

## Running a Container

When running the container, **all environment variables defined in the above section must be set using `-e FOO="bar"` options** to docker. The foreground form of the command is:

	docker run -it --rm -m="512MB" \
		-e "CONTEXT_SECRET_KEY_BASE=development_only" \
		-e "CONTEXT_DEVELOPMENT_URL=postgresql://context:password@192.168.1.103:5432/context_development" \
		-e "CONTEXT_DEVELOPMENT_URL_TEST=postgresql://context:password@192.168.1.103:5432/context_test" \
		healtcreek-server:latest

...or to run in the background:

	docker run -d --rm -p 3000:3000 -m="512MB" \
		-e "CONTEXT_SECRET_KEY_BASE=development_only" \
		-e "CONTEXT_DEVELOPMENT_URL=postgresql://context:password@192.168.1.103:5432/context_development" \
		-e "CONTEXT_DEVELOPMENT_URL_TST=postgresql://context:password@192.168.1.103:5432/context_test" \
		healtcreek-server:latest

## Regression Testing a Container

The container includes a regression test suite to ensure proper operation. Running in test mode is slightly different, as to not inadvertently affect your production database(s). The application server process must also be told to run in 'test' mode.

docker run -it -m="512MB" \
	-e "RAILS_ENV=test" \
	-e "CONTEXT_ENV_VAR_NAME=value" \
	... \
	healtcreek-server:latest \
	rake test


# Attribution

Blame this on Preston Lee <preston.lee@prestonlee.com>. "You're welcome" or "I'm sorry": whichever best applies.
