# Configuration

> A sample configuration for a synchronous identity check.

```json
{
  "check_type": "IDENTITY_CHECK",
  "check_template": {
    "type": "ONE_TIME_SYNCHRONOUS",
    "timeout": 60
  },
  "pricing": {
    "supports_reselling": true,
    "maximum_cost": 200
  },
  "supported_countries": ["GBR", "USA", "CAN"],
  "credentials": {
    "fields": [
      {
        "type": "string",
        "name": "username",
        "label": "Username"
      },
      {
        "type": "password",
        "name": "password",
        "label": "Password"
      }
    ]
  },
  "config": {
    "fields": [
      {
        "type": "boolean",
        "name": "boolean_config",
        "label": "Boolean config field",
        "subtext": "A description of the option",
        "default": false
      },
      {
        "type": "MultiSelect",
        "name": "multiselect_config",
        "label": "Config field with dropdown options",
        "subtext": "A description of the option",
        "options": ["Option 1", "Option 2", "Option 3", "Option 4"],
        "default": null
      }
    ]
  }
}
```

The configuration endpoint defines several important properties about your
integration. Most parts of the configuration are common to all integrations,
but the `check_type` and `check_template` are specific to each type of
integration and will be discussed in their respective sections.

<aside>
  If you update the configuration returned by your integration, it will only
  be updated in PassFort when the integration is re-validated.
</aside>

## Pricing

The `pricing` field defines whether you intend to make your integration
available to PassFort for reselling, instead of requiring that PassFort
customers have a direct commercial relationship with the data provider.

### Fields

<table>
  <thead>
    <th>Field</th>
    <th>Type</th>
    <th>Required?</th>
    <th>Description</th>
  </thead>
  <tbody>
    <tr>
      <td><code>supports_reselling</code></td>
      <td>boolean</td>
      <td>Yes</td>
      <td>
        Whether your integration supports being configured for reselling.
      </td>
    </tr>
    <tr>
      <td><code>maximum_cost</code></td>
      <td>number</td>
      <td>No</td>
      <td>
        The maximum amount of PassFort credits that can be charged for a
        single check. <strong>Required if <code>supports_reselling</code> is
        <code>true</code></strong>.
      </td>
    </tr>
  </tbody>
</table>

<aside>
  PassFort credit is purchased by PassFort's customers. It's used
  to pay for checks resold through PassFort, when reselling is
  supported by the data provider.
  
  Credits are tied to GBP at the ratio of £1 = 100 credits.
</aside>

## Supported countries

The `supported_countries` field defines which countries your integration is
able to support. The exact interpretation of this field varies depending on
the check type, but it typically reflects country of residence for individuals
and the country of incorporation for companies. This field is an array of
strings, which should be the [ISO3 country code][wiki-iso3] for the country. At
least one country must be specified.

## Supported features

The optional `supported_features` field allows your integration to declare 
support for additional features. The absence of this field from your 
integration's config implies that no additional features are supported. 

The list of possible features varies depending on the check type and often 
surface extra functionality implemented by the provider. 

These features are currently recognised as items within the 
`supported_features` array:

<table>
  <thead>
    <th>Feature</th>
    <th>Check Type</th>
    <th>Description</th>
  </thead>
  <tbody>
    <tr>
      <td><a href="#company-search"><code>COMPANY_SEARCH</code></a></td>
      <td>Company Data</td>
      <td>The integration supports predictive search through the companies known to the provider.</td>
    </tr>
  </tbody>
</table> 


## Credentials Fields

The `credentials` field contains exactly one field, `fields`, which specify
an array of single values needed for your integration to contact the data
provider and authorize itself successfully. Customers will provide these as
part of configuring your integration. For checks with reselling enabled,
these credentials will not be sent.

Per PassFort's general API compatibility policies, we may add new types for
configuration fields at any time, although existing types will not be removed.

<aside class="warning">
  You should not alter existing credential fields once your integration is
  being used by PassFort customers. This can cause checks through your
  integration to stop working.
</aside>

### Fields

These fields are permitted on objects inside the `fields` array:

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
      <td>One of: <code>"string"</code>, <code>"password"</code></td>
      <td>Yes</td>
      <td>
        The type of the credential field. <code>password</code> is functionally identical
        to <code>string</code>, but will be rendered as a password input in the UI.
      </td>
    </tr>
    <tr>
      <td><code>name</code></td>
      <td>string</td>
      <td>Yes</td>
      <td>
        The name of the field which will be used when sent to your
        integration.
      </td>
    </tr>
    <tr>
      <td><code>label</code></td>
      <td>string</td>
      <td>Yes</td>
      <td>
        The name that will be displayed for this field in PassFort.
      </td>
    </tr>
  </tbody>
</table>

## Configuration Fields

Like credentials, the `config` field contains exactly one field, `fields`,
which specify an array of configurable options for your integration that can
be set up on individual provider configurations, and will be provided to your
integration on every check.

Per PassFort's general API compatibility policies, we may add new types for
configuration fields at any time, although existing types will not be removed.

<aside class="warning">
  You should not alter existing configuration fields once your integration is
  being used by PassFort customers. This can cause checks through your
  integration to stop working.
</aside>

### Fields

These fields are permitted on objects inside the `fields` array:

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
      <td>One of: <code>"string"</code>, <code>"boolean"</code>, <code>"MultiSelect"</code></td>
      <td>Yes</td>
      <td>
        The type of the configuration field.
      </td>
    </tr>
    <tr>
      <td><code>name</code></td>
      <td>string</td>
      <td>Yes</td>
      <td>
        The name of the field which will be used when sent to your
        integration.
      </td>
    </tr>
    <tr>
      <td><code>label</code></td>
      <td>string</td>
      <td>Yes</td>
      <td>
        The name that will be displayed for this field in PassFort.
      </td>
    </tr>
    <tr>
      <td><code>subtext</code></td>
      <td>string</td>
      <td>No</td>
      <td>
        A short description that will be displayed under the configuration
        option in PassFort.
      </td>
    </tr>
    <tr>
      <td><code>options</code></td>
      <td>array[string]</td>
      <td>No</td>
      <td>
        An <code>array</code> of options which may be chosen; used for both
        display name and value. Only applicable to (and required for) the
        <code>MultiSelect</code> field type.
      </td>
    </tr>
    <tr>
      <td><code>default</code></td>
      <td>A valid value allowed by the type specified in <code>type</code></td>
      <td>Yes</td>
      <td>
        The default value for this configuration field. For
        <code>MultiSelect</code> fields, this value may also be
        <code>null</code>. Otherwise, it must be a valid value for the field's
        type; for example, a <code>boolean</code> field may only have a
        <code>default</code> of either <code>true</code> or <code>false</code>.
      </td>
    </tr>
  </tbody>
</table>

[wiki-iso3]: https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3
