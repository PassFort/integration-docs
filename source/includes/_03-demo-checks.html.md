# Demo Checks

Integrations should support the ability to provide demo results to customers
using PassFort's demo environments for integration work and evaluation. To this
end, the Integration API allows for checks to be run with a specifically
requested demo result using the `demo_result` field in the request payload
of most check types.

## Guidelines for demo results

- Your demo result outputs should match the structure of your live check
  results as closely as possible, to ensure that they are representative of
  the check results customers will receive on live checks.

- Your demo result outputs must incorporate the input data provided to the
  check, so that PassFort's check results are interpreted correctly and
  the check results imitate a result a customer might get for a profile in
  a live check.

- Your integration should provide as many demo results as possible, as long
  as the data provider supports results meeting those criteria.

- The `provider_data` field in the result should be populated with a
  human-readable notice that the check was not run in the live environment,
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

#### `ANY` <span style="float:right">Required</span>

A demo result that will be used as the default if nothing more specific is
requested. It should reflect a genuine non-error result for this integration,
but it does not need to be a passing result.

#### `ANY_CHARGE` <span style="float:right">Conditional</span>

This demo result will be used to test billing. This is required if your
integration supports reselling and
the maximum amount your integration can charge for a check is greater than
zero.

There are no requirements on what the result of the check must be, but if the
check is being resold, at least one non-zero charge must be returned. The usual
rules also still apply: the total amount charged must be no greater than the
maximum specified in your integration's configuration.

Note that, as this is a demo check, no credits will actually be deducted
from the customer.

#### `ERROR_INVALID_CREDENTIALS` <span style="float:right">Required</span>

Your integration must return a result as if a customer with a direct commercial
relationship has provided credentials that have been rejected by the
data provider.

#### `ERROR_ANY_PROVIDER_MESSAGE` <span style="float:right">Required</span>

Your integration must return a result as if the data provider was successfully
reached but encountered a problem fulfilling the request, such a problem
with the service, or missing information in the request.

#### `ERROR_CONNECTION_TO_PROVIDER` <span style="float:right">Required</span>

Your integration must return a result as if it attempted to contact the data
provider but the connection failed (due to timeouts or outages).

### Demo results for Identity Checks

These demo result values are specific to Identity Checks.

#### `NO_MATCHES` <span style="float:right">Required</span>

Your integration must return a result where the data provider could not find
any matching records for the submitted profile.

#### `ONE_NAME_ADDRESS_MATCH` <span style="float:right">Required</span>

Your integration must return a result where the data provider could find a
match on the full name and address for the submitted profile in a single
database.

#### `ONE_NAME_DOB_MATCH` <span style="float:right">Optional</span>

Your integration must return a result where the data provider could find a
match on the full name and date of birth for the submitted profile in a single
database.

#### `TWO_NAME_ADDRESS_MATCH` <span style="float:right">Optional</span>

Your integration must return a result where the data provider could find a
match on the full name and address for the submitted profile in at least
**two** separate databases, if the provider supports this.

#### `ONE_NAME_ADDRESS_ONE_NAME_DOB_MATCH` <span style="float:right">Optional</span>

Your integration must return a result where the data provider could find a
match on the full name and address for the submitted profile in a single
database, and a match on the full name and date of birth in **another
separate database**, if the provider supports this.

#### `ONE_NAME_ADDRESS_DOB_MATCH` <span style="float:right">Optional</span>

Your integration must return a result where the data provider could find a
match on the full name, address, and date of birth for the submitted profile in
at least one database.

#### `MORTALITY_MATCH` <span style="float:right">Optional</span>

Your integration must return a result where the data provider could find a
match on the submitted profile in at least one mortality register, if the
provider supports this.

#### `ONE_NAME_ADDRESS_MORTALITY_MATCH` <span style="float:right">Optional</span>

Your integration must return a result where the data provider could find a
match on the full name and date of birth for the submitted profile in a single
database, and also a match in at least one mortality register, if the provider
supports this.

#### `ONE_NAME_ADDRESS_ONE_NAME_DOB_MORTALITY_MATCH` <span style="float:right">Optional</span>

Your integration must return a result where the data provider could find a
match on the full name and address for the submitted profile in a single
database, and a match on the full name and date of birth in **another
separate database**, and also a match in at least one mortality register, if
the provider supports this.

### Demo results for Document Checks

These demo results are specific to Document Verification and Document Fetch
checks.

#### `ERROR_UNSUPPORTED_DOCUMENT_TYPE` <span style="float:right">Required</span>

Your integration must return a result as if a document was submitted whose type
is not supported by the data provider.

#### `DOCUMENT_IMAGE_CHECK_FAILURE`

Your integration must return a result as if a document was submitted which
failed one or more image checks. For example, if the document image was
too blurry.

#### `DOCUMENT_FORGERY_CHECK_FAILURE`

Your integration must return a result as if a document was submitted which
failed one or more forgery checks. For example, if the fonts used on the
document are incorrect.

#### `DOCUMENT_NAME_FIELD_DIFFERENT`

Your integration must return a result where the name extracted from the
document differs from the name on the check input.

#### `DOCUMENT_NAME_FIELD_UNREADBALE`

Your integration must return a result where no name could be extracted
from the document.

#### `DOCUMENT_DOB_FIELD_DIFFERENT`

Your integration must return a result where the date of birth extracted from the
document differs from the date of birth on the check input.

#### `DOCUMENT_DOB_FIELD_UNREADBALE`

Your integration must return a result where no date of birth could be extracted
from the document.

#### `DOCUMENT_ALL_PASS` <span style="float:right">Required</span>

Your integration must return a result where the extracted data matches the
check input and all image and forgery checks have passed.

#### `ERROR_INVALID_PROVIDER_REFERENCE` <span style="float:right">Conditional</span>

This demo result is required for Document Fetch checks. It is not used for
Document Verification checks.

Your integration must return a result indicating that the document reference
passed as part of the check input was invalid.