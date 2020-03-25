# Demo Checks

Integrations should support the ability to provide demo results to customers
using PassFort's demo environments for integration work and evaluation. To this
end, the Integration API allows for checks to be run with a specifically
requested demo result using the `demo_result` field in the request payload
of most check types.

## Guidelines for demo results

 * Your demo result outputs should match the structure of your live check
   results as closely as possible, to ensure that they are representative of
   the check results customers will receive on live checks.

 * Your demo result outputs must incorporate the input data provided to the
   check, so that PassFort's check results are interpreted correctly and
   the check results imitate a result a customer might get for a profile in
   a live check.

 * Your integration should provide as many demo results as possible, as long
   as the data provider supports results meeting those criteria.

 * The `provider_data` field in the result should be populated with a
   human readable notice that the check was not run in the live environment,
   such as `"Demo result. Did not make request to provider."`.

## Demo result types

To support a wide range of testing scenarios, PassFort uses specific values
in the `demo_result` field to select demo results. The different types of demo
result are outlined below.

<aside>
  New types of demo result may be added at any time, and so your integration
  may be asked to return a demo result it does not recognise, even if you
  implement all currently specified demo result types. You should return an
  error with the type <code>"UNSUPPORTED_DEMO_RESULT"</code> in the check
  result if you do not recognise a specific demo result type.
</aside>

### Demo results for all check types

These demo result values may be requested for any check type.

#### `ANY`

A demo result that will be used as the default if nothing more specific is
requested. It should reflect a genuine non-error result for this integration,
but it does not need to be a passing result.

#### `ERROR_INVALID_CREDENTIALS`

Your integration return a result as if a customer with a direct commercial
relationship has provided credentials that have been rejected by the
data provider.

#### `ERROR_ANY_PROVIDER_MESSAGE`

Your integration must return a result as if the data provider was successfully
reached but encountered a problem fulfilling the request, such a problem
with the service, or missing information in the request.

#### `ERROR_CONNECTION_TO_PROVIDER`

Your integration must return a result as if it attempted to contact the data
provider but the connection failed (due to timeouts or outages).

### Demo results for Identity Checks

These demo result values are specific to Identity Checks.

#### `NO_MATCHES`

Your integration must return a result where the data provider could not find
any matching records for the submitted profile.

#### `ONE_NAME_ADDRESS_MATCH`

Your integration must return a result where the data provider could find a
match on the full name and date of birth for the submitted profile in a single
database.

#### `ONE_NAME_DOB_MATCH`

Your integration must return a result where the data provider could find a
match on the full name and date of birth for the submitted profile in a single
database.

#### `TWO_NAME_ADDRESS_MATCH`

Your integration must return a result where the data provider could find a
match on the full name and address for the submitted profile in at least
**two** separate databases, if the provider supports this.

#### `ONE_NAME_ADDRESS_ONE_NAME_DOB_MATCH`

Your integration must return a result where the data provider could find a
match on the full name and address for the submitted profile in a single
database, and a match on the full name and date of birth in **another
separate database**, if the provider supports this.

#### `ONE_NAME_ADDRESS_DOB_MATCH`

Your integration must return a result where the data provider could find a
match on the full name, address, and date of birth for the submitted profile in
at least one database.

#### `MORTALITY_MATCH`

Your integration must return a result where the data provider could find a
match on the submitted profile in at least one mortality register, if the
provider supports this.

#### `ONE_NAME_ADDRESS_MORTALITY_MATCH`

Your integration must return a result where the data provider could find a
match on the full name and date of birth for the submitted profile in a single
database, and also a match in at least one mortality register, if the provider
supports this.

#### `ONE_NAME_ADDRESS_ONE_NAME_DOB_MORTALITY_MATCH`

Your integration must return a result where the data provider could find a
match on the full name and address for the submitted profile in a single
database, and a match on the full name and date of birth in **another
separate database**, and also a match in at least one mortality register, if
the provider supports this.
