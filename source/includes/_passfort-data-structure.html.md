# Data Structure

PassFort structures data on individual and company entities in a standard
format throughout the product. Additionally, many data structure types are
common across different checks.

## Check input

Checks are given information on a profile through the `check_input` field
on the JSON body of the request, either accepting `CompanyData` or
`IndividualData` depending on the check type. For full information on the
structure of this data, check the [`input_data` field on the 'Run a check'
response in our API documentation][api-docs-post-check] or consult the schemas
for `CompanyData` and `IndividualData` in our
[OpenAPI spec][api-docs-openapi-json].

## Check errors

All checks may return errors in their `errors` field using the structure
specified here.

### Error fields

<table>
  <thead>
    <th>Field</th>
    <th>Type</th>
    <th>Required?</th>
    <th>Description</th>
  </thead>
  <tbody>
    <tr>
      <td><code>type</code></td>
      <td>One of the <a href="#error-types">supported error types</a></td>
      <td>Yes</td>
      <td>The type of error that's being reported.</td>
    </tr>
    <tr>
      <td><code>sub_type</code></td>
      <td>A valid error subtype for the specified <code>type</code></td>
      <td>No</td>
      <td>Provides additional detail for certain types of error.</td>
    </tr>
    <tr>
      <td><code>message</code></td>
      <td>string</td>
      <td>Yes</td>
      <td>
        A message displayed in the Passfort portal to show the
        check error.
      </td>
    </tr>
    <tr>
      <td><code>data</code></td>
      <td>A map of strings to any valid JSON value</td>
      <td>No</td>
      <td>
        Integration-specific structured error information that customers can
        use to get additional information about the error.
      </td>
    </tr>
  </tbody>
</table>

### Error types

#### `INVALID_CREDENTIALS`

The data provider reported that the credentials used aren't valid.

#### `INVALID_CONFIG`

Your integration is not able to run the check because it was sent with
invalid configuration values.

#### `MISSING_CHECK_INPUT`

Your integration is not able to run the check because the `input_data` does
not contain fields that are required by the data provider.

#### `INVALID_CHECK_INPUT`

Your integration is not able to run because the `input_data` contains values
that your integration cannot handle, for example, because the date of birth
is not accurate enough, or because the country on the profile is not supported
by this data provider.

Subtypes:

<table>
 <thead>
  <th>Subtype</th>
  <th>Description</th>
</thead>
<tbody>
  <tr>
    <td><code>UNSUPPORTED_COUNTRY</code></td>
    <td>
      The data provider doesn't support running checks for the
      requested country.
    </td>
  </tr>
  <tr>
    <td><code>MISSING_CONTACT_DETAILS</code></td>
    <td>
      Contact details are missing from the check input.
    </td>
  </tr>
</tbody>
</table>

#### `PROVIDER_CONNECTION`

A successful request could not be made to the data provider due to connection
issues, such as downtime or a check timeout.

#### `PROVIDER_MESSAGE`

The data provider returned an error message when processing this check.

#### `UNSUPPORTED_DEMO_RESULT`

This error should be returned when your integration receives a `demo_result`
value which it doesn't support or does not have demo data implemented.

[api-docs-post-check]: https://developer.passfort.com/api#tag/Checks/paths/~1profiles~1{profile_id}~1checks/post
[api-docs-openapi-json]: https://identity.passfort.com/api/static/schemas/openapi_v41.json

## Check charges

Checks may return charges in their `charges` field using the structure
specified here.

### Charge fields

<table>
  <thead>
    <th>Field</th>
    <th>Type</th>
    <th>Required?</th>
    <th>Description</th>
  </thead>
  <tbody>
    <tr>
      <td><code>amount</code></td>
      <td>integer</td>
      <td>Yes</td>
      <td>
        The amount to charge (in pennies). In the future, it may be possible
        to specify a different currency unit.
      </td>
    </tr>
    <tr>
      <td><code>sku</code></td>
      <td>string</td>
      <td>No</td>
      <td>
        Stock Keeping Unit (SKU). All charges with the same SKU should cost the
        same amount. For providers with a fixed cost in each country, the SKU
        can simply be the 3-letter code for the country in which the check was
        run. This field can be omitted if there is no sensible value to use.
      </td>
    </tr>
    <tr>
      <td><code>reference</code></td>
      <td>string</td>
      <td>No</td>
      <td>
        The reference should be unique for each check. It should be possible
        to use the reference to correlate the charges recorded by the provider
        against the charges recorded in Passfort.
      </td>
    </tr>
  </tbody>
</table>
