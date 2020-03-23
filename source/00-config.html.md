# Configuration

>A sample configuration for a synchronous identity check.

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
  "supported_countries": [
    "GBR", "USA", "CAN"
  ],
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
        "options": [
          "Option 1",
          "Option 2",
          "Option 3",
          "Option 4"
        ],
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
  TODO: More info on PassFort credits
</aside>

## Supported countries

The `supported_countries` field defines which countries your integration is
able to support. The exact interpretation of this field varies depending on
the check, but it typically reflects country of residence for individuals.
This field is a simple array of strings, which should be the [ISO3 country
code][wiki-iso3] for the country.

<aside>
  TODO: How (and should you) declare that an integration supports
  all countries?
</aside>

## Credentials Fields

The `credentials` field contains exactly one field, `fields`, which specify
an array of single values needed for your integration to contact the data
provider and authorize itself successfully. For most checks, the customer will
provide these as part of configuring your integration, but for resold checks
these may also be provided by PassFort directly.

### Fields

These fields are required to be present on every object in the `fields`
array:

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
      <td><code>string</code></td>
      <td>Yes</td>
      <td>
        The name of the field which will be used when sent to your
        integration.
      </td>
    </tr>
    <tr>
      <td><code>label</code></td>
      <td><code>string</code></td>
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



[wiki-iso3]: https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3