# One-time Sync Identity Check

This section lists all endpoints that must be implemented for a one-time  
synchronous identity check integration.

One-time synchronous identity checks are identity checks with the following
behaviour:

  * The check result will be returned directly upon request; the response will
    not be sent until the check is finished (synchronous).

  * If the check request times out, errors or otherwise fails, PassFort will
    not reattempt the check (one-time).


## Get Check Configuration

### HTTP Request

`GET https://my-integration.example.com/config`

```python
from flask import Flask, jsonify

app = Flask(__name__)

@app.get("/config")
def get_check_configuration():
    return jsonify({
        "check_type": "IDENTITY_CHECK",
        "check_template": {
            "type": "ONE_TIME_SYNCHRONOUS",
            "timeout": 60
        },
        "pricing": {
            "supports_reselling": True,
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
                    "name": "require_dob",
                    "label": "Date of birth is required for 1+1 and 2+2 results",
                    "subtext": "The individual's date of birth must be matched in one source for 1+1 and 2+2 results to be achieved",
                    "default": False
                }
            ]
        }
    })
```

```javascript
const express = require('express')
const app = express()

app.get('/config', (req, res) => {
    res.json({
        check_type: 'IDENTITY_CHECK',
        check_template: {
            type: 'ONE_TIME_SYNCHRONOUS',
            timeout: 60
        },
        pricing: {
            supports_reselling: true,
            maximum_cost: 200
        },
        supported_countries: ['GBR', 'USA', 'CAN'],
        credentials: {
            fields: [
               {
                   type: 'string',
                   name: 'username',
                   label: 'Username'
               },
               {
                   type: 'password',
                   name: 'password',
                   label: 'Password'
               }
            ]
        },
        "config": {
            "fields": [
                {
                    type: 'boolean',
                    name: 'require_dob',
                    label: 'Date of birth is required for 1+1 and 2+2 results',
                    subtext: 'The individual\'s date of birth must be matched in one source for 1+1 and 2+2 results to be achieved',
                    default: false
                }
            ]
        }
    })
})
```

>This endpoint should return JSON in the following format:

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
                    "name": "require_dob",
                    "label": "Date of birth is required for 1+1 and 2+2 results",
                    "subtext": "The individual's date of birth must be matched in one source for 1+1 and 2+2 results to be achieved",
                    "default": false
                }
            ]
        }
    }
```

### Response fields

Most configuration fields are already discussed in the [configuration
section](#configuration). Check specific options will be discussed here.

#### Check type

The `check_type` field must be set to `"IDENTITY_CHECK"`.

#### Check template

The `check_template` fields for this check are:

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
      <td>The value <code>"ONE_TIME_SYNCHRONOUS"</code></td>
      <td>Yes</td>
      <td>
        Which check template to use for this check. For one-time synchronous
        checks, you must specify <code>"ONE_TIME_SYNCHRONOUS"</code>.
      </td>
    </tr>
    <tr>
      <td><code>timeout</code></td>
      <td>number</td>
      <td>Yes</td>
      <td>
        The number of seconds PassFort should wait without a response before
        considering identity checks run through this integration to have
        timed out. Must be an integer.
      </td>
    </tr>
  </tbody>
</table>
