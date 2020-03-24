# Metadata

## Get Integration Metadata

```python
from flask import Flask, jsonify

app = Flask(__name__)

@app.get("/")
def get_integration_metadata():
    return jsonify({
        "protocol_version": 1,
        "provider_name": "My Custom Integration"        
    })
```

```javascript
const express = require('express')
const app = express()

app.get('/', (req, res) => {
    res.json({
        protocol_version: 1,
        provider_name: 'My Custom Integration'
    })
})
```

>This endpoint should return JSON in the following format:

```json
{
    "protocol_version": 1,
    "provider_name": "My Custom Integration"
}
```

This endpoint defines the basic properties of all integrations - which version
of the Integration API Protocol is being used, and the name of the provider
this integration connects to (for display and branding purposes
within PassFort). Currently, the only API Protocol version is `1`. This
endpoint is unauthenticated to allow future API versions to use different
authentication methods. **All integrations regardless of type must serve
up this endpoint**.

<aside>
  If you update the name of the provider returned by the endpoint, it will only
  be updated in PassFort when the integration is re-validated.
</aside>

### HTTP Request

`GET https://my-integration.example.com/`

### Response fields

<table>
  <thead>
    <th>Field</th>
    <th>Type</th>
    <th>Required?</th>
    <th>Description</th>
  </thead>
  <tbody>
    <tr>
      <td><code>protocol_version</code></td>
      <td>number</td>
      <td>Yes</td>
      <td>
        An integer representing the version of the version of the Integration
        API to use. Currently, this is always <code>1</code>.
      </td>
    </tr>
    <tr>
      <td><code>provider_name</code></td>
      <td>string</td>
      <td>Yes</td>
      <td>
        The name of the provider this integration connects to. Currently, the
        name must be between at least 6 characters in length, and no greater
        than 49. The maximum and minimum may be (compatibly) changed in the
        future.
      </td>
    </tr>
  </tbody>
</table>


<aside>
  This endpoint does not require authentication.
</aside>