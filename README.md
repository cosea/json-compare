json-compare
=============
A simple comparator for json files that are reachable via an URI.

The goal of this tool was to test backends that use couchdb and validate that they generate the correct json files after substantial changes were made to them.

		Usage:
			jsoncompare [options]
			where [options] are:
			  --original, -o <s>:        The URI to the original JSON, can be a file or an url
			  --check, -c <s>:           The URI to the JSON under test, can be a file or an url
			  --auth-original, -a <s>:   The user:pass combination to use in http basic auth for the original (default: )
				--auth-check, -u <s>:      The user:pass combination to use in http basic auth for the json under test (default: )
				--version, -v:             Print version and exit
				 --help, -h:               Show this message
